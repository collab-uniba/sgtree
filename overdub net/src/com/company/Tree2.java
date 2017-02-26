package com.company;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;


public class Tree2 {
    int id;
    ArrayList<Author> authors;
    //HashMap<Integer, Integer> authors;


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

        /*for (Iterator it = authors.entrySet().iterator(); it.hasNext(); ) {
            Map.Entry pair = (Map.Entry) it.next();
            author = (Integer) pair.getKey();
            numSongs = (Integer) pair.getValue();

            s += "(";
            if (it.hasNext()) {
                s += author + ", " + numSongs + "), ";
            } else {
                s += author + ", " + numSongs;
            }

            s+= ")";
        }*/

        s += "}";
        return s;
    }
}