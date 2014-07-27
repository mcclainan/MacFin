package reports

import utilities.Utilities
import java.util.Map;
import groovy.sql.Sql
import oracle.jdbc.driver.OracleTypes
import planning.YearBeginningResources;

/**
 * @author Anthony
 *
 */
class FinancialReportService {
	
	def dataSource
	
	
	/**
	 * @param year
	 * @return yearOverview: a list that contains 12 lists that represent a month summary they hold the month,income and expense for the corresponding month
	 * This method makes use of a call to an oracle stored procedure to retrieve the data
	 */
	List getYearOverview(Integer year){
		def yearBeginningResources = YearBeginningResources.findByYear(year)
		def total = yearBeginningResources.getActualTotal()
		def currentMonth = new Date().getAt(Calendar.MONTH)
		Sql sql = new groovy.sql.Sql(dataSource)
		List yearOverview = []
		def i = 0.0
		sql.call("BEGIN get_year_overview(?,?); END;",[year,Sql.resultSet(OracleTypes.CURSOR)]) {cursorResults ->
			cursorResults.eachRow{result->
				yearOverview << [result.getAt(0),result.getAt(1),result.getAt(2),0]
			}
		}
		
		yearOverview.each{
			it[0] = it[0].toInteger()
			if(it[1]!= null){
				it[1]= it[1].toDouble()
			}
			else{
			it[1]=0
			}
			
			if(it[2]!= null){
				it[2]= it[2].toDouble()
			}
			else{
				it[2]=0
			}
			total += it[1] + it[2]
			it[3]= total
			if(it[0]>currentMonth){
				it[3]=0
			}
		}

		return yearOverview
	}
}
