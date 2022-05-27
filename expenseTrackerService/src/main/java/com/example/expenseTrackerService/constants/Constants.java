package com.example.expenseTrackerService.constants;

import java.util.Arrays;
import java.util.List;

public class Constants {
    public static final String usd = "US Dollar";
    public static final String eur = "Euro";
    public static final String pln = "Polish Zloty";

    public static List<String> availableCurrencies = Arrays.asList(new String[]{usd, pln, eur});
}
