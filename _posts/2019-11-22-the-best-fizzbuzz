---
layout: post
title: The Best FizzBuzz
category: Code
---

The hard part of FizzBuzz is the newlines.

If you're not aware, FizzBuzz is a programming exercise: print out the numbers from 1 to 100, but for each multiple of 3 print "Fizz" instead, and for each multiple of 5 print "Buzz" instead. At numbers which are multiples of both 3 and 5, print "FizzBuzz".

This is supposed to be a pretty basic challenge, just to demonstrate wheter someone can program their way out of a paper sack. But it can be surprisingly tricky—and strangely enough, it's often trickier for _better_ programmers! That's because FizzBuzz hides an _elegance trap_.

What do I mean? Well, a basic implementation might look like this, in pseudocode:

~~~
for n = 1 to 100:
    if 3 | n and 5 | n:
        print "FizzBuzz"
    else if 3 | n:
        print "Fizz"
    else if 5 | n:
        print "Buzz"
    else:
        print n
~~~

This works fine, but a good programmer, always instinctively seeking elegance, won't be satisfied. It doesn't scale well to more factors (printing "Bazz" on 7, for instance, would require also checking for multiples of 3*5*7, or of 3*7, or 5*7, or just 7). And repeating the strings "Fizz", etc., in different places isn't good.

An idea presents itself: check for multiples of 3 and print "Fizz", then check for multiples of 5 and print "Buzz"—_without_ the `else`. Then multiples of 15 will naturally get "FizzBuzz" without doing anything special.

This is so obviously _right_ that the good programmer will try to do it that way. But then what seemed to be a minor detail—putting newlines in the right place—rears its ugly head. By the time it works, the result is longer and uglier than the basic form above. This is the elegance trap: what is usually a good instinct has led you to spend too much time on a simple problem, and it ended up ugly.

So most discussions of FizzBuzz seem to recommend to avoid overthinking it, and just go with the dumb solution. But dang it, it _is_ dumb. And we **can** do better!

So here is is: the best FizzBuzz, in Python.

~~~ python
wurdz = {3: "Fizz", 5: "Buzz"}
for i in range(1, 101):
    print(''.join(wurdz[d] for d in wurdz if not i % d) or i)
~~~

This generalizes to more factors really well—just add `7: "Bazz"` in the dictionary.

Unfortunately it's a bit harder to express in some other languages, like C++.
You can use the same algorithm, of course, it just ends up being more verbose.
Here's an implementation, using some C++17 syntax.

~~~ C++
#include <map>
#include <string>
#include <iostream>

using std::map, std::string, std::cout;

int main() {
    map<int, string> wurdz = { {3, "Fizz"}, {5, "Buzz"} };
    for (int i=1;  i<101; ++i) {
        string msg = "";
        for (auto const & [div, wrd] : wurdz)
            if (!(i%div))
                msg += wrd;
        if (msg.empty())
            cout << i;
        cout << msg << '\n';
    }
    return 0;
}
~~~
