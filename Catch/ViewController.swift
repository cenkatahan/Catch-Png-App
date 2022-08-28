import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var labelAt0: UIImageView!
    @IBOutlet weak var labelAt1: UIImageView!
    @IBOutlet weak var labelAt2: UIImageView!
    @IBOutlet weak var labelAt3: UIImageView!
    @IBOutlet weak var labelAt4: UIImageView!
    @IBOutlet weak var labelAt5: UIImageView!
    @IBOutlet weak var labelAt6: UIImageView!
    @IBOutlet weak var labelAt7: UIImageView!
    @IBOutlet weak var labelAt8: UIImageView!
    
    @IBOutlet weak var labelScore: UILabel!
    
    private var views = [UIImageView]()
    private var score = 0
    private var timer = Timer()
    private var time = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        startTimer()
        
    }
    
    func initViews(){
        labelScore.text = "Score: \(score)"
        views = [
            labelAt0, labelAt1, labelAt2,
            labelAt3, labelAt4, labelAt5,
            labelAt6, labelAt7, labelAt8
        ]
        
        for view in views {
            view.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(clickImage))
            view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func clickImage(){
        //increase score
        score += 1
        labelScore.text = "Score: \(score)"
    }
    
    func startTimer(){
        score = 0
        labelScore.text = "Score: \(score)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeVisibilityAt), userInfo: nil, repeats: true)
    }
    
    @objc func changeVisibilityAt(){
        time -= 1
        let randomNumber = generateRandomNumber()
        for (index, view) in views.enumerated() {
            if (index != randomNumber){
                view.isHidden = true
            } else {
                view.isHidden = false
            }
        }
        
        if (time < 0){
            timer.invalidate()
            showAlert()
        }
        
    }
    
    
    func generateRandomNumber() -> Int{
        return Int.random(in: 0...8)
    }
    
    
    func showAlert(){
        let alert = UIAlertController(title: "Time's up!", message: "Replay?", preferredStyle: UIAlertController.Style.alert)
        
        let btnReplay = UIAlertAction(title: "REPLAY", style: UIAlertAction.Style.default) { [self] UIAlertAction in
            time = 10
            startTimer()
        }
        
        let btnDissmis = UIAlertAction(title: "DISMISS", style: UIAlertAction.Style.default) { UIAlertAction in
            self.loadView()
        }
        
        alert.addAction(btnReplay)
        alert.addAction(btnDissmis)
        self.present(alert, animated: true)
    }

}

