# Documento de Requerimiento y Alcance del Proyecto: FoodSnapCal

## 1. Introducción

**FoodSnapCal** es una aplicación móvil diseñada para ayudar a los usuarios a registrar su consumo alimenticio mediante la captura de imágenes de sus platos. Utiliza **Supabase** como backend para autenticación, almacenamiento y generación automática de endpoints. Además, se integra con un servicio de **inteligencia artificial** para estimar las calorías presentes en cada plato.

---

## 2. Objetivo del Proyecto

Desarrollar una **aplicación multiplataforma con Ionic** que permita a los usuarios:

- Autenticarse.
- Tomar fotos de sus platos de comida.
- Almacenarlas en Supabase.
- Estimar las calorías mediante IA o APIs externas.

---

## 3. Funcionalidades

### 3.1 Funcionalidades Principales

- Registro e inicio de sesión utilizando **Supabase Auth**.
- Captura de imágenes con la cámara del dispositivo (usando `@capacitor/camera`).
- Subida de imágenes a **Supabase Storage** en un bucket llamado `platos`.
- Estimación de calorías por imagen utilizando una API externa o modelo de IA.

### 3.2 Funcionalidades Futuras

- Visualización del historial alimenticio por usuario.
- Estadísticas de consumo y evolución de hábitos.

---

## 4. Arquitectura del Sistema

El sistema está compuesto por los siguientes componentes:

- **Frontend**: Aplicación Ionic (Angular + Capacitor).
- **Backend**: Supabase (PostgreSQL, Storage, Auth, API REST autogenerada).
- **Servicio externo**: API de estimación calórica (opcional: integración con IA propia).

---

## 5. Supabase

**Supabase** será responsable de:

- Manejo de autenticación con email/contraseña y/o proveedores externos.
- Almacenamiento de imágenes en un bucket de Storage por usuario.
- Generación automática de endpoints RESTful para acceso a datos.
- Gestión de la base de datos relacional (PostgreSQL).

---

## 6. Flujo de la Aplicación

1. El usuario se registra o inicia sesión con Supabase Auth.
2. Toma una foto con la cámara del dispositivo.
3. La imagen se guarda en Supabase Storage.
4. Se envía la imagen a una API para estimar las calorías.
5. Se almacena el resultado en la base de datos de Supabase.
6. El usuario puede ver su historial con imágenes y calorías estimadas.

---

## 7. Stack Tecnológico

- **Ionic + Angular + Capacitor**
- **Supabase** (Auth, Storage, DB, REST API)
- **Node.js** (para lógica futura opcional)
- **API IA de estimación calórica** (ej: CalorieMama, Azure Vision, etc.)
