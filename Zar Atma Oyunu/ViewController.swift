//
//  ViewController.swift
//  Zar Atma Oyunu
//
//  Created by Barış Yeşilkaya on 12.05.2022.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var lblOyuncu1Skor: UILabel!
    @IBOutlet weak var lblOyuncu2Skor: UILabel!
    @IBOutlet weak var lblOyuncu1Puan: UILabel!
    @IBOutlet weak var lblOyuncu2Puan: UILabel!
    @IBOutlet weak var imgOyuncu1Durum: UIImageView!
    @IBOutlet weak var imgOyuncu2Durum: UIImageView!
    @IBOutlet weak var imgZar1: UIImageView!
    @IBOutlet weak var imgZar2: UIImageView!
    @IBOutlet weak var lblSetSonucu: UILabel!
    
    var oyuncuPuanlari = (firstPlayerPoints : 0, secondPlayerPoints : 0)
    var oyuncuSkorlari = (firstPlayerScore : 0, secondPlayerScore : 0)
    var oyuncuSirasi = 1, maxSetSayisi = 5, suankiSet = 1
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        guard let arkaPlan = UIImage(named: "arkaPlan") else{return}
        self.view.backgroundColor = UIColor(patternImage: arkaPlan)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if suankiSet > maxSetSayisi
        {
            return
        }
        
        zarDegerleriUret()
    }
    
    func setSonucu (zar1 : Int, zar2 : Int)
    {
        
        if oyuncuSirasi == 1
        {
            oyuncuPuanlari.firstPlayerPoints = zar1 + zar2
            lblOyuncu1Puan.text = String(oyuncuPuanlari.firstPlayerPoints)
            oyuncuSirasi = 2
            imgOyuncu1Durum.image = UIImage(named: "bekle")
            imgOyuncu2Durum.image = UIImage(named: "onay")
            lblSetSonucu.text = "Sıra 2. oyuncuda"
            lblOyuncu2Puan.text = "0"
            
        }
        else
        {
            oyuncuPuanlari.secondPlayerPoints = zar1 + zar2
            lblOyuncu2Puan.text = String(oyuncuPuanlari.secondPlayerPoints)
            oyuncuSirasi = 1
            imgOyuncu2Durum.image = UIImage(named: "bekle")
            imgOyuncu1Durum.image = UIImage(named: "onay")
            lblSetSonucu.text = "Sıra 1. oyuncuda"
            lblOyuncu1Puan.text = "0"
            
            if oyuncuPuanlari.firstPlayerPoints > oyuncuPuanlari.secondPlayerPoints
            {
                oyuncuSkorlari.firstPlayerScore += 1
                lblSetSonucu.text = "\(suankiSet). seti 1. oyuncu kazandi."
                lblOyuncu1Skor.text = String(oyuncuSkorlari.firstPlayerScore)
                suankiSet += 1
            }
            else if oyuncuPuanlari.firstPlayerPoints < oyuncuPuanlari.secondPlayerPoints
            {
                oyuncuSkorlari.secondPlayerScore += 1
                lblSetSonucu.text =  "\(suankiSet). seti 2. oyuncu kazandi."
                lblOyuncu2Skor.text = String(oyuncuSkorlari.secondPlayerScore)
                suankiSet += 1
            }
            else
            {
                lblSetSonucu.text =  "Berabere"
            }
        }
    }
    
    func zarDegerleriUret ()
    {   DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2)
        {
            let zar1 = arc4random_uniform(6) + 1
            let zar2 = arc4random_uniform(6) + 1
        
            self.imgZar1.image = UIImage(named: String(zar1))
            self.imgZar2.image = UIImage(named: String(zar2))
        
            self.setSonucu(zar1: Int(zar1), zar2: Int(zar2))
        
            if self.suankiSet > self.maxSetSayisi
            {
                if self.oyuncuSkorlari.firstPlayerScore > self.oyuncuSkorlari.secondPlayerScore
                {
                        self.lblSetSonucu.text = "1. OYUNCU KAZANDI."
                }
                else
                {
                    self.lblSetSonucu.text = "2. OYUNCU KAZANDI."
                }
            }
        }
        lblSetSonucu.text = "\(oyuncuSirasi). oyuncu sallıyor."
        imgZar1.image = UIImage(named: "bilinmeyenZar")
        imgZar2.image = UIImage(named: "bilinmeyenZar")
    }
    
    
}

