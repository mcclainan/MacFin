package utilities


class Random {

	static main(args) {
		double randomNumber = Random.getRandomDoubleWithRange(25, 35);
		System.out.println(randomNumber);

	}
	
	public static double getRandomDoubleWithRange(int min, int max){
		
		return min + Math.random() * ((max - min) + 1);
	}

}
