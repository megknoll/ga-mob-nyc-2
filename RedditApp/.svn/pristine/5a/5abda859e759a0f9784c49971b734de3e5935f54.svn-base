

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var URL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadURL(URL!)
    }
    
    func loadURL(urlToLoad : String) {
        let url = NSURL(string: urlToLoad)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }

}
