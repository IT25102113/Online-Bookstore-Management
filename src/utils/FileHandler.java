package utils;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileHandler {

    // ඔයාගේ data ෆෝල්ඩරයේ path එක මෙතන දෙන්න. (Absolute path එක දෙන එක වඩාත් සුදුසුයි)
    // උදාහරණයක්: "/Users/dulara/Desktop/Web Application/data/"
    private static final String BASE_DIRECTORY = "/Users/dularaanjana/Desktop/Web Application/data/";

    /**
     * 1. CREATE:  (Append)
     */
    public static boolean writeToFile(String fileName, String data) {
        try (FileWriter fw = new FileWriter(BASE_DIRECTORY + fileName, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {

            out.println(data);
            return true;

        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
            return false;
        }
    }

    /**
     * 2. READ: Text file
     */
    public static List<String> readFromFile(String fileName) {
        List<String> records = new ArrayList<>();
        File file = new File(BASE_DIRECTORY + fileName);

        if (!file.exists()) {
            return records; // File එක නැත්නම් හිස් List එකක් යවයි
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                records.add(line);
            }
        } catch (IOException e) {
            System.out.println("Error reading from file: " + e.getMessage());
        }
        return records;
    }

    /**
     * 3. UPDATE / DELETE: Text file
     */
    public static boolean modifyFile(String fileName, String oldData, String newData) {
        List<String> records = readFromFile(fileName);
        boolean isModified = false;

        try (FileWriter fw = new FileWriter(BASE_DIRECTORY + fileName, false); // false = Overwrite mode
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {

            for (String record : records) {
                if (record.equals(oldData)) {
                    if (!newData.isEmpty()) {
                        out.println(newData);
                    }
                    isModified = true;
                } else {
                    out.println(record);
                }
            }
            return isModified;

        } catch (IOException e) {
            System.out.println("Error modifying file: " + e.getMessage());
            return false;
        }
    }
}