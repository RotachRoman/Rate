//
//  SearchRates.swift
//  Rate
//
//  Created by Rotach Roman on 25.09.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit

protocol ISearchRates {
    func searchBarTextDidBeginEditing(searchBar: UISearchBar)
    func searchBarTextDidEndEditing(searchBar: UISearchBar)
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
}

class SearchCurrence: ISearchRates{
    
    var searchActive : Bool = false
    private var data = currencyDictionary
    var filtered:[String] = []
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }

    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

        filtered = data.filter({ (text) -> Bool in
            let tmp = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
    }



}
