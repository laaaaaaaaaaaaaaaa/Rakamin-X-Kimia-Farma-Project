CREATE TABLE 'rakamin-kf-analytics-446107.tabel_analisa' AS
SELECT
  t1.transaction_id,
  t1.date,
  t2.branch_id,
  t2.branch_name,
  t2.kota,
  t2.provinsi
FROM
  'rakamin-kf-analytics-446107.kf_final_transaction' AS t1
INNER JOIN
  'rakamin-kf-analytics-446107.kf_kantor_cabang' AS t2
ON
  t1.branch_id = t2.branch_id;
