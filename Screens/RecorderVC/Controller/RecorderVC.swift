//
//  RecorderVC.swift
//  Basirah
//
//  Created by Nadia Seleem on 4/20/21.
//  Copyright © 2021 Nadia seleem. All rights reserved.
//

import UIKit
import AVFoundation

class RecorderVC: UIViewController {

    @IBOutlet weak var uploadingIndicatorLabel: UILabel!
    @IBOutlet weak var recorderImgView: UIImageView!
    
    
    
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var recorder: AVAudioRecorder!
    //1. create the session
    var session: AVAudioSession!
    
    var request: Request!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disablePlayButton()
        disableClearButton()
        disableFinishButton()
        
        prepareRecorder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordPauseButtonDidTouched(_ sender: UIButton)
    {
        self.uploadingIndicatorLabel.isHidden = true

        guard let recorder = recorder else {return}
        if recorder.isRecording
        {
            recorder.pause()
            recorderImgView.image = #imageLiteral(resourceName: "recorder-icon")
            
        }
        else
        {
            recorder.record()
            recorderImgView.image = #imageLiteral(resourceName: "pause-icon")
            enableFinishButton()
            enablePlayButton()
            enableClearButton()
        }
    }
    
    @IBAction func playButtonDidTouched(_ sender: UIButton)
    {
        recorder.stop()
        route(to: .player)
    }
    
    @IBAction func finishRecordingButtonDidTOuched(_ sender: UIButton)
    {
        recorder.stop()
        recorderImgView.image = #imageLiteral(resourceName: "recorder-icon")
        disableClearButton()
        disablePlayButton()
        disableFinishButton()
        
        uploadAudioFile(with: request, fileURL: recorder.url,
        {
            self.dismiss(animated: true, completion: nil)
            
        }, { (msg) in
            
            self.showDefaultAlert(title: "خطأ", message: msg)
            self.enablePlayButton()
            self.enableClearButton()
            self.enableFinishButton()
            
        }) { (progress) in
            
            
            self.uploadingIndicatorLabel.isHidden = false
            
            var msg = " جاري رفع الملف الصوتي"
            msg += progress.arabicNumber()
            msg += "٪"
            
            self.uploadingIndicatorLabel.text = msg
        }
    }
    
    @IBAction func resetButtonDidTouched(_ sender: UIButton)
    {
        recorder.stop()
        
        self.uploadingIndicatorLabel.isHidden = true
        disableFinishButton()
        disableClearButton()
        disablePlayButton()
    }
    
    
    func audioURL() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var documentsDirectory = paths[0]
        documentsDirectory.appendPathComponent("audio.m4a")
        return documentsDirectory
    }
    
    
    func prepareRecorder()
    {
        session = AVAudioSession.sharedInstance()
        
                session.requestRecordPermission()
                {
                    [unowned self] allowed in
                    
                    if allowed
                    {
                        do {
                        // 2. configure the session for recording and playback
                            try self.session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
                            try self.session.setActive(true)
                        // 3. set up a high-quality recording session
                        let settings = [
                            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                            AVSampleRateKey: 44100,
                            AVNumberOfChannelsKey: 2,
                            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                            ]
                        // 4. create the audio recording, and assign ourselves as the delegate
                    
                            self.recorder = try AVAudioRecorder(url: self.audioURL(), settings: settings)
                            self.recorder?.prepareToRecord()
                        }
                            catch  {
                                return
                            }
                        
                    }
                }
       
    }
    
    @IBAction func dismissButtonDidTouched(_ sender: UIButton)
    {
        recorder.stop()
        recorder = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func enableFinishButton()
    {
        finishButton.alpha = 1
        finishButton.isEnabled = true
    }
    
    func disableFinishButton()
    {
        finishButton.alpha = 0.5
        finishButton.isEnabled = false
    }
    
    func enableClearButton()
    {
        resetButton.alpha = 1
        resetButton.isEnabled = true
    }
    
    func disableClearButton()
    {
        resetButton.alpha = 0.5
        resetButton.isEnabled = false
    }
    
    func enablePlayButton()
    {
        playButton.alpha = 1
        playButton.isEnabled = true
    }
    
    func disablePlayButton()
    {
        playButton.alpha = 0.5
        playButton.isEnabled = false
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
