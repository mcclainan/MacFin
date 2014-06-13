			function populateForm(transactionId){
				populateField("transactionDate_day",document.getElementById("date_day" + transactionId).value)
				populateField("transactionDate_month",document.getElementById("date_month" + transactionId).value)
				populateField("transactionDate_year",document.getElementById("date_year" + transactionId).value)
                populateField("name",document.getElementById("name" + transactionId).value)
                populateField("amount",document.getElementById("amount" + transactionId).value)
                populateField("notes","")
                populateField("notes",document.getElementById("notes" + transactionId).value)
                populateField("category.id",document.getElementById("category.id" + transactionId).value)
                populateField("account",document.getElementById("account.id" + transactionId).value)
                populateField("assetLiability","null")
                populateField("assetLiability",document.getElementById("assetLiability.id" + transactionId).value)
                populateField("id",transactionId)
			}
			function populateField(id,value){
				document.getElementById(id).value = value;
			}
			function disableElement(id){
				var element = document.getElementById(id)
				element.disabled = "disabled"
			}
			function enableElement(id){
				var element = document.getElementById(id)
				element.disabled = false
			}
			
			function resetForm(){
				var date = ${new Date().format("dd").toInteger()}
				var month = ${new Date().format("MM").toInteger()}
				var year = ${new Date().format("yyyy").toInteger()}
				
				populateField("transactionDate_day", date)
				populateField("transactionDate_month",month)
				populateField("transactionDate_year",year)
                populateField("name","")
                populateField("amount","")
                populateField("notes","")
                populateField("category.id",1)
                populateField("account",1)
                populateField("assetLiability","null")
                populateField("id","")
                
                enableElement("create")
                enableElement("update")
                enableElement("delete")
                document.getElementById("transactionDate_day").focus()
			}
			
			function resetSearch(){
				populateField("dateSearchOption", "null")
				populateField("searchCategoryId","null")
				populateField("searchName","")
				populateField("searchAmount","")
                populateField("searchAccountId","null")
                populateField("searchAssetLiabilityId","null")
			}
			
			function toggleSearch(action){
				if(action == "on"){
					document.getElementById("searchForm").style.visibility = "visible"
				}else{
					document.getElementById("searchForm").style.visibility = "hidden"
				}
			}
			
			function centerSearch(){
				var width = window.innerWidth
				var height = document.body.clientHeight
				var top = (height/2) - 150
				var left = (width/2) - 350
				document.getElementById("searchForm").style.top = top + "px"
				document.getElementById("searchForm").style.left = left + "px"
			} 
			
			function collapseAllDates(){
				document.getElementById("byMonth").style.visibility = "collapse"
				document.getElementById("byDate").style.visibility = "collapse"
				document.getElementById("byDateRange").style.visibility ="collapse"
			}