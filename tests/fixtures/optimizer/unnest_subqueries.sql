--------------------------------------
-- Unnest Subqueries
--------------------------------------
SELECT *
FROM x AS x
WHERE
  x.a IN (SELECT y.a AS a FROM y)
  OR x.b = ANY (SELECT y.b AS b FROM y)
  OR x.c < (SELECT SUM(y.c) AS c FROM y WHERE y.a = x.a)
  OR x.d > (SELECT SUM(y.d) AS d FROM y WHERE y.a = x.a AND y.b < x.b)
  OR x.e IN (SELECT y.e AS e FROM y WHERE x.a = y.e)
  OR x.f <> ANY (SELECT y.f AS f FROM y WHERE y.f = x.a)
  OR EXISTS (SELECT y.g AS g FROM y WHERE x.a = y.g)
  OR x.h > ANY (SELECT y.a AS a FROM y)
  OR x.i IN (SELECT y.a AS a FROM y LIMIT 10)
  OR x.j IN (SELECT y.a AS a FROM y OFFSET 10)
  OR x.k IN (SELECT y.a AS a, y.b AS b FROM y)
  OR x.l > ANY (SELECT y.a FROM y)
  OR x.m = (SELECT SUM(y.c) AS c FROM y WHERE y.a = x.a LIMIT 10)
  OR x.n = (SELECT SUM(y.c) AS c FROM y WHERE y.a = x.a OFFSET 10)
  OR x.o = (SELECT y.c AS c FROM y WHERE y.a = x.a)
;

SELECT
  *
FROM x AS x
LEFT JOIN (
  SELECT
    y.a AS a
  FROM y
  GROUP BY
    y.a
) AS "_u_0"
  ON x.a = "_u_0"."a"
LEFT JOIN (
  SELECT
    y.b AS b
  FROM y
  GROUP BY
    y.b
) AS "_u_1"
  ON x.b = "_u_1"."b"
LEFT JOIN (
  SELECT
    SUM(y.c) AS c,
    y.a AS "_u_3"
  FROM y
  WHERE
    TRUE
  GROUP BY
    y.a
) AS "_u_2"
  ON "_u_2"."_u_3" = x.a
LEFT JOIN (
  SELECT
    SUM(y.d) AS d,
    y.a AS "_u_5",
    y.b AS "_u_6"
  FROM y
  WHERE
    TRUE
    AND TRUE
  GROUP BY
    y.a,
    y.b
) AS "_u_4"
  ON "_u_4"."_u_5" = x.a
  AND "_u_4"."_u_6" < x.b
LEFT JOIN (
  SELECT
    y.e AS e
  FROM y
  WHERE
    TRUE
  GROUP BY
    y.e
) AS "_u_7"
  ON x.a = "_u_7".e
LEFT JOIN (
  SELECT
    y.f AS f
  FROM y
  WHERE
    TRUE
  GROUP BY
    y.f
) AS "_u_8"
  ON "_u_8".f = x.a
LEFT JOIN (
  SELECT
    y.g
  FROM y
  WHERE
    TRUE
  GROUP BY
    y.g
) AS "_u_9"
  ON x.a = "_u_9".g
WHERE
  NOT "_u_0"."a" IS NULL
  OR NOT "_u_1"."b" IS NULL
  OR x.c < "_u_2".c
  OR x.d > "_u_4".d
  OR x.e = "_u_7".e
  OR x.f <> "_u_8".f
  OR NOT "_u_9".g IS NULL
  OR x.h > ANY (
    SELECT
      y.a AS a
    FROM y
  )
  OR x.i IN (
    SELECT
      y.a AS a
    FROM y
    LIMIT 10
  )
  OR x.j IN (
    SELECT
      y.a AS a
    FROM y
    OFFSET 10
  )
  OR x.k IN (
    SELECT
      y.a AS a,
      y.b AS b
    FROM y
  )
  OR x.l > ANY (
    SELECT
      y.a
    FROM y
  )
  OR x.m = (
    SELECT
      SUM(y.c) AS c
    FROM y
    WHERE
      y.a = x.a
    LIMIT 10
  )
  OR x.n = (
    SELECT
      SUM(y.c) AS c
    FROM y
    WHERE
      y.a = x.a
    OFFSET 10
  )
  OR x.o = (
    SELECT
      y.c AS c
    FROM y
    WHERE
      y.a = x.a
  );

