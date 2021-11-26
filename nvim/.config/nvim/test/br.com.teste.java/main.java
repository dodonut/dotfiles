package java;

import java.io;
import java.util.ArrayList;
import java.util.List;


class HelloWorld {
    public static void main(String[] args) {
        var l = new ArrayList<Integer>();
        l.addAll(List.of(1,2,34));

        System.out.println(l);
    }
}
