//
//  MapKitViewModel.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 04.03.25.
//

import SwiftUI
import MapKit

@Observable
class MapViewModel{
    var searchText: String = ""
    
    var currentPlace: CLPlacemark?
    
    var cameraPosition: MapCameraPosition = .region(.init(center: .home, latitudinalMeters: 1000, longitudinalMeters: 1000))
    
    var locationManager = CLLocationManager()
    
    var route: MKRoute?
    
    var lookAroundScene: MKLookAroundScene?
    var isShowingLookAroundScene = false
    
    
    func getLookAroundScene(from coordinate: CLLocationCoordinate2D) async {
        do {
            self.lookAroundScene = try await MKLookAroundSceneRequest(coordinate: coordinate).scene
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func getCoordinates(for locationName: String) {
        Task {
            guard let placemark = try? await CLGeocoder().geocodeAddressString(locationName).first else {
                return
            }
            
            self.currentPlace = placemark
            
            guard let location = placemark.location else {
                print("No Location")
                return
            }
            
            self.cameraPosition = .region(.init(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000))
            
        }
    }
    
    private func getUserLocation() async -> CLLocationCoordinate2D? {
        let updates = CLLocationUpdate.liveUpdates()
        do {
            let update = try await updates.first() { $0.location?.coordinate != nil }
            return update?.location?.coordinate
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func setUserLocation() async {
        let updates = CLLocationUpdate.liveUpdates()
        
        do {
            let update = try await updates.first() { $0.location?.coordinate != nil }
            guard let userLocation = update?.location?.coordinate else { return }
            self.cameraPosition = .region(.init(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000))
        } catch {
            print("error getting user location")
            return
        }
    }
    
    func calculateRoute(destination: CLLocationCoordinate2D) async {
        let directionRequest = MKDirections.Request()
        
        guard let userLocation = await getUserLocation() else { return }
        
        directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        directionRequest.transportType = .automobile
        
        Task {
            let directions = MKDirections(request: directionRequest)
            let response = try? await directions.calculate()
            self.route = response?.routes.first
        }
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension CLLocationCoordinate2D {
    static var home = CLLocationCoordinate2D(latitude: 51.4410628, longitude: 7.3402022)
    static var allianzArena = CLLocationCoordinate2D(latitude: 48.2187901, longitude: 11.6236227)
}


