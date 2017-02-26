package com.company;

/**
 * Created by antoniolategano on 26/02/17.
 */
public class Author {
    int id;
    int numSongs;

    Author() {}

    Author(int id, int numSongs) {
        this.id =id;
        this.numSongs = numSongs;
    }

    @Override
    public String toString() {
        return id + ", " + numSongs;
    }
}
