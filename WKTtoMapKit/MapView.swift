//
//  MapView.swift
//  WKTtoMapKit
//
//  Created by Zoe Cutler on 5/24/23.
//

import SwiftUI
import MapKit
import GEOSwift

struct MapView: UIViewRepresentable {
    
    let region: MKCoordinateRegion
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = region
        
        try? WKTService.addOverlays(from: "CompletedGreenways", type: .lineString, to: mapView)
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.systemGreen
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer()
    }
}
