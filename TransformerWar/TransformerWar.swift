//
//  ViewController.swift
//  TransformerWar
//
//  Created by Govind Lokhande on 2017-11-12.
//  Copyright © 2017 Govind Lokhande. All rights reserved.
//

import UIKit

class TransformerWar: UIViewController {
    
    var arrayListOfTeams = [Transformer]()
    var GAME_DESTROYED : Int = -1
    var WINNER_FOUND : Int = 0
    var arrayOfTeams = [Transformer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Creaaing the transfarmer objects and add those objects into array
        //"Soundwave"
        let teamSoundwave = Transformer()
        teamSoundwave.strength = 8
        teamSoundwave.intelligence = 9
        teamSoundwave.speed = 2
        teamSoundwave.endurance = 6
        teamSoundwave.rank = 7
        teamSoundwave.courage = 5
        teamSoundwave.firepower = 6
        teamSoundwave.skill = 10
        teamSoundwave.transFormerName = "Soundwave"
        teamSoundwave.transformerType = "D"
        teamSoundwave.numberOfBattles = 0
        
        //"Team Bluestark"
        let teamBluestreak = Transformer()
        teamBluestreak.strength = 6
        teamBluestreak.intelligence = 6
        teamBluestreak.speed = 7
        teamBluestreak.endurance = 9
        teamBluestreak.rank = 5
        teamBluestreak.courage = 2
        teamBluestreak.firepower = 9
        teamBluestreak.skill = 7
        teamBluestreak.transFormerName = "Bluestreak"
        teamBluestreak.transformerType = "D"
        teamBluestreak.numberOfBattles = 0
        
        //Team Hubcap
        let teamHubcap = Transformer()
        teamHubcap.strength = 4
        teamHubcap.intelligence = 4
        teamHubcap.speed = 4
        teamHubcap.endurance = 4
        teamHubcap.rank = 4
        teamHubcap.courage = 4
        teamHubcap.firepower = 4
        teamHubcap.skill = 4
        teamHubcap.transFormerName = "Hubcap"
        teamHubcap.transformerType = "A"
        teamHubcap.numberOfBattles = 0
      
        
        arrayOfTeams.append(teamSoundwave)
        arrayOfTeams.append(teamBluestreak)
        arrayOfTeams.append(teamHubcap)
        
        let battleResumtInformation : BattleResultInformation = self.findWinningTeamAndLosingTeamInformation(arrayListOfTeams: arrayOfTeams)
        
       self.showResult(result: battleResumtInformation)//Function call to show the reult of the battles between transformers.
    }
    //Function implementation to show the reult of the battles between transformers.
    func showResult(result : BattleResultInformation){
     //Switch case to handle the surrewnt state of the game    
        switch result.gameState {
        case WINNER_FOUND:
            print("Winning Team Name - \(String(describing: result.winningTeam?.transFormerName!))")
            print("number of battles - \(result.numberOfBattles!)")
            break
        case GAME_DESTROYED:
            print("number if battles - \(result.numberOfBattles!)")
            print("Game Destroyed")
            break            
        default:  
            print("")
        }
    }
    //Function implementation to get the winning and loosing team information.
    func findWinningTeamAndLosingTeamInformation(arrayListOfTeams:[Transformer]) -> BattleResultInformation {
        self.arrayListOfTeams = arrayListOfTeams
        var battleResultInformation : BattleResultInformation
        let sortedListOfTeams = arrayListOfTeams.sorted(by: { $0.rank! > $1.rank! })//Functional programming for sorting the transformers team W.R.T their ranks.
        //for loop to print sorted tranformers..
        for trans in sortedListOfTeams {
            print("\(trans.transFormerName!) rank --  \(String(describing: trans.rank))")
        }
        //Special Condition Code
        battleResultInformation = self.startBattle()//Functio
        return battleResultInformation
    }
    
     //Function implementation to start the battle between the tranfrmers..
    func startBattle () -> BattleResultInformation {
        //Conditon to handle the result or start battle which depends upon the special conditions.
        let result = specialConditionResult()
        if (result.specialCondition != "NO OP FOUND") {//Condition to check the Transformer named Optimus Prime or Predaking
            return result
        } else {
             return getBattleResult()//Function call to get the battle result between the transformers...
        }
    }
    
