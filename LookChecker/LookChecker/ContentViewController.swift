//
//  ContentViewController.swift
//  macOSCam
//
//

import Cocoa
import AVFoundation

class ContentViewController: NSViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var session: AVCaptureSession!
    var input: AVCaptureDeviceInput!
    var output: AVCaptureVideoDataOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var connection: AVCaptureConnection!
    let captureSession = AVCaptureSession()

    @IBOutlet weak var cameraView: NSView!
    @IBOutlet weak var cancelView: NSView!
    @IBOutlet weak var cancelCameraButton: NSButton!
    @IBOutlet weak var closeButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a capture session
        session = AVCaptureSession()

        // Find the front camera
        let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)

        // Create an input with the front camera
        input = try! AVCaptureDeviceInput(device: frontCamera!)

        // Add the input to the session
        session.addInput(input)

        // Create an output
        output = AVCaptureVideoDataOutput()

        // Set the sample buffer delegate to self
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "MyQueue"))

        // Add the output to the session
        session.addOutput(output)

        // Create a preview layer
        previewLayer = AVCaptureVideoPreviewLayer(session: session)

        previewLayer.frame = view.frame
        closeButton.action = #selector(cancelButtonPressed(_:))
        cancelCameraButton.action = #selector(appDelegate().togglePopover(_:))

        // Add the preview layer to the view
        view.layer?.addSublayer(previewLayer)

        // Get the connection for the front camera
        connection = output.connection(with: .video)

        // Turn off mirroring
        connection.automaticallyAdjustsVideoMirroring = false
        connection.isVideoMirrored = false
        connection.videoOrientation = .portrait

        previewLayer.connection?.automaticallyAdjustsVideoMirroring = false
        previewLayer.connection?.isVideoMirrored = false
    }
    
    override func viewWillAppear() {
            // Start the session
            session.startRunning()
    }

    @objc func cancelButtonPressed(_ sender: NSButton) {
        // Code to be executed when the button is pressed goes here
        NSApplication.shared.terminate(self)

    }

    func appDelegate() -> AppDelegate {
        return NSApplication.shared.delegate as! AppDelegate
    }

    override func viewWillDisappear() {
            super.viewWillDisappear()
            self.session?.stopRunning()
            removeFromParent()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //Do something with the sample buffer
    }
}
