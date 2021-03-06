// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.mycompany.nearestcab.domain;

import com.mycompany.nearestcab.domain.Cab;
import com.mycompany.nearestcab.domain.CabDataOnDemand;
import com.mycompany.nearestcab.domain.CabIntegrationTest;
import java.util.Iterator;
import java.util.List;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect CabIntegrationTest_Roo_IntegrationTest {
    
    declare @type: CabIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: CabIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: CabIntegrationTest: @Transactional;
    
    @Autowired
    CabDataOnDemand CabIntegrationTest.dod;
    
    @Test
    public void CabIntegrationTest.testCountCabs() {
        Assert.assertNotNull("Data on demand for 'Cab' failed to initialize correctly", dod.getRandomCab());
        long count = Cab.countCabs();
        Assert.assertTrue("Counter for 'Cab' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void CabIntegrationTest.testFindCab() {
        Cab obj = dod.getRandomCab();
        Assert.assertNotNull("Data on demand for 'Cab' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Cab' failed to provide an identifier", id);
        obj = Cab.findCab(id);
        Assert.assertNotNull("Find method for 'Cab' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'Cab' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void CabIntegrationTest.testFindAllCabs() {
        Assert.assertNotNull("Data on demand for 'Cab' failed to initialize correctly", dod.getRandomCab());
        long count = Cab.countCabs();
        Assert.assertTrue("Too expensive to perform a find all test for 'Cab', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<Cab> result = Cab.findAllCabs();
        Assert.assertNotNull("Find all method for 'Cab' illegally returned null", result);
        Assert.assertTrue("Find all method for 'Cab' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void CabIntegrationTest.testFindCabEntries() {
        Assert.assertNotNull("Data on demand for 'Cab' failed to initialize correctly", dod.getRandomCab());
        long count = Cab.countCabs();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<Cab> result = Cab.findCabEntries(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'Cab' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'Cab' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void CabIntegrationTest.testFlush() {
        Cab obj = dod.getRandomCab();
        Assert.assertNotNull("Data on demand for 'Cab' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Cab' failed to provide an identifier", id);
        obj = Cab.findCab(id);
        Assert.assertNotNull("Find method for 'Cab' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyCab(obj);
        Integer currentVersion = obj.getVersion();
        obj.flush();
        Assert.assertTrue("Version for 'Cab' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void CabIntegrationTest.testMergeUpdate() {
        Cab obj = dod.getRandomCab();
        Assert.assertNotNull("Data on demand for 'Cab' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Cab' failed to provide an identifier", id);
        obj = Cab.findCab(id);
        boolean modified =  dod.modifyCab(obj);
        Integer currentVersion = obj.getVersion();
        Cab merged = obj.merge();
        obj.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'Cab' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void CabIntegrationTest.testPersist() {
        Assert.assertNotNull("Data on demand for 'Cab' failed to initialize correctly", dod.getRandomCab());
        Cab obj = dod.getNewTransientCab(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'Cab' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'Cab' identifier to be null", obj.getId());
        try {
            obj.persist();
        } catch (final ConstraintViolationException e) {
            final StringBuilder msg = new StringBuilder();
            for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                final ConstraintViolation<?> cv = iter.next();
                msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
            }
            throw new IllegalStateException(msg.toString(), e);
        }
        obj.flush();
        Assert.assertNotNull("Expected 'Cab' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void CabIntegrationTest.testRemove() {
        Cab obj = dod.getRandomCab();
        Assert.assertNotNull("Data on demand for 'Cab' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Cab' failed to provide an identifier", id);
        obj = Cab.findCab(id);
        obj.remove();
        obj.flush();
        Assert.assertNull("Failed to remove 'Cab' with identifier '" + id + "'", Cab.findCab(id));
    }
    
}
