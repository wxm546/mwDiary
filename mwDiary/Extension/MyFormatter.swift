//
//  Formatter.swift
//  mmDiary
//
//  Created by wxm on 2022/9/21.
//

import Foundation

//其他选项
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    short full medi long
//    yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'" z
//设置Formatter时区
//    formatter.timeZone = TimeZone(secondsFromGMT: 8)

var dateFormatterHHmm:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
}


var dateFormatterMMMddHHmm:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd HH:mm"
    return formatter
}

var dateFormatterMMdd:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "M-dd"
    return formatter
}

var dateFormatterMMMM:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM"
    return formatter
}

var dateFormatteryyyyMM:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMM"
    return formatter
}

var dateFormatterMM:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM"
    return formatter
}

var dateFormatterdd:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    return formatter
}
var dateFormatteryyyy:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter
}

var dateFormatteryyyyMMMM:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMMM"
    return formatter
}

var dateFormatterHHmmss:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    return formatter
}
var dateFormatteryyyyMMdd:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}




var exportDateFormatteryyyyMMddHHmmss:DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd HHmmss"
    return formatter
}
