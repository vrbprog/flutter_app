// ignore_for_file: use_colored_box

import 'package:flutter/material.dart';

class WidgetConstrainsTrainingScreen extends StatefulWidget {
  const WidgetConstrainsTrainingScreen({super.key});

  @override
  State<WidgetConstrainsTrainingScreen> createState() =>
      _WidgetConstrainsTrainingScreenState();
}

class _WidgetConstrainsTrainingScreenState
    extends State<WidgetConstrainsTrainingScreen> {
  int _currentIndex = 0;

  static const _tasks = <Widget>[
    TrainingExample1(),
    TrainingExample2(),
    TrainingExample3(),
    TrainingExample4(),
    TrainingExample5(),
    TrainingExample6(),
    TrainingExample7(),
    TrainingExample8(),
    TrainingExample9(),
    TrainingExample10(),
    TrainingExample11(),
    TrainingExample12(),
    TrainingExample13(),
    TrainingExample14(),
    TrainingExample15(),
    TrainingExample16(),
    TrainingExample17(),
    TrainingExample18(),
    TrainingExample19(),
    TrainingExample20(),
    TrainingExample21(),
    TrainingExample22(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<int>(
          alignment: Alignment.centerRight,
          value: _currentIndex,
          underline: const SizedBox.shrink(),
          items: List.generate(
            _tasks.length,
            (i) => DropdownMenuItem(value: i, child: Text('Task ${i + 1}')),
          ),
          onChanged: (v) {
            final index = v ?? 0;
            setState(() => _currentIndex = index);
          },
        ),
      ),
      body: _tasks[_currentIndex],
    );
  }
}

// Task 1:
// Очікуваний результат: червоний квадрат розміром 150x150 та розміщений у
// правому верхньому куті контейнера
// Зараз: червоний квадрат займає все доступне місце і перекриває зелений
class TrainingExample1 extends StatelessWidget {
  const TrainingExample1({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      color: Colors.green,
      child: Container(width: 150, height: 150, color: Colors.red),
    );
  }
}

// Task 2:
// Очікуваний результат: синій контейнер шириною на весь екран і висотою 200.
// Зараз: помилка — Row дає дітям unbounded width, а Container з
// width: double.infinity в unbounded context спричинить крах.
// Завдання: виправте так, щоб контейнер був видимий і займав все доступне
// місце по ширині
class TrainingExample2 extends StatelessWidget {
  const TrainingExample2({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 100, height: 200, color: Colors.green),
        Container(width: double.infinity, height: 200, color: Colors.blue),
      ],
    );
  }
}

// Task 3:
// Очікуваний результат: Зелений контейнер знаходиться у правому верхньому куті.
// Вирівнювання має здійснюватись через віджет Align. Параметри мають задаватися
// через alignment: Alignment(x, y).
// Подивіться як вирівнювання працює зараз і який віджет
// для цього використовується. В чому різниця з віджетом Align?

class TrainingExample3 extends StatelessWidget {
  const TrainingExample3({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Center(
        child: Container(color: Colors.green, width: 100, height: 100),
      ),
    );
  }
}

// Task 4:
// Очікуваний результат:
// Вкладені контейнери знаходяться по центру екрану
// Розмір зеленого контейнеру не має перевищувати 200*200
// Зелений контейнер видно навколо помаранчевого
// (як рамка/border в 10 пікселів) - але фактичний розмір зеленого не має
// стати більшим ніж 200 на 200.

class TrainingExample4 extends StatelessWidget {
  const TrainingExample4({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,

      child: Container(color: Colors.orange, height: 200, width: 200),
    );
  }
}

// Task 5:
// Очікуваний результат: три вкладені контейнери — червоний > синій > жовтий,
// кожен з відступом(padding) 16 від попереднього. Розмір Жовтого — 100x100.
// Розмір решти контейнерів - не задаються і формуються автоматично.
// Контейнери мають вирівнюватись по центру. Ми маємо бачити жовтий контейнер
// повністю, а червоний та синій - частково.
// Подумайте, які розміри будуть у синього та червоного контейнерів.
// Чи є різниця, якщо обгорнути контейнери в Padding чи передати параметри
// margin чи передати padding?

class TrainingExample5 extends StatelessWidget {
  const TrainingExample5({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Container(
        color: Colors.blue,
        child: Container(color: Colors.yellow, height: 100, width: 100),
      ),
    );
  }
}

