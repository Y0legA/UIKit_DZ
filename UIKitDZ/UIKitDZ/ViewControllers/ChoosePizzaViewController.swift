//
//  ChoosePizzaViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 28.09.22.
//

import UIKit

/// Экран выбора пиццы
final class ChoosePizzaViewController: UIViewController {
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background_2"))
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        return imageView
    }()
  
    private let pizzas: [PropertyOfPizza] = [
    PropertyOfPizza(name: "Деревенская", image: "derevenskaya",
                    description: "Сервелат, бекон, карбонад, шампиньоны, соленые огурцы, лук зеленый, лук красный",
                    calorii: "калории - 218.61 ккал углеводы 22.03 г белки 9.74 г жиры 10.51 г"),
    PropertyOfPizza(name: "Четыре сезона", image: "fourSeasons",
                    description: "Колбаса, ветчина, перец, помидоры, пармезан, морепродукты, твердый сыр, грибы",
                    calorii: "калории - 197.31 ккал, углеводы 21.85г, белки 10.01г, жиры 7.70г"),
    PropertyOfPizza(name: "Маргарита", image: "margarita",
                    description: "Томатная паста, оливковое масто, чеснок, соль, базилик, помидоры черри",
                    calorii: "калории - 201.27 ккал, углеводы 24.89г, белки 10.48г, жиры 6.72г"),
    PropertyOfPizza(name: "Пепперони", image: "pepperoni",
                    description: "Сырокопченая колбаса, оливковое масло, пер. чили, помидоры, орегано, базилик, чеснок",
                    calorii: "калории - 274.10 ккал, углеводы 23.78г, белки 12.08г, жиры 14.53г")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    /// Метод выбора пиццы и перехода на экран выбора ингриедиентов
    @objc private func chooseButtonAction(_ sender: UIButton) {
        let chooseIngredientsVC = AddIngredientsViewController()
        chooseIngredientsVC.pizzaProperty = pizzas[sender.tag]
       present(chooseIngredientsVC, animated: true)
    }
    
    private func configureUI() {
        title = "Pizza"
        configureSubviews()
        makeImages()
        
    }
    
    /// Метод для отрисовки блоков UI с описанием пиццы
    private func makeImages() {
        var yCoordinate: CGFloat = 100
        for (indexPizza, pizza) in pizzas.enumerated() {
            let image = UIImageView(image: UIImage(named: pizza.image))
            image.frame = CGRect(x: 10, y: yCoordinate, width: 70, height: 70)
            let label = UILabel(frame: CGRect(x: image.frame.maxX + 10,
                                              y: image.frame.minY + 15,
                                              width: 250, height: 40))
            label.text = pizza.name
            label.font = UIFont(name: "Avenir Next", size: 25)

            let button = UIButton(frame: CGRect(x: label.frame.maxX,
                                                y: image.frame.minY + 15,
                                                width: 40, height: 40))
            button.tag = indexPizza
            button.setImage(UIImage(named: "button"), for: .normal)
            button.addTarget(self, action: #selector(chooseButtonAction), for: .touchUpInside)
            view.addSubview(image)
            view.addSubview(label)
            view.addSubview(button)
            yCoordinate += 100
        }
    }
    
    private func configureSubviews() {
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImageView)
    }
}
