//
//  UserResponse.swift
//  NetworkLayer
//
//  Created by AHMET KAZIM GUNAY on 29/10/2017.
//  Copyright © 2017 AHMET KAZIM GUNAY. All rights reserved.
//

import Foundation

 struct UserResponse: Codable {
    
     let userName: String?
     let userId: Int?
     let avatarUrl: String?
     let gravatarId: String?
     let url: String?
     let htmlUrl: String?
     let followersUrl: String?
     let followingUrl: String?
     let gistsUrl: String?
     let starredUrl: String?
     let subscriptionsUrl: String?
     let organizationsUrl: String?
     let reposUrl: String?
     let eventsUrl: String?
     let receivedEventsUrl: String?
     let type: String?
     let isSiteAdmin: Bool
     let name: String?
     let company: String?
     let blog: String?
     let location: String?
     let email: String?
     let isHireable: Bool?
     let bio: String?
     let publicRepos: Int?
     let publicGists: Int?
     let followers: Int?
     let following: Int?
     let error: String?
    
    enum CodingKeys: String, CodingKey {
        case userName = "login", userId = "id", avatarUrl = "avatar_url", gravatarId = "gravatar_id", url, htmlUrl = "html_url", followersUrl = "followers_url", followingUrl = "following_url", gistsUrl = "gists_url", starredUrl = "starred_url", subscriptionsUrl = "subscriptions_url", organizationsUrl = "organizations_url", reposUrl = "repos_url", eventsUrl = "events_url", receivedEventsUrl = "received_events_url", type, isSiteAdmin = "site_admin", name, company, blog, location, email, isHireable = "hireable", bio, publicRepos = "public_repos", publicGists = "public_gists", followers,following, error
    }
}
