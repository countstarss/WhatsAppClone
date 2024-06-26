#  删除选中的图片媒体文件

- 首先给enum类型的userAction添加一个case：remove
- 然后把 ChatRoomViewModel 中的 handleMediaAttachmentPreview 补全，添加上remove对应的操作：remove（）
- 在 ChatRoomViewModel 中新建函数 remove（） ，添加参数 item : MediaAttachment ,因为要根据这个item的id去匹配要删除的数组的内容
- 填充remove（），思路：找到要删除的attachment 的 index
    - attachmentIndex是 mediaAttachments 中的$0.id 和 item.id匹配的第一项的index 
    - 根据index，删除内容 mediaAttachments.remove（at: attachmentIndex）
    - ======同理，删除photoPicker选中的内容======
    - photoIndex 是 photoPickerItems 中的$0.ItemIdentifier 和 item.id匹配的第一项的index
- ItemIdentifier是photoPicker中特有的内容，实际上添加到photoPicker数组中的是这些图片的ItemIdentifier
    - 这也是为什么完成上一步之后，会出现可以删除thumbnail，但是进入photoPicker，没有取消选中
    - 但是现在我们添加到数组里的是自动生成的UUID，这也是priview和photoPicker不能同步的原因
    - 把UUID替换成ItemIdentifier
- 一般来说，我们无法访问photoPicker，所以要先把photoLibrary分享出来，在添加photoPicker的地方添加 photoLibrary: .shared()
##  到这里，点击cancle按钮删除媒体文件的逻辑处理完成，点击按钮就可以传导到对应的位置完成操作

#  添加动画

- 目前删除内容会两个bug，一个是删除的时候略缩图会重新加载，另外一个是点击的时候背景会闪
- 造成第一个现象的原因是我们的加载方式
- 导致第二个的原因是 ChatRoomViewModel 中控制preview显示的计算属性
    - 它判断attachment是否为空来控制显示，但是实际上有两个容器，所以添加一个 || photoPickerItems.isEmpty

- 完成这些之后，添加一些动画效果，也就是使用
    - .animation（.easeInOIut，value: viewModel.showPhotoPickerPreview）
