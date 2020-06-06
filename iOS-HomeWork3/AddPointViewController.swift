//
//  AddPointViewController.swift
//  iOS-HomeWork3
//
//  Created by User on 06/06/2020.
//  Copyright © 2020 ViA. All rights reserved.
//

import UIKit
import Firebase

class AddPointViewController: UIViewController {

    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var latitudeText: UITextField!
    @IBOutlet weak var longitudeText: UITextField!
    
    @IBAction func saveCoordinates(_ sender: Any) {
        var id = 0
        ref.child("Points").observeSingleEvent(of: .value){
            snapshot in let coordinateDict = snapshot.value as? [String: AnyObject] ?? [:]
            id = coordinateDict.count
            let latitude = Double(self.latitudeText.text!)
            let longitude = Double(self.longitudeText.text!)
            self.ref.child("Points").child("\(id)").setValue(["Latitude": latitude ,"Longitude": longitude])
            
        }
        let alert = UIAlertController(title: "Done", message: "Click the button to contionue", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "very cool", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
