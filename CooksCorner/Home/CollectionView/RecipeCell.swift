import UIKit
import SnapKit

class RecipeCell: UICollectionViewCell {
    static let reuseIdentifier = "RecipeCell"
    
    private let thumbnailImageView = UIImageView()
    private let nameLabel = UILabel()
    private let authorLabel = UILabel()
    private let likesLabel = UILabel()
    private let savesLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        contentView.addSubview(thumbnailImageView)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(nameLabel)
        
        authorLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(authorLabel)
        
        likesLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(likesLabel)
        
        savesLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(savesLabel)
    }
    
    private func setupLayout() {
        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.frame.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        likesLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(8)
        }
        
        savesLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(8)
        }
    }
    
    func configure(with recipe: RecipeModel) {
        thumbnailImageView.image = UIImage(named: recipe.thumbnail)
        nameLabel.text = recipe.name
        authorLabel.text = "by \(recipe.author)"
        likesLabel.text = "Likes: \(recipe.likes)"
        savesLabel.text = "Saves: \(recipe.saves)"
    }
}
