package com.company;

import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;
import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Properties;

public class Main2 {

    private static final String DB_PROPERTIES = "config/DBConnection.properties";
    private Connection connection = null;
    private final Properties dbProperties;
    private static ArrayList<Tree2> trees = null;

    private Main2() {
        trees = new ArrayList<>();
        dbProperties = new Properties();
        InputStream inputStream = null;

        try {
            inputStream = new FileInputStream(DB_PROPERTIES);
            dbProperties.load(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (inputStream != null) {
                    inputStream.close();
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

    private void buildTrees(ResultSet rs) {
        Tree2 temp;
        int tempTreeId;
        int tempAuthorId;
        int tempNumSongs;

        try {
            rs.next();

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
            File fout = new File("Archi OverdubNet 1 (with weight collaborations).tsv");
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
                            if(iNumSongs > jNumSongs) {
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

        rs = main2.executeQuery("SELECT tree_id, memberId, count(*) as num_songs FROM songs WHERE tree_id IS NOT NULL GROUP BY tree_id, memberId");

        main2.buildTrees(rs);
        main2.printTrees();
        main2.saveToFile();

    }
}