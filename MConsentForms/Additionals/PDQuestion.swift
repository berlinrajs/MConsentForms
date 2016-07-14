//
//  PDQuestion.swift
//  ProDental
//
//  Created by Leojin Bose on 2/26/16.
//  Copyright © 2016 SRS. All rights reserved.
//

import UIKit

class PDQuestion: NSObject {
    var question : String!
    var isAnswerRequired : Bool!
    var answer : String?
    var selectedOption : Bool!
    
    init(dict : NSDictionary) {
        super.init()
        self.question = dict["question"] as! String
        self.isAnswerRequired = (dict["verification"] as! String) == "Yes"
    }
    init(question: String) {
        super.init()
        self.question = question
        self.isAnswerRequired = false
    }
    class func arrayOfQuestions(array: [String]) -> [PDQuestion]{
        var questions = [PDQuestion]()
        for string in array {
            let question = PDQuestion(question: string)
            question.selectedOption = false
            questions.append(question)
        }
        return questions
    }
    
    
    class func getObjects (arrayResult : NSArray) -> [PDQuestion] {
        var questions  = [PDQuestion]()
        for dict in arrayResult {
            let obj = PDQuestion(dict: dict as! NSDictionary)
            questions.append(obj)
        }
        return questions
    }
    
    
    class func getJSONObject(responseString : String) -> AnyObject? {
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(responseString.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions.AllowFragments)
            return object
        } catch {
            return nil
        }
    }

    
    class func fetchQuestionsForm1(completion:(result : [PDQuestion]?, success : Bool) -> Void) {
        
//        let responseString = "{\"Status\":\"success\",\"posts\":[{\"question\":\"Are you under a physicians care now?\",\"verification\":\"Yes\"},{\"question\":\"Have you ever had a serious head or neck injury?\",\"verification\":\"Yes\"},{\"question\":\"Are you taking any medication , pills ,or drugs?\",\"verification\":\"Yes\"},{\"question\":\"Have you ever taken Fosamax, Bonivia, Actonel or any other medications containing bisphosphonates?\",\"verification\":\"Yes\"},{\"question\":\"Do you take , or have you taken , phen-fen or redux ? \",\"verification\":\"Yes\"},{\"question\":\"Have you ever been hospitalized or had a major operation?\",\"verification\":\"Yes\"},{\"question\":\"Are you on a special diet?\",\"verification\":\"No\"},{\"question\":\"Do you use tobacco?\",\"verification\":\"No\"}]}"
        
        let responseString = "{\"Status\":\"success\",\"posts\":[{\"question\":\"Are you under a physicians care now?\",\"verification\":\"Yes\"},{\"question\":\"Have you ever had a serious head or neck injury?\",\"verification\":\"Yes\"},{\"question\":\"Are you taking any medication, pills or drugs?\",\"verification\":\"Yes\"},{\"question\":\"Have you ever taken Fosamax, Bonivia, Actonel or any other medications containing bisphosphonates?\",\"verification\":\"Yes\"},{\"question\":\"Do you take, or have you taken, Phen-fen or Redux \",\"verification\":\"Yes\"},{\"question\":\"Have you ever been hospitalized or had a major operation?\",\"verification\":\"Yes\"},{\"question\":\"Are you on a special diet?\",\"verification\":\"No\"},{\"question\":\"Do you use tobacco?\",\"verification\":\"No\"}]}"
        let jsonObject = PDQuestion.getJSONObject(responseString)
        completion(result: self.getObjects(jsonObject!["posts"] as! NSArray), success: true)
        
//        ServiceManager.fetchDataFromService("general_api.php", parameters: nil, success: { (result) -> Void in
//            completion(result: self.getObjects(result["posts"] as! NSArray), success: true)
//            print(result)
//            }) { (error) -> Void in
//                completion(result: nil, success: false)
//        }
    }
}


class PDOption : NSObject {
    var question : String!
    var isSelected : Bool?
    var index : Int!
    
    init(value : String) {
        super.init()
        self.question = value
    }
    
    class func getObjects (arrayResult : NSArray) -> [PDOption] {
        var questions  = [PDOption]()
        for (idx, value) in arrayResult.enumerate() {
            let obj = PDOption(value: value as! String)
            obj.index = idx
            questions.append(obj)
        }
        return questions
    }
    
    
    class func fetchQuestionsForm2(completion:(result : [PDOption]?, success : Bool) -> Void) {
        let responseString = "{\"Status\":\"success\",\"posts\":[\"Pregnant \\/ trying to get pregnant\",\"Nursing\",\"Taking oral contraceptives\"]}"
        
        let jsonObject = PDQuestion.getJSONObject(responseString)
        completion(result: self.getObjects(jsonObject!["posts"] as! NSArray), success: true)
        
//        ServiceManager.fetchDataFromService("women_api.php", parameters: nil, success: { (result) -> Void in
//            completion(result: self.getObjects(result["posts"] as! NSArray), success: true)
//            print(result)
//            }) { (error) -> Void in
//                completion(result: nil, success: false)
//        }
    }
    
    class func fetchQuestionsForm3(completion:(result : [PDOption]?, success : Bool) -> Void) {
        
        let responseString = "{\"Status\":\"success\",\"posts\":[\"Aspirin\",\"Penicillin\",\"Codeine\",\"Acrylic\",\"Metal\",\"Latex\",\"Sulfa drugs\",\"Local anesthetics\"]}"
        
