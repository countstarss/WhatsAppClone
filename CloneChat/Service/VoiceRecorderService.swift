//
//  VoiceRecorderService.swift
//  CloneChat
//
//  Created by luke on 2024/6/26.
//

import Foundation
import AVFoundation
import Combine

final class VoiceRecorderService {
    private var audioRecorder: AVAudioRecorder?
    // 加上set之后表示只能在这个文件中设置，但是在其他文件中可以读取
    private(set) var isRecording = false
    private var elaspedTime : TimeInterval = 0
    private var startTime : Date?
    // AnyCancellable 可以持有这个订阅对象，并在不再需要时取消订阅
    private var timer :AnyCancellable?
    
    func startRecord() {
        // step 1: setup audioSession
        // AVAudioSession 是用于配置和管理音频行为的类,sharedInstance() 方法返回应用的共享音频会话实例。
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // .playAndRecord：允许音频的播放和录制    .default：音频会话的默认模式。
            try audioSession.setCategory(.playAndRecord, mode: .default)
            // overrideOutputAudioPort(.speaker) 方法将音频输出重定向到speaker,也就是扬声器
            try audioSession.overrideOutputAudioPort(.speaker)
            // 激活audioSession
            try audioSession.setActive(true)
            print("VoiceRecorderService : Successfully setup AVAudioSession")
        } catch {
            print("VoiceRecorderService : Failed to setup AVAudioSession")
        }
        
        // step 2: 设置录音文件存储目录
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] // 每次都存储在数组的最前面，所以是[0]
        let audioFileName = Date().toString(format: "dd-MM-YY 'at' HH:MM:ss") + ".m4a"
        let audioFileURL = documentPath.appendingPathComponent(audioFileName)
        
        // step 3: Audio Recorder Settings
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey :AVAudioQuality.high.rawValue
        ]
        
        // step 4: Start Record
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            audioRecorder?.record()
            isRecording = true
            
            // step 5: 加入计时器
            startTime = Date() // 记录点击时的时间
            startTimer() // 开启计时器，记录时间
            print("VoiceRecorderService : Start Record")

        }catch {
            print("VoiceRecorderService: startRecord ->Failed to Setup AudioRecorder")
        }
    }
    
    // step 7: 停止录音
    func stopRecord(completion:((_ audioURL: URL, _ audioDuration: TimeInterval) -> Void)? = nil) {
        guard isRecording else { return } // 只有正在录音时有效
        // step 8: 添加completion 参数2:audioDuration
        let audioDuration = elaspedTime // 在归零之前保存鹿录音的时长
        // 关闭服务
        audioRecorder?.stop()
        isRecording = false
        timer?.cancel()
        elaspedTime = 0 // 归零
        
        //
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
            // step 8: 添加completion 参数1:audioURL
            guard let audioURL = audioRecorder?.url else { return }
            completion?(audioURL,audioDuration)
            
            print("VoiceRecorderService : Stop Record")
        }catch {
            print("VoiceRecorderService: stopRecord -> Failed to tear down AVAudioSession")
        }
    }
    
    // step 9: 清除无用的录音文件
    func tearDown() {
        // 找到录音文件位置，folder是第一个，也就是首地址
        let fileManager = FileManager.default
        // .documentDirectory 指定搜索文档目录    .userDomainMask 限定搜索范围为 - **用户的主目录**
        let folder = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // includingPropertiesForKeys: nil 指定不需要预取任何文件属性
        // 强制解包是没有问题的，因为只有在发送了录音之后，退出会话的的时候才会调用这个程序
        let folderContents = try! fileManager.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil) // ?
        // folderContents 应该是一个数组，包含所有的录音文件URL
        deleteRecordings(folderContents)
    }
    
    private func deleteRecordings(_ urls:[URL]) {
        for url in urls {
            deleteRecordings(at: url)
        }
    }
    
    private func deleteRecordings(at fileUrl:URL) {
        do {
            try FileManager.default.removeItem(at: fileUrl)
            print("VoiceRecorderService: Audio Record was deleted at \(fileUrl)")
        }catch {
            print("VoiceRecorderService: tearDown -> Failed to delete File")
        }
    }
    
    // step 6: 设置计时器
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink{ [weak self] _ in
                guard let startTime = self?.startTime else { return }
                self?.elaspedTime = Date().timeIntervalSince(startTime)
                print("elaspedTime：\(self?.elaspedTime)")
            }
    }
}
