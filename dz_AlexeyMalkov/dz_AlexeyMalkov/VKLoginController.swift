//
//  VKLoginController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 17.06.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class VKLoginController: UIViewController, WKNavigationDelegate{

    @IBOutlet weak var webView: WKWebView!
    
    var token = ""
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7513754"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        webView.navigationDelegate = self
        webView.load(request)
    }
}

extension VKLoginController{
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
                
        let token = params["access_token"]
        print(token!)
        self.token = token!
        
        let userID = params["access_userId"] ?? ""
        UserSession.instance.userId = Int(userID) ?? 0
        print(userID)
        
        loadFriends()
        loadGroups()
        loadPhotos()
        loadAllGroups()
        performSegue(withIdentifier: "VKLogin", sender: nil)
        decisionHandler(.cancel)
    }
    
    func loadFriends() {
        let baseUrl = "https://api.vk.com"
        let path = "/method/friends.get"
    
        let params: Parameters = [
            "access_token" : token,
            "fields": "bdate",
            "v" : "5.103"
        ]
        AF.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            guard let value = response.value else {return}
            print(value)
            }
        }
    
    func loadGroups(){
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token" : token,
            "extended" : 1,
            "v" : "5.68"
        ]
        AF.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            guard let value = response.value else {return}
            print(value)
        }
    }
    func loadPhotos(){
        let baseUrl = "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let params: Parameters = [
            "access_token" : token,
            "no_service_albums": 1,
            "v" : "5.103"
        ]
        AF.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            guard let value = response.value else {return}
            print(value)
        }
    }
    func loadAllGroups(){
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token" : token,
            "q" : "q",
            "v" : "5.103"
        ]
        AF.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            guard let value = response.value else {return}
            print(value)
        }
    }
}
