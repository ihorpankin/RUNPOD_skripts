#!/bin/bash

# Исправляем DNS
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

# Переходим в /workspace
cd /workspace

# Клонируем репозиторий Automatic1111
echo "Cloning Stable Diffusion WebUI..."
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui

# Переходим в папку extensions и клонируем расширения
echo "Installing extensions..."
cd extensions

# LobeHub Theme
git clone https://github.com/lobehub/sd-webui-lobe-theme.git

# One Button Prompt
git clone https://github.com/AIrjen/OneButtonPrompt.git

# Infinite Image Browsing
git clone https://github.com/zanllp/sd-webui-infinite-image-browsing.git

# Inpaint Anything
git clone https://github.com/Uminosachi/sd-webui-inpaint-anything.git

# Infinite Zoom
git clone https://github.com/v8hid/infinite-zoom-automatic1111-webui.git

# Deforum
git clone https://github.com/deforum-art/sd-webui-deforum.git

# Prompt Generator
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui-promptgen.git

# Reactor (Face Swap)
git clone https://github.com/Gourieff/sd-webui-reactor-sfw.git

# AnimateDiff
git clone https://github.com/continue-revolution/sd-webui-animatediff.git

# Tiled Multi Diffusion (Multidiffusion Upscaler)
git clone https://github.com/pkuliyi2015/multidiffusion-upscaler-for-automatic1111.git

# Adetailer
git clone https://github.com/Bing-su/adetailer.git

# Возвращаемся в корень webui
cd /workspace/stable-diffusion-webui

# Создаем venv
python -m venv venv
source venv/bin/activate

# Устанавливаем зависимости
pip install --upgrade pip
pip install -r requirements.txt

# Создаем скрипт запуска run_webui.sh
cat <<EOF > /workspace/run_webui.sh
#!/bin/bash
cd /workspace/stable-diffusion-webui
source venv/bin/activate
python launch.py --listen --xformers --enable-insecure-extension-access --skip-torch-cuda-test --precision full --no-half-vae
EOF
chmod +x /workspace/run_webui.sh

# Удаляем лишние файлы установки
rm -f /workspace/install_script.sh

# Запуск сервисов
echo "Starting WebUI and Runpod services..."
(/start.sh & /workspace/run_webui.sh)
