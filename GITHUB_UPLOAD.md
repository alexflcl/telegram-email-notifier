# 📤 Guía: Subir a GitHub

## Paso 1: Instalar Git

1. Descarga Git desde: https://git-scm.com/download/win
2. Ejecuta el instalador
3. Acepta todas las opciones por defecto
4. Instala

## Paso 2: Ejecutar el script de push

### Opción A: Batch (más simple)
```bash
cd "c:\Proyectos IA\Telegram notifier\telegram-email-notifier-app"
push_to_github.bat
```

### Opción B: PowerShell
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
cd "c:\Proyectos IA\Telegram notifier\telegram-email-notifier-app"
.\push_to_github.ps1
```

## Paso 3: Verificar

Abre: https://github.com/alexflcl/telegram-email-notifier

Deberías ver todos tus archivos subidos ✅

---

## ¿Qué hace el script?

1. ✓ Configura Git con tu usuario
2. ✓ Inicializa repositorio local (.git)
3. ✓ Agrega todos los archivos
4. ✓ Crea commit inicial
5. ✓ Conecta con remote origin
6. ✓ Hace push a main branch

## Después de instalar Git

Una vez que Git esté instalado, simplemente ejecuta:

```bash
push_to_github.bat
```

¡Y listo! El código estará en GitHub. 🚀
