//
//  ViewModel.swift
//  Little Lemon
//
//  Created by LLH on 2024-08-22.
//

import Foundation

class ViewModel: ObservableObject {
    
    func isValidInputs(firstName: String, lastName: String, email: String) -> (Bool, String) {
        
        var isError = false
        var errorMessage = ""
        
        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
            if isValidEmail(email) {
                UserDefaults.standard.set(firstName, forKey: kFirstName)
                UserDefaults.standard.set(lastName, forKey: kLastName)
                UserDefaults.standard.set(email, forKey: kEmail)
                
                UserDefaults.standard.set(true, forKey: kOrderStatuses)
                UserDefaults.standard.set(true, forKey: kPasswordChanges)
                UserDefaults.standard.set(true, forKey: kSpecialOffers)
                UserDefaults.standard.set(true, forKey: kNewsletter)
            }
            else {
                errorMessage = "Please enter a valid email."
                isError = true
            }
        }
        else {
            errorMessage = "Please enter all fields."
            isError = true
        }
        
        return (isError, errorMessage)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
