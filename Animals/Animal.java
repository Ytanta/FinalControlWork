package Animals;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public abstract class Animal {

    private static int counter;
    private static int idCounter = 0;
    protected String type;
    protected String name;
    protected Date birthday;
    protected String commands;
    private int id;

    public static int getCounter(){
        return counter;
    }

    {
        counter ++;
        id = ++idCounter;
    }

    public String getType() {
        return type;
    }

    public String getName() {
        return name;
    }

    public Date getBirthday() {
        return birthday;
    }

    public String getCommands() {
        return commands;
    }

    public void setCommands(String commands) {
        this.commands = commands;
    }


    public Animal(String type, String name, Date birthday, String commands) {
        this.type = type;
        this.name = name;
        this.birthday = birthday;
        this.commands = commands;
    }

    Scanner sc = new Scanner(System.in);


    public static void educate(ArrayList<Animal> animals) {
        int id;
        Scanner sc = new Scanner(System.in);
        String newCommand;
        System.out.println("Enter an animal's id");
        id = sc.nextInt();
        System.out.println("What the command does it know now?: ");
        newCommand = sc.next();
        for (Animal animal : animals) {
            if (animal.id == id) {
                animal.commands +=  ", " + newCommand;
            }
        }
        System.out.println("Education was successful!");
    }
    public static void showSkills(ArrayList<Animal> animals){
        Scanner sc = new Scanner(System.in);
        int id;
        System.out.println("Enter an id of an animal: ");
        id = sc.nextInt();
        for (Animal animal : animals) {
            if (animal.id == id) {
                System.out.println("The animal with id " + animal.id + " has these skills: " + animal.commands);
            }else {System.out.println("Sorry, but there is no animal with this id...");}

        }

    }


    public static void addNewAnimal(ArrayList<Animal> animals) throws ParseException {
        Scanner sc = new Scanner(System.in);

        System.out.println("Input type of animal: ");
        String type = "";
        type = sc.nextLine();
        String name = "";
        String commands = "";
        System.out.println("Enter name: ");
        name = sc.nextLine();
        System.out.println("Enter bday: ");
        String input = sc.nextLine();
        DateFormat formatter = new SimpleDateFormat("yyyy.MM.dd");
        Date bday = formatter.parse(input);
        System.out.println("Enter commands: ");
        commands = sc.nextLine();
        if (type.contains("dog") || type.contains("cat") || type.contains("hamster")) {
            Pet pet = new Pet(type, name, bday, commands);
            animals.add(pet);
            System.out.println("Animal is added!");
        }
        if (type.contains("donkey") || type.contains("camel") || type.contains("horse")) {
            PackAnimal packAnimal = new PackAnimal(type, name, bday, commands);
            animals.add(packAnimal);
            System.out.println("Animal is added!");
        }
        else {
            System.out.println("No this type of anilmal ");
        }

    }


    public static void showAllAnimals(ArrayList<Animal> animals) {
        if (animals.isEmpty()) {
            System.out.println("There is no registered animals");
        }

        for (Animal animal : animals) {
            System.out.println( "---------------------------------------------\nRegistered animals: \n" + animal.id +  " - " + animal.type + " " + animal.name + "\n---------------------------------------------");
        }
    }
}


