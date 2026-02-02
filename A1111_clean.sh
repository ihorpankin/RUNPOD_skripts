#!/bin/bash

# Переходим в /workspace
cd /workspace

# Клонируем репозиторий Automatic1111
echo "Cloning Stable Diffusion WebUI..."
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui

# Создаем venv (так как в базовом pytorch образе его может не быть)
python -m venv venv
source venv/bin/activate

# Устанавливаем зависимости
pip install --upgrade pip
pip install -r requirements.txt

# Создаем скрипт запуска run_webui.sh для удобства
cat <<EOF > /workspace/run_webui.sh
#!/bin/bash
cd /workspace/stable-diffusion-webui
source venv/bin/activate
# Флаги: --listen для доступа извне, --xformers для ускорения, --enable-insecure-extension-access для работы с расширениями
python launch.py --listen --xformers --enable-insecure-extension-access --skip-torch-cuda-test --precision full --no-half-vae
EOF

chmod +x /workspace/run_webui.sh

# Удаляем лишние файлы установки
rm /workspace/install_script.sh

# Запуск сервисов
echo "Starting WebUI and Runpod services..."
(/start.sh & /workspace/run_webui.sh)
GitHub
GitHub - AUTOMATIC1111/stable-diffusion-webui: Stable Diffusion web UI

Stable Diffusion web UI. Contribute to AUTOMATIC1111/stable-diffusion-webui development by creating an account on GitHub.
