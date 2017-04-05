package com.company;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;


public class Tree2 {
    int id;
    ArrayList<Author> authors;

    Tree2(int id) {
        this.id = id;
        authors = new ArrayList<>();
    }

    void addAuthor(int author, int numSongs) {
        this.authors.add(new Author(author, numSongs));
    }

    @Override
    public String toString() {
        Author a;
        String s = "[" + id + "] -> {";

        for (Iterator<Author> it = authors.iterator(); it.hasNext(); ) {
            a = it.next();

            s += "(";
            if (it.hasNext()) {
                s += a.id + ", " + a.numSongs + "), ";
            } else {
                s += a.id + ", " + a.numSongs + ")";
            }
        }

        s += "}";
        return s;
    }
}