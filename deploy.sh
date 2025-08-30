echo "🚀 Starting deployment to GitHub Pages..."

# Переключитися на гілку gh-pages
git checkout gh-pages

# Збудувати проект
echo "📦 Building project..."
ng build --prod --base-href=./

# Скопіювати файли в корінь
echo "📁 Copying files to root..."
cp -r dist/tour-of-heroes/* .

# Додати файли до git
echo "📝 Adding files to git..."
git add .

# Зробити коміт
echo "💾 Committing changes..."
git commit -m "Auto-deploy: $(date)"

# Залити на GitHub
echo "🌐 Pushing to GitHub..."
git push origin gh-pages

# Повернутися на основну гілку
git checkout main

echo "✅ Deployment completed!"
echo "🌍 Your site: https://serhij-zubrin.github.io/tour-of-heroes/"
