//
//  ViewController.swift
//  CameraFilter
//
//  Created by raul.santos on 18/01/23.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    
    let disposeBag = DisposeBag()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nav = segue.destination as? UINavigationController,
              let photosVC = nav.viewControllers.first as? PhotosColletionViewController
                else {
            fatalError("Deu ruim na controler de photos")
        }
        
        photosVC.selectPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
        
    }
     
    @IBAction func applyFilterBtnPressed() {
        
        guard let sourceImage = self.photoImageView.image else {
            return
        }
        
        FilterService().appplyFilter(to: sourceImage)
            .subscribe(onNext: { filteredImage in
                DispatchQueue.main.async {
                    self.photoImageView.image = filteredImage
                }
            }).disposed(by: disposeBag)
        
    }
    
    func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.applyFilterButton.isHidden = false
    }

}

