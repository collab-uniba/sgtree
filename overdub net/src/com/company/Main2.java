package com.company;

import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Properties;

public class Main2 {

    private static final String DB_PROPERTIES = "config/DBConnection.properties";
    private static final String QUERY_PROPERTIES = "config/Query_not_normalized.properties";
    private Connection connection = null;
    private final Properties dbProperties;
    private static Properties queryProperties;
    private static ArrayList<Tree2> trees = null;

    private Main2() {
        trees = new ArrayList<>();
        dbProperties = new Properties();
        queryProperties = new Properties();

        InputStream inputStream1 = null;
        InputStream inputStream2 = null;

        try {
            inputStream1 = new FileInputStream(DB_PROPERTIES);
            dbProperties.load(inputStream1);

            inputStream2 = new FileInputStream(QUERY_PROPERTIES);
            queryProperties.load(inputStream2);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (inputStream1 != null) {
                    inputStream1.close();
                }
                if (inputStream2 != null) {
                    inputStream2.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private ResultSet executeQuery(String query) {
        PreparedStatement statement;
        ResultSet resultSet = null;

        try {
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultSet;
    }

    private void executeQueryAndSave(String query, String filename) {
        PreparedStatement statement;
        ResultSet rs = null;
        FileOutputStream fos = null;

        try {
            File fout = new File(filename);
            fos = new FileOutputStream(fout);
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));


            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            ResultSetMetaData rsmd = rs.getMetaData();

            bw.write(rsmd.getColumnName(1) + "\t" + rsmd.getColumnName(2));
            bw.newLine();

            int i;
            String s;
            //s= rsmd.getColumnTypeName(2);
            while (rs.next()) {
                s = rs.getString(1);
                bw.write(s);

                bw.write("\t");

                s = rs.getString(2);
                bw.write(s);
                bw.newLine();
            }

            bw.close();

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }

    private void buildTrees(ResultSet rs) {
        Tree2 temp;
        int tempTreeId;
        int tempAuthorId;
        int tempNumSongs;

        try {
            rs.next();

            //1° column tree_id, 2° authorId, 3° num_songs the author has written in the tree
            temp = new Tree2(rs.getInt(1));
            temp.addAuthor(rs.getInt(2), rs.getInt(3));
            trees.add(temp);

            while (rs.next()) {
                tempTreeId = rs.getInt(1);
                tempAuthorId = rs.getInt(2);
                tempNumSongs = rs.getInt(3);

                for (Iterator<Tree2> it = trees.iterator(); it.hasNext(); ) {
                    Tree2 t = it.next();
                    if (tempTreeId == t.id) {
                        t.addAuthor(tempAuthorId, tempNumSongs);
                        break;
                    }
                    if (!it.hasNext()) {
                        temp = new Tree2(tempTreeId);
                        temp.addAuthor(tempAuthorId, tempNumSongs);
                        trees.add(temp);
                        break;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void printTrees() {
        //stampa i vari id degli alberi e i nodi che lo compongono
        for (Tree2 t : trees) {
            System.out.println(t.toString());
        }
    }

    private void saveToFile() {
        try {
            File fout = new File("Archi OverdubNet 1 (with weight collaborations and no remix).tsv");
            FileOutputStream fos = new FileOutputStream(fout);
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));

            int size;
            int iNumSongs;
            int jNumSongs;

            bw.write("source\ttarget\tweight\ttype");
            bw.newLine();
            for (Tree2 t : trees) {
                size = t.authors.size();

                if (size != 1) {
                    for (int i = 0; i < size; i++) {
                        iNumSongs = t.authors.get(i).numSongs;
                        for (int j = i + 1; j < size; j++) {
                            jNumSongs = t.authors.get(j).numSongs;
                            if (iNumSongs > jNumSongs) {
                                bw.write(t.authors.get(i).id + "\t" + t.authors.get(j).id + "\t" + iNumSongs + "\t" + "Undirected");
                            } else {
                                bw.write(t.authors.get(i).id + "\t" + t.authors.get(j).id + "\t" + jNumSongs + "\t" + "Undirected");
                            }
                            bw.newLine();
                        }
                    }
                }
            }
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void closeConnection() {

        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void openConnection() {

        try {

            MysqlDataSource mysqlDataSource = new MysqlDataSource();

            mysqlDataSource.setServerName(dbProperties.getProperty("MYSQL_SERVER"));
            mysqlDataSource.setPort(Integer.parseInt(dbProperties.getProperty("MYSQL_PORT")));
            mysqlDataSource.setDatabaseName(dbProperties.getProperty("MYSQL_DB"));

            connection = mysqlDataSource.getConnection(dbProperties.getProperty("MYSQL_USERNAME"),
                    dbProperties.getProperty("MYSQL_PASSWORD"));

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {
        Main2 main2 = new Main2();
        ResultSet rs;

        main2.openConnection();

        rs = main2.executeQuery("SELECT tree_id, memberId, count(*) AS num_songs FROM songs WHERE tree_id IS NOT NULL AND isremix = 0 GROUP BY tree_id, memberId");
        main2.buildTrees(rs);
        main2.printTrees();
        main2.saveToFile();

        /*String[] s = {"GENERALE 1 Corr Songs - New Songs.tsv",
                "GENERALE 2 Corr Songs - Overdubs.tsv",
                "GENERALE 3 Corr Songs - In Degree.tsv",
                "GENERALE 4 Corr Songs - Out Degree.tsv",
                "GENERALE 5 Corr Songs - Betweenness.tsv",
                "GENERALE 6 Corr New Songs - Overdubs.tsv",
                "GENERALE 7 Corr New Songs - Norm. In Degree.tsv",
                "GENERALE 8 Corr New Songs - Norm. Out Degree.tsv",
                "GENERALE 9 Corr New Songs - Betweeness.tsv",
                "GENERALE 10 Corr Overdubs - Norm. In Degree.tsv",
                "GENERALE 11 Corr Overdubs - Norm. Out Degree.tsv",
                "GENERALE 12 Corr Overdubs - Betweenness.tsv",
                "GENERALE 13 Corr In Degree - Out Degree.tsv",
                "GENERALE 14 Corr In Degree - Betweenness.tsv",
                "GENERALE 15 Corr Out Degree - Betweenness.tsv",
                "ROCK 1 Corr Songs - New Songs.tsv",
                "ROCK 2 Corr Songs - Overdubs.tsv",
                "ROCK 3 Corr Songs - In Degree.tsv",
                "ROCK 4 Corr Songs - Out Degree.tsv",
                "ROCK 5 Corr Songs - Betweenness.tsv",
                "ROCK 6 Corr New Songs - Overdubs.tsv",
                "ROCK 7 Corr New Songs - Norm. In Degree.tsv",
                "ROCK 8 Corr New Songs - Norm. Out Degree.tsv",
                "ROCK 9 Corr New Songs - Betweeness.tsv",
                "ROCK 10 Corr Overdubs - Norm. In Degree.tsv",
                "ROCK 11 Corr Overdubs - Norm. Out Degree.tsv",
                "ROCK 12 Corr Overdubs - Betweenness.tsv",
                "ROCK 13 Corr In Degree - Out Degree.tsv",
                "ROCK 14 Corr In Degree - Betweenness.tsv",
                "ROCK 15 Corr Out Degree - Betweenness.tsv",
                "ACOUSTIC 1 Corr Songs - New Songs.tsv",
                "ACOUSTIC 2 Corr Songs - Overdubs.tsv",
                "ACOUSTIC 3 Corr Songs - In Degree.tsv",
                "ACOUSTIC 4 Corr Songs - Out Degree.tsv",
                "ACOUSTIC 5 Corr Songs - Betweenness.tsv",
                "ACOUSTIC 6 Corr New Songs - Overdubs.tsv",
                "ACOUSTIC 7 Corr New Songs - Norm. In Degree.tsv",
                "ACOUSTIC 8 Corr New Songs - Norm. Out Degree.tsv",
                "ACOUSTIC 9 Corr New Songs - Betweeness.tsv",
                "ACOUSTIC 10 Corr Overdubs - Norm. In Degree.tsv",
                "ACOUSTIC 11 Corr Overdubs - Norm. Out Degree.tsv",
                "ACOUSTIC 12 Corr Overdubs - Betweenness.tsv",
                "ACOUSTIC 13 Corr In Degree - Out Degree.tsv",
                "ACOUSTIC 14 Corr In Degree - Betweenness.tsv",
                "ACOUSTIC 15 Corr Out Degree - Betweenness.tsv",
                "HIPHOP 1 Corr Songs - New Songs.tsv",
                "HIPHOP 2 Corr Songs - Overdubs.tsv",
                "HIPHOP 3 Corr Songs - In Degree.tsv",
                "HIPHOP 4 Corr Songs - Out Degree.tsv",
                "HIPHOP 5 Corr Songs - Betweenness.tsv",
                "HIPHOP 6 Corr New Songs - Overdubs.tsv",
                "HIPHOP 7 Corr New Songs - Norm. In Degree.tsv",
                "HIPHOP 8 Corr New Songs - Norm. Out Degree.tsv",
                "HIPHOP 9 Corr New Songs - Betweeness.tsv",
                "HIPHOP 10 Corr Overdubs - Norm. In Degree.tsv",
                "HIPHOP 11 Corr Overdubs - Norm. Out Degree.tsv",
                "HIPHOP 12 Corr Overdubs - Betweenness.tsv",
                "HIPHOP 13 Corr In Degree - Out Degree.tsv",
                "HIPHOP 14 Corr In Degree - Betweenness.tsv",
                "HIPHOP 15 Corr Out Degree - Betweenness.tsv",};

        for(int i = 1; i<=60; i++) {
            main2.executeQueryAndSave(queryProperties.getProperty(String.valueOf(i)), s[i-1]);
        }*/

        main2.closeConnection();

    }
}