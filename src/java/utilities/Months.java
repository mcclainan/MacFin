package utilities;

import org.springframework.context.MessageSourceResolvable;

public enum Months implements MessageSourceResolvable {
	JANUARY("January",0),
	FEBRUARY("February",1),
	MARCH("March",2),
	APRIL("April",3),
	MAY("May",4),
	JUNE("June",5),
	JULY("July",6),
	AUGUST("August",7),
	SEPTEMBER("September",8),
	OCTOBER("October",9),
	NOVEMBER("November",10),
	DECEMBER("December",11);

	String name;
	Integer  number;
	
	
	private Months(String name, Integer number){
		this.name = name;
		this.number = number;
	}
	
	@Override
	public Object[] getArguments() {
		return null;
	}

	@Override
	public String[] getCodes() {
		String[] stringArr = {"enum.months." + number};
		return stringArr;
	}

	@Override
	public String getDefaultMessage() {
		return name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}
	
	

}
