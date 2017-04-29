//
//  NotesListTableView.swift
//  ProjectFinal
//
//  Created by John Paul Young on 4/28/17.
//  Copyright © 2017 John Young. All rights reserved.
//

import UIKit

class NotesListTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    // MARK: - UIViewController Overrides
    private var _notes: [Note]? = nil
    
    override init(frame: CGRect, style: UITableViewStyle) {
        _notes = []
        super.init(frame: frame, style: style)
        dataSource = self
        self.allowsSelection = true
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //UITableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (_notes?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let note: Note = _notes![index]
        let date = monthDayYear(of: note)
        var noteDesc = (_notes?[index].text)!
        let maxCharacters = 20
        
        if (noteDesc.characters.count > maxCharacters) {
            let i = noteDesc.index(noteDesc.startIndex, offsetBy: maxCharacters)
            noteDesc = noteDesc.substring(to: i) + "..."
        }
        cell.textLabel?.text = date
        cell.detailTextLabel?.text = noteDesc
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index: Int = indexPath.row
        NSLog("Selected cell at index: \(index)")
        let note: Note = _notes![index]
        
        // TODO: implement note edit window here
        /* let noteViewController: NoteViewController = NoteViewController(note: note)
         navigationController?.pushViewController(noteViewController, animated: true)
         */
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete){
            let index: Int = indexPath.row
            NSLog("Attempted to delete cell at index: \(index)")
        }
    }
    
    private func monthDayYear(of note: Note) -> String {
        let day: Date = note.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        let monthDayYear: String = dateFormatter.string(from: day)
        return monthDayYear
    }
    
    public var notes: [Note] {
        get{
            return _notes!
        }
        set{
            _notes = newValue
            setNeedsDisplay()
            self.reloadData()
        }
    }

}
