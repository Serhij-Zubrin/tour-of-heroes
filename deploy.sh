echo "🚀 Starting deployment to GitHub Pages..."
set -e

# Запам'ятати поточну гілку, щоб повернутися після деплою
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Збудувати проект з поточної гілки (main/messages-component тощо)
echo "📦 Building project..."
ng build --configuration production --base-href=/tour-of-heroes/

# Ensure build output exists
if [ ! -d "dist/tour-of-heroes" ]; then
  echo "❌ Build output not found at dist/tour-of-heroes. Abort."
  exit 1
fi

# Переключитися на гілку gh-pages для публікації статичних файлів
echo "🔀 Switching to gh-pages branch..."
git checkout gh-pages

# Safety guard: allow destructive actions only on gh-pages
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" != "gh-pages" ]; then
  echo "❌ Refusing to deploy: current branch is '$BRANCH' (expected 'gh-pages')"
  echo "Tip: ensure checkout to gh-pages succeeded before cleaning/copying."
  exit 1
fi

# Скопіювати файли в корінь gh-pages
echo "📁 Copying files to root..."
# Optional: clean old files safely (keeps .git, CNAME, .nojekyll)
# find . -maxdepth 1 -mindepth 1 ! -name ".git" ! -name "CNAME" ! -name ".nojekyll" -exec rm -rf {} +
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
