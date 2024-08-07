//
//  ChatRoomViewModel.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/7.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

// `final` 关键字用于防止类被继承或者防止类的方法、属性被重写
final class ChatRoomViewModel:ObservableObject{
    
    @Published var textMessage :String = ""
    
    // 在MessageSevercve中创建的messages只是一个临时的，我们需要在这里创建messages来保存
    @Published var messages : [MessageItem] = [MessageItem]()
    
    // private(set) var 让外部也能访问到channel
    private(set) var channel:ChannelItem
    
    // 用于打开PhotoPicker
    @Published var showPhotoPicker = false
    
    // 用于保存已选择的图片文件
    @Published var photoPickerItems : [PhotosPickerItem] = []
    
    // 用于保存已选择的媒体文件选择video // 改用覆盖范围更广的MediaAttachment，它包括三种类型
    @Published var mediaAttachments:[MediaAttachment] = []
    
    // 用于保存VideoPlayer状态
    @Published var videoPlayerState: (show: Bool,player:AVPlayer?) = (false,nil)
    
    // 用于同步数据
    @Published var isRecordingVoiceMessage : Bool = false
    @Published var elapsedVoiceMessageTime : TimeInterval = 0
    
    // 用于滑动到底部
    @Published var scrollToButtomRequest: (scroll:Bool,isAnimated :Bool) = (false ,false)
    
    
    // 用于调用服务
    private let voiceRecorderService = VoiceRecorderService()
    
    // 用于控制显示MediaAttachmentPreview
    var showPhotoPickerPreview: Bool {
        return !mediaAttachments.isEmpty || !photoPickerItems.isEmpty
    }
    
    // AnyCancellable <关键点> 存储订阅
    private var subScriptions = Set<AnyCancellable>()
    private var currentUser :UserItem?
    
    var disableSendButton: Bool {
        return mediaAttachments.isEmpty && textMessage.isEmptyorWhiteSpace
    }
    
    //MARK: - Init
    init(channel: ChannelItem) {
        self.channel = channel
        // listenToAuthState初始化currentUser
        listenToAuthState()
        // 加到init中执行，以监控selectedPhotos的变化
        onPhotoPickerSelection()
        
        setUpVoiceRecorderListner()
        
        scrollTobottom(isAnimated: true)
    }
    
    deinit{
        // 结果viewModel的生命周期之后清除订阅内容
        subScriptions.forEach{ $0.cancel() }
        subScriptions.removeAll()
        currentUser = nil
    }
    //MARK: - Listener
    private func listenToAuthState() {
        AuthManager.shared.authState.receive(on: DispatchQueue.main).sink{ [weak self] authState in
            guard let self = self else { return }
            switch authState{
                // 如果通过Firebase Auth拿到当前的登陆状态是LogedIn
            case .loggedIn(let current):
                self.currentUser = current
                // 如果不需要fetch，直接调用getMessage()
                
                // 导致无法正确判断allMembersFetched是否为true的原因是：
                    // 在ChannelTabViewModel中获取Channel时，没有把当前user添加进去,导致channel只有一个
                if self.channel.allMembersFetched{
                    print("allMembersFetched -> \(channel.members.map { $0.username })")
                    self.getMessage()
                }else {
                    // 改变顺序，先获取所有的channelMembers，然后在fetchAllChannelMembers函数里getMessage
                    self.fetchAllChannelMembers()
                }
            default :
                break
            }
            //
        }.store(in: &subScriptions)
    }
    
    private func setUpVoiceRecorderListner() {
        voiceRecorderService.$isRecording.receive(on: DispatchQueue.main)
            .sink { [weak self] isRecording in
                self?.isRecordingVoiceMessage = isRecording
            }.store(in: &subScriptions)
        
        voiceRecorderService.$elapsedTime.receive(on: DispatchQueue.main)
            .sink { [weak self] elaspedTime in
                self?.elapsedVoiceMessageTime = elaspedTime
            }.store(in: &subScriptions)
    }
    
