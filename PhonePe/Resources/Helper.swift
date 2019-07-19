
import Foundation
import SVProgressHUD


//MARK: AppDelegate
let appDelegate = UIApplication.shared.delegate as! AppDelegate

//MARK: ScreenSizes
let screenWidth=UIScreen.main.bounds.size.width
let screenHeight=UIScreen.main.bounds.size.height


//MARK: Alerts
let vAlertButtonOk = "Ok"
let vAlertButtonCancel = "Cancel"
let vAlertTitleCommon = ""
let vAlertMessageNetworkConnection = "Make sure your device is connected to the internet."
let vAlertTitleNetworkConnection = "No Internet Connection"
let vAlertMessageInvalidCredential = "Username required"


let vAPIBaseURL = "https://api.github.com/"

typealias BasicBlock = () -> (Void)

//MARK: Spinner diclarations here
func showSpinner(_ message: String)
{
    SVProgressHUD.show(withStatus: message)
    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
}

func dismissSpinner()
{
    SVProgressHUD.dismiss()
}

func dismissSpinnerWithError(_ message: String)
{
    SVProgressHUD.showError(withStatus: message)
}

//Display Alert - With custom button title

func showAlert(_ title: String, message: String,buttonTitle:String)
{
    let alertController = DBAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
    alertController.show()
}


extension UIColor
{
    convenience public init(r:CGFloat, g:CGFloat, b:CGFloat) {
        
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
