
import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    @IBOutlet weak var myProgressView: UIProgressView!
    
    fileprivate func getResult() {
        request("http://jsonplaceholder.typicode.com/posts").responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success://(let value)
                //print("\(value)")
                
                guard let jsonArray = responseJSON.result.value as? [[String: Any]] else { return }
                print("Array, \(jsonArray)")
                print("1 object \(jsonArray[0])")
                print("1 id \(jsonArray[0]["id"]!)")
                
            case .failure(let error):
                print("\(error)")
                
            }
        }
    }
    
    func checkStatusCode() {
        request("http://jsonplaceholder.typicode.com/posts").responseJSON {
            responseJSON in
            
            guard let statusCode = responseJSON.response?.statusCode else { return }
            
            if (200..<300).contains(statusCode) {
                let value = responseJSON
                    .result
                    .value
                print("value = \(value ?? " ")")
            } else {
                print("error")
            }
            
            print("Status code = \(statusCode)")
        }
    }
    
    func getPicture() {
        
        request("https://i.pinimg.com/originals/ef/6f/8a/ef6f8ac3c1d9038cad7f072261ffc841.jpg").validate()
            
            .downloadProgress { progress in
                
                print("totalUnitCount:\n", progress.totalUnitCount)
                print("completedUnitCount:\n", progress.completedUnitCount)
                print("fractionCompleted:\n", progress.fractionCompleted)
                print("localizedDescription:\n", progress.localizedDescription!)
                print("---------------------------------------------")
                
                
                self.myProgressView.progress = Float(progress.fractionCompleted)
                
        }
        
            .response { response in
                guard let data = response.data,
                let image = UIImage(data: data)
                else { return }
                
                self.myImageView.image = image
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        getResult()
        //        checkStatusCode()
        getPicture()
    }
}

