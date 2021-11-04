//
//  CustomCollectionView.swift
//  ObjectiveCProject
//
//  Created by New Account on 11/3/21.
//

import Foundation
import UIKit

struct CustomData {
    var  backgroundImage : UIImage
}

class CustomCollectionView : UIViewController {
    
    let data = [
        CustomData(backgroundImage: UIImage(named: "Bigsur")!),
        CustomData(backgroundImage: UIImage(named: "Yosemite")!),
        CustomData(backgroundImage: UIImage(named: "FijiIsland")!),
        CustomData(backgroundImage: UIImage(named: "Bigsur")!)
    ]
    
    //create a collectionView
    
    let collectionView : UICollectionView = {
        let view = UIView()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        //register collection view
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomCollectionView()
        addConstraints()
    }
    
    func addCustomCollectionView(){
        view.addSubview(collectionView)
        collectionView.backgroundColor = .orange
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    func addConstraints(){
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 40).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        
    }
}

//Create a custom cell structure
class CustomCell : UICollectionViewCell {
    let customImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    var data :  CustomData? {
        didSet {
            guard let data = data else {
                return
            }
            customImage.image = data.backgroundImage
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        
        //ContentView will hld all the subviews
        contentView.addSubview(customImage)
        
        //Add constraints
        customImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        customImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        
        customImage.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        customImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Extensions: Adding method to existing class

extension CustomCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.data = self.data[indexPath.row]
        
        return cell
    }
    
}

