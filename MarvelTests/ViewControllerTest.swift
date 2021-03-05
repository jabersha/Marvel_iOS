//
//  ViewControllerTest.swift
//  MarvelTests
//
//  Created by Jaber Vieira Da Silva Shamali on 05/03/21.
//

import XCTest
@testable import Marvel

class ViewControllerTest: XCTestCase {

    func makeSUT() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateInitialViewController() as! ViewController
        sut.loadViewIfNeeded()
        return sut
        
    }
    
    func test_load_more(){
        let sut = makeSUT()
        let dados = 0
        
        sut.loadMore()
        XCTAssertLessThan(dados, sut.from)
        
    }
    
    func test_convert_url(){
        let sut = makeSUT()
        
        let link = sut.convertURL(link: "http://i.annihil.us/u/prod/marvel/i/mg/a/f0/5202887448860", extensionImg: "jpg", type: "SV")
        XCTAssertEqual(link, "https://i.annihil.us/u/prod/marvel/i/mg/a/f0/5202887448860/portrait_uncanny.jpg")
        
        }
    
    func test_convert_url_error(){
        let sut = makeSUT()
        
        let link = sut.convertURL(link: "http://i.annihil.us/u/prod/marvel/i/mg/a/f0/", extensionImg: "jpg", type: "SV")
        XCTAssertNotEqual(link, "https://i.annihil.us/u/prod/marvel/i/mg/a/f0/5202887448860/portrait_uncanny.jpg")
        
        }
    

}
