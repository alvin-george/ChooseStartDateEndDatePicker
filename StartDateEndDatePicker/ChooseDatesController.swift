//
//  ChooseDatesController.swift
//  EyaalZayeed
//
//  Created by apple on 04/07/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

protocol UIChooseDatePickerDataDelegate {
    
    func getStartAndEndDates(startDate :String?,endDate: String?)
    func getStartAndEndDatesAsDate(startDate :Date?,endDate: Date?)
}

class ChooseDatesController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var containerBottomSpace: NSLayoutConstraint!
    
    @IBOutlet weak var startDateTextField: EZTextField!
    @IBOutlet weak var endDateTextField: EZTextField!
    @IBOutlet weak var applyButton: EZButton!
    
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var todayLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var toolBarView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var isStartDate:Bool!
    var selectedStartDate:String?
    var selectedEndDate:String?
    var selectedIndex: Int = 0
    
    var startDate:Date?
    var endDate:Date?

    var minimumDate: Date?
    var maximumDate: Date?
    var todaysDate:Date?

    var currentViewController : String =  String()
    var targetViewController :UIViewController?
    var delegate:UIChooseDatePickerDataDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISetup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        initialUISetup()
        
    }
    func initialUISetup()
    {
        self.automaticallyAdjustsScrollViewInsets =  false
        self.navigationController?.navigationBar.isHidden =  true
        //containerView.setCardView(view: containerView)
        pickerContainerView.isHidden =  true
        
        startDateTextField.leftImage =  UIImage(named: "calender_icon")
        endDateTextField.leftImage = UIImage(named: "calender_icon")
        
        startDateTextField.rightImage =  UIImage(named: "bottom_arrow")
        endDateTextField.rightImage =  UIImage(named: "bottom_arrow")
        
        disableApplyButton()
        hideTodayButton()
        setMaximumDate()

    }
    func setMaximumDate()
    {
        let date = NSDate()
        datePicker.maximumDate = date as Date
    }
    
    func enableApplyButton()
    {
        applyButton.isEnabled = true
        applyButton.alpha = 1.0
        
    }
    func disableApplyButton()
    {
        applyButton.isEnabled = false
        applyButton.alpha = 0.4
    
    }
    func hideTodayButton()
    {
        todayButton.isEnabled = false
        todayLabel.isHidden =  true
        
    }
    func showTodayButton()
    {
        todayButton.isEnabled =  true
        todayLabel.isHidden =  false
        
    }

    //TextField Delegates
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            isStartDate = true
            hideTodayButton()
        case 1:
            isStartDate = false
            showTodayButton()
        default:
            break
        }
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.resignFirstResponder()
        makeTextFieldsInactive()
        pickerContainerView.setViewAnimted(view: pickerContainerView, hidden: false)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    func makeTextFieldsActive()    {
        startDateTextField.isEnabled =  true
        endDateTextField.isEnabled =  true
    }
    func makeTextFieldsInactive()    {
        startDateTextField.isEnabled =  false
        endDateTextField.isEnabled =  false
    }
    func clearTextFieldData()    {
        clearStartDate()
        clearEndDate()
        
        disableApplyButton()
        
    }
    func clearStartDate()
    {
        startDateTextField.text = ""
        selectedStartDate = nil
    }
    func clearEndDate()
    {
        endDateTextField.text = ""
        selectedEndDate = nil
    }
    
    //Picker Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    @IBAction func cancelPicker(_ sender: Any) {
        
        pickerContainerView.setViewAnimted(view: pickerContainerView, hidden: true)
        makeTextFieldsActive()
    }
    @IBAction func donePicker(_ sender: Any) {
        
        self.getDefaultDateIfDateickerValueNotChanged(isStartDate:isStartDate)
        
        switch isStartDate {
        case true:
            startDateTextField.text = selectedStartDate
            break
        case false:
            endDateTextField.text = selectedEndDate
            break
        default :
            break
        }
        
        if (selectedStartDate != nil && selectedEndDate != nil)
        {
            enableApplyButton()
         
        }
        else {
            disableApplyButton()
           
        }
        
        pickerContainerView.setViewAnimted(view: pickerContainerView, hidden: true)
        makeTextFieldsActive()
    }
    @IBAction func datePickerValueChanged(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        switch isStartDate {
        case true:
            selectedStartDate = dateFormatter.string(from: (sender as AnyObject).date)
            startDate =  (sender as AnyObject).date
            break
        case false:
            selectedEndDate = dateFormatter.string(from: (sender as AnyObject).date)
            endDate = (sender as AnyObject).date
            break
        default :
            break
        }
        
    }
    
    @IBAction func applyButtonClicked(_ sender: Any) {
        
        
        self.delegate?.getStartAndEndDatesAsDate(startDate :startDate,endDate: endDate)
        
        self.delegate.getStartAndEndDates(startDate: self.startDateTextField.text, endDate: self.endDateTextField.text)
        
        self.dismiss(animated: true)
        
    }
    @IBAction func todayButtonClicked(_ sender: Any) {
        
        if (selectedStartDate != nil && selectedEndDate != nil)
        {
            enableApplyButton()
            
        }
        else {
            disableApplyButton()
            
        }

        getTodaysDate()
        
        print("selectedEndDate : \(selectedEndDate)")
        
        pickerContainerView.setViewAnimted(view: pickerContainerView, hidden: true)
        makeTextFieldsActive()
        
    }
    func getDefaultDateIfDateickerValueNotChanged(isStartDate:Bool)
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = DateFormatter.Style.none
        
        switch isStartDate {
        case true:
            selectedStartDate = formatter.string(from: datePicker.date)
            startDate =  datePicker.date
            break
        case false:
            selectedEndDate = formatter.string(from: datePicker.date)
            endDate =  datePicker.date
            break
        default :
            break
        }
        
    }
    func getTodaysDate()
    {
        let date:Date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.medium
        dateformatter.timeStyle = DateFormatter.Style.none
        
        endDateTextField.text = dateformatter.string(from: date)
        endDate =  date
        
    }
    @IBAction func closeButtonClicked(_ sender: Any) {
        
        clearTextFieldData()
        self.dismiss(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

}
