//
//  DetailViewController.swift
//  ReadmeTableView
//
//  Created by Sebastian on 8/10/22.
//

import Foundation
import UIKit

class DetailViewController: UITableViewController {
    
    let book: Book
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var reviewTextView: UITextView!
    
    @IBAction func updateImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType =
        UIImagePickerController.isSourceTypeAvailable(.photoLibrary) ? .photoLibrary : .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = book.image
        imageView.layer.cornerRadius = 16
        titleLabel.text = book.title
        authorLabel.text = book.author
        if let review = book.review {
            reviewTextView.text = review
        }
        
        reviewTextView.addDoneButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("this sould never be called")
    }
    
    init?(coder: NSCoder, book: Book) {
        self.book = book
        super.init(coder: coder)
    }
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        imageView.image = selectedImage
        Library.saveImage(selectedImage, forBook: book)
        dismiss(animated: true)
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}

extension UITextView {
    func addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
        
        toolbar.items = [flexSpace, doneButton]
        self.inputAccessoryView = toolbar
        
        
        
    }
}
