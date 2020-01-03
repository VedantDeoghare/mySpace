import org.apache.zookeeper.ZooKeeper;
import org.apache.zookeeper.Watcher;
import java.io.IOException;

public class WatchersDemo implements Watcher
{
    private static final String ZOOKEEPER_ADDRESS="localhost:2181";
    private static final int SESSION_TIMEOUT=3000;
    private ZooKeeper zooKeeper;
    private static final String TARGET_ZNODE="/target_znode";
    public static void main(String args[]) throws IOException, InterruptedException, KeeperException
    {
        WatchersDemo watchersDemo = new WatchersDemo();
        watchersDemo.connectToZookeeper();
        watchersDemo.watchTargetZnode();
        watchersDemo.run();
        watchersDemo.close();
    }

    public void connectToZookeeper() throws IOException
    {
        this.zooKeeper= new ZooKeeper(ZOOKEEPER_ADDRESS,SESSION_TIMEOUT, watcher: this)
    }

    public void run() throws InterruptedException
    {
        synchronized(zooKeeper)
        {
            zooKeeper.wait();
        }
    }

    public void close() throws InterruptedException
    {
        zooKeeper.close();
    }

    public void watchTargetZnode() throws KeeperException, InterruptedException
    {   
        Stat stat = zooKeeper.exists(TARGET_ZNODE, watcher: this )
        if(stat == null)
        {
            return;
        }
        
        byte[] data =  zooKeeper.getData(TARGET_ZNODE, watcher: this, stat)
        List<String> children = zooKeeper.getChildren(TARGET_ZNODE, watcher: this)
        
        System.out.println("Data : "+ new String(data)+ "children : "+ children);
    }

    @Override
    public void process(WatchedEvent event)
    {
        switch(event.getType())
        {
            case None:
            if(event.getState() == Event.KeeperState.SyncConnected)
            {
                System.out.println("Succcesfully Connected to Zookeeper ! ");
            }
            else
            {
                synchronized(zooKeeper)
                {
                    System.out.println("Disconnected from event !");
                    zooKeeper.notifyAll();
                }
            }
            break;

            case NodeDeleted:
            System.out.println(TARGET_ZNODE+" was deleted ");
            break;

            case NodeCreated:
            System.out.println(TARGET_ZNODE+ " was created ");
            break;

            case NodeDataChanged:
            System.out.println(TARGET_ZNODE+ " data changed ");
            break;

            case NodeChidrenChanged:
            System.out.println(TARGET_ZNODE+" children changed");
            break;
        }

        try {
            watchTargetZnode();
        } catch (KeeperException e) { }
        catch (InterruptedException e)
        { }
    }
}