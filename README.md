
### Usage

```shell
make up
make psql
docker-compose exec postgis psql -U postgis
psql (13.3 (Debian 13.3-1.pgdg100+1))
Type "help" for help.

postgis=#
```

### Example SQL
```sql
-- ST_Collect　富山県を集める 外枠有り 、内枠有り 、塗りつぶし有り　return MULTIPOLYGON
select ST_Collect(geom) from japan where pref = '富山県'

-- ST_ExteriorRingしてST_Collect　富山県を集める 外枠有り 、内枠有り 、塗りつぶし無し return MULTILINESTRING
select ST_Collect(ST_ExteriorRing(geom)) from japan where pref = '富山県'

-- ST_ExteriorRingしてST_CollectsしたものをリングをST_LineMergeしても変化なし　集めてST_LineMergeしても同じ
select ST_LineMerge(ST_Collect(ST_ExteriorRing(geom))) from japan where pref = '富山県'

-- ST_Union 離れた島があって一つにまとまらないのでマルチポリゴンを返す
select ST_Union(geom) from japan where pref = '富山県'
-- ST_Union 離れた島を除外するので一つにまとまりシングルポリゴンを返す 
select ST_Union(geom) from japan where pref = '富山県' and ST_Area(geom) > 0.0000014

-- 富山県の面積一覧
select ST_Area(geom) as area, geom from japan where pref = '富山県' order by area desc

-- 面積の小さい島などを除外して富山県を集める
select ST_Collect(geom) from japan where pref = '富山県' and ST_Area(geom) > 0.0000014

-- 面積の小さい島などを除外して富山県を集めて内側の線を消す
select ST_Union(geom) from japan where pref = '富山県' and ST_Area(geom) > 0.0000014

-- 面積の小さい島などを除外して富山県を集めて内側の線を消して中を塗りつぶさない
select ST_ExteriorRing(ST_Union(geom)) from japan where pref = '富山県' and ST_Area(geom) > 0.0000014
```

- ST_Unionはシングルポリゴンを返す
- ST_Unionは内側の線消す
- ST_Collectはマルチ系(マルチポリゴン、マルチラインストリング)を返す
- ST_Collectは内側の線を消さない
- ST_CollectはST_Unionよりコストが低い
- ST_ExteriorRingはシングルポリゴンに対して効く、マルチポリゴンには効かない
- 内側の線を消すときはST_UnionしたポリゴンをST_ExteriorRingする