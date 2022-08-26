# A Smart BrainFuck Interpreter In OCaml

## How To Use

To compile a "bf" executable, run the following command:

```
make
```

To run the "bf" executable, run the following command:

```
./bf filename
```

For example, to run the "bf" executable on the file "hello.bf" in the tests directory, run the following command:

```
./bf tests/hello.bf
```

## Running Test Cases

To run the test cases, run the following command:

```
./run-tests.sh
```

or run the following command:

```
bash ./run-tests.sh
```

It will compile if needed and run all of the tests in the tests directory, with a timeout of 3s.

## TODO

1. Add better comments to the code.
2. Clean the code (especially the edge cases).
3. Add better optimizations to the algorithm.
