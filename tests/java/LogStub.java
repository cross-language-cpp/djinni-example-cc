import dev.xlcpp.djinni.hello.Logger;

public class LogStub extends  dev.xlcpp.djinni.hello.Logger {
    public boolean write(long action, long id) {
        System.out.print("Java here with action" + action + ", id " + id);
        return true;
    }
}
