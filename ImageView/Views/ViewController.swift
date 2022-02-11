//
//  ViewController.swift
//  ImageView
//
//  Created by Mohammed Abbas on 2/11/22.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private let viewModel = ViewModel()
    private var cancellers = Set<AnyCancellable>()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Title"
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var loadImageButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("load image", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(ViewController.loadImage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        setUpBinding()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(loadImageButton)
        
        view.addSubview(stackView)
        
        let safeArea = view.safeAreaLayoutGuide
        stackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    private func setUpBinding() {
        viewModel
            .$data
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                let image = UIImage(data: data)
                self?.imageView.image = image
            }
            .store(in: &cancellers)
    }

    @objc private func loadImage() {
        let frame = imageView.frame
        viewModel.loadImage(width: Int(frame.width), height: Int(frame.height))
    }

}

