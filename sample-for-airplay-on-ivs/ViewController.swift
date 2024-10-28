//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
//

/*
 
 This sample provides a very basic implementation on how to use Airplay with IVSPlayerSDK.
 
 Since the IVSPlayerSDK doesnt natively provide Airplay support, we will depend on a
 secondary UIViewController that will use AVPlayer to launch airplay with the same url.
 
 The secondary UIViewController (AVKitPlayerViewController) only handles airplay and is
 dismissed when the airplay popup is dismissed.
 
 Please change the urls on both this UIViewController and AVKitPlayerViewController to ensure both are
 using the same url.
 
 This sample does not account for airplay errors, the implementor is responsible for their own Airplay
 error handling.
 
 */
import UIKit
import AmazonIVSPlayer

class ViewController: UIViewController, IVSPlayer.Delegate, AVRoutePickerViewDelegate {
    
    let avPlayerSegue = "toAVPlayer"
    
    @IBOutlet weak var playerView : IVSPlayerView!
    @IBOutlet weak var airplayBtn : UIButton!
    
    var ivsPlayer : IVSPlayer!
    var avPlayer : AVPlayer?
    
    let url = URL(string:"https://fcc3ddae59ed.us-west-2.playback.live-video.net/api/video/v1/us-west-2.893648527354.channel.DmumNckWFTqz.m3u8")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup IVSPlayer
        ivsPlayer = IVSPlayer()
        // Self must conform to IVSPlayer.Delegate
        ivsPlayer.delegate = self
        // When using IVSPlayerView:
        playerView.player = ivsPlayer
        
        ivsPlayer.load(url)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        //force AVAudioSession back to app, as it may continue to playback in airplay
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playAndRecord, options: [.defaultToSpeaker])
        

        //Returning or starting VC, play URL
        ivsPlayer.play()
    }

    @IBAction func toAirplay() {
        //pause IVSPlayer before handing off to airplay
        ivsPlayer.pause()
        
        //initialize AVPlayer here because we dont want to consume resources
        //unless airplay is being used
        avPlayer = AVPlayer(url: url)
        avPlayer?.play()
        
        let routePicker = AVRoutePickerView()
        // Configure the button's color.
        routePicker.delegate = self
        routePicker.backgroundColor = UIColor.white
        routePicker.tintColor = UIColor.black
        routePicker.prioritizesVideoDevices = true
        
        if let routePickerButton = routePicker.subviews.first(where: { $0 is UIButton }) as? UIButton {
            routePickerButton.sendActions(for: .touchUpInside)
        }
        
        self.view.addSubview(routePicker)
    }
    
    func routePickerViewWillBeginPresentingRoutes(_ routePickerView: AVRoutePickerView) {
        
    }
    
    func routePickerViewDidEndPresentingRoutes(_ routePickerView: AVRoutePickerView) {
        routePickerView.removeFromSuperview()
        self.ivsPlayer.play()
        
        //pause and release avPlayer
        self.avPlayer?.pause()
        self.avPlayer = nil
    }
}

