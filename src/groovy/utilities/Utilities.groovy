package utilities

import java.util.Map;

class Utilities {
	Map getBeginningAndEndOfMonth(int year, int month){
		Calendar calendar = Calendar.getInstance()
		calendar.set(year, month-1, 1)
		int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH)
		def firstOfMonth = new Date()
		firstOfMonth.set(year: year, month: month-1, date:1)
		def endOfMonth = new Date()
		endOfMonth.set(year: year, month: month-1, date:days)
		calendar.get(Calendar.DAY_OF_WEEK)
		
		[firstOfMonth:firstOfMonth.clearTime(),endOfMonth:endOfMonth.clearTime()]
	}
	public static Date getEndOfMonth(int year, int month){
		Calendar calendar = Calendar.getInstance()
		calendar.set(year, month-1, 1)
		int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH)
		def endOfMonth = new Date()
		endOfMonth.set(year: year, month: month-1, date:days)
		calendar.get(Calendar.DAY_OF_WEEK)
		return endOfMonth.clearTime()
	}
}
