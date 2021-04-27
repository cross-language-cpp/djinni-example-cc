
import java.nio.file.Path;

import dev.xlcpp.djinni.NativeLibLoader;


import dev.xlcpp.djinni.hello.Storage;
import dev.xlcpp.djinni.hello.Data;




//yes, not a beautiful Java JUnit test,
// just demonstrate basic usage of how to use the djinni generated files
// and the native lib
public class StorageJavaTest {
    public static void main(String[] args) {

        if (args.length > 0) {
            // assume that is the native lib to load
            System.out.println("Loading:" + args[0]);
            try {
                System.load(args[0]);
            } catch (Exception e) {
                //TODO: TODO , make more informative
                System.exit(2);
            }
        } else {
            // TODO check some locations ...
        }

        var store = Storage.create();
        var d = new Data(1, "Foo") ;
        assert store.add(d);
        assert store.size() == 1 ;
        assert !store.add(d);
        assert store.add(new Data(2, "Bar"));
        assert store.size() == 2 ;
        assert store.remove(1);
        assert store.size() == 1 ;
        assert !store.remove(1);
        assert store.size() == 1 ;
        System.out.println("all done");
    }
}
