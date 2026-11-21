# tdl — Gestor de actividades en Bash

![Bash](https://img.shields.io/badge/Bash-script-4EAA25?logo=gnubash&logoColor=white)
![Plataforma](https://img.shields.io/badge/plataforma-Ubuntu-E95420?logo=ubuntu&logoColor=white)
![Licencia](https://img.shields.io/badge/licencia-MIT-blue)

**tdl** es una herramienta de consola para organizar actividades y subtareas desde la terminal de Linux. 

Cada directorio puede tener su propia lista: `tdl init` crea una carpeta oculta `.tdl` **en el directorio actual**. No hace falta configurar una lista global.

## Características

- Crear, listar, renombrar y eliminar actividades numeradas (`01`, `02`, ...).
- Guardar una descripción en cada actividad.
- Agregar, editar, completar y eliminar subtareas.
- Renumerar las actividades restantes después de eliminarlas.
- Registrar operaciones en `.tdl/tdl.log`.
- Mostrar ayuda cuando se utiliza un comando incorrecto.

## Cómo funciona

Las actividades se guardan como carpetas. Elegí esta estructura porque permite usar `mkdir`, `mv` y `rm`, que practicamos en clase. Cada actividad contiene `descripcion.txt` e `items.txt`.

```text
MiProyecto/
└── .tdl/
    ├── tdl.log
    ├── 01_Estudiar_Bash/
    │   ├── descripcion.txt
    │   └── items.txt
    └── 02_Hacer_Practica/
        ├── descripcion.txt
        └── items.txt
```

Las subtareas se guardan en `items.txt`, una por línea. El formato `0|texto` indica pendiente y `1|texto` indica terminada.

### Funciones y comandos de Bash utilizados

| Función del script | ¿Qué hace y por qué usé esos comandos? |
| --- | --- |
| `comando_init` | Crea `.tdl` con `mkdir` y su registro `tdl.log` con `touch`. |
| `comando_add` | Usa un ciclo `for` para contar carpetas y `printf '%02d'` para dar números de dos dígitos. |
| `comando_ls` | Recorre las actividades, separa sus nombres con `cut` y los muestra de forma legible con `tr`. |
| `comando_rename` | Utiliza `mv` porque cambiar el nombre de la carpeta conserva la descripción y las subtareas. |
| `comando_rm` | Utiliza `rm -rf` para borrar actividades y después `mv` para evitar huecos en la numeración. |
| `comando_desc` | Usa `cat` para consultar, `>` para reemplazar y una redirección vacía para borrar descripciones. |
| `comando_item` | Usa `while read` para listar líneas y `sed` para editar, completar o borrar una subtarea sin abrir un editor. `head` y `tail` permiten obtener una línea concreta al editar. |
| `registro` y `cargar` | `>>` agrega eventos sin borrar el historial; `test` (`[ ]`) comprueba que exista la lista y su archivo de registro. |
| `ayuda`, `error` y `buscar` | Muestran instrucciones, detienen operaciones incorrectas y encuentran actividades por número. `case` permite decidir qué subcomando ejecutar, parecido a Git. |


## Instalación en Ubuntu

**Requisitos:** Ubuntu con Bash y las utilidades habituales del sistema. **Git solo es necesario para clonar el repositorio**, no para ejecutar `tdl` una vez instalado.

1. Clona el repositorio:

   ```bash
   git clone https://github.com/MoisesTorres24/To-Do-List.git
   cd To-Do-List
   ```

2. Da permisos al instalador y ejecútalo:

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. Abre otra terminal o recarga la configuración y comprueba la instalación:

   ```bash
   source ~/.bashrc
   tdl help
   ```

El instalador copia `tdl` a `~/.local/bin/tdl`, le da permisos de ejecución y agrega esa carpeta al `PATH` en `~/.bashrc` si todavía no aparece la línea de configuración. **No se necesita `sudo`.** Si ya descargaste los archivos, puedes ejecutar `./install.sh` sin utilizar Git.

## Ejemplo de uso

```bash
cd ~/Escritorio
tdl init
tdl add "Estudiar Bash"
tdl add "Preparar proyecto"
tdl desc 1 set "Repasar funciones y ciclos"
tdl item 1 add "Practicar while"
tdl item 1 done 1
tdl item 1 ls
tdl ls -d
tdl log
```

Para tener otra lista independiente, entra a otra carpeta y ejecuta `tdl init` allí. Los comandos siempre trabajan con la carpeta `.tdl` del **directorio actual**, no con la última lista utilizada.

### Referencia rápida

```text
tdl init
tdl add "nombre"
tdl ls [-d]
tdl rename N "nombre"
tdl rm N [N ...]
tdl desc N show|set "texto"|clear
tdl item N ls|add "texto"|edit M "texto"|done M|rm M
tdl log
tdl help
```

## Alcance y limitaciones

Este es un proyecto de aprendizaje, pensado principalmente para **Ubuntu/Debian**. No tiene interfaz gráfica ni sincronización entre equipos. Cada lista es local al directorio donde se inicializó. La numeración de actividades admite hasta 99 elementos y la bitácora registra operaciones, pero no incluye fechas y horas.

## Uso de IA

Utilicé inteligencia artificial como apoyo para resolver algunas funciones que me resultaron más complicadas, especialmente la edición de subtareas, la renumeración y ciertas validaciones. También la usé para agregar comentarios al código y redactar este README. El objetivo fue completar el proyecto aplicando los comandos y temas que vimos en clase, manteniendo un script que pueda comprender y explicar.

## Licencia

Este proyecto se distribuye bajo la licencia **MIT**. Consulta el archivo [LICENSE](LICENSE).

## Autor

**Moisés Gerónimo Torres González** — [@MoisesTorres24](https://github.com/MoisesTorres24)
