/**
 @header DetailImageViewController.Swift
 @brief This viewcontoller will manage the detail view, which will display the full image
 @author Dhara Naik on 1/10/17
 @Copyright © 2017 Verizon. All rights reserved.
 @version    1.0.0
 */

import UIKit

class DetailImageViewController: UIViewController {
    
    var selectedImageURL : String?
    
    @IBOutlet weak var imgDetailImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let imageURL = selectedImageURL
        {
            self.imgDetailImage.sd_setImage(with: URL(string: imageURL), placeholderImage:UIImage(named: "Mask"))
        }
    }

    
    /** Will hide the status bar */
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func maskImage(_ image: UIImage, withMask maskImage: UIImage) -> UIImage {
        
        let maskRef = maskImage.cgImage
        
        let mask = CGImage(
            maskWidth: maskRef!.width,
            height: maskRef!.height,
            bitsPerComponent: maskRef!.bitsPerComponent,
            bitsPerPixel: maskRef!.bitsPerPixel,
            bytesPerRow: maskRef!.bytesPerRow,
            provider: maskRef!.dataProvider!,
            decode: nil,
            shouldInterpolate: false)
        
        let masked = image.cgImage!.masking(mask!)
        let maskedImage = UIImage(cgImage: masked!)
        
        // No need to release. Core Foundation objects are automatically memory managed.
        
        return maskedImage
        
    }
    

}
