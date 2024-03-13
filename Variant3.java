import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class Variant3 {
    public static void main(String[] args) {
        Map<String, Integer> sumMap = new HashMap<>();
        Map<String, Integer> countMap = new HashMap<>();

        Scanner scanner = new Scanner(System.in);

        while (scanner.hasNextLine()) {
            String line = scanner.nextLine();
            String[] parts = line.split(" ");

            if (parts.length == 2) {
                String key = parts[0];
                int value = Integer.parseInt(parts[1]);

                if (value >= -10000 && value <= 10000) {
                    sumMap.put(key, sumMap.getOrDefault(key, 0) + value);
                    countMap.put(key, countMap.getOrDefault(key, 0) + 1);
                } else {
                    System.out.println("Значення за межами діапазону [-10000, 10000]: " + value);
                }
            } else if (line.isEmpty()) {
                break;
            } else {
                System.out.println("Недійсна пара 'ключ-значення': " + line);
            }
        }

        scanner.close();

        String[] keys = new String[sumMap.size()];
        double[] averages = new double[sumMap.size()];

        int index = 0;
        for (Map.Entry<String, Integer> entry : sumMap.entrySet()) { // перебір пар
            String key = entry.getKey();
            int sum = entry.getValue();
            int count = countMap.get(key);
            double average = (double) sum / count;

            keys[index] = key;
            averages[index] = average;
            index++;
        }

        bubbleSort(averages, keys);

        for (int i = keys.length - 1; i >= 0; i--) {
            System.out.println(keys[i] + " " + averages[i]);
        }
    }

    private static void bubbleSort(double[] arr, String[] keys) {
        int n = arr.length;
        double temp;
        String tempKey;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (arr[j] > arr[j + 1]) {
                    temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;

                    tempKey = keys[j];
                    keys[j] = keys[j + 1];
                    keys[j + 1] = tempKey;
                }
            }
        }
    }
}
