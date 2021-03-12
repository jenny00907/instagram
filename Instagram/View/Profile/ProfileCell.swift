//
//  ProfileCell.swift
//  Instagram
//
//  Created by Jenny Woorim Lee on 2021/03/12.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    //MARK: - Properties
    private let postImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "portland9")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemRed
        
        addSubview(postImageView)
        postImageView.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    
}

