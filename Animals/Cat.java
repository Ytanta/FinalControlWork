package Animals;

import java.util.Date;

public class Cat extends Pet implements Skills{

    public Cat(String type, String name, Date birthday, String commands) {
        super(type, name, birthday, commands);
    }
}
