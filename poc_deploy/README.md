# poc_deploy - dbt Project on Snowflake

Proyecto dbt desplegado en Snowflake mediante CD con GitHub Actions y Snowflake CLI.

## Project Structure

```
poc_deploy_snowflake/
├── .github/
│   └── workflows/
│       └── snowflake.yml      # GitHub Action para CD automático
├── poc_deploy/
│   ├── models/
│   │   ├── staging/           # Staging models (materialized as views)
│   │   │   ├── _sources.yml   # Source definitions
│   │   │   ├── _schema.yml    # Model docs & tests
│   │   │   └── stg_example.sql
│   │   └── marts/             # Marts models (materialized as tables)
│   │       ├── _schema.yml    # Model docs & tests
│   │       └── mart_example.sql
│   ├── macros/
│   │   └── generate_schema_name.sql
│   ├── seeds/
│   │   └── example_seed.csv
│   ├── snapshots/
│   ├── analyses/
│   ├── tests/
│   ├── dbt_project.yml        # Main project config
│   ├── packages.yml           # Package dependencies (dbt_utils)
│   ├── profiles.yml           # Snowflake connection (local only, gitignored)
│   └── .gitignore
├── .gitignore
└── README.md
```

## CI/CD Pipeline

El despliegue se realiza automáticamente mediante **GitHub Actions** usando **Snowflake CLI**.

### Flujo

```
Push/Merge a main → GitHub Action → Snowflake CLI → snow dbt deploy → Objeto dbt en Snowflake
```

### Configuración requerida en GitHub

#### Secrets (Settings → Secrets → Actions, dentro del environment `prod`)

| Secret | Descripción |
|---|---|
| `SNOWFLAKE_ACCOUNT` | Account identifier (ej: `xy12345.eu-west-1`) |
| `SNOWFLAKE_USER` | Usuario de la cuenta de servicio |
| `SNOWFLAKE_PASSWORD` | Password de la cuenta de servicio |

#### Variables (Settings → Variables → Actions, dentro del environment `prod`)

| Variable | Descripción |
|---|---|
| `SNOWFLAKE_DATABASE` | Database destino |
| `SNOWFLAKE_SCHEMA` | Schema destino |

#### Environment

Debe existir un environment llamado `prod` en Settings → Environments.

### Cómo desplegar

Cualquier push a `main` dispara el workflow automáticamente:

```bash
git add .
git commit -m "feat: add new model"
git push origin main
```

Monitorea el progreso en la pestaña **Actions** de tu repositorio.

## Desarrollo local

### 1. Activar entorno virtual

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\venv\Scripts\activate
```

### 2. Configurar conexión a Snowflake

Edita `poc_deploy/profiles.yml` con tus credenciales (este archivo está en `.gitignore`).

### 3. Instalar paquetes dbt

```bash
cd poc_deploy
dbt deps --profiles-dir .
```

### 4. Verificar conexión

```bash
dbt debug --profiles-dir .
```

### 5. Ejecutar modelos

```bash
dbt run --profiles-dir .
```

### 6. Ejecutar tests

```bash
dbt test --profiles-dir .
```

## Comandos útiles

| Comando | Descripción |
|---|---|
| `dbt run` | Ejecutar todos los modelos |
| `dbt test` | Ejecutar todos los tests |
| `dbt seed` | Cargar datos seed (CSV) |
| `dbt docs generate` | Generar documentación |
| `dbt docs serve` | Servir documentación localmente |
| `dbt run --select staging` | Ejecutar solo modelos staging |
| `dbt run --select marts` | Ejecutar solo modelos marts |

> **Nota:** Añade `--profiles-dir .` a todos los comandos si tu `profiles.yml` está en el directorio del proyecto en vez de `~/.dbt/`.
