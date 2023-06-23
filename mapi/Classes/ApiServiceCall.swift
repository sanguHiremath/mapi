//
//  Created by Sangamesh on 14/06/23.
//

import Foundation

public protocol ServiceRunnable {
    
    func networkRequest<T:Codable>(request: URLRequest, completionHandler:@escaping(_ result: T)-> Void)
    
}

public class ApiServiceCall {
    public init(){}
    
     public func networkRequest(request: URLRequest, completionHandler:@escaping(_ result: Data?)-> Void){
        URLSession.shared.dataTask(with: request) { data, response, error in
            completionHandler(data)
        }.resume()
     }
}



