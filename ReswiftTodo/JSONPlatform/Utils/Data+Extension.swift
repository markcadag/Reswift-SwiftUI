//
//  Data+Extension.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation

import CommonCrypto

extension Data {

    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }

    var sha256: Data {
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(count), &hash)
        }
        return Data(hash)
    }

}
