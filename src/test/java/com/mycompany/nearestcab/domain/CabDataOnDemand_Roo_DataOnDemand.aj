// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.mycompany.nearestcab.domain;

import com.mycompany.nearestcab.domain.Cab;
import com.mycompany.nearestcab.domain.CabDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Component;

privileged aspect CabDataOnDemand_Roo_DataOnDemand {
    
    declare @type: CabDataOnDemand: @Component;
    
    private Random CabDataOnDemand.rnd = new SecureRandom();
    
    private List<Cab> CabDataOnDemand.data;
    
    public Cab CabDataOnDemand.getNewTransientCab(int index) {
        Cab obj = new Cab();
        setLatitude(obj, index);
        setLongitude(obj, index);
        return obj;
    }
    
    public void CabDataOnDemand.setLatitude(Cab obj, int index) {
        double latitude = new Integer(index).doubleValue();
        obj.setLatitude(latitude);
    }
    
    public void CabDataOnDemand.setLongitude(Cab obj, int index) {
        double longitude = new Integer(index).doubleValue();
        obj.setLongitude(longitude);
    }
    
    public Cab CabDataOnDemand.getSpecificCab(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Cab obj = data.get(index);
        Long id = obj.getId();
        return Cab.findCab(id);
    }
    
    public Cab CabDataOnDemand.getRandomCab() {
        init();
        Cab obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Cab.findCab(id);
    }
    
    public boolean CabDataOnDemand.modifyCab(Cab obj) {
        return false;
    }
    
    public void CabDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Cab.findCabEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Cab' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Cab>();
        for (int i = 0; i < 10; i++) {
            Cab obj = getNewTransientCab(i);
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
            data.add(obj);
        }
    }
    
}
