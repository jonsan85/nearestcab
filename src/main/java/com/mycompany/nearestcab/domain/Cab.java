package com.mycompany.nearestcab.domain;
import java.util.List;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;

import javax.persistence.Column;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.json.RooJson;
import org.springframework.transaction.annotation.Transactional;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
@RooJson
public class Cab {
	
	static final double earthRadius = 3958.75;
	
    /**
     */
    @NotNull
    private double latitude;

    /**
     */
    @NotNull
    private double longitude;
    
    public void update (Cab clone) {
    	Cab.
    	this.setLatitude(clone.getLatitude());
    	this.setLongitude(clone.getLongitude());
    }
    
    public void update (double latitude, double longitude) {
    	this.setLatitude(latitude);
    	this.setLatitude(longitude);
    
    }
    
	public static double getDistance(double lat1, double lng1, double lat2,
			double lng2) {
		
		double dLat = Math.toRadians(lat2 - lat1);
		double dLng = Math.toRadians(lng2 - lng1);
		double sindLat = Math.sin(dLat / 2);
		double sindLng = Math.sin(dLng / 2);
		double a = Math.pow(sindLat, 2) + Math.pow(sindLng, 2)
				* Math.cos(Math.toRadians(lat1))
				* Math.cos(Math.toRadians(lat2));
		double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		double dist = earthRadius * c;

		return dist;
	}
	
	@Transactional(readOnly = true)
    public static List<Cab> findCabEntriesRO(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM Cab o", Cab.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
}
