package com.example.expenseTrackerService.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.expenseTrackerService.dto.ExchangeRatesDto;
import com.example.expenseTrackerService.scrapping.services.ExchangeRatesService;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/exchangeRates")
public class ExchangeRatesController {

    @Autowired
    private ExchangeRatesService exchangeRatesService;

    @GetMapping("/for={baseCurrency}")
    public ResponseEntity<ExchangeRatesDto> getCovidData(@PathVariable String baseCurrency) {
        return new ResponseEntity<ExchangeRatesDto>(exchangeRatesService.retrieveExchangeRates(baseCurrency), HttpStatus.OK);
    }
}
