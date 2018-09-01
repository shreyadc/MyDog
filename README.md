# MyDog

A basic iOS application developed in Swift using MVVM design pattern, following the SOLID and DRY Principles. The app displays a simple login screen. On login the user is taken to the Home Page. Once the user logs in the user can not logout. Even on restarting the app the user will be taken directly to the Home Page. 

There are two tabs Home and "My Dog". Home will display a simple text. My Dog tab will display a random dog image and the breed name of the dog. There is a button called "Thats not my dog!". On tapping the button another random dog image and the corresponding breed name will be displayed.

Also, network error handling has been implemented to handle parse errors. Decodable protocol has been used to parse the json response from the network calls.

Architecture:

I have used MVVM for developing the application. In order to keep the business logic free from the view and the models I have created the “View Model” layer which encapsulates the business model used by the application. This helps to keep the view controller and the view files to have very less and ‘to the point’ code. This also completely isolates the model. Data Binding is also implemented using Generics to make the code cleaner and update the UI automatically whenever the datasource changes.

Alamofire is used for scalable network operations.

OHHTTPStubs is used for Unit testing the network layer.
