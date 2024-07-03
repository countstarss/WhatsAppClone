// Generated using Sourcery 2.2.5 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - AdminMessageTextView
/// Documentation for AdminMessageTextView
///
/// MARK: Properties
/// - `channel`: `ChannelItem`
/// - `body`: `some View`

/// MARK: Methods
/// - `textView(_ text: String)`
///   - parameter `text`: `String`
///   - returns: `some View`
///   - access: `private`
// MARK: - AdminMessageType
/// Documentation for AdminMessageType
///
/// MARK: Properties

// MARK: - AppDelegate
/// Documentation for AppDelegate
///
/// MARK: Properties

/// MARK: Methods
/// - `application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil)`
///   - parameter `application`: `UIApplication`
///   - parameter `launchOptions`: `[UIApplication.LaunchOptionsKey : Any]?`
///   - returns: `Bool`
///   - access: `internal`
// MARK: - AuthButton
/// Documentation for AuthButton
///
/// MARK: Properties
/// - `title`: `String`
/// - `onTap`: `() -> Void`
/// - `isEnabled`: `UnknownTypeSoAddTypeAttributionToVariable`
/// - `backgroundColor`: `Color`
/// - `textColor`: `Color`
/// - `body`: `some View`

// MARK: - AuthError
/// Documentation for AuthError
///
/// MARK: Properties
/// - `errorDescription`: `String?` (Optional)

// MARK: - AuthHeaderView
/// Documentation for AuthHeaderView
///
/// MARK: Properties
/// - `body`: `some View`

