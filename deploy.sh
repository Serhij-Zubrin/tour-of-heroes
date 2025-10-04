#!/bin/bash
echo "🚀 Starting deployment to GitHub Pages..."
set -e

# Запам'ятати поточну гілку, щоб повернутися після деплою
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Збудувати проект з поточної гілки (main/messages-component тощо)
echo "📦 Building project..."
ng build --configuration production --base-href=/tour-of-heroes/

# Перевірити, що build існує
if [ ! -d "dist/tour-of-heroes" ]; then
  echo "❌ Build output not found at dist/tour-of-heroes. Abort."
  exit 1
fi

# Деплой через angular-cli-ghpages
echo "🌐 Deploying to GitHub Pages..."
npx angular-cli-ghpages --dir=dist/tour-of-heroes --no-silent --message="Force redeploy $(date)"

# Повернутися на попередню гілку
git checkout "$CURRENT_BRANCH"

# Відновити node_modules точно як у package-lock.json
echo "📦 Restoring dependencies..."
npm ci

echo "✅ Deployment completed!"
echo "🌍 Your site is available on GitHub Pages:"
echo "🌍 https://serhij-zubrin.github.io/tour-of-heroes/"