//
//  ThreeColumnPickerView.swift
//  UIPickerViewInSwiftUI
//
//  Created by Tuan Nguyen on 30/06/2021.
//

import SwiftUI

struct ThreeColumnPickerView: UIViewRepresentable {
    @Binding var firstElements: [String]
    @Binding var secondElements: [String]
    @Binding var thirdElements: [String]
    
    @Binding var firstSelected: String
    @Binding var secondSelected: String
    @Binding var thirdSelected: String
        
    var didSelectRow: (() -> Void)
    //makeCoordinator()
    func makeCoordinator() -> ThreeColumnPickerView.Coordinator {
        Coordinator(self)
    }
    
    //makeUIView(context:)
    func makeUIView(context: UIViewRepresentableContext<ThreeColumnPickerView>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }
    
    //updateUIView(_:context:)
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<ThreeColumnPickerView>) {
        view.reloadAllComponents()
        if let index = firstElements.firstIndex(of: firstSelected) {
            view.selectRow(index, inComponent: 0, animated: true)
        }
        if let index = secondElements.firstIndex(of: secondSelected) {
            view.selectRow(index, inComponent: 1, animated: true)
        }
        if let index = thirdElements.firstIndex(of: thirdSelected) {
            view.selectRow(index, inComponent: 2, animated: true)
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        private let numberOfColumn = 3
        var parent: ThreeColumnPickerView

        //init(_:)
        init(_ pickerView: ThreeColumnPickerView) {
            self.parent = pickerView
        }
        
        //numberOfComponents(in:)
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return numberOfColumn
        }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return pickerView.bounds.width / CGFloat(numberOfColumn) - 5
        }
        
        //pickerView(_:numberOfRowsInComponent:)
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            switch component {
            case 0:
                return self.parent.firstElements.count
            case 1:
                return self.parent.secondElements.count
            case 2:
                return self.parent.thirdElements.count
            default:
                return 0
            }
        }
        
        //pickerView(_:titleForRow:forComponent:)
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            switch component {
            case 0:
                return self.parent.firstElements[row]
            case 1:
                return self.parent.secondElements[row]
            case 2:
                return self.parent.thirdElements[row]
            default:
                return nil
            }
        }
        
        //pickerView(_:didSelectRow:inComponent:)
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            print("\(component)-\(row)")
            switch component {
            case 0:
                self.parent.firstSelected = self.parent.firstElements[row]
            case 1:
                self.parent.secondSelected = self.parent.secondElements[row]
            case 2:
                self.parent.thirdSelected = self.parent.thirdElements[row]
            default:
                return
            }
            self.parent.didSelectRow()
        }
    }
}
