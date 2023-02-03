//
//  RegisterResponse.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 11/02/2022.
//

import Foundation

class RegisterResponse: Codable {
    let status: Int?
    let success: Bool
    let message: String?
    let data: RegisterDataClass

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case success = "Success"
        case message = "Message"
        case data = "Data"
    }
}

// MARK: - DataClass
struct RegisterDataClass: Codable {
    let user: User?
    let banner: [Banner]?
    let imagebanners: [Imagebanner]?

    enum CodingKeys: String, CodingKey {
        case user = "User"
        case banner = "Banner"
        case imagebanners
    }
}

// MARK: - Banner
struct Banner: Codable {
    let imageURL: String?
    let bannerDescription, heading: String?
    let url: String?
    
    var imageFullUrl: String {
        get {
            return EndpointItem.base.baseURL + (imageURL ?? "")
        }
    }

    enum CodingKeys: String, CodingKey {
        case imageURL = "ImageURL"
        case bannerDescription = "Description"
        case heading = "Heading"
        case url = "URL"
    }
}

// MARK: - Imagebanner
struct Imagebanner: Codable {
    let title, imageURL: String?
    
    var imageFullUrl: String {
        get {
            return EndpointItem.base.baseURL + (imageURL ?? "")
        }
    }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case imageURL = "ImageUrl"
    }
}

// MARK: - User
struct User: Codable {
    let empID: Int?
    let registrationCode: String?
    let title, firstName, middleName, lastName: String?
    let email: String?
    let gender, dob: String?
    let speciality: Int?
    let pmdcNumber, contactNumber: String?
    let city: String?
    let clinicAddress, status: String?
    let deviceType: Int?
    let authToken, verifiedUser: String?
    let specialityName: String?

    enum CodingKeys: String, CodingKey {
        case empID = "EmpId"
        case registrationCode = "RegistrationCode"
        case title = "Title"
        case firstName = "FirstName"
        case middleName = "MiddleName"
        case lastName = "LastName"
        case email = "Email"
        case gender = "Gender"
        case dob = "Dob"
        case speciality = "Speciality"
        case pmdcNumber = "PmdcNumber"
        case contactNumber = "ContactNumber"
        case city = "City"
        case clinicAddress = "ClinicAddress"
        case status = "Status"
        case deviceType = "DeviceType"
        case authToken = "AuthToken"
        case verifiedUser = "VerifiedUser"
        case specialityName = "SpecialityName"
    }
}
