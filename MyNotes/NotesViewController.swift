//
//  NotesViewController.swift
//  MyNotes
//
//  Created by Ник К on 25.12.2022.
//

import UIKit


class NotesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var newNote: Note?
    var notes = [
        Note.init(title: "First notes", content: "Content first notes"),
        Note.init(title: "Two notes", content: "Content two notes")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        setupCell()
    }
    func setupCell() {
        let nib = UINib(nibName: "NoteCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: NoteCell.cellId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "SEGUE_NOTE_DETAIL":
            if let viewController = segue.destination as? AddNoteViewController,
               let note = sender as? Note {
                viewController.note = note
                viewController.delegate = self
            }
        case "SEGUE_ADDNOTE":
            if let viewController = segue.destination as? AddNoteViewController {
                viewController.delegate = self
            }
                
        default:
            return
        }
    }
}


// MARK: - UITableViewDataSource

extension NotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.cellId, for: indexPath) as! NoteCell
        let note = notes[indexPath.row]
        cell.titleLabel.text = note.title
        cell.contentLabel.text = note.content
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NoteCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        performSegue(withIdentifier: "SEGUE_NOTE_DETAIL", sender: note)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let row = indexPath.row
            notes.remove(at: row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension NotesViewController: IAddNoteViewControllerDelegate {
    func didChangeNote(old: Note, new: Note) {
        if let index = notes.firstIndex(of: old) {
        notes[index] = new
        }
        else { notes.append(new)
        }
        tableView.reloadData()
    }
    
    func didAddNote(_ note: Note) {
        notes.append(note)
        tableView.reloadData()
    }
    
}
