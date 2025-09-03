
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


-- Variables temporales
-- ⚠️ Reemplazar por un UUID válido desde auth.users.id
-- Podés obtenerlo con: select * from auth.users;
-- En este ejemplo, uso un UUID fijo para pruebas
-- DECLARE user_id uuid := 'uuid-usuario-demo'; (si estuvieras en una función)

-- Insertar perfil de usuario
insert into public.usuarios_perfil (user_id, nombre, edad, genero, altura_cm, peso_kg, objetivo)
values
('06e4eec9-1a35-436c-afbc-b58f9ce633bd', 'Lucía Fernández', 30, 'femenino', 165, 65, 'Controlar calorías por dieta médica');

-- Insertar platos
insert into public.platos (user_id, imagen_url, descripcion, calorias, calorias_estimada_usuario)
values
('06e4eec9-1a35-436c-afbc-b58f9ce633bd', 'https://supabase.storage.io/bucket/platos/ensalada.jpg', 'Ensalada mixta con pollo', 420, 400),
('06e4eec9-1a35-436c-afbc-b58f9ce633bd', 'https://supabase.storage.io/bucket/platos/pasta.jpg', 'Pasta con salsa roja', 650, null);

-- Insertar consumos diarios
insert into public.consumos_diarios (user_id, fecha, calorias_totales, meta_calorias)
values
('06e4eec9-1a35-436c-afbc-b58f9ce633bd', current_date, 1070, 1800);

-- Insertar alimentos manuales
insert into public.alimentos_manual (user_id, nombre, cantidad, calorias)
values
('06e4eec9-1a35-436c-afbc-b58f9ce633bd', '1 taza de avena', '1 taza', 150),
('06e4eec9-1a35-436c-afbc-b58f9ce633bd', 'Manzana', '1 unidad', 95);

-- Insertar eventos de salud
insert into public.eventos_salud (user_id, tipo, descripcion)
values
('06e4eec9-1a35-436c-afbc-b58f9ce633bd', 'Dolor abdominal', 'Leve malestar luego de la cena'),
('06e4eec9-1a35-436c-afbc-b58f9ce633bd', 'Mareo', 'Mareo al mediodía después de comer muy poco');

--select * from public.eventos_salud where tipo = 'Dolor abdominal';
