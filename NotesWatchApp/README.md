## Hi there! 🙋🏼‍♂️<br>

Welcome to the NotesApp, this is an app built for the Apple Watch using SwiftUI <br>
I've follow good practices and some cool features to do it, on the app you'll be able to: <br>

⍟ Add a note <br>
⍟ Delete a note<br>
⍟ List your notes<br>
⍟ See the detail of your note<br>

To save the user notes I used the UserDefault class to persistence the data.
also using the views life cycle I was able to load and save the data. 

On the first screen you can decide if you want to add a note or check your notes<br>
[!HomeScreen](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/NotesWatchApp/Screen%20Shot%202022-04-30%20at%209.36.15%20AM.png) <br>

Write a note screen: <br>
[!AddNoteView](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/NotesWatchApp/AddNotes.png) <br>
You can save an emoji, or type your text using the pad of the Apple Watch, after you save your note, the view will dismiss letting you go to the home view. <br>

On the check notes, you'll be able to check all the notes you've saved. <br>
[!ListNotesView](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/NotesWatchApp/ListNotes.png) <br>

If you don't need your note anymore, using the OnDelete method I add functionality for you to delete your note swipping it to the left. 👈🏻 <br>
[!DeleteNoteView](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/NotesWatchApp/DeleteNotes.png) <br>

and clicking in one of them you can see the detail about the note, your message and the time the note was created. 🕰 <br>
[!DetailNoteView](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/NotesWatchApp/NoteDetail.png) <br>

Here is a full demo of the App: <br>
[!FullDemo](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/NotesWatchApp/FullDemo.gif) <br>

Thank you for being here. 😁

