//
//  BattleResultInformation.swift
//  TransformerWar
//
//  Created by Govind Lokhande on 2017-11-12.
//  Copyright © 2017 Govind Lokhande. All rights reserved

//  BattleResultInformation is a model used to store the values of battles result between transformer. 
import Foundation
class BattleResultInformation {
    var numberOfBattles : Int?
    var winningTeam : Transformer?
    var losingTeam : String?
    var  gameState = Int()
    var specialCondition = String()
}
