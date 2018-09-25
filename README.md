# OCaml String Concatenation Benchmark

Determining which way of concatenating strings is fastest.

## Methods

We have 4 different microbenchmarks for the combinations of long/short lists and
long/short strings. We compare the `^` operator, `String.concat`, and creating a
buffer with an initial size equal to that of all the strings and adding to it.

## Results

```text
5 strings x 10000 length
┌───────────────┬──────────┬─────────┬───────────┬──────────┬────────────┐
│ Name          │ Time/Run │ mWd/Run │  mjWd/Run │ Prom/Run │ Percentage │
├───────────────┼──────────┼─────────┼───────────┼──────────┼────────────┤
│ ^ operator    │   5.59us │ 379.00w │ 1_506.43w │    0.43w │    100.00% │
│ String.concat │   2.30us │         │   627.00w │          │     41.13% │
│ Buffer        │   5.03us │   9.00w │ 1_254.00w │          │     89.95% │
└───────────────┴──────────┴─────────┴───────────┴──────────┴────────────┘

5 strings x 3 length
┌───────────────┬──────────┬─────────┬────────────┐
│ Name          │ Time/Run │ mWd/Run │ Percentage │
├───────────────┼──────────┼─────────┼────────────┤
│ ^ operator    │ 112.33ns │  13.00w │    100.00% │
│ String.concat │  76.13ns │   3.00w │     67.78% │
│ Buffer        │  86.06ns │  15.00w │     76.61% │
└───────────────┴──────────┴─────────┴────────────┘

1000 strings x 1000 length
┌───────────────┬──────────────┬─────────┬─────────────┬──────────┬────────────┐
│ Name          │     Time/Run │ mWd/Run │    mjWd/Run │ Prom/Run │ Percentage │
├───────────────┼──────────────┼─────────┼─────────────┼──────────┼────────────┤
│ ^ operator    │ 227_268.35us │ 378.89w │ 62_564.12kw │    0.11w │    100.00% │
│ String.concat │     421.89us │         │    125.00kw │          │      0.19% │
│ Buffer        │     965.91us │   9.35w │    250.00kw │          │      0.43% │
└───────────────┴──────────────┴─────────┴─────────────┴──────────┴────────────┘

1000 strings x 3 length
┌───────────────┬──────────┬────────────┬─────────────┬──────────┬────────────┐
│ Name          │ Time/Run │    mWd/Run │    mjWd/Run │ Prom/Run │ Percentage │
├───────────────┼──────────┼────────────┼─────────────┼──────────┼────────────┤
│ ^ operator    │ 444.82us │ 88_404.00w │ 100_920.97w │   74.97w │    100.00% │
│ String.concat │  16.43us │            │     377.01w │          │      3.69% │
│ Buffer        │  15.46us │      9.00w │     754.00w │          │      3.48% │
└───────────────┴──────────┴────────────┴─────────────┴──────────┴────────────┘

10000 strings x 3 length
┌───────────────┬──────────┬─────────┬──────────┬────────────┐
│ Name          │ Time/Run │ mWd/Run │ mjWd/Run │ Percentage │
├───────────────┼──────────┼─────────┼──────────┼────────────┤
│ String.concat │ 173.52us │         │   3.75kw │    100.00% │
│ Buffer        │ 154.85us │   9.03w │   7.50kw │     89.24% │
└───────────────┴──────────┴─────────┴──────────┴────────────┘
```

- Seems like `String.concat` is the fastest way (until list size grows to >
  1000, and it's still relatively competitive with Buffer), and the way that
  allocates the least amount of memory.

- Creating a buffer and adding strings is usually slower with regards to
  performance, and allocates more memory than `String.concat`.

- The `^` operator is orders of magnitude slower + allocates obscene amounts of
  memory as list size or string size grow.
