#!/bin/bash

echo "🚀 Starting deployment to GitHub Pages..."
set -e

# Запам'ятати поточну гілку, щоб повернутися після деплою
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Build проект
echo "📦 Building project..."
ng build --configuration production --base-href=/tour-of-heroes/

# Перевірка наявності build output
if [ ! -d "dist/tour-of-heroes" ]; then
  echo "❌ Build output not found at dist/tour-of-heroes. Abort."
  exit 1
fi

# Переключитися на gh-pages
echo "🔀 Switching to gh-pages branch..."
git checkout gh-pages

# Safety guard: переконатися, що ми на gh-pages
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" != "gh-pages" ]; then
  echo "❌ Refusing to deploy: current branch is '$BRANCH' (expected 'gh-pages')"
  exit 1
fi

# Очистити старі файли, крім .git, CNAME та .nojekyll
echo "🧹 Cleaning old files..."
find . -maxdepth 1 -mindepth 1 ! -name ".git" ! -name "CNAME" ! -name ".nojekyll" -exec rm -rf {} +

# Копіювати новий build
echo "📁 Copying new build..."
cp -r dist/tour-of-heroes/* .

# Додати файли до git
echo "📝 Adding files to git..."
git add .

# Коміт (якщо є зміни)
echo "💾 Committing changes..."
git commit -m "Auto-deploy: $(date)" || echo "Nothing to commit"

# Пуш на GitHub
echo "🌐 Pushing to GitHub..."
git push origin gh-pages

# Повернутися на попередню гілку
echo "🔄 Returning to previous branch: $CURRENT_BRANCH"
git checkout "$CURRENT_BRANCH"

# Відновити node_modules точно як у package-lock.json
echo "📦 Restoring dependencies..."
npm ci

echo "✅ Deployment completed!"
echo "🌍 Your site: https://serhij-zubrin.github.io/tour-of-heroes/"
