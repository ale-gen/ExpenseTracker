package com.example.expenseTrackerService.scrapping.services;

import java.io.IOException;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.example.expenseTrackerService.constants.Constants;
import com.example.expenseTrackerService.dto.ExchangeRatesDto;

import org.springframework.stereotype.Component;

@Component("exchangeRatesService")
public class ExchangeRatesService {
    
    public ExchangeRatesDto retrieveExchangeRates(String baseCurrency) {
        String websiteURL = "https://www.x-rates.com/table/?from=" + baseCurrency + "&amount=1";
        Double converterUsd = 1.0;
        Double converterEur = 1.0;
        Double converterPln = 1.0;

        try {
            Document webPage = Jsoup.connect(websiteURL).get();
            Element tbody = webPage.getElementsByClass("tablesorter ratesTable").first().getElementsByTag("tbody").get(0);
            List<Element> rows = tbody.children().subList(2, tbody.children().size());

            for (Element row : rows) {
                System.out.println(row);
                System.out.println("To byl row.");
                Elements tds = row.getElementsByTag("td");

                if (tds.isEmpty())
                    continue;

                if (tds.size() <= 2)
                    continue;

                String currency = tds.get(0).text();

                if (Constants.availableCurrencies.contains(currency)) {
                    String value = tds.get(1).getElementsByTag("a").first().text();
                    switch (currency) {
                        case Constants.usd:
                            converterUsd = toDoubleOrNull(value);
                            break;
                        case Constants.eur:
                            converterEur = toDoubleOrNull(value);
                            break;
                        case Constants.pln:
                            converterPln = toDoubleOrNull(value);
                            break;
                        default:
                            continue;
                    }
                }
            }
            return new ExchangeRatesDto(converterEur, converterUsd, converterPln);

        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Double toDoubleOrNull(String rate) {
        try {
            return Double.parseDouble(rate);
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
