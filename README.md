# OCaml String Concatenation Benchmark

## Methods

Created a list of 1000 strings, and then concatenated them using:

- string add: using the `^` operator
- string concat: using `String.concat ""`
- buffer add: creating a buffer and adding the strings

## Results

```
Estimated testing time 30s (3 benchmarks x 10s). Change using -quota SECS.
┌───────────────┬────────────┬────────────┬─────────────┬────────────┐
│ Name          │   Time/Run │    mWd/Run │    mjWd/Run │ Percentage │
├───────────────┼────────────┼────────────┼─────────────┼────────────┤
│ string add    │ 1_180.57us │ 44_287.00w │ 332_713.01w │    100.00% │
│ string concat │    18.21us │            │     752.00w │      1.54% │
│ buffer add    │    23.80us │    406.01w │   2_708.03w │      2.02% │
└───────────────┴────────────┴────────────┴─────────────┴────────────┘
```

- Seems like `String.concat` is the both the fastest way, and the way that
  allocates the least amount of memory.
- Creating a buffer and adding strings is a relatively close second place with
  regards to performance, but allocates significantly more memory.
- The `^` operator not only is almost two orders of magnitude slower, but also
  allocates an obscene amount of memory relative to the other two methods
