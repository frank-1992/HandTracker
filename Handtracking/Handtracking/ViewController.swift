//
//  ViewController.swift
//  Handtracking
//
//  Created by frank on 12/6/22.
//

import UIKit
import ARKit
import RealityKit

class ViewController: UIViewController {
    

    lazy var arView: ARView = {
        let arView = ARView(frame: view.bounds)
        arView.session.delegate = self
        return arView
    }()
    
    lazy var handTracker: HandTracker = HandTracker()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(arView)

        handTracker.startGraph()
        handTracker.delegate = self
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetTracking()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
    
    private func resetTracking() {
        
        let config = ARBodyTrackingConfiguration()
        
//        config.planeDetection = [.horizontal, .vertical]
//        config.isLightEstimationEnabled = true
//        config.environmentTexturing = .automatic
//        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
//            switch config.frameSemantics {
//            case [.personSegmentationWithDepth]:
//                config.frameSemantics.remove(.personSegmentationWithDepth)
//            default:
//                config.frameSemantics.insert(.personSegmentationWithDepth)
//            }
//        }
        arView.session.run(config)
    }
}
extension ViewController: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
        let pixelBuffer = frame.capturedImage
        handTracker.processVideoFrame(pixelBuffer)
    }
    
}

extension ViewController : TrackerDelegate {
    
    func handTracker(_ handTracker: HandTracker!, didOutputLandmarks landmarks: [Landmark]!)  {
        print ("do something")
    }
    func handTracker(_ handTracker: HandTracker!, didOutputPixelBuffer pixelBuffer: CVPixelBuffer!) {
        
    }
}


