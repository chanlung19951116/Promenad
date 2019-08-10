//
//  ErrorMsg.swift
//  Promenad
//
//  Created by LiuYan on 8/5/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import Foundation
public class ErrorMsg {
    public func getErrorMsg(code: Int)->String {
        var description: String = ""
        switch code {
            case 0:
                description = "Success"
                break;
            case 1:
                description = "You are trying to send more than the maximum of 30 requests per second."
                break;
            case 2:
                description = "The stated parameter is missing."
                break;
            case 3:
                description = "Invalid value for parameter. If you see Facility not allowed in the error text, check that you are using the correct Base URL in your request.\n"
                break;
            case 4:
                description = "The supplied API key or secret in the request is either invalid or disabled."
                break;
            case 5:
                description = "An error occurred processing this request in the Cloud Communications Platform."
                break;
            case 6:
                description = "The request could not be routed."
                break;
            case 7:
                description = "The number you are trying to verify is blacklisted for verification."
                break;
            case 8:
                description = "The api_key you supplied is for an account that has been barred from submitting messages."
            break;
            case 9:
                description = "Your account does not have sufficient credit to process this request."
                break;
            case 10:
                description = "Partner quota exceeded."
                break;
            case 15:
                description = "The destination number is not in a supported network."
                break;
            case 16:
                description = "The code inserted does not match the expected value."
                break;
            case 17:
                description = "The wrong code was provided too many times."
                break;
            case 18:
                description = "You added more than the maximum ten request_ids to your request."
                break;
            case 19:
                description = "No more events are left to execute for this request."
                break;
            case 101:
                description = "There are no matching verify requests."
                break;
            default:
                description = ""
        }
        return description
    }
}