// Task 6:
// Очікуваний результат: помаранчевий контейнер 200x200 з текстом по центру.
// Зараз: контейнер підлаштовується під розмір тексту,
// бо не задано явних розмірів.
// Завдання: виправте, задавши розмір контейнеру та вирівнявши текст.
// Звертаю увагу, що сам текст теж має бути по центру.
class TrainingExample6 extends StatelessWidget {
  const TrainingExample6({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.orange,
        child: const Text('Lorem ipsum dolor sit amet, consectetur'),
      ),
    );
  }
}

// Task 7:
// Очікуваний результат: помаранчевий контейнер 100x100 зверху,
// а під ним — список елементів, що займає решту екрану.
// Зараз: є overflow помилка, бо ListView отримує unbounded height
// від Column і намагається бути нескінченним.

class TrainingExample7 extends StatelessWidget {
  const TrainingExample7({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(color: Colors.orange, height: 100, width: 100),
        ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) => Text('Item $index'),
        ),
      ],
    );
  }
}

// Task 8:
// Очікуваний результат: три кольорові блоки в Column,
// червоний займає 1/4, зелений 2/4, синій 1/4 висоти.
// Зараз: всі три однакового розміру (flex: 1 за замовчуванням).
class TrainingExample8 extends StatelessWidget {
  const TrainingExample8({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Container(color: Colors.red)),
        Expanded(child: Container(color: Colors.green)),
        Expanded(child: Container(color: Colors.blue)),
      ],
    );
  }
}

// Task 9:
// Очікуваний результат: червоний контейнер висотою 100,
// зелений контейнер займає решту простору.
// Зараз: червоний та зелений контейнери мають однакові розміри.
class TrainingExample9 extends StatelessWidget {
  const TrainingExample9({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Container(color: Colors.red, height: 100)),
        Expanded(child: Container(color: Colors.green)),
      ],
    );
  }
}

// Task 10:
// Очікуваний результат: помаранчевий контейнер 100x100 зліва,
// а праворуч — список елементів, що займає решту ширини.
// Зараз: є помилка, бо ListView отримує unbounded width від Row.

class TrainingExample10 extends StatelessWidget {
  const TrainingExample10({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Container(color: Colors.orange, height: 100, width: 100),
          ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => Text('Item $index'),
          ),
        ],
      ),
    );
  }
}

// Task 11:
// Очікуваний результат: три кольорові блоки в Row,
// червоний — фіксований 80px, зелений і синій ділять решту порівну.

class TrainingExample11 extends StatelessWidget {
  const TrainingExample11({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(child: Container(color: Colors.red, width: 80, height: 100)),
          Expanded(child: Container(color: Colors.green, height: 100)),
          Expanded(child: Container(color: Colors.blue, height: 100)),
        ],
      ),
    );
  }
}

// Task 12:
// Очікуваний результат: у Row є два контейнери висотою 100.
// Лівий контейнер — червоний, з динамічною шириною.
// Правий контейнер — зелений, займає всю решту доступної ширини.
// Якщо ширина червоного контейнера дорівнює ширині екрана
// або більша за неї, він має зайняти весь доступний простір,
// а зелений контейнер не повинен бути видимим.
// Якщо ширина червоного контейнера менше ширини екрану - червоний контейнер
// має займати саме стільки місця - скільки визначено в width.

// P.S. Це досить складне і не зовсім очевидне завдання.
// Підказка: LayoutBuilder може допомогти.

class TrainingExample12 extends StatelessWidget {
  const TrainingExample12({super.key});
  @override
  Widget build(BuildContext context) {
    const redContainerWidth = 100.0;

    return Row(
      children: [
        Container(
          color: Colors.red,
          height: 100,
          width: redContainerWidth,
          child: const Text('Hi'),
        ),

        Expanded(child: Container(color: Colors.green, height: 100)),
      ],
    );
  }
}

// Task 13:
// Очікуваний результат: текст масштабується під розмір контейнера 200x50,
// без зменшення розміру тексту через fontSize
// Зараз: частину тексту не видно, бо fontSize: 30 занадто великий.

