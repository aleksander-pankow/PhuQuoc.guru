//
//  MapView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 20/06/2023.
//
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D
    let title: String
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        // Set initial map region
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        
        // Add pin annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update the map view if needed
    }
}
