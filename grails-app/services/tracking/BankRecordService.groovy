package tracking

import grails.transaction.Transactional
import java.text.ParseException
import java.text.SimpleDateFormat
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest

@Transactional
class BankRecordService {
	/**Takes an uploaded file and reads the data into the bank record tab
	 * @param request the HTTP request map 
	 * @param flash the object that comes with the call to grails controller 
	 * @Param account the tracking.Account object
	 */
    def upload(DefaultMultipartHttpServletRequest request,Map flash, Account account) {
		def bank = account.bank
		List newFile = []
		request.getFile("file").inputStream.eachLine{
			//Get the input stream of a file that is taken from the request
			List row = it.split(",")//Split each line into elements delimited by comma
			newFile << row //Add the list as an element in the new file
		}
		List bankRecordsList = []
		List duplicateBankRecordsList = []
		
		int i = 0
		if(bank.hasHeading == "Y"){
			i=1
		}
		for(i; i < newFile.size(); i++){
			List row = newFile.get(i)
			BankRecord bankRecord = new BankRecord()
			try {
				
				bankRecord.description = row.get(bank.descriptionColumn)
				if(bankRecord.description == ''){
					throw new Exception()
				}
			} catch (IndexOutOfBoundsException e) {
			} catch (Exception e){
				flash.errors.descriptionError = "Description should not be assigned to a blank column| Occured on row ${i}"
			}
			
			try {
				bankRecord.transactionDate = new SimpleDateFormat(bank.dateFormat).parse(row.get(bank.dateColumn))
				if(bankRecord.transactionDate.format("MM/dd/yyyy")=="01/01/1970"){
					throw new Exception()
				}
			} catch (IndexOutOfBoundsException e) {
				println e.message
			} catch (ParseException e){
				flash.errors.dateError = "The column assign to Transaction Date has the wrong data type [${e.message}]"
			} catch (Exception e){
				flash.errors.dateError = "The Date Format was invalid."
			}
			if(flash.errors.dateError){
				flash.errors.dateError += "| Occured on row ${i}"
			}
			
			try {
				
				if(bank.hasMultipleAmountColumns == "Y"){
					if(row.get(debitColumn)){
						bankRecord.amount = Math.abs(row.get(bank.debitColumn).replace("\"", "").toDouble()) * (-1)
					}else{
						bankRecord.amount = Math.abs(row.get(bank.creditColumn).replace("\"", "").toDouble())
					}
				}else{
					bankRecord.amount = row.get(bank.amountColumn).replace("\"", "").toDouble()
				}
			} catch (IndexOutOfBoundsException e) {
				println e.message
			} catch(NumberFormatException e){
				flash.errors.numberError = "The amount property was not to a compatible Column. There was a problem recognizing the data as a number. [${e.message}]"
			}
			if(flash.errors.numberError){
				flash.errors.numberError += "| Occured on row ${i}"
			}
			
			bankRecord.account = account
			
			
			
			if(flash.errors){
				return "errors"
			}
			
			if(bankRecord.save()){
				bankRecordsList << bankRecord
			}else{
				duplicateBankRecordsList << bankRecord
			}
		}
		
		if(!flash.errors){
			flash.message = "${bankRecordsList.size()} Bank Records where added. The file contained ${duplicateBankRecordsList.size()} duplicate records."
			[bankRecordsList:bankRecordsList,duplicateBankRecordsList:duplicateBankRecordsList]
		}
    }
}
