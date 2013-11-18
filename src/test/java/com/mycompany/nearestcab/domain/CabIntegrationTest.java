package com.mycompany.nearestcab.domain;
import org.junit.Test;
import org.springframework.roo.addon.test.RooIntegrationTest;
import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;

import com.mycompany.nearestcab.controller.CabController;

import java.util.List;

@RooIntegrationTest(entity = Cab.class)
public class CabIntegrationTest {
	
    @Test
    public void testMarkerMethod() {
    }
    
	@Test
    public void testFindCabEntriesRO() {
        Assert.assertNotNull("Data on demand for 'Cab' failed to initialize correctly", dod.getRandomCab());
        long count = Cab.countCabs();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<Cab> result = Cab.findCabEntriesRO(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'Cab' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'Cab' returned an incorrect number of entries", count, result.size());
    }
	
	@Test
    public void testPutCreateUpdate() {
		
		long countBefore = Cab.countCabs();
		Cab cab = new Cab(); 
		cab.setLatitude(77); 
		cab.setLongitude(77);
		cab.persist();
		long countAfter = Cab.countCabs();
        Assert.assertEquals("Persist method for 'Cab' failed", countBefore+1, countAfter);
        
        long id = cab.getId();
        Cab saved = Cab.findCab(id);
        Assert.assertNotNull("Find entries method for 'Cab' illegally returned null", saved);
        long id2 = saved.getId();
        Assert.assertEquals("Persist then find for 'Cab' did not return the same id", id, id2);
        
        Cab cab2 = Cab.fromJsonToCab("{id: "+id+", Latitude: 99, Longitude: 99}");       
        cab.update(cab2);
        Cab merged = cab.merge();
        Assert.assertEquals("Update method for 'Cab' failed", merged.getLatitude(), 99, 0.001);
        Assert.assertEquals("Update method for 'Cab' failed", merged.getLongitude(), 99, 0.001);   
    }	
	
	@Test
    public void testGetDistance() {
        Cab cab = dod.getRandomCab();
        Assert.assertNotNull("Data on demand for 'Cab' failed to initialize correctly", cab);        
        Double dist = Cab.getDistance(cab.getLatitude(), cab.getLongitude(), cab.getLatitude(), cab.getLongitude());
        Assert.assertEquals("Get distance method for 'Cab' failed", dist, 0, 0.000001);
    }
	
	@Test
    public void testGetRelevantCabs() {
        Cab cab = dod.getRandomCab();
        Assert.assertNotNull("Data on demand for 'Cab' failed to initialize correctly", cab);  
        cab.setLatitude(99);
        cab.setLongitude(99);
        
        List<Cab> cabs = Cab.getRelevantCabs(99, 99, 1, 1);
        Assert.assertEquals("Get relevant cabs method for 'Cab' failed", cabs.size(), 1);
    }
}
