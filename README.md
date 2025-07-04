# Описание моего проекта
ССЫЛКА НА ВИДЕО:https://youtu.be/suqS-bqfMfU
(В гитхаб не заливалось видео больше 100мб)

Я разработала iOS-приложение для просмотра всех эмодзи с возможностью добавления любимых в избранное.  
В приложении реализовала поиск по имени эмодзи, а также сортировку по категориям и в алфавитном порядке.  
Все запросы к данным проходят через сервер, который ранее был отправлен организаторами, который я развернула на Render.  
Для хранения списка избранных эмодзи локально использовала UserDefaults, чтобы пользовательские предпочтения сохранялись между сессиями.

---

# Инструкции по установке и запуску

1. Клонируйте репозиторий.
2. Перейдите в папку `client`, где находится весь код iOS-приложения.
3. Откройте проект через Xcode.
4. Убедитесь, что сервер запущен на Render.  
   (Есть нюанс, что Render автоматически «усыпляет» сервис, если он 15 минут без активности. При следующем запросе он разбудит его, но это займёт несколько секунд.  
   По вопросам напишите на [https://t.me/msh_ak](https://t.me/msh_ak)).
5. Нажмите **Run** для запуска проекта на устройстве.

---

# Процесс проектирования и разработки

Сначала я разработала серверную часть, которая обращается к внешнему API и передаёт данные в приложение.  
Сервер размещён на платформе Render для удобного и быстрого деплоя.

На стороне клиента я решила использовать архитектуру MVVM, чтобы отделить бизнес-логику от интерфейса и сделать проект более структурированным.

Для создания интерфейса я использовала комбинацию UIKit и SwiftUI.  
Это позволило мне быстрее реализовать сложные элементы интерфейса и одновременно получить гибкость и современный внешний вид.

---

# Уникальные подходы и технологии

- Все внешние запросы проходят только через мой сервер, как и было указано в требованиях.
- Для хранения списка “избранного” используется локальное хранилище (UserDefaults).
- Интерфейс построен с использованием как UIKit, так и SwiftUI для большей гибкости.
- Архитектура MVVM помогла чётко разделить логику и представление.

---

# Принятые компромиссы

Так как времени на реализацию было всего несколько дней, я пыталась реализовать хороший функционал и добавить щепоточку креатива на главной странице.  
Некоторые дополнительные функции вроде сложных фильтров или оффлайн-режима пока отложены, чтобы в процессе курса я их лучше освоила и выполняла.

Также пришлось выбирать между полной адаптацией под UIKit или использованием SwiftUI.  
В итоге я остановилась на комбинации этих подходов, чтобы быстрее и удобнее достичь нужного результата.

---

# Известные ошибки или ограничения

- При медленном интернете может быть небольшая задержка при загрузке эмодзи.
- Если сервер Render временно недоступен, приложение не сможет получить данные (в будущем планирую добавить обработку ошибок).

---

# Почему выбрала этот технический стек

Я выбрала Django для серверной части, потому что была знакома с его структурой благодаря занятиям в университете, а ещё он позволяет очень быстро поднимать работающий API.

На клиенте использовала SwiftUI, потому что это современный инструмент для разработки интерфейсов под iOS, и мне было комфортно на нём работать, даже несмотря на небольшой опыт со Swift.  
Также я подключила элементы UIKit для тех частей, где SwiftUI требовал дополнительных решений.

В итоге всё сложилось довольно естественно и органично.





