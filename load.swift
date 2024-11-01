//
//  load.swift
//  Stak Fantasy
//
//  Created by Admin on 20.10.2024.
//

import Foundation
import UIKit
import AVFoundation

public class loader: UIViewController{
    
    let imageCount = 10 // Количество изображений
    let imageNames = ["item1", "item2", "item3", "item4", "item6", "item7", "item8"]
    var imageViews: [UIImageView] = []
    
    private var musicplayer: AVAudioPlayer?
    private var soundplayer: AVAudioPlayer?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.value(forKey: "StackFantasyBackgroundName") == nil {
            UserDefaults.standard.set("1",forKey: "StackFantasyBackgroundName")
        }
        bg()
        images()
        
        logo()
        sound()
        music()
        DoFuncAfterTime(value: 3){
            let vc = menu()
            vc.modalPresentationStyle = .fullScreen
            vc.navigationItem.hidesBackButton = true
            self.present(vc, animated: true)
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateImages()
    }
    
    private func music(){
         guard let path = Bundle.main.path(forResource: "bgds", ofType: "mp3") else { return }
                let url = URL(fileURLWithPath: path)
                
                do {
                    MusicPlayer.sharedInstance.player = try AVAudioPlayer(contentsOf: url)
                } catch {
                    print("Error loading background music: \(error.localizedDescription)")
                }
        MusicPlayer.sharedInstance.player.volume = data.GetMusic()
        MusicPlayer.sharedInstance.player.numberOfLoops = -1
        MusicPlayer.sharedInstance.player.play()
     }
     
     private func sound(){
         guard let path = Bundle.main.path(forResource: "clis", ofType: "mp3") else { return }
                let url = URL(fileURLWithPath: path)
                
                do {
                    SoundPlayer.sharedInstance.player = try AVAudioPlayer(contentsOf: url)
                } catch {
                    print("Error loading background music: \(error.localizedDescription)")
                }
             SoundPlayer.sharedInstance.player.volume = data.GetSound()
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
    
    private func DoFuncAfterTime(value: CGFloat,completetion: @escaping () -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + value){
            completetion()
        }
    }
    
    private func bg(){
        let bg = UIImageView(image: UIImage(named: data.GetBGName()))
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
    
    private func logo(){
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        view.addSubview(logo)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.minimumScaleFactor = 0.001
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Futura-Bold", size: 300)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "LOADING"
        logo.addSubview(label)
        
        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            logo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            logo.heightAnchor.constraint(equalToConstant: 140),
            logo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            label.leadingAnchor.constraint(equalTo: logo.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: logo.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: logo.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            label.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}


class MusicPlayer {
    var player: AVAudioPlayer = AVAudioPlayer()
    let audioPath = Bundle.main.path(forResource: "bgds", ofType: "mp3")!
    static let sharedInstance = MusicPlayer()
    init() { }
}

class SoundPlayer {
    var player: AVAudioPlayer = AVAudioPlayer()
    let audioPath = Bundle.main.path(forResource: "clis", ofType: "mp3")!
    static let sharedInstance = SoundPlayer()
    init() { }
}
