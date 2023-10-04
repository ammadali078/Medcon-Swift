//
//  DolsViewController.swift
//  medcon-swift
//
//  Created by Ccomputing on 20/10/2022.
//
import Foundation
import UIKit
import AVKit
import Alamofire
import ObjectMapper


class DolsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var dolsBgImage: UIImageView!
    @IBOutlet weak var dolsBannerImage: UIImageView!
    @IBOutlet weak var dolsTblView: UITableView!
    
    var ApiResult : [DataVideos] = []
    
    let baseUrl = "http://medconwebapi-v3.digitrends.pk"
    
    
    var listArray:[String] = ["https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
                                  "http://techslides.com/demos/sample-videos/small.mp4",
                                  "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v",
                                  "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
                                  "http://techslides.com/demos/sample-videos/small.mp4",
                                  "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v",
                                  "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
                                  "http://techslides.com/demos/sample-videos/small.mp4",
                                  "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"
                                    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "Dols"
        
        let hamButton = UIButton(type: .custom)
        let HamImageName =  "SGhNNT"
        hamButton.setImage(UIImage(named: HamImageName), for: .normal)
//            hamButton.addTarget(self, action: #selector(didTouchHamButton(_:)), for: .touchUpInside)
        hamButton.imageEdgeInsets = UIEdgeInsets(top: -2, left: 0, bottom: -1, right: -20)
        hamButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 8, right: 0)
        hamButton.sizeToFit()
        
        // create custom left bar button item
        let rightBarButtonItem = UIBarButtonItem(customView: hamButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.getPlann()
        
        
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let VideoUrl = ApiResult[indexPath.row].videoUrl ?? ""
        
        if let url = URL(string: baseUrl + VideoUrl) {
          let player = AVPlayer(url:  url)
          let playerViewController = AVPlayerViewController()
          playerViewController.player = player
          present(playerViewController, animated: true) {
             player.play()
          }
       }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ApiResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dolsCell", for: indexPath) as! DolsTableViewCell
        
        let imageUrl = ApiResult[indexPath.row].imageUrl ?? ""
        let VideoUrl = ApiResult[indexPath.row].videoUrl ?? ""
        
        let url = URL(string: baseUrl + imageUrl)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        cell.DollsImageView.image = UIImage(data: data!)
        cell.DolsTitleLabelView.text = ApiResult[indexPath.row].title
        
        return cell
        
    }
    
    
    
    
    func getPlann(){
        
        AF.request(Constants.VideoApi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                    
                    //On Dialog Close
                    if (response.error != nil) {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                        return
                    }
                    
                    let dollsModel = Mapper<DollsModel>().map(JSONString: response.value!) //JSON to model
                    
                    if dollsModel != nil {
                        
                        if (dollsModel?.success)! {
                            
                            let List = dollsModel?.data?[0].videos ?? []
                            
                            let filter = List.filter {($0.typeId == 5)}
                            
                            self.ApiResult = filter
                            
                            
                            self.dolsTblView.reloadData()
                        
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (dollsModel?.message!)!)
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                    }
                
            })
        
        
        
    }
    
}
