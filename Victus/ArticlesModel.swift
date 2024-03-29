//
//  ArticlesModel.swift
//  Victus
//
//  Created by Zhansen Zhalel on 26.02.2024.
//

import Foundation

struct Article: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
}

struct ArticlesModel {
    static let articles = [
        Article(
            imageName: "article1",
            title: "Как привести питание в норму без стресса",
            description: """
            В нашем современном мире, где ритм жизни часто быстрый и непредсказуемый, поддержание здорового образа жизни может стать настоящим вызовом. Однако, даже если ваше питание вышло из ритма и требует коррекции, нет необходимости в панике. Привести свое питание в норму можно без стресса, сделав несколько простых, но эффективных шагов.

            1. Постепенные изменения. Внедряйте изменения в свое питание постепенно. Начинайте с маленьких шагов, например, добавляйте больше фруктов и овощей в свой рацион или заменяйте нездоровые перекусы на более полезные альтернативы.
            
            2. Питайтесь разнообразно. Включайте в свой рацион широкий спектр продуктов, чтобы получить все необходимые питательные вещества. Разнообразное питание делает диету интересной и питательной.
            
            3. Будьте внимательны к порциям. Контролируйте размер порций, чтобы избежать переедания. Учите свой организм правильным порциям и слушайте его сигналы насыщения.
            
            4. Не пропускайте приемов пищи. Регулярные приемы пищи помогают поддерживать метаболизм на должном уровне и предотвращают чрезмерный голод, который может привести к необдуманным перекусам.
            
            5. Планируйте заранее. Заранее планируйте свои приемы пищи и закупайтесь продуктами заранее. Это поможет избежать соблазна прибегнуть к быстрым и нездоровым вариантам питания.
            
            6. Научитесь слушать свое тело. Внимательно слушайте сигналы своего тела о голоде и насыщении. Пейте больше воды и обращайте внимание на физические симптомы, указывающие на реальный голод.
            
            7. Не забывайте о удовольствии от пищи. Наслаждайтесь каждым приемом пищи, выбирая качественные продукты и разнообразные блюда. Питание не должно быть скучным или монотонным.
            
            Следуя этим простым советам, вы можете привести свое питание в норму без стресса и добиться здорового стиля жизни. Помните, что важно не только то, что вы едите, но и ваше отношение к питанию.
            """
        ),
        Article(
            imageName: "article2",
            title: "Здоровое и разнообразное питание без лишних затрат",
            description: """
            Все мы стремимся к здоровому и разнообразному питанию, однако иногда кажется, что это слишком дорого. Но не беспокойтесь, вы можете достичь своих питательных целей, не перегружая свой бюджет. Вот несколько советов, как питаться правильно и разнообразно, но при этом не слишком дорого.

            1. Планируйте свои покупки. Перед тем как отправиться в магазин, составьте список продуктов, которые вам нужны. Это поможет избежать лишних покупок и сократить расходы.

            2. Покупайте сезонные продукты. Сезонные фрукты и овощи обычно дешевле и более свежие. Используйте сезонные продукты в своем рационе для экономии денег.

            3. Изучайте специальные предложения и скидки. Внимательно следите за скидками и акциями в магазинах. Подписывайтесь на рассылки или используйте приложения для мобильных устройств, чтобы быть в курсе специальных предложений.

            4. Покупайте оптом. Покупка продуктов в больших упаковках или оптом может быть выгоднее. Разделите продукты на порции и заморозьте лишнее, чтобы сохранить свежесть и экономить деньги.

            5. Используйте дешевые источники белка. Белки являются важной частью питания, но не обязательно покупать дорогие мясные продукты. Вместо этого обратитесь к дешевым источникам белка, таким как яйца, бобы, горох, творог или тофу.

            6. Готовьте дома. Приготовление еды дома обычно дешевле, чем еда в ресторане или фаст-фуде. Исследуйте рецепты и экспериментируйте с приготовлением блюд дома.

            7. Используйте местные рынки и продуктовые кооперативы. Местные рынки и кооперативы могут предлагать более доступные цены на свежие овощи, фрукты и другие продукты.

            8. Минимизируйте потери продуктов. Используйте все части продуктов, включая овощные остатки для бульонов, кожуру фруктов для варенья или компотов. Это поможет сэкономить деньги и уменьшить отходы.

            Следуя этим простым советам, вы сможете питаться правильно и разнообразно, не перегружая свой бюджет. Помните, что забота о здоровье не должна быть дорогой, если вы планируете свои покупки и используете ресурсы эффективно.
            """
        )
    ]
}
