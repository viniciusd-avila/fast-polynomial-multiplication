# Fast Polynomial Multiplication
Implementation of FFT in Common Lisp to attain fast multiplication of polynomials, that is, in O(n log n)

## Running the program

Look into SBCL, CLisp or LispWorks to compile and load fpm.lisp.

After that, call the fast-poly-multiplication function with two arrays of numeric elements as arguments. For instance, if you'd like to know what is *2 + x + x<sup>2</sup>* times *1 + x + x<sup>2</sup>*, call:
`(fast-poly-multiplication #(2 1 1) #(1 1 1))`

And the answer is, of course, *2 + 3x + 4x<sup>2</sup> + 2x<sup>3</sup> + x<sup>4</sup>*, here represented as `#(2 3 4 2 1 0 0 0)`.

The inverse of the fourier transform was also implemented, because it's a step in this method of polynomial multiplication. To test it we can run:
`(inverse-fft (fft #(3 5 6 2 1 7 0 0)))`[^1] and obtain the argument itself, `#(3 5 6 2 1 7 0 0)`.

[^1]: The argument for *fft* must be an array of 2^*k* numeric elements, k = 0, 1, 2, 3,... 
