package assetLiability

import grails.transaction.Transactional
import category.*

@Transactional
class AssetLiabilityService {

    def create(AssetLiability assetLiability) {
		//Get Asset Liability Class off the object assign it to local variable
		def alclass = assetLiability.assetLiabilityClass
		
		//Use a chain of if statements to determine what categories to create and create them
		
		//create categories for assets / investments
		def metaCategory
		if(alclass.onAppreciation){
			metaCategory = MetaCategory.findByName("INVESTMENT")
			def category = new Category(metaCategory:metaCategory,
				                                name:"${assetLiability.name}-Appr",
												type:"I",
												cash:"N",
									  assetLiability:assetLiability,
							    assetLiabilityAction:alclass.onAppreciation)
			assetLiability.addToCategories(category)
		}
		
		if(alclass.onDepreciation){
			metaCategory = MetaCategory.findByName("INVESTMENT")
			def category = new Category(metaCategory:metaCategory,
					name:"${assetLiability.name}-Deppr",
					type:"E",
					cash:"N",
					assetLiability:assetLiability,
					assetLiabilityAction:alclass.onDepreciation)
			assetLiability.addToCategories(category)
		}
		
		if(alclass.onPurchase){
			metaCategory = MetaCategory.findByName("INVESTMENT")
			def category = new Category(metaCategory:metaCategory,
					name:"${assetLiability.name}-Purch",
					type:"E",
					cash:"N",
					assetLiability:assetLiability,
					assetLiabilityAction:alclass.onPurchase)
			assetLiability.addToCategories(category)
		}
		
		if(alclass.onSale){
			metaCategory = MetaCategory.findByName("INVESTMENT")
			def category = new Category(metaCategory:metaCategory,
					name:"${assetLiability.name}-Sale",
					type:"I",
					cash:"N",
					assetLiability:assetLiability,
					assetLiabilityAction:alclass.onSale)
			assetLiability.addToCategories(category)
		}
		
		//Create categories for Liabilities/Loans and other classes of financing
		
		if(alclass.onInterest){
			metaCategory = MetaCategory.findByName("FINANCING")
			def category = new Category(metaCategory:metaCategory,
					name:"${assetLiability.name}-Int",
					type:"E",
					cash:"N",
					assetLiability:assetLiability,
					assetLiabilityAction:alclass.onInterest)
			assetLiability.addToCategories(category)
		}
		
		if(alclass.onPayment){
			metaCategory = MetaCategory.findByName("FINANCING")
			def category = new Category(metaCategory:metaCategory,
					name:"${assetLiability.name}-Pmt",
					type:"E",
					cash:"N",
					assetLiability:assetLiability,
					assetLiabilityAction:alclass.onPayment)
			assetLiability.addToCategories(category)
		}
		
		if(alclass.onProceedes){
			metaCategory = MetaCategory.findByName("FINANCING")
			def category = new Category(metaCategory:metaCategory,
					name:"${assetLiability.name}-Proceedes",
					type:"I",
					cash:"N",
					assetLiability:assetLiability,
					assetLiabilityAction:alclass.onProceedes)
			assetLiability.addToCategories(category)
		}
		
    }
}

