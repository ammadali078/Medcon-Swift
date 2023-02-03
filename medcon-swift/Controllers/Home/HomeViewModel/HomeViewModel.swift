//
//  HomeViewModel.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 16/02/2022.
//

import Foundation
import UIKit

protocol HomeWebServiceDelegate {
    func successJournals()
    func failureJournals()
    
    func successJournalsMsl()
    func failureJournalsMsl()
    
    func successVideoLibrary()
    func failureVideoLibrary()
    
    func successAlbum()
    func failureAlbum()
}

class HomeViewModel {
    var delegate: HomeWebServiceDelegate?
    var selectedSpeciality: SpecialityTag = .Gastroenterology
    var journalResponseData: JournalResponse?
    var journalMslResponseData: JournalResponse?
    var videoLibraryResponseData: VideoLibraryResponse?
    var albumResponseData: AlbumResponse?
    
    func callJournal() {
        if self.journalResponseData != nil {
            self.delegate?.successJournals()
            return
        }
        APIManager.shared().call(type: EndpointItem.newsAndJournals, params: nil) { [weak self] (journalsResponse: JournalResponse?, alert: AlertMessage?) in
            if let _ = alert {
                self?.delegate?.failureJournals()
            }
            else if let resp = journalsResponse, !resp.success {
                self?.delegate?.failureJournals()
            }
            else {
                self?.journalResponseData = journalsResponse
                self?.delegate?.successJournals()
            }
            
        }
    }
    
    func callJournalMsl() {
        if self.journalMslResponseData != nil {
            self.delegate?.successJournalsMsl()
            return
        }
        APIManager.shared().call(type: EndpointItem.newsAndJournalsMsl, params: nil) { [weak self] (journalsMslResponse: JournalResponse?, alert: AlertMessage?) in
            if let _ = alert {
                self?.delegate?.failureJournalsMsl()
            }
            else if let resp = journalsMslResponse, !resp.success {
                self?.delegate?.failureJournalsMsl()
            }
            else {
                self?.journalMslResponseData = journalsMslResponse
                self?.delegate?.successJournalsMsl()
            }
            
        }
    }
    
    func callVideoLibrary() {
        if self.videoLibraryResponseData != nil {
            self.delegate?.successVideoLibrary()
            return
        }
        APIManager.shared().call(type: EndpointItem.videoLibrary, params: nil) { [weak self] (videoLibraryResponse: VideoLibraryResponse?, alert: AlertMessage?) in
            if let _ = alert {
                self?.delegate?.failureVideoLibrary()
            }
            else if let resp = videoLibraryResponse, !resp.success {
                self?.delegate?.failureVideoLibrary()
            }
            else {
                self?.videoLibraryResponseData = videoLibraryResponse
                self?.delegate?.successVideoLibrary()
            }
        }
    }
    
    func callAlbum() {
        if self.albumResponseData != nil {
            self.delegate?.successAlbum()
            return
        }
        APIManager.shared().call(type: EndpointItem.album, params: nil) { [weak self] (albumResponse: AlbumResponse?, alert: AlertMessage?) in
            if let _ = alert {
                self?.delegate?.failureAlbum()
            }
            else if let resp = albumResponse, !resp.success {
                self?.delegate?.failureAlbum()
            }
            else {
                self?.albumResponseData = albumResponse
                self?.delegate?.successAlbum()
            }
            
        }
    }
}
