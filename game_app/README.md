# PlayStation Games App 🎮

تطبيق متكامل لعرض والبحث عن ألعاب البلايستيشن، تم بناؤه باستخدام **Flutter** وبالاعتماد على **RAWG API**. يتبع التطبيق معايير **Clean Architecture** لضمان فصل منطق العمل عن الواجهة وسهولة الصيانة.

## ✨ المميزات الرئيسية (Core Features)
*   **قائمة ألعاب PlayStation:** عرض تلقائي لأحدث ألعاب PS4 و PS5 عند فتح التطبيق.
*   **نظام البحث:** إمكانية البحث الفوري عن أي لعبة بالاسم في قاعدة بيانات RAWG.
*   **تفاصيل اللعبة:** صفحة مخصصة تعرض الوصف الكامل، المطورين، التقييمات، وصور الألعاب.
*   **إدارة الحالة (State Management):** استخدام مكتبة `Flutter Bloc` (Cubit) لإدارة حالات التطبيق المختلفة (Loading, Success, Error).

---

## 🏗️ الهيكل البرمجي (Clean Architecture)
التطبيق مقسم إلى ثلاث طبقات أساسية:

### 1. طبقة الـ Domain (الجوهر)
تحتوي على منطق العمل الصافي (Pure Logic):
*   **Entities**: الأجسام الأساسية مثل `GameEntity` و `GameDetailsEntity`.
*   **UseCases**: العمليات مثل `SearchGamesUseCase` و `GetGameDetailsUseCase`.
*   **Repositories**: واجهات تعريفية (Abstract Classes) تحدد عقود البيانات.

### 2. طبقة الـ Data
مسؤولة عن جلب البيانات ومعالجتها:
*   **Models**: تحويل الـ JSON إلى كائنات Dart.
*   **Data Sources**: التعامل مع الإنترنت باستخدام مكتبة `Dio`.
*   **Repositories Implementation**: تنفيذ العقود المحددة في طبقة الـ Domain.

### 3. طبقة الـ Presentation
كل ما يخص واجهة المستخدم والتفاعل:
*   **Logic (Cubit)**: إدارة الحالات (مثل `GamesCubit` و `GameDetailsCubit`).
*   **Pages**: الشاشات الرئيسية وشاشة التفاصيل.
*   **Widgets**: المكونات الصغيرة القابلة لإعادة الاستخدام مثل `GameItemWidget`.

---

## 📁 هيكل الملفات والمجلدات (Folder Structure)

```text
lib/
├── core/
│   ├── api/                # ApiConstants, DioFactory
│   ├── di/                 # Dependency Injection (GetIt)
│   ├── errors/             # Failures handling
│   └── routing/            # AppRouter & Routes
├── features/
│   └── games/
│       ├── data/
│       │   ├── datasources/  # GamesRemoteDataSource
│       │   ├── models/       # GameModel, GameDetailsModel
│       │   └── repo/         # GamesRepositoryImpl
│       ├── domain/
│       │   ├── entities/     # GameEntity, GameDetailsEntity
│       │   ├── repo/         # GamesRepository (Interface)
│       │   └── usecases/     # GetPlaystationGames, SearchGames, GetDetails
│       └── presentation/
│           ├── logic/        # Cubits (Games & Details)
│           ├── pages/        # GamesScreen, GameDetailsScreen
│           └── widgets/      # GameItemWidget
└── main.dart