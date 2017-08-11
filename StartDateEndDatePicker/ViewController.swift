//
//  ViewController.swift
//  StartDateEndDatePicker
//
//  Created by apple on 11/08/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIChooseDatePickerDataDelegate {



    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //showCalenderPicker
    func showChooseDatesPicker(currentViewControllerIdentifier : String?)
    {
        let datePickerView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chooseDatesController") as! ChooseDatesController
        datePickerView.currentViewController = currentViewControllerIdentifier!
        datePickerView.delegate =  self
        datePickerView.modalPresentationStyle = .overCurrentContext
        self.present(datePickerView, animated: true, completion: nil)
        
    }
    //UIChooseDatePickerDataDelegate
    func getStartAndEndDates(startDate: String?, endDate: String?) {
        
        print("startDate: \(startDate) + endDate \(endDate)")
        
    }
    func getStartAndEndDatesAsDate(startDate: Date?, endDate: Date?) {
        
        print("startDate.Date : \(startDate) + endDate.Date :\(endDate)")
    }
    @IBAction func filterButtonClicked(_ sender: Any) {
        
        showChooseDatesPicker(currentViewControllerIdentifier: "viewController")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

