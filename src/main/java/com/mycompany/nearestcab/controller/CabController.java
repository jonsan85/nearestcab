package com.mycompany.nearestcab.controller;

import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

import com.mycompany.nearestcab.domain.Cab;

@RequestMapping("/cabs")
@Controller
@RooWebScaffold(path = "cabs", formBackingObject = Cab.class)
public class CabController {

	@RequestMapping(value = "/{id}", method = RequestMethod.GET, headers = "Accept=application/json")
	@ResponseBody
	public Object showJson(@PathVariable("id") Long id) {
		Cab cab = Cab.findCab(id);
		if (cab == null) {
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		return cab.toJson();
	}

	@RequestMapping(method = RequestMethod.GET, headers = "Accept=application/json")
	@ResponseBody
	public String listJson(
			@RequestParam(value = "latitude", required = true) Double latitude,
			@RequestParam(value = "longitude", required = true) Double longitude,
			@RequestParam(value = "limit", required = false) Integer limit,
			@RequestParam(value = "radius", required = false) Double radius) {
		
		return Cab.toJsonArray(Cab.getRelevantCabs(latitude, longitude, limit, radius));
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT, headers = "Accept=application/json")
	public ResponseEntity<String> updateFromJson(@RequestBody String json,
			@PathVariable("id") Long id) {
		Cab cab = Cab.findCab(id);
		if (cab == null) {

			// return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
			// Instead of not found, we create it
			Cab.fromJsonToCab(json).persist();
			return new ResponseEntity<String>(HttpStatus.OK);

		}
		cab.update(Cab.fromJsonToCab(json));
		cab.merge();
		return new ResponseEntity<String>(HttpStatus.OK);
	}

	@RequestMapping(method = RequestMethod.PUT, headers = "Accept=application/json")
	public ResponseEntity<String> updateFromJsonArray(@RequestBody String json) {
		for (Cab cab : Cab.fromJsonArrayToCabs(json)) {
			Cab orig = Cab.findCab(cab.getId());
			if (orig == null) {
				cab.persist();
			} else {
				orig.update(cab);
				orig.merge();
			}
		}
		return new ResponseEntity<String>(HttpStatus.OK);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE, headers = "Accept=application/json")
	public ResponseEntity<String> deleteFromJson(@PathVariable("id") Long id) {
		Cab cab = Cab.findCab(id);
		if (cab == null) {
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		cab.remove();
		return new ResponseEntity<String>(HttpStatus.OK);
	}

	@RequestMapping(method = RequestMethod.DELETE, headers = "Accept=application/json")
	public ResponseEntity<String> deleteAll() {
		for (Cab cab : Cab.findAllCabs()) {
			cab.remove();
		}
		return new ResponseEntity<String>(HttpStatus.OK);
	}

}
