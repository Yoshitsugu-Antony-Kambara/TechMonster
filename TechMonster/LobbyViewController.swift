//
//  LobbyViewController.swift
//  TechMonster
//
//  Created by 神原良継 on 2019/04/13.
//  Copyright © 2019 YoshitsuguKambara. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {

    var maxStamina: Float = 100
    var stamina: Float = 100
    var player: Player = Player()
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaBar: UIProgressView!
    @IBOutlet var levelLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //標準だとスタミナバーが細かいので縦に拡大
        staminaBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        
        //プレイヤーのデータをセット
        nameLabel.text = player.name
        levelLabel.text = String(format: "Lv. %d", player.level)
        
        //スタミナを起動時に最大にする(保存できるといいね！)
        stamina = maxStamina
        staminaBar.progress = stamina / maxStamina
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TechDraUtil.playBGM(fileName: "lobby")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        TechDraUtil.stopBGM()
        
    }
    
    
    @IBAction func startBattle() {
        performSegue(withIdentifier: "startBattle", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startBattle" {
            let battleVC = segue.destination as! BattleViewController
            player.currentHP = player.maxHP
            battleVC.player = player
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
