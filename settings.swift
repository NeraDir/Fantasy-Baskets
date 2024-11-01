//
//  settings.swift
//  Stak Fantasy
//
//  Created by Admin on 20.10.2024.
//

import Foundation
import UIKit

public class settings:UIViewController{
    
    private let bgnames: [String] = ["1","2","3"]
    private var bgbuttons: [UIButton] = []
    private let bg = UIImageView(image: UIImage(named: data.GetBGName()))
    private let slidersView: UIView = UIView()

    let imageCount = 10 // Количество изображений
    let imageNames = ["item1", "item2", "item3", "item4", "item6", "item7", "item8"]
    var imageViews: [UIImageView] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        bge()
        images()

        label()
        slidersAndLabelsSettings()
        backgroundButtons()
        closeButton()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateImages()
    }
    private func backgroundButtons(){
        let rows = 1
              let columns = 3

              let buttonWidth: CGFloat = 110
              let buttonHeight: CGFloat = 220
              let spacing: CGFloat = 10

              let gridWidth = CGFloat(columns) * buttonWidth + CGFloat(columns - 1) * spacing
              let gridHeight = CGFloat(rows) * buttonHeight + CGFloat(rows - 1) * spacing
              
              let startX = (view.frame.width - gridWidth) / 2
              let startY = ((view.frame.height - gridHeight) / 2 ) - 50
              
              var index = 0

              for row in 0..<rows {
                  for column in 0..<columns {
                      let x = startX + CGFloat(column) * (buttonWidth + spacing)
                      let y = startY + CGFloat(row) * (buttonHeight + spacing)

                      let button = UIButton(frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight))
                      button.setBackgroundImage(UIImage(named: bgnames[index]), for: .normal)
                      button.tag = index
                      button.layer.borderWidth = 3
                      button.layer.cornerRadius = 10
                      button.layer.borderColor = CGColor(red: 0, green: 0, blue: 255, alpha: 1)
                      index += 1
                      button.addTarget(self, action: #selector(OnButonPressed(_:)), for: [.touchUpInside,.touchUpOutside])
                      bgbuttons.append(button)
                      view.addSubview(button)
                  }
              }
    }
    
    func images() {
            var frames: [CGRect] = [] // Сохраняем фреймы изображений, чтобы избежать наложения
            
            for i in 0..<imageCount {
                let randomImageName = imageNames[i % imageNames.count]
                guard let image = UIImage(named: randomImageName) else { continue }
                
                // Создание UIImageView с изображением
                let imageView = UIImageView(image: image)
                
                // Генерация случайного размера
                let rndzime = CGFloat.random(in: 50...100)
                let randomSize = CGSize(width: rndzime, height: rndzime)
                imageView.frame.size = randomSize
                
                // Генерация случайной позиции, проверка на наложение
                var randomFrame: CGRect
                repeat {
                    let randomX = CGFloat.random(in: 0...(view.bounds.width - randomSize.width))
                    let randomY = CGFloat.random(in: 0...(view.bounds.height - randomSize.height))
                    randomFrame = CGRect(origin: CGPoint(x: randomX, y: randomY), size: randomSize)
                } while frames.contains { $0.intersects(randomFrame) }
                
                frames.append(randomFrame)
                imageView.frame = randomFrame
                
                // Устанавливаем случайный угол поворота
                let randomRotation = CGFloat.random(in: 0...360) * (.pi / 180)
                imageView.transform = imageView.transform.rotated(by: randomRotation)
                
                // Добавляем UIImageView на экран и в массив
                view.addSubview(imageView)
                imageViews.append(imageView)
            }
        }
        
        func animateImages() {
            for (index, imageView) in imageViews.enumerated() {
                let delay = Double(index) * 0.15 // Задержка для последовательного старта анимации
                animateImageView(imageView, delay: delay)
            }
        }
        
        func animateImageView(_ imageView: UIImageView, delay: Double) {
            UIView.animate(
                withDuration: 1.5,
                delay: delay,
                options: [.autoreverse, .repeat],
                animations: {
                    // Движение вверх
                    imageView.center.y -= 50
                },
                completion: { _ in
                    // Возврат на место
                    imageView.center.y += 50
                }
            )
        }
    
    private func label(){
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.minimumScaleFactor = 0.001
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Futura-Bold", size: 300)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "SETTINGS"
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 90),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -90),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            label.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func bge(){
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.contentMode = .scaleToFill
        view.addSubview(bg)
        
        NSLayoutConstraint.activate([
            bg.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            bg.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            bg.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            bg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    private func slidersAndLabelsSettings(){
       
        slidersView.translatesAutoresizingMaskIntoConstraints = false
        slidersView.contentMode = .scaleAspectFit
        slidersView.layer.zPosition = 3
        view.addSubview(slidersView)
        
        let musicslider = UISlider()
        musicslider.minimumValue = 0
        musicslider.maximumValue = 1
        musicslider.value = data.GetMusic()
        musicslider.translatesAutoresizingMaskIntoConstraints = false
        musicslider.addTarget(self, action: #selector(OnChangeMusic(_:)), for: .valueChanged)
        slidersView.addSubview(musicslider)
        
        let soundslider = UISlider()
        soundslider.minimumValue = 0
        soundslider.maximumValue = 1
        soundslider.value = data.GetSound()
        soundslider.translatesAutoresizingMaskIntoConstraints = false
        soundslider.addTarget(self, action: #selector(OnChangeSound(_:)), for: .valueChanged)
        slidersView.addSubview(soundslider)
        
        let musiclabel = UILabel()
        musiclabel.translatesAutoresizingMaskIntoConstraints = false
        musiclabel.text = "MUSIC"
        musiclabel.textAlignment = .center
        musiclabel.textColor = .white
        musiclabel.contentMode = .scaleAspectFit
        musiclabel.minimumScaleFactor = 0.001
        musiclabel.adjustsFontSizeToFitWidth = true
        musiclabel.layer.zPosition = 2
        musiclabel.font = UIFont(name: "Futura-Bold", size: 300)
        musicslider.addSubview(musiclabel)
        
        
        let soundlabel = UILabel()
        soundlabel.translatesAutoresizingMaskIntoConstraints = false
        soundlabel.text = "SOUND"
        soundlabel.textAlignment = .center
        soundlabel.textColor = .white
        soundlabel.contentMode = .scaleAspectFit
        soundlabel.minimumScaleFactor = 0.001
        soundlabel.adjustsFontSizeToFitWidth = true
        soundlabel.layer.zPosition = 2
        soundlabel.font = UIFont(name: "Futura-Bold", size: 300)
        soundslider.addSubview(soundlabel)
        
        NSLayoutConstraint.activate([
            slidersView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            slidersView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            slidersView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            slidersView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            slidersView.heightAnchor.constraint(equalToConstant: 200),
            musiclabel.centerXAnchor.constraint(equalTo: musicslider.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            musiclabel.topAnchor.constraint(equalTo: musicslider.safeAreaLayoutGuide.topAnchor, constant:-30),
            musiclabel.heightAnchor.constraint(equalToConstant: 40),
            musicslider.centerYAnchor.constraint(equalTo: slidersView.centerYAnchor, constant: -30),
            musicslider.leadingAnchor.constraint(equalTo: slidersView.leadingAnchor, constant: 20),
            musicslider.trailingAnchor.constraint(equalTo: slidersView.trailingAnchor, constant: -20),
            soundlabel.centerXAnchor.constraint(equalTo: soundslider.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            soundlabel.topAnchor.constraint(equalTo: soundslider.safeAreaLayoutGuide.topAnchor, constant:-30),
            soundlabel.heightAnchor.constraint(equalToConstant: 40),
            soundslider.centerYAnchor.constraint(equalTo: slidersView.centerYAnchor, constant: 30),
            soundslider.leadingAnchor.constraint(equalTo: slidersView.leadingAnchor, constant: 20),
            soundslider.trailingAnchor.constraint(equalTo: slidersView.trailingAnchor, constant: -20),
        ])
    }
    
    private func closeButton(){
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.layer.zPosition = 1
        button.setBackgroundImage(UIImage(named: "bt4"), for: .normal)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "X"
        label.textAlignment = .center
        label.textColor = .white
        label.contentMode = .scaleAspectFit
        label.minimumScaleFactor = 0.001
        label.adjustsFontSizeToFitWidth = true
        label.layer.zPosition = 2
        label.font = UIFont(name: "Futura-Bold", size: 300)
        button.tag = 22
        button.addTarget(self, action: #selector(OnButonPressed(_:)), for: [.touchUpInside,.touchUpOutside])
        button.addSubview(label)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: button.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: button.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: button.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: button.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            button.widthAnchor.constraint(equalToConstant: data.squareBt),
            button.heightAnchor.constraint(equalToConstant: data.squareBt),
            button.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
        ])
    }
    
    @objc private func OnChangeMusic(_ sender: UISlider){
        data.SetMusic(value: sender.value)
        MusicPlayer.sharedInstance.player.volume = data.GetMusic()
    }
    
    @objc private func OnChangeSound(_ sender: UISlider){
        data.SetSound(value: sender.value)
        SoundPlayer.sharedInstance.player.volume = data.GetSound()
    }
    
    @objc private func OnButonPressed(_ sender: UIButton){
        SoundPlayer.sharedInstance.player.play()
        if sender.tag < 20{
            data.SetBGName(value: bgnames[sender.tag])
            bg.image = UIImage(named: data.GetBGName())
        }
        else{
            openController(viewController: menu())
        }
    }
    
    private func openController(viewController: UIViewController){
        let vc = viewController
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.hidesBackButton = true
        self.present(vc, animated: true)
    }
}