class TrainingExample13 extends StatelessWidget {
  const TrainingExample13({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 50,
        color: Colors.amber,
        child: const Text(
          'Дуже довгий текст який не поміщається',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

// Task 14:
// Очікуваний результат: текст "Flutter" зменшується пропорційно
// при зменшенні контейнера, але не збільшується більше свого натурального
// розміру.
// Зараз: Текст "Flutter" збільшується відповідно до розміру контейнеру.
// Ми хочемо, щоб якщо розмір тексту не потребує зменшення для відображення -
// він має залишатися свого розміру

class TrainingExample14 extends StatelessWidget {
  const TrainingExample14({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 100,
        color: Colors.lightBlue.shade100,
        child: const FittedBox(
          child: Text('Flutter', style: TextStyle(fontSize: 30)),
        ),
      ),
    );
  }
}

// Task 15:
// Очікуваний результат: жовтий контейнер мінімум 200x200,
// навіть якщо child менший. Розмір контейнеру не змінювати. Мінімальний розмір
// задати іншим віджетом.
// Зараз: контейнер 50x50, бо Container має явні width/height,

class TrainingExample15 extends StatelessWidget {
  const TrainingExample15({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(color: Colors.yellow, width: 50, height: 50),
    );
  }
}

// Task 16: ConstrainedBox
// Тут просто розберіться - чому не застосовуються constraints ConstrainedBox?

// Запишіть відповідь у коментарі до коду нижче
// Відповідь: ConstrainedBox не застосовуються, тому що ...
class TrainingExample16 extends StatelessWidget {
  const TrainingExample16({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 300, minHeight: 300),
          child: Container(color: Colors.red),
        ),
      ),
    );
  }
}

// Task 17: ConstrainedBox
// Очікуваний результат: кнопка шириною мінімум 250 і по центру.
// При встановленні ширини кнопки в 1000px - кнопка розтягується на всю
// допустиму ширину і не має бути помилки

class TrainingExample17 extends StatelessWidget {
  const TrainingExample17({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 250),
            child: SizedBox(
              width: 1000,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Press me'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Task 18:
// Очікуваний результат: червоний контейнер 50x50 всередині синього 200x200,
// не розтягнутий батьком.
// Спробуйте спочатку використати UnconstrainedBox - потім
// OverflowBox. Також використайте їх різні параметри.

class TrainingExample18 extends StatelessWidget {
  const TrainingExample18({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.blue,
        width: 200,
        height: 200,
        child: Container(color: Colors.red, width: 50, height: 50),
      ),
    );
  }
}

// Task 19:
// Очікуваний результат: зелений контейнер 300x100 виходить за межі
// батьківського 200x200 без помилок overflow. Використовуйте OverflowBox.
// Зверніть увагу, яка зміна параметрів потрібна для OverflowBox для
// коректного відображення відповідно до вимог

class TrainingExample19 extends StatelessWidget {
  const TrainingExample19({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.blue,
        width: 200,
        height: 200,
        child: UnconstrainedBox(
          child: Container(color: Colors.green, width: 300, height: 100),
        ),
      ),
    );
  }
}

// Task 20:
// В цьому варіанті Вам потрібно розібратися чому зелений контейнер
// накладається на червоний, але не накладається на синій (він знаходиться під
// синім контейнером). Відповідь запишіть в коментарі до коду нижче.

/// Відповідь: ...

class TrainingExample20 extends StatelessWidget {
  const TrainingExample20({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(color: Colors.red, height: 100, width: double.infinity),
        SizedBox(
          height: 100,
          child: OverflowBox(
            maxHeight: double.infinity,
            maxWidth: double.infinity,
            child: Container(color: Colors.green, width: 200, height: 200),
          ),
        ),
        Container(color: Colors.blue, height: 100, width: double.infinity),
      ],
    );
  }
}

// Task 21: LimitedBox
// На цьому прикладі розгляньте, чому в другому Column контейнер з зеленим
// кольором не обмежується батьком LimitedBox.

// Відповідь: ...
class TrainingExample21 extends StatelessWidget {
  const TrainingExample21({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            LimitedBox(
              maxHeight: 50,
              child: Container(color: Colors.red, height: 100, width: 100),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100,
              child: LimitedBox(
                maxHeight: 50,
                child: Container(color: Colors.green, height: 100, width: 100),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Task 22:
// Чому LimitedBox не впливає на розмір зеленого контейнера?

// Відповідь: ...
class TrainingExample22 extends StatelessWidget {
  const TrainingExample22({super.key});
  @override
  Widget build(BuildContext context) {
    return const LimitedBox(
      maxHeight: 80,
      child: ColoredBox(
        color: Colors.green,
        child: Text(
          'lorem ipsum dolor sit amet consectetur adipiscing elit sed do '
          'eiusmod tempor incididunt ut labore et dolore magna aliqua, '
          'Lorem ipsum dolor sit amet consectetur adipiscing elit sed do '
          'eiusmod tempor incididunt ut labore et dolore magna aliqua, '
          'Lorem ipsum dolor sit amet consectetur adipiscing elit sed do '
          'eiusmod tempor incididunt ut labore et dolore magna aliqua, ',
        ),
      ),
    );
  }
}
