//
//  BarcodeScannerView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 18.02.25.
//

import SwiftUI
import AVFoundation


struct BarcodeScannerViewModel: UIViewControllerRepresentable {
    @Binding var scannedCode: String?
    var viewModel: ProductAPIViewModel

    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: BarcodeScannerViewModel

        init(parent: BarcodeScannerViewModel) {
            self.parent = parent
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
               let scannedCode = metadataObject.stringValue {
                DispatchQueue.main.async {
                    self.parent.scannedCode = scannedCode
                    self.parent.viewModel.fetchProduct(barcode: scannedCode)
                }
            }
        }
    }

    let captureSession = AVCaptureSession()

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else {
            return viewController
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }

        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean13, .ean8, .qr]
        }

        videoPreviewLayer.frame = viewController.view.layer.bounds
        videoPreviewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(videoPreviewLayer)

        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
