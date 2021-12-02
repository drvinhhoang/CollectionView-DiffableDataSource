


import UIKit

final class LibraryController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<TutorialCollection, Tutorial>!
    private let tutorialCollections = DataSource.shared.tutorials
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    private func setupView() {
        self.title = "Library"
        // register reusable supplementary view for header
        collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier)
        
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        configureDataSource()
        configureSnapShot()
    }
}



// MARK: - Collection View

extension LibraryController {
    
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
            section.boundarySupplementaryItems = [sectionHeader]
            
            
            return section
            
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
}


// MARK: - Diffable datasource

extension LibraryController {
    typealias TutorialDataSource = UICollectionViewDiffableDataSource<TutorialCollection, Tutorial>
    
    func configureDataSource() {
        dataSource = TutorialDataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, tutorial: Tutorial) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialCell.reuseIdentifier, for: indexPath) as? TutorialCell else {
                return nil
            }
            
            cell.titleLabel.text = tutorial.title
            cell.thumbnailImageView.image = tutorial.image
            cell.thumbnailImageView.backgroundColor = tutorial.imageBackgroundColor
            
            return cell
            
        }
        
        
        // Setup supplementaryViewProvider
        dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            if let self = self, let titleSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier, for: indexPath) as? TitleSupplementaryView {
                
                // get the current section (section is of type TutorialCollection)
                
                let tutorialCollection = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                // add textLabel.text of header view  using data from current section object (tutorialCollection)
                titleSupplementaryView.textLabel.text = tutorialCollection.title
                
                return titleSupplementaryView
            } else {
                return nil
            }
        }
        
        
    }
    
    
    
    func configureSnapShot() {
        var initialSnapshot = NSDiffableDataSourceSnapshot<TutorialCollection,Tutorial>()
        
        tutorialCollections.forEach { collection in
            initialSnapshot.appendSections([collection])
            initialSnapshot.appendItems(collection.tutorials)
        }
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
}
