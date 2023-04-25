//
//  UserDetailsNetworkService.swift
//  SSL-Pinning-For-URLSession
//
//  Created by Mac on 12/03/22.
//

import Foundation
import UIKit

class UserDetailsNetworkService: NetworkServiceHandler, UserDetailsProtocol {
    // MARK: - Get User List
    func makeRequestForUserList(cache: Bool, completion: @escaping (Result<[User], Error>) -> Void) {
        request(route: .user, cache: cache, type: [User].self, completion: completion)
    }
    
    // MARK: - Get User's Blog Post Details
    func makeRequestForUserBlogPost(parameter: [String: Any]?, completion: @escaping (Result<PostDetail, Error>) -> Void) {
        request(route: .posts, method: .POST, parameter: parameter, cache: true, type: PostDetail.self,completion: completion)
    }
}
