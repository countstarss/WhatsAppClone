##  这一部分主要是获取channel中的members
##  现在已经有了currnetUser和前两个用户，只需要获取其他user
##  只取前两个用户的历史原因应该是因为要设置群组名字
        取出两个名字作为channelMembers
            根据members封装membersExcludingMe
                使用map从membersExcludingMe中取出fullName数组
                    判断groupChannel的人数，按照不同的规则拼接groupMembersNames

