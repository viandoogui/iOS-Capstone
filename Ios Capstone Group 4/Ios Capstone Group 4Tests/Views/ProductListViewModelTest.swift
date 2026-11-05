//
//  ProductListViewModelTest.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 11/4/26.
//


import Testing
@testable import Ios_Capstone_Group_4

@MainActor
struct ProductListViewModelTests {
    
    @Test func searchLetter() async {
        let repo = MockProductRepository()
        let viewModel = ProductListView.ViewModel(repository: repo)
        
        await viewModel.loadProducts()
        
        viewModel.filter = "d"
        
        #expect(viewModel.matchingProduct.count == 4)
    }
    
    
    @Test func searchSubstring() async {
        let repo = MockProductRepository()
        let viewModel = ProductListView.ViewModel(repository: repo)
        
        await viewModel.loadProducts()

        viewModel.filter = "Ad"
        
        #expect(viewModel.matchingProduct.count == 2)
    }
    
    @Test func searchAllLowercase() async {
        let repo = MockProductRepository()
        let viewModel = ProductListView.ViewModel(repository: repo)
        
        await viewModel.loadProducts()
        
        viewModel.filter = "led"
        
        #expect(viewModel.matchingProduct.count == 1)
        #expect(viewModel.matchingProduct.contains(where: { $0.name == "LED Headlight 800" }) == true)
    }
    
    @Test func searchAllUppercase() async {
        let repo = MockProductRepository()
        let viewModel = ProductListView.ViewModel(repository: repo)
        
        await viewModel.loadProducts()
        
        
        viewModel.filter = "CRUISER"
        
        #expect(viewModel.matchingProduct.count == 1)
        #expect(viewModel.matchingProduct.contains(where: { $0.name == "City Cruiser 3-Speed" }) == true)
    }
    
    @Test func searchSpace() async {
        let repo = MockProductRepository()
        let viewModel = ProductListView.ViewModel(repository: repo)
        
        await viewModel.loadProducts()
        
        viewModel.filter = " "
        
        #expect(viewModel.matchingProduct.count == 0)
    }
    
    @Test func searchSplitName() async {
        let repo = MockProductRepository()
        let viewModel = ProductListView.ViewModel(repository: repo)
        
        await viewModel.loadProducts()
        
        viewModel.filter = "tain Pro"
        
        #expect(viewModel.matchingProduct.count == 1)
        #expect(viewModel.matchingProduct.contains(where: { $0.name == "Mountain Pro 500"}) == true)
    }
    
    @Test func sortAZ() async {
        let repo = MockProductRepository()
        let viewModel = ProductListView.ViewModel(repository: repo)
        
        await viewModel.loadProducts()
        
        viewModel.sortAZ()
        
        let names = viewModel.matchingProduct.map { $0.name }
        
        #expect(names == ["City Cruiser 3-Speed", "Hydration Pack 12L", "LED Headlight 800", "Mountain Pro 500", "Road Racer Elite", "Trail Helmet X"])
    }
    @Test func sortZA() async {
        let repo = MockProductRepository()
        let viewModel = ProductListView.ViewModel(repository: repo)
        
        await viewModel.loadProducts()
        
        viewModel.sortZA()
        
        let names = viewModel.matchingProduct.map { $0.name }
        
        #expect(names == ["Trail Helmet X","Road Racer Elite","Mountain Pro 500", "LED Headlight 800","Hydration Pack 12L", "City Cruiser 3-Speed"   ])
    }
    
    @Test func searchLetterAndSortAZ() async {
        let repo = MockProductRepository()
        let viewModel = ProductListView.ViewModel(repository: repo)
        
        await viewModel.loadProducts()
        
        viewModel.filter = "R"
        viewModel.sortAZ()
        
        let names = viewModel.matchingProduct.map { $0.name }
        
        #expect(viewModel.matchingProduct.count == 5)
        #expect(names == ["City Cruiser 3-Speed","Hydration Pack 12L","Mountain Pro 500","Road Racer Elite","Trail Helmet X"])
    }
   
    @Test func sortPriceLowToHigh() async {
        let repo = MockProductRepository()
        let viewModel = ProductListView.ViewModel(repository: repo)
        
        await viewModel.loadProducts()
        
        viewModel.LowToHigh()
        
        let prices = viewModel.matchingProduct.map { $0.listPrice }
        
        #expect(prices == prices.sorted(by: <))
        #expect(viewModel.matchingProduct.count > 0)
    }

    @Test func sortPriceHighToLow() async {
        let repo = MockProductRepository()
        let viewModel = ProductListView.ViewModel(repository: repo)
        
        await viewModel.loadProducts()
        
        viewModel.HighToLow()
        
        let prices = viewModel.matchingProduct.map { $0.listPrice }
        
        #expect(prices == prices.sorted(by: >))
        #expect(viewModel.matchingProduct.count > 0)
    }
}