    private func clearTextInputArea() {
        mediaAttachments.removeAll()
        photoPickerItems.removeAll()
        textMessage = ""
    }
    
    //MARK: - Send Message
    func sendMessage() {
        guard let currentUser else { return }
        if mediaAttachments.isEmpty {
            MessageService.sendTextMessage(to: channel, from: currentUser, textMessage) { [weak self] in
                self?.textMessage = ""
            }
        } else {
            sendMultipleMediaMessage(textMessage, attachment: mediaAttachments)
            clearTextInputArea()
            UIApplication.dismissKeyboard()
        }
        getMessage()
    }
    // 发送多条attachmentMessage
    private func sendMultipleMediaMessage(_ text:String,attachment: [MediaAttachment]) {
        mediaAttachments.forEach { attachment in
            switch attachment.type {
            case .photo:
                sendPhotoMessage(text: text, attachment)
                
            case .video:
                sendVideoMessage(text: text, attachment)
                
            case .audio:
                sendVoiceMessage(text: text, attachment)
            }
        }
    }
    
    private func sendPhotoMessage(text: String, _ attachment: MediaAttachment) {
        /// upload image to our storage
        uploadImageToStorage(attachment) { [weak self] imageUrl in
            /// store the matedata to database 发送到数据库里面
            guard let self = self, let currentUser else { return }
            print("Upload image to storage") // successfully upload
            let uploadParams = MessageUploadParams(
                channel: channel,
                text: text,
                type: .photo,
                attachment: attachment,
                sender: currentUser,
                // 为了防止出错，使用的可选值，但是链接是需要传入的，将URL转成一个字符串
                thumbnailUrl:imageUrl.absoluteString
            )
            
            MessageService.sendMediaMessage(to: channel, params: uploadParams) { [weak self] in
                self?.textMessage = ""
                self?.mediaAttachments = []
                print("Already send photo message to database")
                //MARK: - Scroll to bottom to upload image
                self?.scrollTobottom(isAnimated: true)
            }
            
        }
    }
    
    private func sendVideoMessage(text: String, _ attachment: MediaAttachment){
        /// upload the file to storage
        uploadFileToStorage(forUploadType: .videoMessage, attachment) { videoURL in
            /// upload the video thumbnail
            self.uploadImageToStorage(attachment, completion: {[weak self] thumbnailURL in
                guard let self = self,let currentUser else { return }
                let uploadParams = MessageUploadParams(
                    channel: self.channel,
                    text: text,
                    type: .video,
                    attachment: attachment,
                    sender: currentUser,
                    thumbnailUrl: thumbnailURL.absoluteString,
                    videoURL: videoURL.absoluteString)
                /// save the mate data and url to databse
                MessageService.sendMediaMessage(to: self.channel, params: uploadParams) { [weak self] in
                    self?.scrollTobottom(isAnimated: true)
                    print("successfully save the video mateData and url to databse")
                }
            })
            
        }
        
    }
    
    private func sendVoiceMessage(text: String, _ attachment: MediaAttachment){
        guard let audioDuration = attachment.audioDuration ,let currentUser  = self.currentUser else { return }
        uploadFileToStorage(forUploadType: .voiceMessage, attachment) { [weak self] fileUrl in
            guard let self else { return }
            let uploadParams = MessageUploadParams(
                channel: self.channel,
                text: text,
                type: .audio,
                attachment: attachment,
                sender: currentUser,
                audioURL: fileUrl.absoluteString,
                audioDuration: audioDuration
            )
            MessageService.sendMediaMessage(to: channel, params: uploadParams) { [weak self] in
                self?.scrollTobottom(isAnimated: true)
                print("successfully save the video mateData and url to databse")
            }
        }
    }

    
    private func scrollTobottom(isAnimated :Bool) {
        scrollToButtomRequest.scroll = true
        scrollToButtomRequest.isAnimated = isAnimated
    }
    
    
    // 作用：上传thumbnail得到imageUrl返回值，将值传给completion
    private func uploadImageToStorage(_ attachment: MediaAttachment,completion:@escaping(_ imageUrl :URL) -> Void) {
        FirebaseHelper.uploadImage(attachment.thumbnail, for: .photoMessage) { result in
            switch result {
            case .success(let imageUrl):
                completion(imageUrl)
            case .failure(let error):
                print("Failed to upload image storage: \(error.localizedDescription)")
            }
        } progressHandler: { progress in
            print("UPLOAD PROGRESS : == \(progress) ==")
        }

    }
    
