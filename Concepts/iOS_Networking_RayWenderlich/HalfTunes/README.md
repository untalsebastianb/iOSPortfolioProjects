Hi <br> 
this project is part of the Networking with URLSession course of RayWenderlich. <br>
Link: https://www.raywenderlich.com/10376245-networking-with-urlsession

where I tried and learned concepts about the iOS Newtorking layer. <br>

**Covered concepts** <br>
URLSession Configuration <br>
URLSession Connections <br>
Downloading Files <br>
Uploading Data <br>
Pausing, Resuming and Canceling Data <br>
Showing Network Progress <br>
Simulating Different Network Speeds <br>
Vapor Framework <br>
Background Downloading <br>
WebSockets <br>
URLSession and Combine <br>
Authentication <br>
Application Transport Security <br>
Cookies <br>

for this specific project, I used the URLSessionDownloadTask and it's respective delegate methods to download a song. 
using the delegate methods to know if the download fails, or if it succeeded, handle the response, and save it from a temporary file to a permanent file, <br>
also exposing this data in an ObservableObject for the UI to react when the property in charge of the downloaded data change

