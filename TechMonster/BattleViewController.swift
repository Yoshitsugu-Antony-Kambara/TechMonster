//
//  BattleViewController.swift
//  TechMonster
//
//  Created by 神原良継 on 2019/04/13.
//  Copyright © 2019 YoshitsuguKambara. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

    var enemy: Enemy!
    var player: Player!
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var attackButton: UIButton!
    
    @IBOutlet var enemyImageView: UIImageView!
    @IBOutlet var playerImageView: UIImageView!
    
    @IBOutlet var enemyHPBar: UIProgressView!
    @IBOutlet var playerHPBar: UIProgressView!
    
    @IBOutlet var enemyNameLabel: UILabel!
    @IBOutlet var playerNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //標準だとProgressBarが細いので拡大
        enemyHPBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        playerHPBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        
        //プレイヤーのデータをセット
        playerNameLabel.text = player.name
        playerImageView.image = player.image
        playerHPBar.progress = player.currentHP / player.maxHP
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startBattle()
    }
    
    func startBattle() {
        TechDraUtil.playBGM(fileName: "BGM_battle001")
        
        enemy = Enemy()
        
        //数のデータをセット
        enemyNameLabel.text = enemy.name
        enemyImageView.image = enemy.image
        enemyHPBar.progress = enemy.currentHP / enemy.maxHP
        
        //攻撃ボタン
        attackButton.isHidden = true
    }
    
    @IBAction func playerAttack() {
        TechDraUtil.animateDamage(enemyImageView)
        TechDraUtil.playSE(fileName: "SE_attack")
        
        //HPの更新
        enemy.currentHP = enemy.currentHP - player.attackPower
        enemyHPBar.setProgress(enemy.currentHP / enemy.maxHP, animated: true)
        
        //的の敗北
        if enemy.currentHP < 0 {
            TechDraUtil.animateVanish(enemyImageView)
            finishBattle(winPlayer: true)
        }
    }
    
    func finishBattle(winPlayer: Bool) {
        TechDraUtil.stopBGM()
        
        //攻撃ボタンを隠す
        attackButton.isHidden = true
        
        //アラートを表示
        let finishedMessage: String
        if winPlayer == true {
            TechDraUtil.playSE(fileName: "SE_fanfare")
            finishedMessage = "プレイヤーの勝利!!"
        } else {
            TechDraUtil.playSE(fileName: "SE_gameover")
            finishedMessage = "プレイヤーの敗北..."
        }
        let alert = UIAlertController(title: "バトル終了!", message: finishedMessage, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: default, handler: { action in
            //OKを押すと、モーダルを消してLobbyViewControllerに戻る
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
