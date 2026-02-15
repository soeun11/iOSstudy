//
//  DependencyValue.swift
//  TCA
//
//  Created by 소은 on 2/16/26.
//

import Dependencies

extension DependencyValues {
    var appRepository: AppRepository {
        get { self[AppRepository.self] }
        set { self[AppRepository.self] = newValue }
    }
}
