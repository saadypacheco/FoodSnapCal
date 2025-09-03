
-- diseño de la base de datos -- DER .
-- entregar el archivo .script y diagrama DER

--crer la base de datos y las tablas en supabase

-- 1. Tabla de perfil de usuario extendido
create table public.usuarios_perfil (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  nombre text,
  edad int,
  genero text,
  altura_cm int,
  peso_kg int,
  objetivo text,
  creado_en timestamp default now()
);

-- 2. Tabla de platos
create table public.platos (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  imagen_url text not null,
  descripcion text,
  calorias int,
  calorias_estimadas_usuario int,
  tomado_en timestamp default now()
);

-- 3. Tabla de consumos diarios
create table public.consumos_diarios (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  fecha date not null,
  calorias_totales int default 0,
  meta_calorias int,
  creado_en timestamp default now()
);

-- 4. Tabla para alimentos cargados manualmente
create table public.alimentos_manual (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  nombre text not null,
  cantidad text,
  calorias int,
  fecha date default current_date
);

-- 5. Tabla de eventos o síntomas de salud
create table public.eventos_salud (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  tipo text,
  descripcion text,
  fecha_hora timestamp default now()
);

-- Relaciones entre tablas
ALTER TABLE meals ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
ALTER TABLE meals ADD CONSTRAINT fk_photo FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE SET NULL;
ALTER TABLE meals ADD CONSTRAINT fk_calories FOREIGN KEY (calorie_estimation_id) REFERENCES calorie_estimations(id) ON DELETE SET NULL;
ALTER TABLE health_metrics ADD CONSTRAINT fk_user_metric FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
ALTER TABLE meal_tags ADD CONSTRAINT fk_meal FOREIGN KEY (meal_id) REFERENCES meals(id) ON DELETE CASCADE;
