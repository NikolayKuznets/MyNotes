//
//  NoteDetailViewController.swift
//  MyNotes
//
//  Created by Ник К on 25.12.2022.
//

import UIKit

class NoteDetailViewController: UIViewController {
    var note: Note?

    @IBOutlet weak var contentTextView: UITextView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = note?.title
        contentTextView.text = note?.content
    }
    

    
}
