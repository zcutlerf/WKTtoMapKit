//
//  WKTService.swift
//  WKTtoMapKit
//
//  Created by Zoe Cutler on 5/25/23.
//

import Foundation
import MapKit
import GEOSwift

class WKTService {
    static func addOverlays(from fileName: String, type: GeoJSONType, to mapView: MKMapView) throws {
        let wktComponents = try readWKTFile(named: fileName)
        
        // TODO: implement different types of overlays
        switch type {
        case .point:
            //TODO: Do we need an implementation for this?
            break
        case .multiPoint:
            //TODO: Do we need an implementation for this?
            break
        case .lineString:
            for wktComponent in wktComponents {
                guard let lineString = try? LineString(wkt: wktComponent) else {
                    continue
                }
                
                let coordinates = lineString.points.map { point in
                    CLLocationCoordinate2D(latitude: point.y, longitude: point.x)
                }
                
                let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
                // We can add the overlay here because MKMapView is a class, which is a reference type, so we retain this information back in our MapView struct.
                mapView.addOverlay(polyline)
            }
        case .multiLineString:
            //TODO: Do we need an implementation for this?
            break
        case .polygon:
            //TODO: Do we need an implementation for this?
            break
        case .multiPolygon:
            //TODO: Do we need an implementation for this?
            break
        case .geometryCollection:
            //TODO: Do we need an implementation for this?
            break
        case .feature:
            //TODO: Do we need an implementation for this?
            break
        case .featureCollection:
            //TODO: Do we need an implementation for this?
            break
        //TODO: Add a default case to catch the ones we wont use?
        }
    }
    
    private static func readWKTFile(named fileName: String) throws -> [String] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            throw URLError(.fileDoesNotExist)
        }
        
        let content = try String(contentsOfFile: path)
        let lines: [String] = content.components(separatedBy: .newlines)
        
        var cells: [String] = []
        for index in 1..<lines.count {
            guard let start = lines[index].firstIndex(of: "\"") else { continue }
            guard let end = lines[index].lastIndex(of: "\"") else { continue }
            let realStart = lines[index].index(after: start)
            let realEnd = lines[index].index(before: end)

            let newCell = lines[index][realStart...realEnd]
            cells.append(String(newCell))
        }

        return cells
    }
}
