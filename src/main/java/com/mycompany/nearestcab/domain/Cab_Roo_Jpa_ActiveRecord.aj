// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.mycompany.nearestcab.domain;

import com.mycompany.nearestcab.domain.Cab;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Cab_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager Cab.entityManager;
    
    public static final EntityManager Cab.entityManager() {
        EntityManager em = new Cab().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Cab.countCabs() {
        return entityManager().createQuery("SELECT COUNT(o) FROM Cab o", Long.class).getSingleResult();
    }
    
    public static List<Cab> Cab.findAllCabs() {
        return entityManager().createQuery("SELECT o FROM Cab o", Cab.class).getResultList();
    }
    
    public static Cab Cab.findCab(Long id) {
        if (id == null) return null;
        return entityManager().find(Cab.class, id);
    }
    
    public static List<Cab> Cab.findCabEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM Cab o", Cab.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void Cab.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Cab.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Cab attached = Cab.findCab(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Cab.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Cab.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public Cab Cab.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Cab merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}
