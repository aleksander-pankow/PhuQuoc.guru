//
//  NavigationManager.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 20/06/2023.
//

import MapKit

class NavigationManager {
    func moveTo(latitude: Double, longitude: Double, title: String) {
        let destinationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)  // Provide the latitude and longitude of the destination location

        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        destinationMapItem.name = title  // Name of the destination location

        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]  // Specify the directions mode

        MKMapItem.openMaps(with: [destinationMapItem], launchOptions: launchOptions)
    }
}
