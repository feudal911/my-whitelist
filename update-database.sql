-- Atualizar a tabela wishlist_items para incluir categoria
-- Execute este SQL no Supabase SQL Editor

-- Adicionar coluna de categoria
ALTER TABLE wishlist_items 
ADD COLUMN IF NOT EXISTS category TEXT DEFAULT 'outros';

-- Atualizar itens existentes para ter categoria padrão
UPDATE wishlist_items 
SET category = 'outros' 
WHERE category IS NULL;

-- Criar índice para melhor performance nas buscas
CREATE INDEX IF NOT EXISTS idx_wishlist_items_category ON wishlist_items(category);

-- Verificar se a coluna foi adicionada
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns 
WHERE table_name = 'wishlist_items' 
AND table_schema = 'public'
ORDER BY ordinal_position;

