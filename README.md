
### Usage

```shell
// set up
make up

// psql examples
make all

// psql command
make psql
docker-compose exec postgis psql -U postgis
psql (13.3 (Debian 13.3-1.pgdg100+1))
Type "help" for help.

postgis=#
```

## japan table

```postgresql
make japan
docker-compose exec postgis psql -U postgis -c "\d japan"
                                     Table "public.japan"
  Column  |          Type          | Collation | Nullable |              Default               
----------+------------------------+-----------+----------+------------------------------------
 gid      | integer                |           | not null | nextval('japan_gid_seq'::regclass)
 pref     | character varying(10)  |           |          | 
 regional | character varying(20)  |           |          | 
 city1    | character varying(20)  |           |          | 
 city2    | character varying(20)  |           |          | 
 code     | character varying(5)   |           |          | 
 geom     | geometry(Polygon,4612) |           |          | 
Indexes:
    "japan_pkey" PRIMARY KEY, btree (gid)
    "japan_city1_idx" btree (city1)
    "japan_city2_idx" btree (city2)
    "japan_code_idx" btree (code)
    "japan_geom_idx" gist (geom)
    "japan_pref_idx" btree (pref)
    "japan_regional_idx" btree (regional)
```

## prefectures table
- Cut small islands from Japan.
- Collect adjacencies and union them.

```postgresql
$ make prefectures
docker-compose exec postgis psql -U postgis -c "\d prefectures"
                                    Table "public.prefectures"
 Column |          Type          | Collation | Nullable |                 Default                  
--------+------------------------+-----------+----------+------------------------------------------
 gid    | integer                |           | not null | nextval('prefectures_gid_seq'::regclass)
 code   | character varying(2)   |           | not null | 
 name   | character varying(10)  |           | not null | 
 geom   | geometry(Polygon,4612) |           |          | 
Indexes:
    "prefectures_pkey" PRIMARY KEY, btree (gid)
    "prefectures_geom_idx" gist (geom)

```

 ```postgresql
$ make prefectures_count
docker-compose exec postgis psql -U postgis -c "select code, name, count(*) as count from prefectures group by code, name order by code;"
 code |   name   | count 
------+----------+-------
 01   | 北海道   |    14
 02   | 青森県   |     1
 03   | 岩手県   |     1
 04   | 宮城県   |     5
 05   | 秋田県   |     1
 06   | 山形県   |     1
 07   | 福島県   |     1
 08   | 茨城県   |     1
 09   | 栃木県   |     1
 10   | 群馬県   |     1
 11   | 埼玉県   |     1
 12   | 千葉県   |     2
 13   | 東京都   |    19
 14   | 神奈川県 |     3
 15   | 新潟県   |     3
 16   | 富山県   |     1
 17   | 石川県   |     2
 18   | 福井県   |     1
 19   | 山梨県   |     1
 20   | 長野県   |     1
 21   | 岐阜県   |     1
 22   | 静岡県   |     1
 23   | 愛知県   |     3
 24   | 三重県   |     4
 25   | 滋賀県   |     1
 26   | 京都府   |     1
 27   | 大阪府   |     4
 28   | 兵庫県   |     7
 29   | 奈良県   |     1
 30   | 和歌山県 |     4
 31   | 鳥取県   |     1
 32   | 島根県   |     5
 33   | 岡山県   |     3
 34   | 広島県   |    18
 35   | 山口県   |    14
 36   | 徳島県   |     3
 37   | 香川県   |     7
 38   | 愛媛県   |    11
 39   | 高知県   |     2
 40   | 福岡県   |     6
 41   | 佐賀県   |     2
 42   | 長崎県   |    28
 43   | 熊本県   |     9
 44   | 大分県   |     3
 45   | 宮崎県   |     1
 46   | 鹿児島県 |    30
 47   | 沖縄県   |    24
(47 rows)
```