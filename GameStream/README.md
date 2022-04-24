## Welcome to the GameStream project <br>

The GameStream is an application where you can SignIn and SignUp, to do that, I used the UserDefaults class to create a persistence layer <br>
Thus you can register a new user and land on the Home page, where you will find the implementation of Grids to do carousels, a search bar where you can type and find your favorite game, and also the Populars, Suggested, Recommended, and Videos you might like sections. <br>

All of the data is being loaded from a remote server, using URlSession and @ObservableObject @Published @ObservedObject decorators to expose and get the data. <br>

I built this app using Swift UI, following the MVVM pattern and following the best practices to reach the goal.<br>
also, I used some external libraries to build some features. <br>


Clicking on any image from the carousel using NavigationLinks you'll be redirected to a detailed view of the game you just picked, where you will find the video game, followed by a description section using VStacks, HStacks, LazyHGrid, ZStacks, to organize the content properly. <br>

This was a really good project to implement a lot of knowledge from Swift UI, using the MVVM pattern I split the models, and the ViewModels (network calls, logic layers) from the views, thus making the project robust and scalable through time. <br>


External third parties libraries: <br>
‣ KingFisher - to load images from the server. <br>
‣ SUImagePickerView - to show an image picker to change the user profile pic. <br>

Figma: <br>
https://www.figma.com/file/J62PMUCv8uCtKNpoN3L7iK/Game-Stream?node-id=21%3A22 <br>


Demo gifs: <br>

UIAllerts:<br>
![AlertsDemo](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/GameStream/UIAllertsDemo.gif) <br>

SignIn: <br>
![SignIn Demo](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/GameStream/SignInDemo.gif)<br>

SignUp:<br>
![SingUp Demo](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/GameStream/SignUpDemo.gif)<br>

Home:<br>
![SingUp Demo](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/GameStream/HomeSlidesDemo.gif)<br>

Search bar:<br>
![SearchBar Demo](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/GameStream/SearchBarDemi.gif)<br>

Game view:<br>
![GameView Demo](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/GameStream/GamesDemo.gif)<br>

Favorites view:<br>
![GameView Demo](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/GameStream/FavoritesDemo.gif)<br>

Profile view:<br>
![Profile Demo](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/GameStream/ProfileDemo.gif)<br>

Certification:<br>
![Certification](https://github.com/untalsebastianb/iOSPortfolioProjects/blob/main/GameStream/SwiftUI%20Certification.png)<br>

Thank you for your time and I hope you like my work.






