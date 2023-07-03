//
//  ViewController.swift
//  mapi
//
//  Created by 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 on 06/16/2023.
//  Copyright (c) 2023 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. All rights reserved.
//

import UIKit
import mapi

class ViewController: UIViewController {
    
    let data = ApiServiceCall()
    let req = NetworkServicesImpl()
    
    let postUrl = "https://jsonplaceholder.typicode.com/posts"
    let putUrl = "https://jsonplaceholder.typicode.com/posts/1"
    let deleteUrl = "https://jsonplaceholder.typicode.com/posts/1"
    let getUrl  = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=1d3d0861bce94607af863f33c17b0cc3"

    let body :[String:AnyHashable] =
    [
        "userId": 1,
        "title" : "Welcome to Moonraft",
        "body"  : "Post request Test",
        "id"    : 1
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
      
        guard let url = URL(string: postUrl) else {return}
        
        let urlRequest = req.createRequest(requestUrl: url,
                                           httpMethod: HttpMethods.post,
                                           header: [HeaderValues.content_type:HeaderFields.application_json],
                                           requestBody: body)
                            
        data.networkRequest(request: urlRequest) { result in
          let val = self.req.decodeData(decodeData: result, dataType: Result.self)
            print("data is  \(val?.title ?? "empty")")
        }
    
    }
}

public enum HttpMethods {
    public static let post = "POST"
    public static let put = "PUT"
    public static let get = "GET"
    public static let delete = "DELETE"
    public static let patch = "PATCH"
}

public enum HeaderValues {
    public static let content_type = "Content-Type"
    public static let application_json = "Accept"
}

public enum HeaderFields{
    public static let application_json = "application/json"
    public static let application_pdf = "application/pdf"
    public static let application_xml = "application/xml"
    public static let text_html = "text/html"
}



struct APIResponse: Decodable{
    let articles: [Article]
}

struct Article: Decodable{
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct Source: Decodable{
    let name: String
}


struct Result: Decodable{
    let userId: Int
    let title : String
    let body  : String
    let id    : Int
}


struct UploadData: Decodable{
    let name : String
    let job  : String
}





