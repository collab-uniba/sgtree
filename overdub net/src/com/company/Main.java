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

    private void printTrees() {
        //stampa i vari id degli alberi e i nodi che lo compongono
        for (Tree t : trees) {
            System.out.println(t.toString());
        }
    }

    public static void main(String[] args) {
        Main main = new Main();
        ResultSet rs;
        Tree temp;

        main.openConnection();
        rs = main.executeQuery("SELECT tree_id, memberId FROM songs WHERE tree_id IS NOT NULL GROUP BY tree_id, memberId");

        try {
            rs.next();

            temp = new Tree(rs.getInt(1));
            temp.addAuthor(rs.getInt(2));
            trees.add(temp);

            while (rs.next()) {
                for (Iterator<Tree> it = trees.iterator(); it.hasNext(); ) {
                    Tree t = it.next();
                    if (rs.getInt("tree_id") == t.id) {
                        t.addAuthor(rs.getInt("memberId"));
                        break;
                    }
                    if (!it.hasNext()) {
                        temp = new Tree(rs.getInt("tree_id"));
                        temp.addAuthor(rs.getInt("memberId"));
                        trees.add(temp);
                        break;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            main.closeConnection();
        }

        main.printTrees();

        try {
            File fout = new File("Archi OverdubNet 1.tsv");
            FileOutputStream fos = new FileOutputStream(fout);
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));

            int size;
            for (Tree t : trees) {
                size = t.authors.size();
                if (size != 1) {
                    for (int i = 0; i < size; i++) {
                        for (int j = i + 1; j < size; j++) {
                            bw.write(t.authors.get(i) + "\t" + t.authors.get(j));
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
}
