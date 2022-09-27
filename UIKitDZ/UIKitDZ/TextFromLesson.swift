//
//  TextFromLesson.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 27.09.22.
//
/*
class ViewController: UIViewController, UITextFieldDelegate {
    
    var buttonShare = UIButton()
    var textField = UITextField()
    var activityViewCobtroller: UIActivityViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createButton()
        self.createTextField()
    }
    
    // MARK: - Method
    func createTextField() {
        self.textField.frame = CGRect(x: 0, y: 0, width: 280, height: 30)
        self.textField.center = self.view.center
        self.textField.borderStyle = .roundedRect
        self.textField.delegate = self
        self.view.addSubview(self.textField)
    }
    
    func createButton() {
        self.buttonShare = UIButton(type: .roundedRect)
        self.buttonShare.frame = CGRect(x: 50, y: 350, width: 280, height: 44)
        self.buttonShare.setTitle("Расшарить", for: .normal)
        self.buttonShare.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        self.view.addSubview(self.buttonShare)
    }
    
    @objc func handleShare(paramSender: Any) {
        let text = self.textField.text
        if text?.count == 0 {
            let message = "Сначала введите текст, потом нажмите кнопку"
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
        
        self.activityViewCobtroller = UIActivityViewController(activityItems: [self.textField.text ?? "nil"],
                                                               applicationActivities: nil)
        guard let activityViewCobtroller = self.activityViewCobtroller else { return }
        self.present(activityViewCobtroller, animated: true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
}
*/
