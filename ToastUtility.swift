
import UIKit

class ToastUtilityNew {
    
    class func showToast(message : String, controller: UIViewController) {
        let toastLabel = UILabel(frame: CGRect(x: controller.view.frame.size.width/2 - 150, y: controller.view.frame.size.height - 150, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5;
        toastLabel.clipsToBounds  =  true
        controller.view.addSubview(toastLabel)
        controller.view.bringSubviewToFront(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    class Builder {
        
        // MARK: Private Var
        private var toast           : UILabel
        private var controller      : UIViewController
        
        private var screenTime                  : TimeInterval = 1.0
        private var hideAnimationDuration       : TimeInterval = 2.0
        
        private var width   : CGFloat   = 300.0
        
        // MARK: init Method
        init(message: String, controller: UIViewController) {
            let frame = CGRect(
                x: controller.view.frame.size.width/2 - 150,
                y: controller.view.frame.size.height - 150,
                width: width,
                height: 35)
            
            toast =  UILabel(frame: frame)
            toast.text = message
            toast.numberOfLines = 0
            
            self.controller = controller
            defaultSetup()
        }
        
        // MARK: Builder Set Methods
        func setColor(background: UIColor, text: UIColor) -> ToastUtilityNew.Builder {
            toast.backgroundColor   = background
            toast.textColor         = text
            return self
        }
        
        func set(font: UIFont) -> ToastUtilityNew.Builder {
            toast.font = font
            return self
        }
        
        func setScreenTime(duration: TimeInterval) -> ToastUtilityNew.Builder {
            self.screenTime = duration
            return self
        }
        
        func setHideAnimation(duration: TimeInterval) -> ToastUtilityNew.Builder {
            self.hideAnimationDuration = duration
            return self
        }
        
        func dynamicHeight() -> ToastUtilityNew.Builder {
            if let heigth = toast.text?
                .height(withConstrainedWidth: width, font: toast.font) {
                toast.frame.size.height = heigth
            }
            return self
        }
        
        
        // MARK: Build Method (show)
        func show() {
            controller.view.addSubview(toast)
            controller.view.bringSubviewToFront(toast)
            UIView.animate(
                withDuration: hideAnimationDuration,
                delay: screenTime,
                options: .curveEaseOut,
                animations: { [weak self] in
                    self?.toast.alpha = 0.0
            },
                completion: { [weak self] (_) in
                    self?.toast.removeFromSuperview()
            })
        }
        
        // MARK: Private Method
        private func defaultSetup() {
            toast.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            toast.textColor = UIColor.white
            toast.textAlignment = .center
            toast.font = UIFont(name: "Montserrat-Light", size: 10.0)
            toast.layer.cornerRadius = 5
            toast.clipsToBounds  =  true
        }
    }
}
