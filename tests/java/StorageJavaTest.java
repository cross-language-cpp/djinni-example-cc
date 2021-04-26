
import java.nio.file.Path;

import dev.xlcpp.djinni.NativeLibLoader;


import dev.xlcpp.djinni.hello.Storage;
import dev.xlcpp.djinni.hello.Data;


public class StorageJavaTest {
    public static void main(String[] args) {

        if (args.length > 0) {
            System.out.println("here:" + args[0]);
        }


        try {
            System.out.println("Working Directory = " + System.getProperty("user.dir"));

            var file_path = "/Users/a4z/work/xlcpp/intro/hello_djinni/build/lib/DjinniStorage.framework/DjinniStorage" ;
            System.load(file_path);
            // System.setProperty( "java.library.path", "/Users/a4z/work/xlcpp/intro/hello_djinni/build/lib" );
            // System.loadLibrary("DjinniStorage");

            var d = new Data(1, "Foo") ;

            System.out.println("" + d.getId() + " " + d.getValue() );

        } catch (Exception e) {
            //TODO: handle
            System.exit(2);

        }


    }
}
