# System Design

# channel

Channel
    admins
    members
    creationData
    memberCount
    
Channel-Message
    ChannelId
        messageId
            message: { text,timetemp,sender}
        

User-Direct-Message
    userId
        channelId1: true
        channelId2: true

Direct-Message: unique, 1:1 communication with just 2 members
Group-Channel : non-unique,3-12members

- Denormalization : 为了提高读取性能,牺牲写入占用的内存空间
