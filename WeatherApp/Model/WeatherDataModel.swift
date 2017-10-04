//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Arul on 9/26/17.
//  Copyright © 2017 69 Rising. All rights reserved.
//

import Foundation

class WeatherDataModel {
    
    //MARK: - Declare Weather Variable
    /***************************************************************/
    
    var city : String?
    var temperature : String?
    var weatherIcon : String?

    //MARK: - Declare Current Weather Variable
    /***************************************************************/
    
    var day : String?
    var month : String?
    var year : String?
    var getDate : Date?
    
    //MARK: - Initialize Date and Date Formatter Object
    /***************************************************************/
    
    let formatter = DateFormatter()
    
    //MARK: - Func for get weather image from image assets
    /***************************************************************/
    
    func getWeatherIcon(collection: Int) -> String {
        
        switch collection {
            
                case 0...300 :
                    return "tstorm1"
            
                case 301...500 :
                    return "light_rain"
            
                case 501...600 :
                    return "shower3"
            
                case 601...700 :
                    return "snow4"
            
                case 701...771 :
                    return "fog"
            
                case 772...799 :
                    return "tstorm3"
            
                case 800 :
                    return "sunny"
            
                case 801...804 :
                    return "cloudy2"
            
                case 900...903, 905...1000  :
                    return "tstorm3"
            
                case 903 :
                    return "snow5"
            
                case 904 :
                    return "sunny"
            
                default :
                    return "dunno"
        }
            
    }
    
    //MARK: - Func for get months name
    /***************************************************************/
    
    func getMonths(monthInNumber: String) -> String {
        
        switch monthInNumber {
        case "01":
            return "January"
        case "02":
            return "February"
        case "03":
            return "March"
        case "04":
            return "April"
        case "05":
            return "May"
        case "06":
            return "June"
        case "07":
            return "July"
        case "08":
            return "August"
        case "09":
            return "September"
        case "10":
            return "October"
        case "11":
            return "November"
        case "12":
            return "December"
        default:
            return "Month Unavailable"
            
        }
    }
    
    func getForecastDate(dates: Date) -> String {
        formatter.dateFormat = "dd"
        let result = formatter.string(from: dates)
        return result
    }
    
    func getForecastMonth(month: Date) -> String {
        formatter.dateFormat = "MM"
        let result = formatter.string(from: month)
        return getMonths(monthInNumber: result)
    }
    
    func getForecastYear(year: Date) -> String {
        formatter.dateFormat = "yyyy"
        let result = formatter.string(from: year)
        return result
    }
    
}
