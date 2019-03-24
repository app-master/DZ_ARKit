//
//  ViewController.swift
//  DZ_ARKit
//
//  Created by user on 23/03/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.showsStatistics = true
        sceneView.debugOptions = [SCNDebugOptions.showFeaturePoints, SCNDebugOptions.showWorldOrigin]
        
        let scene = SCNScene()
        
        loadCampus(in: scene)
        
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    func loadCampus(in scene: SCNScene) {
        
        let mainNode = SCNNode()
        mainNode.position = SCNVector3(0, 0, -1)
        
        mainNode.addChildNode(createGrass())
        mainNode.addChildNode(createBuilding())
        mainNode.addChildNode(createRoad1())
        mainNode.addChildNode(createRoad2())
        mainNode.addChildNode(loadHorseFrom(sceneFile: "art.scnassets/Hourse_DAE.scn")!)
        mainNode.addChildNode(loadHumanFrom(sceneFile: "art.scnassets/Ribak_Rigged.scn")!)
        
        var x: Double = -0.2
        var z: Double = -0.8
        
        for _ in 0..<7 {
            for _ in 0..<10 {
                mainNode.addChildNode(createTree(x: x, y: 0, z: z))
                x += 0.2
            }
            z += 0.2
            x = -0.2
        }
        
        scene.rootNode.addChildNode(mainNode)
    }
    
    func createGrass() -> SCNNode {
        
        let geometry = SCNPlane(width: 5, height: 2)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "grass.jpg")
        
        geometry.materials = [material]
        
        let grassNode = SCNNode(geometry: geometry)
        grassNode.position = SCNVector3(0, -0.001, 0)
        grassNode.eulerAngles.x = -.pi / 2
        
        return grassNode
    }
    
    func loadHorseFrom(sceneFile: String) -> SCNNode? {
        
        guard let scene = SCNScene(named: sceneFile) else { return nil }
        
        let node = scene.rootNode
        node.position = SCNVector3(x: -1, y: 0.24, z: 0)
        node.scale = SCNVector3(x: 0.08, y: 0.08, z: 0.04)
        node.eulerAngles.y = .pi / 2
        
        return node
        
    }
    
    func loadHumanFrom(sceneFile: String) -> SCNNode? {
    
    guard let scene = SCNScene(named: sceneFile) else { return nil }
    
    let node = scene.rootNode
    node.position = SCNVector3(x: -0.8, y: 0, z: 0)
    node.scale = SCNVector3(x: 0.3, y: 0.3, z: 0.3)
    node.eulerAngles.y = -.pi / 2
    
    return node
    
    }
    
    func createTree(x: Double, y: Double, z: Double) -> SCNNode {
        
        let treeNode = SCNNode()
        treeNode.position = SCNVector3(x, y, z)
        
        let geometry1 = SCNCylinder(radius: 0.01, height: 0.4)
        let material1 = SCNMaterial()
        material1.diffuse.contents = UIImage(named: "treeBark.jpg")
        geometry1.materials = [material1]

        let node1 = SCNNode(geometry: geometry1)
        node1.position = SCNVector3(0, 0.2, 0)
        treeNode.addChildNode(node1)
        
        
        let geometry2 = SCNCone(topRadius: 0.001, bottomRadius: 0.1, height: 0.6)
        let material2 = SCNMaterial()
        material2.diffuse.contents = UIImage(named: "el.jpg")
        geometry2.materials = [material2]

        let node2 = SCNNode(geometry: geometry2)
        node2.position = SCNVector3(0, 0.4, 0)
        treeNode.addChildNode(node2)
        
        
        
        return treeNode
    }
    
    func createRoad1() -> SCNNode {
        
        let geometry = SCNPlane(width: 1, height: 0.5)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "asphalt1.jpg")
        geometry.materials = [material];
        
        let roadNode = SCNNode(geometry: geometry)
        roadNode.position = SCNVector3(-2, 0, 0.25)
        roadNode.eulerAngles.x = -.pi / 2
        
        return roadNode
    }
    
    func createRoad2() -> SCNNode {

        let geometry = SCNPlane(width: 5, height: 0.5)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "asphalt.jpg")
        geometry.materials = [material];

        let roadNode = SCNNode(geometry: geometry)
        roadNode.position = SCNVector3(0, 0, 0.75)
        roadNode.eulerAngles.x = -.pi / 2

        return roadNode
    }
    
    func createBuilding() -> SCNNode {
        
        let geometry = SCNBox(width: 1, height: 2, length: 1, chamferRadius: 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "building.jpg")
        
        let roofMaterial = SCNMaterial()
        roofMaterial.diffuse.contents = UIColor.gray
        
        geometry.materials = [material, material, material, material, roofMaterial, roofMaterial]
        
        let buildingNode = SCNNode(geometry: geometry)
        buildingNode.position = SCNVector3(-2, 1, -0.5)
        
        return buildingNode
    }
    

}