// MARK: - AuthManager
/// Documentation for AuthManager
///
/// MARK: Properties
/// - `shared`: `AuthProvider` - Default: `AuthManager()`
/// - `authState`: `CurrentValueSubject<AuthState, Never>` - Default: `CurrentValueSubject<AuthState, Never>(.pending)`
/// - `testAccount`: `[String]` - Default: `[
        "test1@test.com",
        "test2@test.com",
        "test3@test.com",
        "test4@test.com",
        "test5@test.com",
        "test6@test.com",
        "test7@test.com",
        "test8@test.com",
        "test9@test.com",
        "test10@test.com",
        "test11@test.com",
        "test12@test.com",
        "test13@test.com",
        "test14@test.com",
        "test15@test.com",
        "test16@test.com",
        "test17@test.com",
        "test18@test.com",
        "test19@test.com",
        "test20@test.com",
        "test21@test.com",
        "test22@test.com",
        "test23@test.com",
        "test24@test.com",
        "test25@test.com",
        "test26@test.com",
        "test27@test.com",
        "test28@test.com",
        "test29@test.com",
        "test30@test.com",
        "test31@test.com",
        "test32@test.com",
        "test33@test.com",
        "test34@test.com",
        "test35@test.com",
        "test36@test.com",
        "test37@test.com",
        "test38@test.com",
        "test39@test.com",
        "test40@test.com",
    ]`

/// MARK: Methods
/// - `init()`
///   - returns: `AuthManager`
///   - access: `private`
/// - `autoLogin()`
///   - returns: `Void`
///   - access: `internal`
/// - `login(with email: String, and password: String)`
///   - parameter `email`: `String`
///   - parameter `password`: `String`
///   - returns: `Void`
///   - access: `internal`
/// - `createAccount(for username: String, with email: String, and password: String)`
///   - parameter `username`: `String`
///   - parameter `email`: `String`
///   - parameter `password`: `String`
///   - returns: `Void`
///   - access: `internal`
/// - `logOut()`
///   - returns: `Void`
///   - access: `internal`
/// - `saveUserInfoDatabase(user: UserItem)`
///   - parameter `user`: `UserItem`
///   - returns: `Void`
///   - access: `private`
/// - `fetchCurrentUserInfo()`
///   - returns: `Void`
///   - access: `private`
// MARK: - AuthScreenModel
/// Documentation for AuthScreenModel
///
/// MARK: Properties
/// - `isLoading`: `Bool` - Default: `false`
/// - `email`: `String` - Default: `""`
/// - `password`: `String` - Default: `""`
/// - `username`: `String` - Default: `""`
/// - `errorState`: `(showError :Bool , errorMessage: String)` - Default: `(false , "Uh ha,error here:")`
/// - `disableLoginButton`: `Bool`
/// - `disableSignUpButton`: `Bool`

/// MARK: Methods
/// - `handleSignUp()`
///   - returns: `Void`
///   - access: `internal`
/// - `handleLogin()`
///   - returns: `Void`
///   - access: `internal`
// MARK: - AuthState
/// Documentation for AuthState
///
/// MARK: Properties

// MARK: - AuthTextField
/// Documentation for AuthTextField
///
/// MARK: Properties
/// - `type`: `InputType`
/// - `text`: `String`
/// - `body`: `some View`

// MARK: - AuthTextField.InputType
/// Documentation for AuthTextField.InputType
///
/// MARK: Properties
/// - `placeholder`: `String`
/// - `iconName`: `String`
/// - `keyboardType`: `UIKeyboardType`

// MARK: - BubbleAudioView
/// Documentation for BubbleAudioView
///
/// MARK: Properties
/// - `item`: `MessageItem`
/// - `sliderValue`: `Double` - Default: `0`
/// - `sliderRange`: `ClosedRange<Double>` - Default: `0...20`
/// - `body`: `some View`

/// MARK: Methods
/// - `playButton()`
///   - returns: `some View`
///   - access: `private`
/// - `timeStampTextView()`
///   - returns: `some View`
///   - access: `private`
// MARK: - BubbleImageView
/// Documentation for BubbleImageView
///
/// MARK: Properties
/// - `item`: `MessageItem`
/// - `body`: `some View`

/// MARK: Methods
/// - `messageImageView()`
///   - returns: `some View`
///   - access: `private`
/// - `shareButton()`
///   - returns: `some View`
///   - access: `private`
/// - `playButton()`
///   - returns: `some View`
///   - access: `private`
/// - `timeStmpTextView()`
///   - returns: `some View`
///   - access: `private`
// MARK: - BubbleTailModifier
/// Documentation for BubbleTailModifier
///
/// MARK: Properties
/// - `direction`: `MessageDirection`

/// MARK: Methods
/// - `body(content: Content)`
///   - parameter `content`: `Content`
///   - returns: `some View`
///   - access: `internal`
// MARK: - BubbleTailView
/// Documentation for BubbleTailView
///
/// MARK: Properties
/// - `direction`: `MessageDirection`
/// - `item`: `MessageItem`
/// - `backgroundColor`: `Color`
/// - `body`: `some View`

// MARK: - BubbleTextView
/// Documentation for BubbleTextView
///
/// MARK: Properties
/// - `item`: `MessageItem`
/// - `body`: `some View`

/// MARK: Methods
/// - `timeStampTextView()`
///   - returns: `some View`
///   - access: `private`
// MARK: - CallsTabScreen
/// Documentation for CallsTabScreen
///
/// MARK: Properties
/// - `searchText`: `String` - Default: `""`
/// - `callHistory`: `CallHistory` - Default: `CallHistory.all`
/// - `body`: `some View`

/// MARK: Methods
/// - `leadingNavItem()`
///   - returns: `some ToolbarContent`
///   - access: `private`
/// - `trailingNavItem()`
///   - returns: `some ToolbarContent`
///   - access: `private`
/// - `principalNavItem()`
///   - returns: `some ToolbarContent`
///   - access: `private`
// MARK: - CallsTabScreen.CallHistory
/// Documentation for CallsTabScreen.CallHistory
///
/// MARK: Properties
/// - `id`: `String`

// MARK: - ChannelConstants
/// Documentation for ChannelConstants
///
/// MARK: Properties
/// - `maxGroupParticipants`: `Int` - Default: `12`

// MARK: - ChannelCreationError
/// Documentation for ChannelCreationError
///
/// MARK: Properties

// MARK: - ChannelCreationRoute
/// Documentation for ChannelCreationRoute
///
/// MARK: Properties

// MARK: - ChannelCreationTextView
/// Documentation for ChannelCreationTextView
///
/// MARK: Properties
/// - `colorScheme`: `UnknownTypeSoAddTypeAttributionToVariable`
/// - `backgroundColor`: `Color`
/// - `body`: `some View`

// MARK: - ChannelItem
/// Documentation for ChannelItem
///
/// MARK: Properties
/// - `id`: `String`
/// - `name`: `String?` (Optional)
/// - `lastMessage`: `String`
/// - `creationDate`: `Date`
/// - `lastMessageTimeStmp`: `Date`
/// - `membersCount`: `Int`
/// - `adminUids`: `[String]`
/// - `membersUids`: `[String]`
/// - `members`: `[UserItem]`
/// - `thumbnailUrl`: `String?` (Optional)
/// - `createdBy`: `String`
/// - `isGroupChat`: `Bool`
/// - `membersExcludingMe`: `[UserItem]`
/// - `title`: `String`
/// - `isCreatedByMe`: `Bool`
/// - `creatorName`: `String`
/// - `coverImageUrl`: `String?` (Optional)
/// - `groupMembersNames`: `String`
/// - `allMembersFetched`: `Bool`
/// - `placeholder`: `ChannelItem` - Default: `ChannelItem.init(
        id: "1",
        lastMessage: "Hello world",
        creationDate: Date(),
        lastMessageTimeStmp: Date(),
        membersCount: 3,
        adminUids: [],
        membersUids: [],
        members: [UserItem(uid: "1", username: "Luke", email: "swiftSkool@gamil.com"),
                  UserItem(uid: "2", username: "smith", email: "smith@gamil.com")],
        createdBy: ""
    )`

/// MARK: Methods
/// - `init(_ dict: [String :Any])`
///   - parameter `dict`: `[String :Any]`
///   - returns: `ChannelItem`
///   - access: `internal`
// MARK: - ChannelItemView
/// Documentation for ChannelItemView
///
/// MARK: Properties
/// - `channel`: `ChannelItem`
/// - `body`: `some View`
/// - `channelTitle`: `String`

/// MARK: Methods
/// - `titleTextView()`
///   - returns: `some View`
///   - access: `private`
/// - `lastMessagePreview()`
///   - returns: `some View`
///   - access: `private`
// MARK: - ChannelListView
/// Documentation for ChannelListView
///
/// MARK: Properties
/// - `body`: `some View`

// MARK: - ChannelTabRoutes
/// Documentation for ChannelTabRoutes
///
/// MARK: Properties

// MARK: - ChannelTabScreen
/// Documentation for ChannelTabScreen
///
/// MARK: Properties
/// - `searchText`: `String` - Default: `""`
/// - `viewModel`: `ChannelTabViewModel`
/// - `body`: `some View`

/// MARK: Methods
/// - `init(_ currentUser: UserItem)`
///   - parameter `currentUser`: `UserItem`
///   - returns: `ChannelTabScreen`
///   - access: `internal`
/// - `destinationView(for route: ChannelTabRoutes)`
///   - parameter `route`: `ChannelTabRoutes`
///   - returns: `some View`
///   - access: `private`
/// - `leadingNavItem()`
///   - returns: `some ToolbarContent`
///   - access: `private`
/// - `trailingNavItem()`
///   - returns: `some ToolbarContent`
///   - access: `private`
/// - `AiButton()`
///   - returns: `some View`
///   - access: `private`
/// - `caremaButton()`
///   - returns: `some View`
///   - access: `private`
/// - `newChatButton()`
///   - returns: `some View`
///   - access: `private`
/// - `archivedButton()`
///   - returns: `some View`
///   - access: `private`
/// - `inboxFooterView()`
///   - returns: `some View`
///   - access: `private`
// MARK: - ChannelTabViewModel
/// Documentation for ChannelTabViewModel
///
/// MARK: Properties
/// - `navRoutes`: `[ChannelTabRoutes]` - Default: `[ChannelTabRoutes]()`
/// - `navigateToChatRoom`: `Bool` - Default: `false`
/// - `newChannel`: `ChannelItem?` (Optional)
/// - `showChatPartnerPickerScreen`: `Bool` - Default: `false`
/// - `channels`: `[ChannelItem]` - Default: `[ChannelItem]()`
/// - `channelDictionary`: `[ChannelId: ChannelItem]` - Default: `[:]`
/// - `currentUser`: `UserItem`

/// MARK: Methods
/// - `onNewChannelCreation(_ channel: ChannelItem)`
///   - parameter `channel`: `ChannelItem`
///   - returns: `Void`
///   - access: `internal`
/// - `init(_ currentUser: UserItem)`
///   - parameter `currentUser`: `UserItem`
///   - returns: `ChannelTabViewModel`
///   - access: `internal`
/// - `fetchCurrentUserChannels()`
///   - returns: `Void`
///   - access: `internal`
/// - `getChannel(with channelId: String)`
///   - parameter `channelId`: `String`
///   - returns: `Void`
///   - access: `private`
/// - `getChannelMembers(_ channel: ChannelItem, completion: @escaping (_ members: [UserItem]) -> Void)`
///   - parameter `channel`: `ChannelItem`
///   - parameter `completion`: `@escaping (_ members: [UserItem]) -> Void`
///   - returns: `Void`
///   - access: `internal`
/// - `reloadData()`
///   - returns: `Void`
///   - access: `private`
// MARK: - ChatPartnerPickerOption
/// Documentation for ChatPartnerPickerOption
///
/// MARK: Properties
/// - `id`: `String`
/// - `title`: `String`
/// - `imageName`: `String`

// MARK: - ChatPartnerPickerScreen
/// Documentation for ChatPartnerPickerScreen
///
/// MARK: Properties
/// - `searchText`: `String` - Default: `""`
/// - `showChatPartnerPickerScreen`: `Bool`
/// - `dismiss`: `UnknownTypeSoAddTypeAttributionToVariable`
/// - `viewModel`: `ChatPartnerPickerViewModel` - Default: `ChatPartnerPickerViewModel()`
/// - `onCreate`: `(_ newChannel: ChannelItem) -> Void`
/// - `body`: `some View`

/// MARK: Methods
/// - `loadMoreUsers()`
///   - returns: `some View`
///   - access: `private`
/// - `DestinationRoute(for route: ChannelCreationRoute)`
///   - parameter `route`: `ChannelCreationRoute`
///   - returns: `some View`
///   - access: `private`
/// - `trailingNavItem()`
///   - returns: `some ToolbarContent`
///   - access: `private`
/// - `CancelButton()`
///   - returns: `some View`
///   - access: `private`
// MARK: - ChatPartnerPickerScreen.HeaderItemView
/// Documentation for ChatPartnerPickerScreen.HeaderItemView
///
/// MARK: Properties
/// - `item`: `ChatPartnerPickerOption`
/// - `opTapHandler`: `() -> Void`
/// - `body`: `some View`

/// MARK: Methods
/// - `ButtonBody()`
///   - returns: `some View`
///   - access: `private`
// MARK: - ChatPartnerPickerViewModel
/// Documentation for ChatPartnerPickerViewModel
///
/// MARK: Properties
/// - `navStack`: `[ChannelCreationRoute]` - Default: `[ChannelCreationRoute]()`
/// - `selectedChatPartners`: `[UserItem]` - Default: `[UserItem]()`
/// - `users`: `[UserItem]` - Default: `[UserItem]()`
/// - `errorState`: `(showError :Bool , errorMessage :String)` - Default: `(false,"Uh Oh")`
/// - `subScription`: `AnyCancellable?` (Optional)
/// - `lastCursor`: `String?` (Optional)
/// - `currentUser`: `UserItem?` (Optional)
/// - `showSelectedUsers`: `Bool`
/// - `disableNextButton`: `Bool`
/// - `isPageinatable`: `Bool`
/// - `isDirectChannel`: `Bool`

/// MARK: Methods
/// - `init()`
///   - returns: `ChatPartnerPickerViewModel`
///   - access: `internal`
/// - `deinit()`
///   - returns: `Void`
///   - access: `internal`
/// - `listenToAuthState()`
///   - returns: `Void`
///   - access: `private`
/// - `fetchUsers()`
///   - returns: `Void`
///   - access: `internal`
/// - `deSelectAllChatPartners()`
///   - returns: `Void`
///   - access: `internal`
/// - `handleItemSelection(_ item: UserItem)`
///   - parameter `item`: `UserItem`
///   - returns: `Void`
///   - access: `internal`
/// - `isUserSelected(_ user: UserItem)`
///   - parameter `user`: `UserItem`
///   - returns: `Bool`
///   - access: `internal`
/// - `createDirectChannel(chatPartner: UserItem, completion: @escaping (_ newChannel: ChannelItem) -> Void)`
///   - parameter `chatPartner`: `UserItem`
///   - parameter `completion`: `@escaping (_ newChannel: ChannelItem) -> Void`
///   - returns: `Void`
///   - access: `internal`
/// - `vertifyIfDirectChannelExists(with chatPartnerId: String)`
///   - parameter `chatPartnerId`: `String`
///   - returns: `ChannelId?`
///   - access: `private`
/// - `createGroupChannel(_ groupName: String?, completion: @escaping (_ newChannel: ChannelItem) -> Void)`
///   - parameter `groupName`: `String?`
///   - parameter `completion`: `@escaping (_ newChannel: ChannelItem) -> Void`
///   - returns: `Void`
///   - access: `internal`
/// - `showError(_ errorMessage: String)`
///   - parameter `errorMessage`: `String`
///   - returns: `Void`
///   - access: `private`
/// - `createChannel(_ channelName: String?)`
///   - parameter `channelName`: `String?`
///   - returns: `Result<ChannelItem,Error>`
///   - access: `private`
// MARK: - ChatPartnerRowView
/// Documentation for ChatPartnerRowView
///
/// MARK: Properties
/// - `user`: `UserItem`
/// - `trailingItems`: `Content`
/// - `body`: `some View`

/// MARK: Methods
/// - `init(user: UserItem, trailingItems: () -> Content = { EmptyView() })`
///   - parameter `user`: `UserItem`
///   - parameter `trailingItems`: `() -> Content`
///   - returns: `ChatPartnerRowView`
///   - access: `internal`
// MARK: - ChatRoomScreen
/// Documentation for ChatRoomScreen
///
/// MARK: Properties
/// - `channel`: `ChannelItem`
/// - `viewModel`: `ChatRoomViewModel`
/// - `body`: `some View`
/// - `channelTitle`: `String`

/// MARK: Methods
/// - `init(channel: ChannelItem)`
///   - parameter `channel`: `ChannelItem`
///   - returns: `ChatRoomScreen`
///   - access: `internal`
/// - `bottomSafeAreaView()`
///   - returns: `some View`
///   - access: `private`
/// - `leadingNavItem()`
///   - returns: `some ToolbarContent`
///   - access: `private`
/// - `trailingNavItem()`
///   - returns: `some ToolbarContent`
///   - access: `private`
// MARK: - ChatRoomViewModel
/// Documentation for ChatRoomViewModel
///
/// MARK: Properties
/// - `textMessage`: `String` - Default: `""`
/// - `messages`: `[MessageItem]` - Default: `[MessageItem]()`
/// - `channel`: `ChannelItem`
/// - `showPhotoPicker`: `Bool` - Default: `false`
/// - `photoPickerItems`: `[PhotosPickerItem]` - Default: `[]`
/// - `mediaAttachments`: `[MediaAttachment]` - Default: `[]`
/// - `videoPlayerState`: `(show: Bool,player:AVPlayer?)` - Default: `(false,nil)`
/// - `isRecordingVoiceMessage`: `Bool` - Default: `false`
/// - `elapsedVoiceMessageTime`: `TimeInterval` - Default: `0`
/// - `scrollToButtomRequest`: `(scroll:Bool,isAnimated :Bool)` - Default: `(false ,false)`
/// - `voiceRecorderService`: `VoiceRecorderService` - Default: `VoiceRecorderService()`
/// - `showPhotoPickerPreview`: `Bool`
/// - `subScriptions`: `Set<AnyCancellable>` - Default: `Set<AnyCancellable>()`
/// - `currentUser`: `UserItem?` (Optional)
/// - `disableSendButton`: `Bool`

/// MARK: Methods
/// - `init(channel: ChannelItem)`
///   - parameter `channel`: `ChannelItem`
///   - returns: `ChatRoomViewModel`
///   - access: `internal`
/// - `deinit()`
///   - returns: `Void`
///   - access: `internal`
/// - `listenToAuthState()`
///   - returns: `Void`
///   - access: `private`
/// - `setUpVoiceRecorderListner()`
///   - returns: `Void`
///   - access: `private`
/// - `clearTextInputArea()`
///   - returns: `Void`
///   - access: `private`
/// - `sendMessage()`
///   - returns: `Void`
///   - access: `internal`
/// - `sendMultipleMediaMessage(_ text: String, attachment: [MediaAttachment])`
///   - parameter `text`: `String`
///   - parameter `attachment`: `[MediaAttachment]`
///   - returns: `Void`
///   - access: `private`
/// - `sendPhotoMessage(text: String, _ attachment: MediaAttachment)`
///   - parameter `text`: `String`
///   - parameter `attachment`: `MediaAttachment`
///   - returns: `Void`
///   - access: `private`
/// - `scrollTobottom(isAnimated: Bool)`
///   - parameter `isAnimated`: `Bool`
///   - returns: `Void`
///   - access: `private`
/// - `uploadImageToStorage(_ attachment: MediaAttachment, completion: @escaping (_ imageUrl: URL) -> Void)`
///   - parameter `attachment`: `MediaAttachment`
///   - parameter `completion`: `@escaping (_ imageUrl: URL) -> Void`
///   - returns: `Void`
///   - access: `private`
/// - `getMessage()`
///   - returns: `Void`
///   - access: `private`
/// - `fetchAllChannelMembers()`
///   - returns: `Void`
///   - access: `private`
/// - `handleTextInputArea(_ action: TextInputArea.userAction)`
///   - parameter `action`: `TextInputArea.userAction`
///   - returns: `Void`
///   - access: `internal`
/// - `toggleAudioRecorder()`
///   - returns: `Void`
///   - access: `private`
/// - `createAudioAttachment(from audioURL: URL?, _ audioDuration: TimeInterval)`
///   - parameter `audioURL`: `URL?`
///   - parameter `audioDuration`: `TimeInterval`
///   - returns: `Void`
///   - access: `private`
/// - `onPhotoPickerSelection()`
///   - returns: `Void`
///   - access: `private`
/// - `parsePhotoPickerItem(_ photoPickerItems: [PhotosPickerItem])`
///   - parameter `photoPickerItems`: `[PhotosPickerItem]`
///   - returns: `Void`
///   - access: `private`
/// - `dismissMediaPlayer()`
///   - returns: `Void`
///   - access: `internal`
/// - `handleMediaAttachmentPreview(_ action: MediaAttachmentPreview.userAction)`
///   - parameter `action`: `MediaAttachmentPreview.userAction`
///   - returns: `Void`
///   - access: `internal`
/// - `showMediaPlayer(_ fileURL: URL)`
///   - parameter `fileURL`: `URL`
///   - returns: `Void`
///   - access: `internal`
/// - `remove(_ item: MediaAttachment)`
///   - parameter `item`: `MediaAttachment`
///   - returns: `Void`
///   - access: `private`
// MARK: - CircularProfileImageView
/// Documentation for CircularProfileImageView
///
/// MARK: Properties
/// - `profileImageUrl`: `String?` (Optional)
/// - `size`: `Size`
/// - `fallbackImage`: `FallBackImage`
/// - `body`: `some View`

/// MARK: Methods
/// - `init(_ profileImageUrl: String? = nil, size: Size)`
///   - parameter `profileImageUrl`: `String?`
///   - parameter `size`: `Size`
///   - returns: `CircularProfileImageView`
///   - access: `internal`
/// - `placeholderImageView()`
///   - returns: `some View`
///   - access: `private`
/// - `init(_ channel: ChannelItem, size: Size)`
///   - parameter `channel`: `ChannelItem`
///   - parameter `size`: `Size`
///   - returns: `CircularProfileImageView`
///   - access: `internal`
// MARK: - CircularProfileImageView.FallBackImage
/// Documentation for CircularProfileImageView.FallBackImage
///
/// MARK: Properties

/// MARK: Methods
/// - `init(for membersCount: Int)`
///   - parameter `membersCount`: `Int`
///   - returns: `CircularProfileImageView.FallBackImage`
///   - access: `internal`
// MARK: - CircularProfileImageView.Size
/// Documentation for CircularProfileImageView.Size
///
/// MARK: Properties
/// - `dimension`: `CGFloat`

// MARK: - CommunityTabScreen
/// Documentation for CommunityTabScreen
///
/// MARK: Properties
/// - `body`: `some View`

/// MARK: Methods
/// - `exampleButtton()`
///   - returns: `some View`
///   - access: `private`
/// - `communityButtton()`
///   - returns: `some View`
///   - access: `private`
// MARK: - CreateCallLinkSection
/// Documentation for CreateCallLinkSection
///
/// MARK: Properties
/// - `body`: `some View`

// MARK: - Date
/// Documentation for Date
///
/// MARK: Properties
/// - `dayOrTimeRepresentation`: `String`
/// - `formatToTime`: `String`

/// MARK: Methods
/// - `toString(format: String)`
///   - parameter `format`: `String`
///   - returns: `String`
///   - access: `internal`
// MARK: - FirebaseConstants
/// Documentation for FirebaseConstants
///
/// MARK: Properties
/// - `StorageRef`: `Storage` - Default: `Storage.storage(url: "gs://whatsapp-a26a2.appspot.com").reference()`
/// - `DatabaseRef`: `Database` - Default: `Database.database(url:"https://whatsapp-a26a2-default-rtdb.asia-southeast1.firebasedatabase.app").reference()`
/// - `UserRef`: `DatabaseRef` - Default: `DatabaseRef.child("user")`
/// - `ChannelRef`: `DatabaseRef` - Default: `DatabaseRef.child("channels")`
/// - `MessageRef`: `DatabaseRef` - Default: `DatabaseRef.child("channels-messages")`
/// - `UserChannelRef`: `DatabaseRef` - Default: `DatabaseRef.child("user-channels")`
/// - `UserDirectChannels`: `DatabaseRef` - Default: `DatabaseRef.child("user-direct-channels")`

// MARK: - FirebaseHelper
/// Documentation for FirebaseHelper
///
/// MARK: Properties

/// MARK: Methods
/// - `uploadImage(_ image: UIImage, for type: UploadType, completion: @escaping UploadCompletion, progressHandler: @escaping ProgressHandler)`
///   - parameter `image`: `UIImage`
///   - parameter `type`: `UploadType`
///   - parameter `completion`: `@escaping UploadCompletion`
///   - parameter `progressHandler`: `@escaping ProgressHandler`
///   - returns: `Void`
///   - access: `internal`
/// - `uploadFile(for type: UploadType, fileURL: URL, completion: @escaping UploadCompletion, progressHandler: @escaping ProgressHandler)`
///   - parameter `type`: `UploadType`
///   - parameter `fileURL`: `URL`
///   - parameter `completion`: `@escaping UploadCompletion`
///   - parameter `progressHandler`: `@escaping ProgressHandler`
///   - returns: `Void`
///   - access: `internal`
// MARK: - FirebaseHelper.UploadType
/// Documentation for FirebaseHelper.UploadType
///
/// MARK: Properties
/// - `filePath`: `StorageReference`

// MARK: - GroupChatPartnersScreen
/// Documentation for GroupChatPartnersScreen
///
/// MARK: Properties
/// - `viewModel`: `ChatPartnerPickerViewModel`
/// - `searchText`: `String` - Default: `""`
/// - `body`: `some View`

/// MARK: Methods
/// - `chatPartnerRowView(_ user: UserItem)`
///   - parameter `user`: `UserItem`
///   - returns: `some View`
///   - access: `private`
/// - `loadMoreUsers()`
///   - returns: `some View`
///   - access: `private`
/// - `titleView()`
///   - returns: `some ToolbarContent`
///   - access: `private`
/// - `traillingNavItem()`
///   - returns: `some ToolbarContent`
///   - access: `private`
// MARK: - LoginScreen
/// Documentation for LoginScreen
///
/// MARK: Properties
/// - `authScreenModel`: `AuthScreenModel` - Default: `AuthScreenModel()`
/// - `body`: `some View`

/// MARK: Methods
/// - `forgetPasswordButton()`
///   - returns: `some View`
///   - access: `private`
/// - `signUpButton()`
///   - returns: `some View`
///   - access: `private`
// MARK: - MainTabView
/// Documentation for MainTabView
///
/// MARK: Properties
/// - `currentUser`: `UserItem`
/// - `body`: `some View`

/// MARK: Methods
/// - `init(_ currentUser: UserItem)`
///   - parameter `currentUser`: `UserItem`
///   - returns: `MainTabView`
///   - access: `internal`
/// - `makeTabBarOpaque()`
///   - returns: `Void`
///   - access: `private`
// MARK: - MainTabView.Tab
/// Documentation for MainTabView.Tab
///
/// MARK: Properties
/// - `icon`: `String`

// MARK: - MediaAttachment
/// Documentation for MediaAttachment
///
/// MARK: Properties
/// - `id`: `String`
/// - `type`: `MediaAttachmentType`
/// - `thumbnail`: `UIImage`
/// - `fileURL`: `URL?` (Optional)

// MARK: - MediaAttachmentPreview
/// Documentation for MediaAttachmentPreview
///
/// MARK: Properties
/// - `mediaAttachments`: `[MediaAttachment]`
/// - `actionHandler`: `(_ action: userAction) -> Void`
/// - `body`: `some View`

/// MARK: Methods
/// - `thumbnailImageView(_ attachment: MediaAttachment)`
///   - parameter `attachment`: `MediaAttachment`
///   - returns: `some View`
///   - access: `private`
/// - `cancleButton(_ attachment: MediaAttachment)`
///   - parameter `attachment`: `MediaAttachment`
///   - returns: `some View`
///   - access: `private`
/// - `playButton(_ systemName: String, attachment: MediaAttachment)`
///   - parameter `systemName`: `String`
///   - parameter `attachment`: `MediaAttachment`
///   - returns: `some View`
///   - access: `private`
/// - `audioAttachmentPreview(_ attachment: MediaAttachment)`
///   - parameter `attachment`: `MediaAttachment`
///   - returns: `some View`
///   - access: `private`
// MARK: - MediaAttachmentPreview.Constants
/// Documentation for MediaAttachmentPreview.Constants
///
/// MARK: Properties
/// - `listHeight`: `CGFloat` - Default: `90`
/// - `imageDimen`: `CGFloat` - Default: `80`

// MARK: - MediaAttachmentPreview.userAction
/// Documentation for MediaAttachmentPreview.userAction
///
/// MARK: Properties

// MARK: - MediaAttachmentType
/// Documentation for MediaAttachmentType
///
/// MARK: Properties

/// MARK: Methods
/// - `==(lhs: MediaAttachmentType, rhs: MediaAttachmentType)`
///   - parameter `lhs`: `MediaAttachmentType`
///   - parameter `rhs`: `MediaAttachmentType`
///   - returns: `Bool`
///   - access: `internal`
// MARK: - MessageDirection
/// Documentation for MessageDirection
///
/// MARK: Properties
/// - `random`: `MessageDirection`

// MARK: - MessageItem
/// Documentation for MessageItem
///
/// MARK: Properties
/// - `id`: `String`
/// - `isGroupChat`: `Bool`
/// - `text`: `String`
/// - `type`: `MessageType`
/// - `ownerUid`: `String`
/// - `timeStmp`: `Date`
/// - `sender`: `UserItem?` (Optional)
/// - `thumbnailUrl`: `String?` (Optional)
/// - `thumbnailHeight`: `CGFloat?` (Optional)
/// - `thumbnailWidth`: `CGFloat?` (Optional)
/// - `direction`: `MessageDirection`
/// - `sentPlaceHolder`: `MessageItem` - Default: `MessageItem(
        id: UUID().uuidString,
        isGroupChat: true,
        text: "sent Holly Spagetiy",
        type:.text,
        ownerUid: "send",
        timeStmp: Date(),
        sender: .placeholder, thumbnailUrl: "https://firebasestorage.googleapis.com/v0/b/whatsapp-a26a2.appspot.com/o/photo_message%2FC28EC1F6-83FE-42FF-958B-5C82C224DCB3.jpeg?alt=media&token=7dc316ac-5acd-47ef-a779-87347e0c4982"
        // direction: .sent
        // direction作为一个计算属性，而不再是属性
    )`
/// - `receivePlaceHolder`: `MessageItem` - Default: `MessageItem(
        id:UUID().uuidString,
        isGroupChat: false,
        text: "receive Holly Spagetiy",
        type:.text,
        ownerUid: "receive",
        timeStmp: Date(),
        sender: .placeholder, thumbnailUrl: ""
    )`
/// - `alignment`: `Alignment`
/// - `horizontalAlignment`: `HorizontalAlignment`
/// - `backgroundColor`: `Color`
/// - `degree`: `Double`
/// - `showGroupPartnerInfo`: `Bool`
/// - `leadingPadding`: `CGFloat`
/// - `trailingPadding`: `CGFloat`
/// - `horizontalPadding`: `CGFloat` - Default: `25`
/// - `imageSize`: `CGSize`
/// - `imageWidth`: `CGFloat`
/// - `stubMessage`: `[MessageItem]` - Default: `[
        MessageItem(id: UUID().uuidString, isGroupChat: false,text: "Hi,there", type: .text,ownerUid: "send", timeStmp: Date(), sender: .placeholder, thumbnailUrl: ""),
        MessageItem(id: UUID().uuidString, isGroupChat: true,text: "check out this photo", type: .photo,ownerUid: "receive", timeStmp: Date(), sender: .placeholder, thumbnailUrl: ""),
        MessageItem(id: UUID().uuidString, isGroupChat: true,text: "Play on this video", type: .video, ownerUid: "receive", timeStmp: Date(), sender: .placeholder, thumbnailUrl: ""),
        MessageItem(id: UUID().uuidString, isGroupChat: false,text: "Listen to this video", type: .audio, ownerUid: "send", timeStmp: Date(), sender: .placeholder, thumbnailUrl: ""),
        MessageItem(id: UUID().uuidString, isGroupChat: false,text: "Hi,there", type: .text, ownerUid: "send", timeStmp: Date(), sender: .placeholder, thumbnailUrl: ""),
        MessageItem(id: UUID().uuidString, isGroupChat: true,text: "Listen to this video", type: .audio, ownerUid: "receive", timeStmp: Date(), sender: .placeholder, thumbnailUrl: ""),
        MessageItem(id: UUID().uuidString, isGroupChat: true,text: "Listen to this video", type: .audio, ownerUid: "send", timeStmp: Date(), sender: .placeholder, thumbnailUrl: "")
    ]`

/// MARK: Methods
/// - `init(id: String, dict: [String:Any], isGroupChat: Bool, sender: UserItem)`
///   - parameter `id`: `String`
///   - parameter `dict`: `[String:Any]`
///   - parameter `isGroupChat`: `Bool`
///   - parameter `sender`: `UserItem`
///   - returns: `MessageItem`
///   - access: `internal`
// MARK: - MessageListController
/// Documentation for MessageListController
///
/// MARK: Properties
/// - `viewModel`: `ChatRoomViewModel`
/// - `cellIdentifier`: `String` - Default: `"MessageListControllerCells"`
/// - `subScriptions`: `Set<AnyCancellable>` - Default: `Set<AnyCancellable>()`
/// - `tableView`: `UITableView` - Default: `{
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()`
/// - `backgroundImageView`: `UIImageView` - Default: `{
        let backgroundImageView = UIImageView(image: .chatbackground)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()`

/// MARK: Methods
/// - `viewDidLoad()`
///   - returns: `Void`
///   - access: `internal`
/// - `init(_ viewModel: ChatRoomViewModel)`
///   - parameter `viewModel`: `ChatRoomViewModel`
///   - returns: `MessageListController`
///   - access: `internal`
/// - `deinit()`
///   - returns: `Void`
///   - access: `internal`
/// - `init?(coder: NSCoder)`
///   - parameter `coder`: `NSCoder`
///   - returns: `MessageListController?`
///   - access: `internal`
/// - `setUpViews()`
///   - returns: `Void`
///   - access: `private`
/// - `setUpMessageListners()`
///   - returns: `Void`
///   - access: `private`
/// - `tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)`
///   - parameter `tableView`: `UITableView`
///   - parameter `indexPath`: `IndexPath`
///   - returns: `UITableViewCell`
///   - access: `internal`
/// - `tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)`
///   - parameter `tableView`: `UITableView`
///   - parameter `section`: `Int`
///   - returns: `Int`
///   - access: `internal`
/// - `tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)`
///   - parameter `tableView`: `UITableView`
///   - parameter `indexPath`: `IndexPath`
///   - returns: `CGFloat`
///   - access: `internal`
// MARK: - MessageListView
/// Documentation for MessageListView
///
/// MARK: Properties
/// - `viewModel`: `ChatRoomViewModel`

/// MARK: Methods
/// - `init(_ viewModel: ChatRoomViewModel)`
///   - parameter `viewModel`: `ChatRoomViewModel`
///   - returns: `MessageListView`
///   - access: `internal`
/// - `makeUIViewController(context: Context)`
///   - parameter `context`: `Context`
///   - returns: `MessageListController`
///   - access: `internal`
/// - `updateUIViewController(_ uiViewController: MessageListController, context: Context)`
///   - parameter `uiViewController`: `MessageListController`
///   - parameter `context`: `Context`
///   - returns: `Void`
///   - access: `internal`
// MARK: - MessageService
/// Documentation for MessageService
///
/// MARK: Properties

/// MARK: Methods
/// - `sendTextMessage(to channel: ChannelItem, from currentUser: UserItem, _ textMessage: String, completion: () -> Void)`
///   - parameter `channel`: `ChannelItem`
///   - parameter `currentUser`: `UserItem`
///   - parameter `textMessage`: `String`
///   - parameter `completion`: `() -> Void`
///   - returns: `Void`
///   - access: `internal`
/// - `sendMediaMessage(to channel: ChannelItem, params: MessageUploadParams, completion: @escaping () -> Void)`
///   - parameter `channel`: `ChannelItem`
///   - parameter `params`: `MessageUploadParams`
///   - parameter `completion`: `@escaping () -> Void`
///   - returns: `Void`
///   - access: `internal`
/// - `getMessages(for channel: ChannelItem, completion: @escaping ([MessageItem]) -> Void)`
///   - parameter `channel`: `ChannelItem`
///   - parameter `completion`: `@escaping ([MessageItem]) -> Void`
///   - returns: `Void`
///   - access: `internal`
// MARK: - MessageType
/// Documentation for MessageType
///
/// MARK: Properties
/// - `title`: `String`

/// MARK: Methods
/// - `init?(_ stringVlue: String)`
///   - parameter `stringVlue`: `String`
///   - returns: `MessageType?`
///   - access: `internal`
/// - `==(lhs: MessageType, rhs: MessageType)`
///   - parameter `lhs`: `MessageType`
///   - parameter `rhs`: `MessageType`
///   - returns: `Bool`
///   - access: `internal`
// MARK: - MessageUploadParams
/// Documentation for MessageUploadParams
///
/// MARK: Properties
/// - `channel`: `ChannelItem`
/// - `text`: `String`
/// - `type`: `MessageType`
/// - `attachment`: `MediaAttachment`
/// - `sender`: `UserItem`
/// - `thumbnailUrl`: `String?` (Optional)
/// - `videoURL`: `String?` (Optional)
/// - `audioURL`: `String?` (Optional)
/// - `audioDuration`: `TimeInterval?` (Optional)
/// - `ownerUid`: `String`
/// - `thumbnailWidth`: `CGFloat?` (Optional)
/// - `thumbnailHeight`: `CGFloat?` (Optional)

// MARK: - NewGroupSetUpScreen
/// Documentation for NewGroupSetUpScreen
///
/// MARK: Properties
/// - `channelName`: `String` - Default: `"Default Group Name"`
/// - `viewModel`: `ChatPartnerPickerViewModel`
/// - `onCreate`: `(_ newChannel: ChannelItem) -> Void`
/// - `body`: `some View`

/// MARK: Methods
/// - `channelSetUpHeaderView()`
///   - returns: `some View`
///   - access: `private`
/// - `profileImageView()`
///   - returns: `some View`
///   - access: `private`
/// - `trailingNavItem()`
///   - returns: `some ToolbarContent`
///   - access: `private`
// MARK: - PhotosPickerItem
/// Documentation for PhotosPickerItem
///
/// MARK: Properties
/// - `isVideo`: `Bool`

// MARK: - RecentCallItemView
/// Documentation for RecentCallItemView
///
/// MARK: Properties
/// - `body`: `some View`

/// MARK: Methods
/// - `rencentCallsTextView()`
///   - returns: `some View`
///   - access: `private`
// MARK: - RecentUpdatesItemView
/// Documentation for RecentUpdatesItemView
///
/// MARK: Properties
/// - `body`: `some View`

// MARK: - RootScreen
/// Documentation for RootScreen
///
/// MARK: Properties
/// - `viewModel`: `RootScreenModel` - Default: `RootScreenModel()`
/// - `body`: `some View`

// MARK: - RootScreenModel
/// Documentation for RootScreenModel
///
/// MARK: Properties
/// - `authState`: `AuthState` - Default: `AuthState.pending`
/// - `cancallable`: `AnyCancellable?` (Optional)

/// MARK: Methods
/// - `init()`
///   - returns: `RootScreenModel`
///   - access: `internal`
// MARK: - SelectedChatPartnerView
/// Documentation for SelectedChatPartnerView
///
/// MARK: Properties
/// - `users`: `[UserItem]`
/// - `onTapHandler`: `(_ user: UserItem) -> Void`
/// - `viewModel`: `ChatPartnerPickerViewModel` - Default: `ChatPartnerPickerViewModel()`
/// - `body`: `some View`

/// MARK: Methods
/// - `chatPartnerView(_ user: UserItem)`
///   - parameter `user`: `UserItem`
///   - returns: `some View`
///   - access: `private`
/// - `cancelButton(_ user: UserItem)`
///   - parameter `user`: `UserItem`
///   - returns: `some View`
///   - access: `private`
// MARK: - SettingHeaderView
/// Documentation for SettingHeaderView
///
/// MARK: Properties
/// - `body`: `some View`

/// MARK: Methods
/// - `userInfoTextView()`
///   - returns: `some View`
///   - access: `private`
// MARK: - SettingsItem
/// Documentation for SettingsItem
///
/// MARK: Properties
/// - `imageName`: `String`
/// - `imageType`: `imageType`
/// - `backgroundColor`: `Color`
/// - `title`: `String`
/// - `avatar`: `SettingsItem` - Default: `SettingsItem(
        imageName: "photo",
        imageType: .systemImage,
        backgroundColor: .blue,
        title: "Change Profile Photo"
    )`
/// - `broadCastLists`: `SettingsItem` - Default: `SettingsItem(
        imageName: "megaphone.fill",
        imageType: .systemImage,
        backgroundColor: .green,
        title: "Broadcast Lists"
    )`
/// - `starredMessages`: `SettingsItem` - Default: `SettingsItem(
        imageName: "star.fill",
        imageType: .systemImage,
        backgroundColor: .yellow,
        title: "Starred Messages"
    )`
/// - `linkedDevices`: `SettingsItem` - Default: `SettingsItem(
        imageName: "laptopcomputer",
        imageType: .systemImage,
        backgroundColor: .green,
        title: "Linked Devices"
    )`
/// - `account`: `SettingsItem` - Default: `SettingsItem(
        imageName: "key.fill",
        imageType: .systemImage,
        backgroundColor: .blue,
        title: "Account"
    )`
/// - `privacy`: `SettingsItem` - Default: `SettingsItem(
        imageName: "lock.fill",
        imageType: .systemImage,
        backgroundColor: .cyan,
        title: "Privacy"
    )`
/// - `chats`: `SettingsItem` - Default: `SettingsItem(
        imageName: "whatsapp-setting",
        imageType: .assetImage,
        backgroundColor: .green,
        title: "Chats"
    )`
/// - `notifications`: `SettingsItem` - Default: `SettingsItem(
        imageName: "bell.badge.fill",
        imageType: .systemImage,
        backgroundColor: .red,
        title: "Notifications"
    )`
/// - `storage`: `SettingsItem` - Default: `SettingsItem(
        imageName: "arrow.up.arrow.down",
        imageType: .systemImage,
        backgroundColor: .green,
        title: "Storage and Data"
    )`
/// - `help`: `SettingsItem` - Default: `SettingsItem(
        imageName: "info",
        imageType: .systemImage,
        backgroundColor: .blue,
        title: "Help"
    )`
/// - `tellFriend`: `SettingsItem` - Default: `SettingsItem(
        imageName: "heart.fill",
        imageType: .systemImage,
        backgroundColor: .red,
        title: "Tell a Friend"
    )`
/// - `media`: `SettingsItem` - Default: `SettingsItem(
        imageName: "photo",
        imageType: .systemImage,
        backgroundColor: .blue,
        title: "Media, Links and Docs"
    )`
/// - `mute`: `SettingsItem` - Default: `SettingsItem(
        imageName: "speaker.wave.2.fill",
        imageType: .systemImage,
        backgroundColor: .green,
        title: "Mute"
    )`
/// - `wallpaper`: `SettingsItem` - Default: `SettingsItem(
        imageName: "circles.hexagongrid",
        imageType: .systemImage,
        backgroundColor: .mint,
        title: "Wallpaper & Sound"
    )`
/// - `saveToCameraRoll`: `SettingsItem` - Default: `SettingsItem(
        imageName: "square.and.arrow.down",
        imageType: .systemImage,
        backgroundColor: .yellow,
        title: "Save to Camera Roll"
    )`
/// - `encryption`: `SettingsItem` - Default: `SettingsItem(
        imageName: "lock.fill",
        imageType: .systemImage,
        backgroundColor: .blue,
        title: "Encryption"
    )`
/// - `disappearingMessages`: `SettingsItem` - Default: `SettingsItem(
        imageName: "timer",
        imageType: .systemImage,
        backgroundColor: .blue,
        title: "Disappearing Messages"
    )`
/// - `lockChat`: `SettingsItem` - Default: `SettingsItem(
        imageName: "lock.doc.fill",
        imageType: .systemImage,
        backgroundColor: .blue,
        title: "Lock Chat"
    )`
/// - `contactDetails`: `SettingsItem` - Default: `SettingsItem(
        imageName: "person.circle",
        imageType: .systemImage,
        backgroundColor: .gray,
        title: "Contact Details"
    )`

// MARK: - SettingsItem.imageType
/// Documentation for SettingsItem.imageType
///
/// MARK: Properties

// MARK: - SettingsItemView
/// Documentation for SettingsItemView
///
/// MARK: Properties
/// - `item`: `SettingsItem`
/// - `body`: `some View`

/// MARK: Methods
/// - `iconImageView()`
///   - returns: `some View`
///   - access: `private`
// MARK: - SettingsTabScreen
/// Documentation for SettingsTabScreen
///
/// MARK: Properties
/// - `searchText`: `String` - Default: `""`
/// - `body`: `some View`

/// MARK: Methods
/// - `trailingNavItem()`
///   - returns: `some ToolbarContent`
///   - access: `private`
// MARK: - SignUpScreen
/// Documentation for SignUpScreen
///
/// MARK: Properties
/// - `dismiss`: `UnknownTypeSoAddTypeAttributionToVariable`
/// - `authScreenModel`: `AuthScreenModel` - Default: `AuthScreenModel()`
/// - `body`: `some View`

/// MARK: Methods
/// - `backButton()`
///   - returns: `some View`
///   - access: `private`
// MARK: - StatusSection
/// Documentation for StatusSection
///
/// MARK: Properties
/// - `body`: `some View`

/// MARK: Methods
/// - `cameraButton()`
///   - returns: `some View`
///   - access: `private`
/// - `pencilButton()`
///   - returns: `some View`
///   - access: `private`
// MARK: - StatusSectionHeader
/// Documentation for StatusSectionHeader
///
/// MARK: Properties
/// - `body`: `some View`

// MARK: - String
/// Documentation for String
///
/// MARK: Properties
/// - `text`: `String` - Default: `"text"`
/// - `type`: `String` - Default: `"type"`
/// - `timeStmp`: `String` - Default: `"timeStmp"`
/// - `ownerUid`: `String` - Default: `"ownerUid"`
/// - `thumbnailWidth`: `String` - Default: `"thumbnailWidth"`
/// - `thumbnailHeight`: `String` - Default: `"thumbnailHeight"`
/// - `uid`: `String` - Default: `"uid"`
/// - `username`: `String` - Default: `"username"`
/// - `email`: `String` - Default: `"email"`
/// - `bio`: `String` - Default: `"bio"`
/// - `profileImageUrl`: `String` - Default: `"profileImageUrl"`
/// - `id`: `String` - Default: `"id"`
/// - `name`: `String` - Default: `"name"`
/// - `lastMessage`: `String` - Default: `"lastMessage"`
/// - `creationDate`: `String` - Default: `"creationDate"`
/// - `lastMessageTimeStmp`: `String` - Default: `"lastMessageTimeStmp"`
/// - `membersCount`: `String` - Default: `"membersCount"`
/// - `adminUids`: `String` - Default: `"adminUids"`
/// - `membersUids`: `String` - Default: `"membersUids"`
/// - `thumbnailUrl`: `String` - Default: `"thumbnailUrl"`
/// - `members`: `String` - Default: `"members"`
/// - `createdBy`: `String` - Default: `"createdBy"`
/// - `lastMessageType`: `String` - Default: `"lastMessageType"`
/// - `isEmptyorWhiteSpace`: `Bool`

// MARK: - TextInputArea
/// Documentation for TextInputArea
///
/// MARK: Properties
/// - `ispulsing`: `Bool` - Default: `false`
/// - `textMessage`: `String`
/// - `viewModel`: `ChatRoomViewModel` - Default: `ChatRoomViewModel(channel: .placeholder)`
/// - `isRecording`: `Bool`
/// - `elapsedTime`: `TimeInterval`
/// - `disableSendButton`: `Bool`
/// - `actionHandle`: `(_ action: userAction) -> Void`
/// - `isSendButtonDisabled`: `Bool`
/// - `body`: `some View`

/// MARK: Methods
/// - `messageTextField()`
///   - returns: `some View`
///   - access: `private`
/// - `textViewBorder()`
///   - returns: `some View`
///   - access: `private`
/// - `imagePickerButton()`
///   - returns: `some View`
///   - access: `private`
/// - `sendMessageButton()`
///   - returns: `some View`
///   - access: `private`
/// - `audioRecorderButton()`
///   - returns: `some View`
///   - access: `private`
/// - `audioSessionIndicatorView()`
///   - returns: `some View`
///   - access: `private`
// MARK: - TextInputArea.userAction
/// Documentation for TextInputArea.userAction
///
/// MARK: Properties

// MARK: - TimeInterval
/// Documentation for TimeInterval
///
/// MARK: Properties
/// - `formatElaspedTime`: `String`
/// - `stubTimeInterval`: `TimeInterval`

// MARK: - UIApplication
/// Documentation for UIApplication
///
/// MARK: Properties

/// MARK: Methods
/// - `dismissKeyboard()`
///   - returns: `Void`
///   - access: `internal`
// MARK: - UITableView
/// Documentation for UITableView
///
/// MARK: Properties

/// MARK: Methods
/// - `scrollTolastRow(at scrollPosition: UITableView.ScrollPosition, animated: Bool)`
///   - parameter `scrollPosition`: `UITableView.ScrollPosition`
///   - parameter `animated`: `Bool`
///   - returns: `Void`
///   - access: `private`
// MARK: - UIWindowScene
/// Documentation for UIWindowScene
///
/// MARK: Properties
/// - `current`: `UIWindowScene?` (Optional)
/// - `screenHeight`: `CGFloat`
/// - `screenwidth`: `CGFloat`

// MARK: - URL
/// Documentation for URL
///
/// MARK: Properties
/// - `stubURL`: `URL`

/// MARK: Methods
/// - `generateVideoThumbnail()`
///   - returns: `UIImage?`
///   - access: `internal`
// MARK: - UpdataTabScreen
/// Documentation for UpdataTabScreen
///
/// MARK: Properties
/// - `searchText`: `String` - Default: `""`
/// - `body`: `some View`

/// MARK: Methods
/// - `channelSectionHeader()`
///   - returns: `some View`
///   - access: `private`
// MARK: - UpdataTabScreen.Constant
/// Documentation for UpdataTabScreen.Constant
///
/// MARK: Properties
/// - `imageDimen`: `CGFloat` - Default: `55`

// MARK: - UploadError
/// Documentation for UploadError
///
/// MARK: Properties
/// - `errorDescription`: `String?` (Optional)

// MARK: - UserItem
/// Documentation for UserItem
///
/// MARK: Properties
/// - `uid`: `String`
/// - `username`: `String`
/// - `email`: `String`
/// - `bio`: `String?` (Optional) - Default: `nil`
/// - `profileImageUrl`: `String?` (Optional) - Default: `nil`
/// - `id`: `String`
/// - `bioUnwrapped`: `String`
/// - `placeholder`: `UserItem` - Default: `UserItem(uid: "1", username: "Luke", email: "swiftSkool@gamil.com")`
/// - `placeholders`: `[UserItem]` - Default: `[
            UserItem(uid: "1", username: "Luke", email: "swiftSkool@gamil.com"),
            UserItem(uid: "2", username: "smith", email: "smith@gamil.com"),
            UserItem(uid: "3", username: "John", email: "John@gamil.com"),
            UserItem(uid: "4", username: "Lily", email: "Lily@gamil.com"),
            UserItem(uid: "5", username: "curl", email: "curl@gamil.com"),
            UserItem(uid: "6", username: "bob", email: "swiftSkool@gamil.com"),
            UserItem(uid: "7", username: "bill", email: "jobs@gamil.com"),
            UserItem(uid: "8", username: "locus", email: "locus@gamil.com"),
            UserItem(uid: "9", username: "jonas", email: "locus@gamil.com"),
            UserItem(uid: "10", username: "jams", email: "swiftSkool@gamil.com"),
            UserItem(uid: "11", username: "jobs", email: "jobs@gamil.com"),
            UserItem(uid: "12", username: "clair", email: "clair@gamil.com"),
        ]`

/// MARK: Methods
/// - `init(dictionary: [String : Any])`
///   - parameter `dictionary`: `[String : Any]`
///   - returns: `UserItem`
///   - access: `internal`
// MARK: - UserNode
/// Documentation for UserNode
///
/// MARK: Properties
/// - `users`: `[UserItem]`
/// - `currentCursor`: `String?` (Optional)
/// - `emptyNode`: `UserNode` - Default: `UserNode(users: [], currentCursor: nil)`

// MARK: - UserService
/// Documentation for UserService
///
/// MARK: Properties

/// MARK: Methods
/// - `getUser(with uids: [String], completion: @escaping (UserNode) -> Void)`
///   - parameter `uids`: `[String]`
///   - parameter `completion`: `@escaping (UserNode) -> Void`
///   - returns: `Void`
///   - access: `internal`
/// - `paginateUsers(lastCursor: String?, pageSize: UInt)`
///   - parameter `lastCursor`: `String?`
///   - parameter `pageSize`: `UInt`
///   - returns: `UserNode`
///   - access: `internal`
// MARK: - VideoPickerTransferable
/// Documentation for VideoPickerTransferable
///
/// MARK: Properties
/// - `url`: `URL`
/// - `transferRepresentation`: `some TransferRepresentation`

// MARK: - View
/// Documentation for View
///
/// MARK: Properties

/// MARK: Methods
/// - `applyTail(_ direction: MessageDirection)`
///   - parameter `direction`: `MessageDirection`
///   - returns: `some View`
///   - access: `internal`
// MARK: - VoiceRecorderService
/// Documentation for VoiceRecorderService
///
/// MARK: Properties
/// - `audioRecorder`: `AVAudioRecorder?` (Optional)
/// - `isRecording`: `Bool` - Default: `false`
/// - `elapsedTime`: `TimeInterval` - Default: `0`
/// - `startTime`: `Date?` (Optional)
/// - `timer`: `AnyCancellable?` (Optional)

/// MARK: Methods
/// - `startRecord()`
///   - returns: `Void`
///   - access: `internal`
/// - `stopRecord(completion: ((_ audioURL: URL, _ audioDuration: TimeInterval) -> Void)? = nil)`
///   - parameter `completion`: `((_ audioURL: URL, _ audioDuration: TimeInterval) -> Void)?`
///   - returns: `Void`
///   - access: `internal`
/// - `tearDown()`
///   - returns: `Void`
///   - access: `internal`
/// - `deleteRecordings(_ urls: [URL])`
///   - parameter `urls`: `[URL]`
///   - returns: `Void`
///   - access: `internal`
/// - `deleteRecordings(at fileUrl: URL)`
///   - parameter `fileUrl`: `URL`
///   - returns: `Void`
///   - access: `internal`
/// - `startTimer()`
///   - returns: `Void`
///   - access: `private`
// MARK: - WhatsAppCloneApp
/// Documentation for WhatsAppCloneApp
///
/// MARK: Properties
/// - `delegate`: `UnknownTypeSoAddTypeAttributionToVariable`
/// - `body`: `some Scene`

// MARK: - mediaPlayerView
/// Documentation for mediaPlayerView
///
/// MARK: Properties
/// - `player`: `AVPlayer`
/// - `dismissPlayer`: `() -> Void`
/// - `body`: `some View`

/// MARK: Methods
/// - `cancelButton()`
///   - returns: `some View`
///   - access: `private`
// MARK: - suggestChannelItemView
/// Documentation for suggestChannelItemView
///
/// MARK: Properties
/// - `body`: `some View`

