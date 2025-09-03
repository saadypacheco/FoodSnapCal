# 📦 Esquema de Base de Datos - FoodSnapCal (Supabase)

Este esquema define la estructura de las tablas necesarias para almacenar la información del usuario, sus comidas, métricas de salud y eventos relacionados al control de calorías, alimentación y bienestar.

---

## 1. Tabla `usuarios_perfil`

Extiende el modelo básico de usuario de Supabase (`auth.users`) con información adicional para personalización del sistema y cálculo de calorías recomendadas.

| Campo         | Tipo          | Descripción                                       |
|---------------|---------------|-------------------------------------------------- |
| `id`          | `uuid`        | Identificador único del perfil (PK)               |
| `user_id`     | `uuid`        | FK a `auth.users(id)`                             |
| `nombre`      | `text`        | Nombre del usuario                                |
| `edad`        | `int`         | Edad del usuario                                  |
| `genero`      | `text`        | Género (M/F/Otro)                                 |
| `altura_cm`   | `int`         | Altura en centímetros                             |
| `peso_kg`     | `int`         | Peso en kilogramos                                |
| `objetivo`    | `text`        | Objetivo general (bajar, mantener, subir calorias)|
| `creado_en`   | `timestamp`   | Fecha de creación del registro                    |

**Claves foráneas:**
- `user_id → auth.users(id)` (con eliminación en cascada)

---

## 2. Tabla `platos`

Almacena los platos capturados por el usuario mediante la cámara. Se espera que las imágenes sean almacenadas en Supabase Storage y referenciadas por URL.

| Campo        | Tipo       | Descripción                          |
|--------------|------------|--------------------------------------|
| `id`         | `uuid`     | Identificador del plato (PK)         |
| `user_id`    | `uuid`     | FK a `auth.users(id)`                |
| `imagen_url` | `text`     | URL de la imagen subida              |
| `descripcion`| `text`     | Descripción del plato (opcional)     |
| `calorias`   | `int`      | Estimación de calorías               |
| `calorias_   | `int`      | calorias que indica el usuario       |
|   estimadas_ |                                                   |
|   usuario`   |                                                   |
| `tomado_en`  | `timestamp`| Fecha/hora en que se tomó la imagen  |

**Claves foráneas:**
- `user_id → auth.users(id)`

---

## 3. Tabla `consumos_diarios`

Registro de la cantidad de calorías consumidas cada día y comparación contra el objetivo diario del usuario.

| Campo             | Tipo       | Descripción                                |
|-------------------|------------|--------------------------------------------|
| `id`              | `uuid`     | Identificador del consumo diario (PK)      |
| `user_id`         | `uuid`     | FK a `auth.users(id)`                      |
| `fecha`           | `date`     | Fecha correspondiente al registro          |
| `calorias_totales`| `int`      | Total de calorías consumidas ese día       |
| `meta_calorias`   | `int`      | Meta calórica asignada para el día         |
| `creado_en`       | `timestamp`| Fecha/hora en que se creó el registro      |

**Claves foráneas:**
- `user_id → auth.users(id)`

---

## 4. Tabla `alimentos_manual`

Permite que el usuario cargue alimentos manualmente si no usa la cámara.

| Campo      | Tipo       | Descripción                            |
|------------|------------|----------------------------------------|
| `id`       | `uuid`     | Identificador del alimento (PK)        |
| `user_id`  | `uuid`     | FK a `auth.users(id)`                  |
| `nombre`   | `text`     | Nombre del alimento                    |
| `cantidad` | `text`     | Porción o cantidad                     |
| `calorias` | `int`      | Calorías estimadas                     |
| `fecha`    | `date`     | Fecha del consumo                      |

**Claves foráneas:**
- `user_id → auth.users(id)`

---

## 5. Tabla `eventos_salud`

Eventos o síntomas relevantes que el usuario puede registrar (por ejemplo: dolor de cabeza, baja presión, malestar, etc.)

| Campo       | Tipo       | Descripción                          |
|-------------|------------|--------------------------------------|
| `id`        | `uuid`     | Identificador del evento (PK)        |
| `user_id`   | `uuid`     | FK a `auth.users(id)`                |
| `tipo`      | `text`     | Tipo de evento o síntoma             |
| `descripcion`| `text`    | Descripción detallada (opcional)     |
| `fecha_hora`| `timestamp`| Fecha y hora del evento              |

**Claves foráneas:**
- `user_id → auth.users(id)`

---

## Seguridad

Todas las tablas dependen del `user_id` de `auth.users` (integración nativa de Supabase). La eliminación en cascada asegura que, si un usuario es eliminado, se borren automáticamente sus registros en todas las tablas.

