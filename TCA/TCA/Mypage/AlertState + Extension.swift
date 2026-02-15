//
//  AlertState + Extension.swift
//  TCA
//
//  Created by 소은 on 2/10/26.
//
import SwiftUI
import ComposableArchitecture

enum AlertType {
    case error(message: String)
}

extension AlertState {
    static func createAlert(type: AlertType) -> AlertState {
        switch type {
        case let .error(message):
            return AlertState( title: {TextState("에러") },
                               actions: { ButtonState {TextState("확인")}},
                               message: { TextState("에러가 발생했습니다. \(message)")}
            )
        }
    }
}


