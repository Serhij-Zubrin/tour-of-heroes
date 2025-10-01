echo "🚀 Starting deployment to GitHub Pages..."

# Запам'ятати поточну гілку, щоб повернутися після деплою
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Збудувати проект з поточної гілки (main/messages-component тощо)
echo "📦 Building project..."
ng build --prod --base-href=./

# Переключитися на гілку gh-pages для публікації статичних файлів
echo "🔀 Switching to gh-pages branch..."
git checkout gh-pages

# Скопіювати файли в корінь gh-pages
echo "📁 Copying files to root..."
cp -r dist/tour-of-heroes/* .

# Додати файли до git
echo "📝 Adding files to git..."
git add .

# Зробити коміт
echo "💾 Committing changes..."
git commit -m "Auto-deploy: $(date)" || echo "Nothing to commit"

# Залити на GitHub
echo "🌐 Pushing to GitHub..."
git push origin gh-pages

# Повернутися на попередню гілку
git checkout "$CURRENT_BRANCH"

echo "✅ Deployment completed!"
echo "🌍 Your site is available on the gh-pages branch."
echo "🌍 Your site: https://serhij-zubrin.github.io/tour-of-heroes/"
