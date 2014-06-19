package utilities

class Experiment {
	static main (args){
		def date = new Date()
		println date.format('MM-dd-yyy')
		date.set(year:1976,month:11,date:29)
		println date.format('MM-dd-yyy')
	}
}
