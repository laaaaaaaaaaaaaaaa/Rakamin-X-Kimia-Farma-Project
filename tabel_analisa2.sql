CREATE TABLE `rakamin-kf-analytics-446107.kimia_farma.tabel_analisa2` AS
SELECT 
    t.transaction_id,                           -- Kode ID transaksi
    t.customer_name,                           -- Nama customer
    p.product_id,                              -- Kode produk obat
    p.product_name,                            -- Nama produk obat
    t.branch_id,                               -- Kode ID cabang
    b.branch_name,                             -- Nama cabang
    b.kota,                                    -- Kota cabang
    b.provinsi,                                -- Provinsi cabang
    t.price AS actual_price,                   -- Harga obat
    t.discount_percentage,                     -- Persentase diskon
    b.rating AS rating_cabang,                 -- Rating cabang
    t.rating AS rating_transaksi,              -- Rating transaksi
    -- Hitung nett_sales (harga setelah diskon)
    t.price - (t.price * t.discount_percentage / 100) AS nett_sales,
    -- Tentukan persentase_gross_laba berdasarkan kategori harga
    CASE
        WHEN t.price <= 50000 THEN 10
        WHEN t.price > 50000 AND t.price <= 100000 THEN 15
        WHEN t.price > 100000 AND t.price <= 300000 THEN 20
        WHEN t.price > 300000 AND t.price <= 500000 THEN 25
        ELSE 30
    END AS persentase_gross_laba,
    -- Hitung nett_profit (laba bersih)
    (t.price - (t.price * t.discount_percentage / 100)) * 
    CASE
        WHEN t.price <= 50000 THEN 0.10
        WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
        WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
        WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS nett_profit
FROM 
    `rakamin-kf-analytics-446107.kimia_farma.kf_final_transaction` t
JOIN 
    `rakamin-kf-analytics-446107.kimia_farma.kf_product` p
ON 
    t.product_id = p.product_id
JOIN 
    `rakamin-kf-analytics-446107.kimia_farma.kf_kantor_cabang` b
ON 
    t.branch_id = b.branch_id
ORDER BY 
    t.transaction_id;
