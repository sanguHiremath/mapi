//
//  NetworkServices.swift
//  mapi
//
//  Created by Sangamesh on 23/06/23.
//

import Foundation

public protocol NetworkServices{
    func createRequest(requestUrl: URL, httpMethod: String?, header:[String:String], requestBody: [String:AnyHashable])->URLRequest
 
    func decodeData<T:Decodable>(decodeData: Data?, dataType: T.Type)->T?
}

public class NetworkServicesImpl: NetworkServices{
    
    public init(){}

    public func createRequest(requestUrl: URL, httpMethod: String?, header: [String : String], requestBody: [String : AnyHashable]) -> URLRequest {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = httpMethod
        
        for(key, value) in header {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: .fragmentsAllowed)
        
        return urlRequest
    }
    
    public func decodeData<T:Decodable>(decodeData: Data?, dataType: T.Type)->T?{
        if(decodeData != nil && decodeData?.count != 0)
        {
            do {
                let data = try JSONDecoder().decode(T.self, from: decodeData!)
                return data
            }
            catch let decodingError {
                debugPrint(decodingError)
            }
        }
        return nil
    }
    
}
