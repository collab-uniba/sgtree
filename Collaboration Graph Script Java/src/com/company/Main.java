package com.company;

import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Properties;

public class Main {

    private static final String DB_PROPERTIES = "config/DBConnection.properties";
    private Connection connection = null;
    private final Properties dbProperties;
    private static ArrayList<Tree> trees = null;

    private Main() {
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
        Tree temp;
        int tempTreeId;
        int tempAuthorId;

        try {
            rs.next();

            temp = new Tree(rs.getInt(1));
            temp.addAuthor(rs.getInt(2));
            trees.add(temp);

            while (rs.next()) {
                tempTreeId = rs.getInt(1);
                tempAuthorId = rs.getInt(2);

                for (Iterator<Tree> it = trees.iterator(); it.hasNext(); ) {
                    Tree t = it.next();
                    if (tempTreeId == t.id) {
                        t.addAuthor(tempAuthorId);
                        break;
                    }
                    if (!it.hasNext()) {
                        temp = new Tree(tempTreeId);
                        temp.addAuthor(tempAuthorId);
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
        for (Tree t : trees) {
            System.out.println(t.toString());
        }
    }

    private void saveToFile() {
        try {
            File fout = new File("Archi CollaborationNet.tsv");
            FileOutputStream fos = new FileOutputStream(fout);
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));

            int numAuthors;
            bw.write("source\ttarget\ttype");
            bw.newLine();
            for (Tree t : trees) {
                numAuthors = t.authors.size();
                if (numAuthors != 1) {
                    for (int i = 0; i < numAuthors; i++) {
                        for (int j = i + 1; j < numAuthors; j++) {
                            bw.write(t.authors.get(i) + "\t" + t.authors.get(j) + "\t" + "Undirected");
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
        Main main = new Main();
        ResultSet rs;

        main.openConnection();
        rs = main.executeQuery("SELECT tree_id, memberId FROM songs WHERE tree_id IS NOT NULL AND isremix = 0 GROUP BY tree_id, memberId");

        main.buildTrees(rs);
        main.printTrees();
        main.saveToFile();

        main.closeConnection();
    }
}
