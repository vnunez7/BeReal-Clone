//
//  DateFormatter+Extensions.swift
//  BeReal Clone
//
//  Created by Victoria Nunez on 4/5/23.
//

import Foundation

extension DateFormatter {
    static var postFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
}
