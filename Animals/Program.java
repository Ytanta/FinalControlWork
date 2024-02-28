package Animals;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Scanner;

public class Program {
    public static void main(String[] args) throws ParseException {

        ArrayList<Animal> allAnimals = new ArrayList<Animal>();


        while (true) {
            Scanner sc = new Scanner(System.in);
            System.out.println("---------------------------------------------\nWelcome to animal register programm!\n" +
                    "Choose from the menu below: \n" +
                    "1 - see the list of animals\n" +
                    "2 - add a new animal\n" +
                    "3 - see the skills of an animal with its id\n" +
                    "4 - educate an animal\n" +
                    "5 - exit\n" +
                    "Enter your choice: "
            );
            int choice = sc.nextInt();
            switch (choice) {
                case 1 -> Animal.showAllAnimals(allAnimals);
                case 2 -> Animal.addNewAnimal(allAnimals);
                case 3 -> Animal.showSkills(allAnimals);
                case 4 -> Animal.educate(allAnimals);
                case 5 -> {
                    System.out.println("Bye-bye!");
                    return;
                }
            }


        }
    }
}
