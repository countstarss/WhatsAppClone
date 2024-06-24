#  commit 34 showing chat partner information in group chats

## 控制是否在BubbleText中显示用户头像
- 使用一个变量控制
- 变量来源于MessageItem，在MessageItem中添加isGroupChat：Bool

- 把页面padding逻辑放到MessageItem属性里边，UI只负责渲染
- 添加leadingPadding和trailingPadding属性

- 由于初始化时图片链接是可选的，所以可传可不传，当然首选是图片url，而不是fallbackImage
- CircularProfileImageView(item.sender.profileImageUrl,size: .mini)
- 图片链接在UserItem中，直接将UserItem作为一个属性添加到MessageItem中



