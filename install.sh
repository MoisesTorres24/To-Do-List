
#!/bin/bash

# El instalador debe ejecutarse desde la carpeta del repositorio.
cd "$(dirname "$0")" || exit 1

if [ ! -f "tdl" ]; then
    echo "Error: No se encontro el archivo tdl."
    exit 1
fi

# Instala el comando sin necesitar permisos de administrador.
mkdir -p "$HOME/.local/bin" || exit 1
cp "tdl" "$HOME/.local/bin/tdl" || exit 1
chmod +x "$HOME/.local/bin/tdl" || exit 1

# Comprueba si la linea del PATH ya esta guardada en .bashrc.
# De esta forma no se agrega la misma configuracion dos veces.
configuracion='export PATH="$HOME/.local/bin:$PATH"'
encontrada=0
touch "$HOME/.bashrc" || exit 1

while IFS= read -r linea; do
    if [ "$linea" = "$configuracion" ]; then
        encontrada=1
    fi
done < "$HOME/.bashrc"

if [ "$encontrada" -eq 0 ]; then
    printf '\n%s\n' "$configuracion" >> "$HOME/.bashrc" || exit 1
fi

echo "tdl instalado en $HOME/.local/bin/tdl"
echo "Abre una terminal nueva o ejecuta: source ~/.bashrc"
echo "Luego prueba: tdl help"
