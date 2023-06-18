//
//  ViewController.swift
//  iOS_APP_1
//
//  Created by 계은성 on 2023/06/07.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var MusicName: UILabel!
    @IBOutlet weak var ArtistName: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    
    // MARK: - pickerView
    let Max_Arary_Num =  3
    
    let Picker_View_Column = 1
    
    var Text_picker = [ "K-pop", "Jazz", "Metal"]
    
    var stringArray = [String?]()
    
    
    
    
    // MARK: - model
    // 싱글톤 활용하여 networkManager만들기
    let networkManager = NetworkManager.shared

    
    
    var musicArray: [Music] = []
    
    var musicData: Music?

    var term: String = "K-pop"
    
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupFirstView()
        configure()
        setupPicker()
    }
    
    private func setupFirstView() {
        networking(term: "\(term)")
    }
    
    
    private func setupPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        pickerView.backgroundColor = .clear
        pickerView.tintColor = .clear
    }
    
    
    
    private func networking(term: String) {
        networkManager.fetchMusic(term: term) { result in
            switch result {
            case .success(let successData):
                print(#function)
                
                self.musicArray = successData
                
                self.randomData()
                
                
                
                print("333")

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    
    private func randomData() {
        self.musicData = self.musicArray.randomElement()
        self.changeData(musicData: self.musicData!)
    }
    
    
    
    
    
    private func changeData(musicData: Music?) {
        
        let imageURL = musicData?.imageUrl
        
        
        // 이미지가 없을 때 error
        if imageURL == nil {
            print("********** imageUrl이 없음 **********")
            self.ImageView.image = UIImage(systemName: "person")
            self.MusicName.text = "error"
            self.ArtistName.text = "error"
            return
        }
        
        
        
        
        // String으로 된 url을 URL로 사용할 수 있게 하는 작업
        guard let urlString = imageURL, let url = URL(string: urlString) else { return }
        
        
        
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            
            DispatchQueue.main.async { [self] in
                if musicData?.songName == nil {
                    self.networking(term: term)
                    
//                    self.randomData()
                }
                
                self.ImageView.image = UIImage(data: data)
                self.MusicName.text = musicData?.songName
                self.ArtistName.text = musicData?.artistName ?? "없음"
            }
        }
    }
    
    
    
    
    private func configure() {
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 20
        
        resetButton.clipsToBounds = true
        resetButton.layer.cornerRadius = 8
        
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 8
    }
    
    
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
//        networking(term: "\(term)")
        randomData()
    }
    
        //DetailVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVC" {
            let detailVC = segue.destination as! DetailViewController
            
            
            
//            let artist = musicData?.artistName
            
//            dump(musicArray)
            detailVC.musicArray = self.musicArray
            
            
//            detailVC.artistName = musicData?.artistName
//            detailVC.artistName = "Stitcher & Team Coco, Rob Lowe"
//            detailVC.artistName = "newjeans"
            
        }
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
}






// MARK: - picker
extension ViewController: UIPickerViewDelegate {
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Text_picker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        artistName.text = Text_picker[row]
        self.term = Text_picker[row]
        print(term)
        networking(term: term)
    }
}




extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Picker_View_Column
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Text_picker.count
    }
}
