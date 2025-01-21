# aiplus_to_do

A test Flutter project.

## Getting Started

Для управления состоянием я использую BLoC, так как он удобен и прост в освоении. Он предоставляет четкое разделение бизнес-логики и пользовательского интерфейса, что повышает ясность и структуру кода. Хотя для такого проекта BLoC может быть и избыточным, я решил применить его для улучшения читабельности и четкости архитектуры. BLoC также привнес несколько дополнительных зависимостей (meta, bloc, flutter_bloc, equatable).
Что касается работы с базой данных, я использую shared_preferences по необходимости. Однако предпочитаю использовать более структурированные решения, такие как Drift, для работы с базами данных. Shared_preferences же в основном применяется для сохранения настроек пользователя, таких как выбранный город, тема и другие данные.
В проекте также используются две другие зависимости: flutter_slidable — для улучшения интерфейса с возможностью сдвига элементов, и uuid — для удобного генерирования уникальных айдишек.

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
