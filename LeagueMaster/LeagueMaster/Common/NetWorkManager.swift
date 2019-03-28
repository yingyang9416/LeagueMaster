//
//  NetworkManager.swift
//  LeagueMaster
//
//  Created by Ying Yang on 3/27/19.
//  Copyright © 2019 Ying Yang. All rights reserved.
//

import Foundation

/// Enumeration of http methos
public enum HttpMethodType: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case HEAD = "HEAD"
    case DELETE = "DELETE"
}

/**
 Class to make web services requests
 */
public class NetWorkManager {
    // URL String
    var url: String
    
    /// Http method to make the call
    var httpMethod: HttpMethodType
    
    // Completion Handler
    public typealias CompletionHandler = (_ data: Data?, _ statusCode: Int?, _ error: Error?) -> Void
    
    /// Class designated initializer
    ///
    /// - Parameters:
    ///     - url: URL of the API to call out
    ///     - httpMethodType: Http Method (GET,POST)
    /// - Returns: Void
    /// - Date: 03/22/2019
    public init(URL: String, httpMethodType: HttpMethodType) {
        self.url = URL
        self.httpMethod = httpMethodType
    }
    
    /// Call out an API and returns result via Closure
    ///
    /// - Parameters:
    ///     - data: Data to send to the server (optional)
    ///     - httpHeaders: Header(s) to add to request [HttpHeader: Value] (optional)
    ///     - completionHandler: Closure that receives the server response (status code: String,data received: Any?, server response: URLResponse)
    /// - Returns: Void
    /// - Date: 03/22/2019
    public func callAPI(data: Any?, httpHeaders: [String: String]?, completionHandler: @escaping CompletionHandler) -> Void {
        
        //Data to send to API, parsed
        var dataParsed: AnyObject?
        
        //Set Request for URL
        let request = NSMutableURLRequest(url: URL(string: self.url)!)
        
        //Check if there are data to send
        if let data = data {
            
            do {
                dataParsed = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) as AnyObject?
                
            }catch {
                dataParsed = nil
            }
        }
        
        //Set Request
        request.httpMethod = self.httpMethod.rawValue
        request.httpBody = dataParsed as? Data
        
        if let headers = httpHeaders {
            headers.forEach { (key, value) in
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            completionHandler(data, (response as? HTTPURLResponse)?.statusCode, error)
        }).resume()
    }
    
    /// Call out an API and returns result via Closure
    ///
    /// - Parameters:
    ///     - dataParameter: Data to send to the server (optional)
    ///     - httpHeaders: Header(s) to add to request [HttpHeader: Value] (optional)
    ///     - completionHandler: Closure that receives the server response (status code: String,data received: Any?, server response: URLResponse)
    /// - Returns: Void
    /// - Date: 03/22/2019
    public func callAPI(dataParameter: [String: Any]? = nil, httpHeaders: [String: String]? = nil, completionHandler: @escaping CompletionHandler) -> Void {
        callAPI(data: dataParameter, httpHeaders: httpHeaders, completionHandler: completionHandler)
    }
    
}
