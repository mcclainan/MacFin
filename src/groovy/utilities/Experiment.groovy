package utilities

class Experiment {
	static main (args){
		def startDay = "1".toInteger()
		println ">>>>>>>>>>>>>>>>>>${startDay}"
		def eh = new ExperimentHelper(startDay)
		println ">>>>>>>>>>>>>>>>>>${startDay}"
	}
}
