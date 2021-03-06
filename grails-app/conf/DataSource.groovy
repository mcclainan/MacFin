dataSource {
    pooled = true
    jmxExport = true
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
//    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
}

// environment specific settings
environments {
    development {
        dataSource {
            driverClassName = "oracle.jdbc.driver.OracleDriver"
            dialect = "org.hibernate.dialect.Oracle10gDialect"
            username = "MAC_FINANCIAL_ADMIN"
            password = "!TMoancyf1"
//            url = "jdbc:oracle:thin:@24.255.171.38:1521:XE"
            url = "jdbc:oracle:thin:@localhost:1521:XE"
            pooled = true
            properties {
                maxActive = 100
                minEvictableIdleTimeMillis=1800000
                timeBetweenEvictionRunsMillis=1800000
                numTestsPerEvictionRun=3
                testOnBorrow=true
                testWhileIdle=true
                testOnReturn=true
                validationQuery="SELECT 1 from dual"
            }
        }
    }
    test {
		dataSource {
			driverClassName = "oracle.jdbc.driver.OracleDriver"
			dialect = "org.hibernate.dialect.Oracle10gDialect"
			username = "MAC_FINANCIAL_TEST"
			password = "TONY2505"
			url = "jdbc:oracle:thin:@24.255.171.38:1521:XE"
			dbcreate = 'update'
			pooled = true
			properties {
			   maxActive = -1
			   minEvictableIdleTimeMillis=1800000
			   timeBetweenEvictionRunsMillis=1800000
			   numTestsPerEvictionRun=3
			   testOnBorrow=true
			   testWhileIdle=true
			   testOnReturn=true
			   validationQuery="SELECT 1 from dual"
			}
		}
    }
    production {
        dataSource {
            driverClassName = "oracle.jdbc.driver.OracleDriver"
			dialect = "org.hibernate.dialect.Oracle10gDialect"
			username = "MAC_FINANCIAL_ADMIN"
			password = "!TMoancyf1"
//            url = "jdbc:oracle:thin:@24.255.171.38:1521:XE"	
            url = "jdbc:oracle:thin:@localhost:1521:XE"	
            pooled = true
            properties {
               maxActive = 100
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1 from dual"
            }
        }
    }
}
