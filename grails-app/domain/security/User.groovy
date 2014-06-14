package security

class User {
	
	String userName
	String password
	String name
	
    static constraints = {
		userName blank:false,unique:true
		password blank:false
		name blank:false
    }
	static mapping = {
		table 'USER_TABLE'
	}
}
