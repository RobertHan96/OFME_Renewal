//
//  CharFavoriteMusicCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/30.
//

import UIKit

class CharacterFavoriteMusicCell: UICollectionViewCell {
    @IBOutlet weak var songsContainerView: UIView!
    @IBOutlet weak var firstSongContainerView: UIView!
    @IBOutlet weak var secondSongContainerView: UIView!
    @IBOutlet weak var firstSongName: UILabel!
    @IBOutlet weak var firstArtistName: UILabel!
    @IBOutlet weak var secondSongName: UILabel!

    @IBOutlet weak var featureName: UILabel!
    @IBOutlet weak var secondArtistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configure(feature: String?, data: HomeMainResult?) {
        
        if let characterFeature = feature, let characterInfo = data?.data {
            featureName.makeHightledText(all: "\(characterFeature.getFeatureNameForLable)를 알려줘 !", for: characterFeature.getFeatureNameForLable)
            guard let favoriteSongResponse = characterInfo[characterFeature] else { return }
            let songs = getFavoriteSongFromResponse(response: favoriteSongResponse)
            setupSongs(songs: songs)
            
        }
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        songsContainerView.backgroundColor = .characterFeatureCellBackground
        firstSongContainerView.backgroundColor = .white
        secondSongContainerView.backgroundColor = .white
        firstSongName.textColor = .typoBlack
        firstArtistName.textColor = .favoriteSongArtistName
        secondSongName.textColor = .typoBlack
        secondArtistName.textColor = .favoriteSongArtistName
    }
    
    private func setupSongs(songs: [FavoriteSong]) {
        DispatchQueue.main.async {
            self.firstSongName.text = songs.first?.name
            self.firstArtistName.text = songs.first?.artist
            self.secondSongName.text = songs[1].name
            self.secondArtistName.text = songs[1].artist
        }
    }
    
    private func getFavoriteSongFromResponse(response: String) -> [FavoriteSong]{
        var songs: [FavoriteSong] = []
        response.split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespaces)
                .split(separator: "-")}
                .map { songs.append(FavoriteSong(name: String($0.first ?? ""), artist: String($0[1] ?? "")))  }
        
        return songs
    }
    

}