    // 通过添加forUploadType参数，增加可重用性能
    private func uploadFileToStorage(
                            forUploadType : FirebaseHelper.UploadType,
                            _ attachment: MediaAttachment,
                            completion:@escaping(_ imageUrl :URL) -> Void) {
        guard let fileToUpload = attachment.fileURL else { return }
        FirebaseHelper.uploadFile(for: forUploadType, fileURL: fileToUpload){ result in
            switch result {
            case .success(let fileURL):
                completion(fileURL)
            case .failure(let error):
                print("Failed to upload video storage: \(error.localizedDescription)")
            }
        } progressHandler: { progress in
            print("UPLOAD PROGRESS : == \(progress) ==")
        }
    }
    
    
    
    
    private func getMessage(){
        // 这里闭包中的messages是 MessageSeverce.getMessages 的completion传过来的
        MessageService.getMessages(for:channel) {[weak self] messages in
            self?.messages = messages // 把channel对应的messages赋值给模板messages
        }
    }
    
    // 只有是Group channel时，才会调用这个函数
    private func fetchAllChannelMembers() {
        // 现在已经有了currnetUser和前两个用户，只需要获取其他user
        guard let currentUser = currentUser else { return }
        let membersAlreadyFetched = channel.members.compactMap { $0.uid } // 得到的是一个uid数组
        // 需要获取的是membersUids中不包含membersAlreadyFetched中的部分
        var membersUidsToFetch = channel.membersUids.filter { !membersAlreadyFetched.contains($0) } // 去掉已获取
        membersUidsToFetch = membersUidsToFetch.filter{ $0 != currentUser.uid } 
        // 去掉currentUser
        
        UserService.getUser(with: membersUidsToFetch) { [weak self] userNode in
            guard let self = self else { return }
            self.channel.members.append(contentsOf: userNode.users)
//            self.channel.members.append(currentUser) // 把currentUser添加到最后面
            print("fetchAllChannelMembers: \(channel.members.map {$0.username})")
        }
        getMessage()
    }
    
    //MARK: - 触发Input区域的动作
    // 根据点击的按钮选择不同的方法，这个方法是TextInput的actionHandle
    func handleTextInputArea(_ action:TextInputArea.userAction) {
        switch action {
        case .presentPhotoPicker:
            showPhotoPicker = true
            print("showPhotoPicker:\(showPhotoPicker)")
        case .sendMessage:
            sendMessage()
        case .recordAudio:
            toggleAudioRecorder()
        }
    }
    
    
    //MARK: - Audio
    private func toggleAudioRecorder() {
        if voiceRecorderService.isRecording {
            voiceRecorderService.stopRecord { audioURL, audioDuration in
                self.createAudioAttachment(from: audioURL, audioDuration)
            }
        }else {
            voiceRecorderService.startRecord()
        }
    }
    
