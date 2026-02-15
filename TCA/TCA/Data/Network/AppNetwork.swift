//
//  AppNetwork.swift
//  TCA
//
//  Created by 소은 on 2/15/26.
//

import Alamofire

protocol AppNetworkProtocol {
    func fetchAppList(term: String, limit: Int) async -> Result<[AppListItem], NetworkError>
    func fetchAppDetail(id: Int) async -> Result<[AppDetailItem], NetworkError>
}

struct AppNetwork: AppNetworkProtocol {
    
    private let mananger = NetworkManager()
    
    private let baseURL = "https://itunes.apple.com/"
    
    func fetchAppList(term: String, limit: Int) async -> Result<[AppListItem], NetworkError> {
        let url = baseURL + "search?term=\(term)&country=kr&entity=software&limit=\(limit)"
        return await mananger.fetchData(url: url, method: .get)
    }
    
    func fetchAppDetail(id: Int) async -> Result<[AppDetailItem], NetworkError> {
        let url = baseURL + "lookup?id=\(id)&country=kr"
        return await mananger.fetchData(url: url, method: .get)
    }
}


struct MockAppNetwork: AppNetworkProtocol {
    func fetchAppList(term: String, limit: Int) async -> Result<[AppListItem], NetworkError> {
        .success([])
    }
    
    func fetchAppDetail(id: Int) async -> Result<[AppDetailItem], NetworkError> {
        .failure(.invalid)
    }
}
