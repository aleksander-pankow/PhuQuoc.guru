//
//  LocationExtension.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 19/06/2023.
//

import CoreLocation

extension CLPlacemark {

    var address: String? {
        if let name = name {
            var result = name

            if let street = thoroughfare {
                result += ", \(street)"
            }

            if let city = locality {
                result += ", \(city)"
            }

            if let country = country {
                result += ", \(country)"
            }

            return result
        }

        return nil
    }

}