        let jsonObject = PDQuestion.getJSONObject(responseString)
        completion(result: self.getObjects(jsonObject!["posts"] as! NSArray), success: true)
        
        
//        ServiceManager.fetchDataFromService("alergic_api.php", parameters: nil, success: { (result) -> Void in
//            completion(result: self.getObjects(result["posts"] as! NSArray), success: true)
//            print(result)
//            }) { (error) -> Void in
//                completion(result: nil, success: false)
//        }
    }
    
    class func fetchQuestionsForm4(completion:(result : [PDOption]?, success : Bool) -> Void) {
        
        let responseString = "{\"Status\":\"success\",\"posts\":[\"AIDS\\/HIV Positive\",\"Alzheimers disease\",\"Anaphylaxis\",\"Anemia\",\"Angina\",\"Arthritis/Gout\",\"Artificial heart valve\",\"Artificial Joints\",\"Asthma\",\"Blood Disease\",\"Blood Transfusion\",\"Breathing Problems\",\"Bruise Easily\",\"Cancer\",\"Chemotherapy\",\"Chest pains\",\"Cold sores \\/ Fever blisters\",\"Congenital heart disorder\",\"Convulsion\",\"Cortisone medicine\",\"Diabetes\",\"Drug Addiction\",\"Easily Winded\",\"Emphysema\",\"Epilepsy or Seizures\",\"Excessive Bleeding\",\"Excessive Thirst\",\"Fainting spells \\/ Dizziness\",\"Frequent Cough\",\"Frequent Diarrhea\",\"Frequent Headaches\",\"Genital Herpes\",\"Glaucoma\",\"Hay Fever\",\"Heart Attack \\/ Failure\",\"Heart Murmur\",\"Heart Pacemaker\",\"Heart Trouble \\/ Disease\",\"Hemophilia\",\"Hepatites A\",\"Hepatites B or C\",\"Herpes\",\"High Blood Pressure\",\"High Cholesterol\",\"Hives or Rash\",\"Hypoglycemia\",\"Irregular Heartbeat\",\"Kidney Problem\",\"Leukemia\",\"Liver Diseases\",\"Low Blood Pressure\",\"Lung diseases\",\"Mitral Valve Prolapse\",\"Osteoporosis\",\"Pain in Jaw Joints\",\"Parathyroid Disease\",\"Psychiatric Care\",\"Radiation Treatments\",\"Recent Weight Loss\",\"Renal Dialysis\",\"Rheumatic Fever\",\"Rheumatism\",\"Scarlet Fever\",\"Shingles\",\"Sickle Cell Disease\",\"Sinus Trouble\",\"Spina Bifida\",\"Stomach\\/Intestinal Disease\",\"Stroke\",\"Swelling of Limbs\",\"Thyroid Disease\",\"Tonsillitis\",\"Tuberculosis\",\"Tumors or Growths\",\"Ulcers\",\"Venereal Disease\",\"Yellow Jaundice\"]}"
        
        let jsonObject = PDQuestion.getJSONObject(responseString)
        completion(result: self.getObjects(jsonObject!["posts"] as! NSArray), success: true)
        
//        ServiceManager.fetchDataFromService("disease_api.php", parameters: nil, success: { (result) -> Void in
//            completion(result: self.getObjects(result["posts"] as! NSArray), success: true)
//            print(result)
//            }) { (error) -> Void in
//                completion(result: nil, success: false)
//        }
    }
    
    class func fetchQuestionsToothExtractionForm1(completion:(result : [PDOption]?, success : Bool) -> Void) {
        let responseString = "{\"Status\":\"success\",\"posts\":[\"Pain\",\"Infection\",\"Decay\",\"Gum Disease\",\"Broken tooth\",\"Non-restorable\"]}"
        
        let jsonObject = PDQuestion.getJSONObject(responseString)
        completion(result: self.getObjects(jsonObject!["posts"] as! NSArray), success: true)
    }
    
    class func fetchQuestionsToothExtractionForm2(completion:(result : [PDOption]?, success : Bool) -> Void) {
        let responseString = "{\"Status\":\"success\",\"posts\":[\"No Treatment\",\"Root Canal Therapy\",\"Filling\",\"Crown\",\"Gum Treatment\"]}"
        
        let jsonObject = PDQuestion.getJSONObject(responseString)
        completion(result: self.getObjects(jsonObject!["posts"] as! NSArray), success: true)
    }
    
    class func fetchQuestionsForm1(completion:(result : [PDOption]?, success : Bool) -> Void) {
        
        let responseString = "{\"Status\":\"success\",\"posts\":[\"Anemia\",\"Prosthetic Joint\",\"AIDS or ARC\",\"Fainting Spells\",\"Asthma/ Hay Fever\",\"Tuberculosis\",\"High Blood Pressure\",\"Diabetes\",\"Hepatitis\",\"GI Disorder\",\"Seizures\",\"Epilepsy\",\"Sinus Trouble\",\"Rheumatic Fever\",\"Kidney Disease\",\"Ever taken Phen-Fen\",\"Jaundice \",\"Acid Reflux\",\"Ulcers\",\"Immune Disorders\",\"Tumors\",\"Arthritis/ Rheumatism\",\"Allergies\",\"Ever taken Fosamax\",\"Liver Disease\",\"Respiratory Disease\",\"Excessive Bleeding\",\"Chemical Dependency \",\"Cancer\",\"Radiation/Chemotherapy\",\"Stroke\",\"Other\"]}"
        
        let jsonObject = PDQuestion.getJSONObject(responseString)
        completion(result: self.getObjects(jsonObject!["posts"] as! NSArray), success: true)
        
        
    }

}