    private func createAudioAttachment(from audioURL: URL?, _ audioDuration: TimeInterval) {
        guard let audioURL = audioURL else { return }
        let id = UUID().uuidString
        let audioAttachment = MediaAttachment(id: id, type: .audio(audioURL,audioDuration))
        mediaAttachments.insert(audioAttachment, at: 0) // 在开头插入
    }
    
    
    
    
    //MARK: - PhotoPicker & Video
    // 添加照片的思路分析：
    // 1. 监控$photoPickerItems，当其中有内容时，将PhotosPicker得到的整个数组拿去解码
    // 2. 把数组中的item循环取出，将其转换成可传输的对象，然后将得到的数据转成UIImage类型
    // 3. 把得到的图片插入到selectedPhotots中，每次都插入到最前面
    
    private func onPhotoPickerSelection() {
        $photoPickerItems.sink { [weak self] photoItems in
            guard let self = self else { return }
            let audioAttachments = mediaAttachments.filter({ $0.type == .audio(.stubURL,.stubTimeInterval) })
            mediaAttachments = audioAttachments
            Task{
                await self.parsePhotoPickerItem(photoItems)
            }
        }.store(in: &subScriptions)
        // store的作用 ：管理订阅生命周期
        // 确保Combine的订阅在subScriptions集合中保存,这意味着只要subScriptions存在，订阅就会保持活动状态。
    }
    
    private func parsePhotoPickerItem(_ photoPickerItems: [PhotosPickerItem]) async {
        for photoItem in photoPickerItems {
            if photoItem.isVideo {
                if let movie = try? await photoItem.loadTransferable(type: VideoPickerTransferable.self){
                    // 使用AVAssetImageGenerator生成视频的略缩图
                    // 我们要直接使用URL类型值生成Thumbnail，要使用这个功能就需要给URL添加扩展
                    if let thumbnail = try? await movie.url.generateVideoThumbnail(), let itemIdentifier = photoItem.itemIdentifier{
                        let videoAttachment = MediaAttachment(id: itemIdentifier, type: .video(thumbnail, movie.url))
                        self.mediaAttachments.insert(videoAttachment, at: 0)
                    }
                }
            }else {
                guard
                    let data = try? await photoItem.loadTransferable(type: Data.self),
                    // loadTransferable，将特定数据类型中加载数据并将其转换为可传输的对象。通常用于处理和传输数据的场景，比如从照片库中加载照片、从文件中读取数据等。
                    let thumbnail = UIImage(data: data)
                else { return }
                    if let itemIdentifier = photoItem.itemIdentifier {
                        let photoAttachment = MediaAttachment(id: itemIdentifier, type: .photo(thumbnail))
                        self.mediaAttachments.insert(photoAttachment, at: 0)
                    }
                
            }
        }
    }
    
    
    func dismissMediaPlayer() {
        videoPlayerState.player?.replaceCurrentItem(with: nil)
        videoPlayerState.player = nil
        videoPlayerState.show = false
    }
  
    
    //MARK: - HandleMedia Attachment Preview
    func handleMediaAttachmentPreview(_ action:MediaAttachmentPreview.userAction) {
        switch action {
        case .play(let attachment):
            guard let fileURL = attachment.fileURL else { return }
            showMediaPlayer(fileURL)
        case .remove(let attachment):
            remove(attachment) // 删除略缩图
            guard let fileURL = attachment.fileURL else { return }
            if attachment.type == .audio(.stubURL, .stubTimeInterval) {
                print("handleMediaAttachmentPreview -> deleteRecordings-2 ...")
                voiceRecorderService.deleteRecordings(at: fileURL)
            }
        }
    }
    

    func showMediaPlayer(_ fileURL:URL) {
        videoPlayerState.show = true
        videoPlayerState.player = AVPlayer(url: fileURL)
    }
    
    private func remove(_ item:MediaAttachment) {
        guard let attachmentIndex = mediaAttachments.firstIndex(where: { $0.id == item.id}) else { return }
        mediaAttachments.remove(at: attachmentIndex)
        
        guard let photoIndex = photoPickerItems.firstIndex(where: { $0.itemIdentifier == item.id}) else { return }
        photoPickerItems.remove(at: photoIndex)
    }
    
}
