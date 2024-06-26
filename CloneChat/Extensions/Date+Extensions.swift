//
//  Date+Extensions.swift
//  CloneChat
//
//  Created by luke on 2024/6/19.
//
//  处理时间字符串，根据时间返回不同的值

import Foundation

extension Date {
    
    ///  处理时间字符串，根据时间返回不同的值
    ///  这个拓展会显示日期，但是每条消息只显示单纯的时间就够了，
    ///  所以需要在这个基础上再写一个时间拓展用在BubbleText
    var dayOrTimeRepresentation :String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        
        if calendar.isDateInToday(self){
            dateFormatter.dateFormat = "h:mm a"
            let formattedDate = dateFormatter.string(from: self)
            return formattedDate
        }else if calendar.isDateInYesterday(self){
            return "Yesterday"
        }else{
            dateFormatter.dateFormat = "MM/dd/yy"
            return dateFormatter.string(from: self)
        }
    }
    
    var formatToTime :String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let formattedTime = dateFormatter.string(from: self)
        return formattedTime
    }
    
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let formattedTimeString = dateFormatter.string(from: self)
        return formattedTimeString
    }
}
