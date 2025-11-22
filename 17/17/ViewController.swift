//
//  ViewController.swift
//  17
//
//  Created by user on 11/21/25.
//

import UIKit

class ViewController: UIViewController {

  lazy var firstLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "First Label"
    label.backgroundColor = .systemBlue
    label.setContentHuggingPriority(.init(751), for: .horizontal)
    return label
  }()
  
  lazy var secondLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Second Label"
    label.backgroundColor = .systemGreen
    label.setContentHuggingPriority(.init(750), for: .horizontal)
    return label
  }()
  
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .systemOrange
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private var portraitConstraints: [NSLayoutConstraint] = []
  private var landscapeConstraints: [NSLayoutConstraint] = []
  private var imageViewTopConstraint: NSLayoutConstraint?
  private var imageViewBottomConstraint: NSLayoutConstraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSubviews()
    setupConstraints()
    updateConstraintsForOrientation()
    registerForTraitChanges([UITraitHorizontalSizeClass.self, UITraitVerticalSizeClass.self]) { (self: ViewController, previousTraitCollection: UITraitCollection) in
      self.updateConstraintsForOrientation()
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    updateImageConstraints()
  }
  
  func setupSubviews() {
    view.addSubview(firstLabel)
    view.addSubview(secondLabel)
    view.addSubview(imageView)
  }
  
  func setupConstraints() {
    let portraitLeftSpacing = firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
    let portraitMiddleSpacing = firstLabel.trailingAnchor.constraint(equalTo: secondLabel.leadingAnchor, constant: -20)
    let portraitRightSpacing = secondLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
    
    portraitMiddleSpacing.priority = .init(999)
    
    portraitConstraints = [
      portraitLeftSpacing,
      portraitMiddleSpacing,
      portraitRightSpacing,
      firstLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      secondLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 100),
      imageView.heightAnchor.constraint(equalToConstant: 100)
    ]
    
    updateImageConstraints()
    
    let landscapeLeftSpacing = firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
    let landscapeSpacing1 = firstLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -20)
    let landscapeSpacing2 = imageView.trailingAnchor.constraint(equalTo: secondLabel.leadingAnchor, constant: -20)
    let landscapeRightSpacing = secondLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
    
    landscapeSpacing1.priority = .init(999)
    landscapeSpacing2.priority = .init(999)
    
    landscapeConstraints = [
      landscapeLeftSpacing,
      landscapeSpacing1,
      landscapeSpacing2,
      landscapeRightSpacing,
      firstLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      secondLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 100),
      imageView.heightAnchor.constraint(equalToConstant: 100)
    ]
  }
  
  func updateImageConstraints() {
    if let topConstraint = imageViewTopConstraint {
      NSLayoutConstraint.deactivate([topConstraint])
    }
    if let bottomConstraint = imageViewBottomConstraint {
      NSLayoutConstraint.deactivate([bottomConstraint])
    }
    
    let screenHeight = view.bounds.height > 0 ? view.bounds.height : (view.window?.windowScene?.screen.bounds.height ?? view.bounds.height)
    let offsetFromCenter = screenHeight / 10
    
    imageViewTopConstraint = imageView.bottomAnchor.constraint(lessThanOrEqualTo: firstLabel.topAnchor, constant: -10)
    imageViewTopConstraint?.priority = .init(1000)
    
    imageViewBottomConstraint = imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -offsetFromCenter)
    imageViewBottomConstraint?.priority = .init(999)
    
    if !(UIDevice.current.orientation.isLandscape || view.bounds.width > view.bounds.height) {
      NSLayoutConstraint.activate([imageViewTopConstraint!, imageViewBottomConstraint!])
    }
  }
  
  func updateConstraintsForOrientation() {
    NSLayoutConstraint.deactivate(portraitConstraints)
    NSLayoutConstraint.deactivate(landscapeConstraints)
    
    if let topConstraint = imageViewTopConstraint {
      NSLayoutConstraint.deactivate([topConstraint])
    }
    if let bottomConstraint = imageViewBottomConstraint {
      NSLayoutConstraint.deactivate([bottomConstraint])
    }
    
    if UIDevice.current.orientation.isLandscape || view.bounds.width > view.bounds.height {
      NSLayoutConstraint.activate(landscapeConstraints)
    } else {
      NSLayoutConstraint.activate(portraitConstraints)
      updateImageConstraints()
    }
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    
    coordinator.animate(alongsideTransition: { _ in
      self.updateConstraintsForOrientation()
      self.view.layoutIfNeeded()
    })
  }
  
  @IBAction func toggleCons() {
  }
}

