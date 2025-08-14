-- Configuração das Funcionalidades Avançadas do Whitelist
-- Execute este SQL no Supabase SQL Editor

-- 1. Atualizar tabela wishlist_items para incluir usuário
ALTER TABLE wishlist_items 
ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id);

-- 2. Criar tabela de notificações
CREATE TABLE IF NOT EXISTS notifications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Criar tabela de histórico
CREATE TABLE IF NOT EXISTS item_history (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    action TEXT NOT NULL CHECK (action IN ('created', 'updated', 'deleted', 'completed', 'shared')),
    item_title TEXT NOT NULL,
    details TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Criar índices para performance
CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_notifications_read ON notifications(read);
CREATE INDEX IF NOT EXISTS idx_item_history_user_id ON item_history(user_id);
CREATE INDEX IF NOT EXISTS idx_item_history_action ON item_history(action);
CREATE INDEX IF NOT EXISTS idx_wishlist_items_user_id ON wishlist_items(user_id);

-- 5. Configurar RLS (Row Level Security) para as novas tabelas
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE item_history ENABLE ROW LEVEL SECURITY;

-- 6. Políticas RLS para notifications
CREATE POLICY "Users can view their own notifications" ON notifications
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own notifications" ON notifications
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own notifications" ON notifications
    FOR UPDATE USING (auth.uid() = user_id);

-- 7. Políticas RLS para item_history
CREATE POLICY "Users can view their own history" ON item_history
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own history" ON item_history
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- 8. Atualizar políticas RLS da tabela wishlist_items
DROP POLICY IF EXISTS "Enable read access for all users" ON wishlist_items;
DROP POLICY IF EXISTS "Enable insert access for all users" ON wishlist_items;
DROP POLICY IF EXISTS "Enable update access for all users" ON wishlist_items;
DROP POLICY IF EXISTS "Enable delete access for all users" ON wishlist_items;

-- Criar novas políticas baseadas em usuário
CREATE POLICY "Users can view their own items" ON wishlist_items
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own items" ON wishlist_items
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own items" ON wishlist_items
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own items" ON wishlist_items
    FOR DELETE USING (auth.uid() = user_id);

-- 9. Função para atualizar timestamp automático
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 10. Trigger para atualizar updated_at automaticamente
DROP TRIGGER IF EXISTS update_notifications_updated_at ON notifications;
CREATE TRIGGER update_notifications_updated_at
    BEFORE UPDATE ON notifications
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- 11. Verificar se as tabelas foram criadas
SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns 
WHERE table_name IN ('notifications', 'item_history', 'wishlist_items')
ORDER BY table_name, ordinal_position;

-- 12. Verificar políticas RLS
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual,
    with_check
FROM pg_policies 
WHERE tablename IN ('notifications', 'item_history', 'wishlist_items');

