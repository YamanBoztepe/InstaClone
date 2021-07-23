//
//  SignUpViewModel.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 21.07.2021.
//

import Foundation

class SignUpViewModel: BaseViewModel {
    private(set) var countries = [Country]()
    private(set) var cities = [CityDetails]()
    
    func getCountries() {
        let regionCodes = Locale.isoRegionCodes
        for regionCode in regionCodes {
            let country = Country(countryCode: regionCode, name: Locale.current.localizedString(forRegionCode: regionCode) ?? "")
            countries.append(country)
        }
    }
    
    func getCities(from countryCode: String) {
        let networkManager = NetworkManager.shared
        let url = URLConstants.geoBaseUrl + "\(countryCode)/regions/?limit=10&asciiMode=true"
        if let request = networkManager.createUrlRequest(from: url, addValues: [URLConstants.geoApiField : URLConstants.geoApiKey]) {
            
            networkManager.getData(from: request, responseModel: City.self) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.cities = response.data ?? []
                    self.fetchCompleted?()
                case .failure(let error):
                    print(error)
                    self.errorHandler?(error)
                }
            }
        }
    }
}