    //Function implementation to get the battle result between the transformers...    
    func getBattleResult() -> BattleResultInformation {
       var transformer: Transformer = arrayListOfTeams[0]
       var i : Int = 1
        while i < arrayListOfTeams.count {
            let transformerNext = arrayListOfTeams[1]
            transformer = findWinnerTeamDependsOnFirstCondition(t1:transformer ,t2:transformerNext)//Function call to find the battle result by campairing the transformers teams as per the given conditions..
            i += 1
        }
        let battleResult: BattleResultInformation = createWinningTeamObject(t1: transformer)
        return battleResult
    }
    // Function implementation to create winner transformer team object
    func createWinningTeamObject(t1:Transformer) -> BattleResultInformation {
        let battleResultObject = BattleResultInformation()
        battleResultObject.gameState = WINNER_FOUND
        battleResultObject.losingTeam = ""
        battleResultObject.numberOfBattles = t1.numberOfBattles
        battleResultObject.winningTeam = t1        
        return battleResultObject
    }
    // Function implementation to manage the special condition
    func specialConditionResult() -> BattleResultInformation {
        var battleResultInfo = BattleResultInformation()
        var listOfWinners = Array<BattleResultInformation>()
        for trans in arrayListOfTeams {
            trans.overallRatings = self.calculateOverallRatings(transformer: trans)//Function to clculate the overall rating of the tranformers..
            if(trans.transFormerName == "Optimus Prime" || trans.transFormerName == "Predaking"){
                listOfWinners.append(createWinningTeamObject(t1: trans))
                
            }
        }
        //Condition to differentiate the optimus prime and Predaking tranformers..
        if (listOfWinners.count == 1) {
            battleResultInfo = listOfWinners[0]
            battleResultInfo.specialCondition = "OP"
            return battleResultInfo
        } else if(listOfWinners.count > 1) {//If more than tranformers with name optimus prime and Predaking tranformers..
            battleResultInfo.specialCondition = "MULTIPLE OP"
            return self.createGameDestroyedObject()//function call to destroy & create object to destroy tranformers.
        } else {
            battleResultInfo.specialCondition = "NO OP FOUND"
        }
        
        return battleResultInfo
    }
    
    // Function implementation to calculate overall ratting of transformer team
    func calculateOverallRatings(transformer : Transformer) -> Int{
        
        return (transformer.strength! as Int + transformer.intelligence! as Int + transformer.speed! as Int + transformer.endurance! as Int! + transformer.firepower! as Int)
    }
    // Function implementation to destroyed transformer object
    func createGameDestroyedObject() -> BattleResultInformation {
        let battleResult = BattleResultInformation()
        battleResult.gameState = GAME_DESTROYED
        battleResult.numberOfBattles = 0
        return battleResult
    }
    
    // Function implementation to find the winner team w.r.t given conditions
    func findWinnerTeamDependsOnFirstCondition(t1:Transformer,t2:Transformer) -> Transformer {
        
        var numberOdBattles: Int = 0
        if((t2.courage! - t1.courage!  >= 4) &&  (t2.strength! - t1.strength! >= 3)) {
            t2.noOfVictories = t2.noOfVictories + 1
            numberOdBattles += 1
            t2.numberOfBattles = numberOdBattles
            return t2;
        } else if((t1.courage! - t2.courage!  >= 4) &&  (t1.strength! - t2.strength! >= 3)){
            t1.noOfVictories = t1.noOfVictories + 1
            numberOdBattles += 1
            t1.numberOfBattles = numberOdBattles
            return t1;
        } else if(t2.skill! -  t1.skill!  >= 3){
            t2.noOfVictories = t2.noOfVictories + 1
            numberOdBattles += 1
            t2.numberOfBattles = numberOdBattles
            return t2;
        }else if((t1.skill!) - t2.skill! >= 3){
            t1.noOfVictories = t1.noOfVictories + 1
            numberOdBattles += 1
            t1.numberOfBattles = numberOdBattles
            return t1;
        } else if(t2.overallRatings! > t2.overallRatings!){
            t2.noOfVictories = t2.noOfVictories + 1;
            numberOdBattles += 1
            t2.numberOfBattles = numberOdBattles
            return t1;
        } else if(t1.overallRatings! > t2.overallRatings!) {
            t1.noOfVictories = t1.noOfVictories + 1;
            numberOdBattles += 1
            t1.numberOfBattles = numberOdBattles
            return t1;
        }
        return t1;
    }
    
}


