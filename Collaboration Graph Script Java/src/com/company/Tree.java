package com.company;

import java.util.ArrayList;
import java.util.Iterator;


public class Tree {
    int id;
    ArrayList<Integer> authors;

    Tree(int id) {
        this.id = id;
        authors = new ArrayList<>();
    }

    void addAuthor(int author) {
        this.authors.add(author);
    }

    @Override
    public String toString() {
        Integer value;
        String s = "[" + id + "] -> {";

        for (Iterator<Integer> it = authors.iterator(); it.hasNext(); ) {
            value = it.next();
            if (it.hasNext()) {
                s += value + ", ";
            } else {
                s += value;
            }
        }

        s += "}";
        return s;
    }
}
