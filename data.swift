//
//  data.swift
//  Stak Fantasy
//
//  Created by Admin on 20.10.2024.
//

import Foundation
import UIKit

public class data{
    
    static public let squareBt: CGFloat = 70
    static public let widthBt: CGFloat = 280
    static public let heightBt: CGFloat = 90
    
    static public func SetPlayerCoins(value: Int){
        UserDefaults.standard.set(value, forKey: "StackFantasyPlayerCoins")
    }
    
    static public func SetBGName(value: String){
        UserDefaults.standard.set(value, forKey: "StackFantasyBackgroundName")
    }
    
    static public func SetSound(value: Float){
        UserDefaults.standard.set(value, forKey: "StackFantasySoundVolume")
    }
    static public func SetMusic(value: Float){
        UserDefaults.standard.set(value, forKey: "StackFantasyMusicVolume")
    }
    static public func SetLevel(value: Int){
        UserDefaults.standard.set(value, forKey: "StackFantasyCurrentLevel")
    }
    static public func SetMaxLevel(value: Int){
        UserDefaults.standard.set(value, forKey: "StackFantasyMaxCurrentLevel")
    }
    
    static public func SetScore(value: Int){
        UserDefaults.standard.set(value, forKey: "StackFantasyPlayerScore")
    }
    
    static public func GetScore() -> Int{
        return UserDefaults.standard.integer(forKey: "StackFantasyPlayerScore")
    }
    
    static public func GetPlayerCoins() -> Int{
        return UserDefaults.standard.integer(forKey: "StackFantasyPlayerCoins")
    }
    
    static public func GetBGName() -> String{
        return UserDefaults.standard.string(forKey: "StackFantasyBackgroundName")!
    }
    
    static public func GetSound() -> Float{
        return UserDefaults.standard.float(forKey: "StackFantasySoundVolume")
    }
    
    static public func GetMusic() -> Float{
        return UserDefaults.standard.float(forKey: "StackFantasyMusicVolume")
    }
    
    static public func GetLevel() -> Int{
        return UserDefaults.standard.integer(forKey: "StackFantasyCurrentLevel")
    }
    
    static public func GetMaxLevel() -> Int{
        return UserDefaults.standard.integer(forKey: "StackFantasyMaxCurrentLevel")
    }
}
