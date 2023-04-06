//
//  PostViewController.swift
//  BeReal Clone
//
//  Created by Victoria Nunez on 4/5/23.
//

import UIKit

import PhotosUI
import ParseSwift


class PostViewController: UIViewController {
    
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var captionTextField: UITextField!
    
    @IBOutlet weak var previewImageView: UIImageView!
    

    private var pickedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onPickedImageTapped(_ sender: Any) {
        var config = PHPickerConfiguration()
        config.filter = .images

        config.preferredAssetRepresentationMode = .current

        config.selectionLimit = 1

        let picker = PHPickerViewController(configuration: config)

        picker.delegate = self

        present(picker, animated: true)

    }
    
    @IBAction func onShareTapped(_ sender: Any) {
        view.endEditing(true)

        guard let image = pickedImage,
              let imageData = image.jpegData(compressionQuality: 0.1) else {
            return
        }

        let imageFile = ParseFile(name: "image.jpg", data: imageData)

        var post = Post()

        post.imageFile = imageFile
        post.caption = captionTextField.text

        post.user = User.current
        post.save { [weak self] result in

            DispatchQueue.main.async {
                switch result {
                case .success(let post):
                    print("✅ Post Saved! \(post)")

                    self?.navigationController?.popViewController(animated: true)

                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
            }
        }


    }

    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

extension PostViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let provider = results.first?.itemProvider,
           provider.canLoadObject(ofClass: UIImage.self) else { return }

        provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in

           guard let image = object as? UIImage else {

              self?.showAlert()
              return
           }

           if let error = error {
               self?.showAlert(description: String(describing: error))
              return
           } else {
              DispatchQueue.main.async {
                 self?.previewImageView.image = image
                 self?.pickedImage = image
              }
           }
        }
    }

}

