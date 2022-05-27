package com.example.expenseTrackerService.dto;

public class ExchangeRatesDto {
    public Double converterEUR;
    public Double converterUSD;
    public Double converterPLN;

    public ExchangeRatesDto(Double converterEUR, Double converterUSD, Double convertedPLN) {
        this.converterEUR = converterEUR;
        this.converterUSD = converterUSD;
        this.converterPLN = convertedPLN;
    }

    public ExchangeRatesDto() {
    }
}
