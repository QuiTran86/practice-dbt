WITH test_data AS (
    SELECT '{{ ls_2_str(['a', 'b']) }}' = 'a, b' AS MATCHING
)
SELECT * FROM test_data
WHERE NOT MATCHING
