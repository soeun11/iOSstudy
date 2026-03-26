//
//  APIClientTest.swift
//  BoxOffices
//
//  Created by 소은 on 3/3/26.
//

import XCTest
@testable import BoxOffices

final class APIClientTest: XCTestCase {

    func test_fetch() async throws {

        struct Response: Decodable {
            let boxOfficeResult: BoxOfficeResult

            struct BoxOfficeResult: Decodable {
                let dailyBoxOfficeList: [DailyBoxOffice]

                struct DailyBoxOffice: Decodable {
                    let movieCd: String
                }
            }
        }

        let apiClient = APIClient(
            key: "82ca741a2844c5c180a208137bb92bd7"
        )

        let response: Response = try await apiClient.fetch(
            path: "boxoffice/searchDailyBoxOfficeList.json",
            httpMethod: .get,
            queryItems: [
                URLQueryItem(name: "targetDt", value: "20120101")
            ]
        )

        XCTAssertEqual(response.boxOfficeResult.dailyBoxOfficeList.count, 10)
    }
}
