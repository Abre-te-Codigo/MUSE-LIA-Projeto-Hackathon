//
//  ARViewController.swift
//  AbraTeCodigo
//
//  Created by Ailton Vieira Pinto Filho on 24/10/20.
//

import UIKit
import ARKit
import SceneKit.ModelIO

class ARViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        sceneView.session.run(config)
        
        guard let url = Bundle.main.url(forResource: "coin", withExtension: "usdz") else { fatalError() }
        let mdlAsset = MDLAsset(url: url)
        let scene = SCNScene(mdlAsset: mdlAsset)
        
        let paperPlaneNode = scene.rootNode
//            paperPlaneNode.position = SCNVector3(x, y, z)
        sceneView.scene.rootNode.addChildNode(paperPlaneNode)

    }

}
