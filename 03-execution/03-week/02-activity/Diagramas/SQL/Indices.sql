CREATE INDEX idx_users_person ON users(id_person);

CREATE INDEX idx_user_role_user ON user_role(id_user);
CREATE INDEX idx_user_role_role ON user_role(id_role);

CREATE INDEX idx_role_module_role ON role_module(id_role);
CREATE INDEX idx_role_module_module ON role_module(id_module);

CREATE INDEX idx_module_view_module ON module_view(id_module);
CREATE INDEX idx_module_view_view ON module_view(id_view);

CREATE INDEX idx_view_action_view ON view_action(id_view);
CREATE INDEX idx_view_action_action ON view_action(id_action);

CREATE INDEX idx_cart_user ON cart(id_user);

CREATE INDEX idx_cart_detail_cart ON cart_detail(id_cart);
CREATE INDEX idx_cart_detail_product ON cart_detail(id_product);

CREATE INDEX idx_orders_user ON orders(id_user);
CREATE INDEX idx_orders_cart ON orders(id_cart);

CREATE INDEX idx_order_detail_order ON order_detail(id_order);
CREATE INDEX idx_order_detail_product ON order_detail(id_product);

CREATE INDEX idx_inventory_product ON inventory(id_product);

CREATE INDEX idx_product_category_product ON product_category(id_product);
CREATE INDEX idx_product_category_category ON product_category(id_category);