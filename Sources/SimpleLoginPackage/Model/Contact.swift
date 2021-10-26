//
//  Contact.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 18/10/2021.
//

import Foundation

public struct Contact {
    public let id: Int
    public let email: String
    public let creationTimestamp: TimeInterval
    public let lastEmailSentTimestamp: TimeInterval?
    public let reverseAlias: String
    public let reverseAliasAddress: String
    public let existed: Bool // Used when creating a new contact
}

extension Contact: Decodable {
    private enum Key: String, CodingKey {
        case id = "id"
        case email = "contact"
        case creationTimestamp = "creation_timestamp"
        case lastEmailSentTimestamp = "last_email_sent_timestamp"
        case reverseAlias = "reverse_alias"
        case reverseAliasAddress = "reverse_alias_address"
        case existed = "existed"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.creationTimestamp = try container.decode(TimeInterval.self, forKey: .creationTimestamp)
        self.lastEmailSentTimestamp = try container.decodeIfPresent(TimeInterval.self,
                                                                    forKey: .lastEmailSentTimestamp)
        self.reverseAlias = try container.decode(String.self, forKey: .reverseAlias)
        self.reverseAliasAddress = try container.decode(String.self, forKey: .reverseAliasAddress)
        self.existed = try container.decodeIfPresent(Bool.self, forKey: .existed) ?? false
    }
}

public struct ContactArray: Decodable {
    public let contacts: [Contact]
}