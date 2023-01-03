//
//  AddNoteViewController.swift
//  MyNotes
//
//  Created by Ник К on 25.12.2022.
//

import UIKit

protocol IAddNoteViewControllerDelegate: AnyObject {
    func didAddNote(_ note: Note)
    func didChangeNote(old: Note, new: Note)
}

final class AddNoteViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    weak var delegate: IAddNoteViewControllerDelegate?
    var note: Note?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = note?.title
        contentTextView.text = note?.content
        
       saveButton.isEnabled = false
        
        titleTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        contentTextView.delegate = self
    }
    
    @IBAction private func didTapCancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
          }
    
    @IBAction private func didTapDoneButton(_ sender: UIBarButtonItem) {
        guard let text = titleTextField.text else { return }
        guard let content = contentTextView.text else { return }
        
        if text == "" || content == "" {
            return
        }
        
        let note = Note(title: text, content: content)
        if let oldNote = self.note {
            delegate?.didChangeNote(old: oldNote, new: note)
        }
        else { delegate?.didAddNote(note)}
        
        navigationController?.popViewController(animated: true)
    }
    
}

extension AddNoteViewController {
   
    @objc private func textFieldChanged() {
        
        saveButton.isEnabled = titleTextField.text?.isEmpty == false
    }
}

extension AddNoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        saveButton.isEnabled = textView.text?.isEmpty == false
        }
}
