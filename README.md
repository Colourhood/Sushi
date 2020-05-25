## Sushi is a lightweight HTTP networking library with JSON decoding built in - written in Swift. 

### __Installation__

#### Cocoapods
In your your `Podfile` file add the following...
```
pod 'Sushi' '~> 1.2.0'
```

#### Carthage
Support for carthage will be added in a future release

### Guide/Documentation
Sushi was designed around one particular objective - JSON decoding.

#### Step 1: Modeling your data
In this example, `UserModel` is the data model we expect to receive after creating and sending a request.
All models should conform to the `Codable` protocol.
```
struct UserModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
```

#### Step 2: Create an Endpoint
An Endpoint is a representation of a network endpoint that contains information such as:

`Model` - Data type represented from a request response.
`httpMethod` - HTTP Method: GET, POST (others coming soon)
`url` - A String with information to open a request

```
import Sushi

struct UserEndpoint: Endpoint {
    typealias Model = UserModel

    var httpMethod: HTTPMethod = .GET
    var urlRequest: String = "https://jsonplaceholder.typicode.com/todos/1"
}
```

#### Step 3: Calling a request
Finally, we create an instance of `Sushi` and `UserEndpoint`. Then create the request with the information provided from endpoint.

Sushi handles the request asynchronously, once the request has been completed either the `success` or `failure` callbacks will be called.
```
import Sushi

var endpoint = UserEndpoint()
var sushi: Sushi = Sushi()

sushi.request(endpoint: endpoint, success: { (data) in
    print("\(data)") // Data conforms to UserModel and Swift can now confidently infer properties from it
    
    print("\(data.userId))      // userId: 0
    print("\(data.id))          // id: 1234
    print("\(data.title))       // title: "Title received"
    print("\(data.completed))   // completed: false
})
```
