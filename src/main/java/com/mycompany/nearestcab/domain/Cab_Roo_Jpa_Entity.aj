// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.mycompany.nearestcab.domain;

import com.mycompany.nearestcab.domain.Cab;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;

privileged aspect Cab_Roo_Jpa_Entity {
    
    declare @type: Cab: @Entity;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Cab.id;
    
    @Version
    @Column(name = "version")
    private Integer Cab.version;
    
    public Long Cab.getId() {
        return this.id;
    }
    
    public void Cab.setId(Long id) {
        this.id = id;
    }
    
    public Integer Cab.getVersion() {
        return this.version;
    }
    
    public void Cab.setVersion(Integer version) {
        this.version = version;
    }
    
}