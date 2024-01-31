//
//  ViewController.swift
//  CollageImage
//
//  Created by Xotech on 30/01/2024.
//

import UIKit
import PhotosUI
import CropViewController

class ViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var firstImageView: UIImageView!

    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var thirdImageView: UIImageView!
    
    
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var fourthImageView: UIImageView!
    
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var midImageView: UIImageView!
    
    var activeView : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(viewTappedOne(_:)))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(viewTappedTwo(_:)))
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(viewTappedThree(_:)))
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(viewTappedFour(_:)))
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(viewTappedFive(_:)))
        firstView.addGestureRecognizer(tapGesture1)
        secondView.addGestureRecognizer(tapGesture2)
        thirdView.addGestureRecognizer(tapGesture3)
        fourthView.addGestureRecognizer(tapGesture4)
        midView.addGestureRecognizer(tapGesture5)
       
    }
    
    @objc func viewTappedOne(_ sender: UITapGestureRecognizer) {
        activeView = 1
        viewTapped()
    }
    
    @objc func viewTappedTwo(_ sender: UITapGestureRecognizer) {
        activeView = 2
        viewTapped()
    }
    
    
    @objc func viewTappedThree(_ sender: UITapGestureRecognizer) {
        activeView = 3
        viewTapped()
    }
    
    
    @objc func viewTappedFour(_ sender: UITapGestureRecognizer) {
        activeView = 4
        viewTapped()
    }
    
    
    @objc func viewTappedFive(_ sender: UITapGestureRecognizer) {
        activeView = 5
        viewTapped()
    }
    
    
    
    func viewTapped() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
                
        let picker = PHPickerViewController(configuration: config)
                
        picker.delegate = self
                
        self.present(picker, animated: true)
    }
    
    func cropImage(_ image : UIImage){
        //print(image)
        var cropView = CropViewController(croppingStyle: .default, image: image )
        cropView.aspectRatioPreset = .presetSquare
        cropView.aspectRatioLockEnabled = false
        cropView.doneButtonTitle = "Done"
        cropView.delegate = self
        present(cropView,animated: true )
    }

    


}



extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true )
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { [self]object,error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async { [self] in
                        self.cropImage(image)
                    }
                }
            })
        }
    }
}


extension ViewController : CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        print("didCropToImage")
        print(activeView)
        
        switch activeView {
        case 1:
            firstImageView.image = image
        case 2:
            secondImageView.image = image
        case 3:
            thirdImageView.image = image
        case 4:
            fourthImageView.image = image
        default:
            midImageView.image = image
        }
       
        cropViewController.dismiss(animated: true)
    }
}

