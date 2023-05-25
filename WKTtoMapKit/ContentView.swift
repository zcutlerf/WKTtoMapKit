//
//  ContentView.swift
//  WKTtoMapKit
//
//  Created by Zoe Cutler on 5/24/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.33, longitude: -83.04),
        span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
    )
    
    var body: some View {
        MapView(region: region)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
