package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class JpaListener_24110342 implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            System.out.println("=== [JpaListener_24110342] Initializing EntityManagerFactory on Startup... ===");
            EntityManager em = JPAConfig_24110342.getEntityManager();
            em.close();
            System.out.println("=== [JpaListener_24110342] EntityManagerFactory Initialized Successfully! ===");
        } catch (Exception e) {
            System.err.println("=== [JpaListener_24110342] Error initializing JPA: " + e.getMessage() + " ===");
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("=== [JpaListener_24110342] Shutting down EntityManagerFactory... ===");
        JPAConfig_24110342.shutdown();
    }
}
