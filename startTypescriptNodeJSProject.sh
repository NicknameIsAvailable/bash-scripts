#!/bin/bash

if ! command -v tsc &> /dev/null
then
    echo "Не установлен TypeScript. Установите его с помощью npm:"
    echo "npm install -g typescript"
    exit
fi

read -p "Введите путь для создания проекта (например, /путь/к/директории): " project_path

if [ ! -d "$project_path" ]; then
    echo "Указанный путь не существует."
    exit
fi

read -p "Введите название директории проекта: " project_name

cd "$project_path" || exit

echo "Создание директории проекта..."
mkdir "$project_name"
cd "$project_name" || exit

echo "Инициализация проекта npm..."
npm init -y

echo "Установка зависимостей (typescript)..."
npm install typescript --save-dev

echo "Создание файла tsconfig.json..."
echo '{
  "compilerOptions": {
    "target": "es6",
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true
  },
  "include": [
    "src/**/*.ts"
  ],
  "exclude": [
    "node_modules"
  ]
}' > tsconfig.json

echo "Создание директории src и файла index.ts..."
mkdir src
echo 'console.log("Привет, мир!");' > src/index.ts

echo "Генерация скрипта запуска..."
echo 'tsc && node dist/index.js' > start.sh
chmod +x start.sh

echo "Проект создан!"

xdg-open "$project_path/$project_name"
