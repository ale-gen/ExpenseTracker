package com.example.expenseTrackerService.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "expenses")
public class Expense implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @NotBlank(message = "Name is mandatory")
    private String name;

    @NotNull(message = "Amount is mandatory")
    private double amount;

    @NotBlank(message = "Currency is mandatory")
    private String currency;

    private Date expenseDate;

    private boolean unnecessary;

    @ManyToOne
    private ExpenseCategory category;

    public Expense() {}

    public Expense(String name, double amount, String currency, Date expenseDate, boolean unnecessary) {
        this.name = name;
        this.amount = amount;
        this.currency = currency;
        this.expenseDate = expenseDate;
        this.unnecessary = unnecessary;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public Date getExpenseDate() {
        return expenseDate;
    }

    public void setExpenseDate(Date expenseDate) {
        this.expenseDate = expenseDate;
    }

    public boolean isUnnecessary() {
        return unnecessary;
    }

    public void setUnnecessary(boolean unnecessary) {
        this.unnecessary = unnecessary;
    }

    @Override
    public String toString() {
        return "Expense: " + id + "\nName: " + name + "\nAmount: " + amount + "\nCurrency: " 
        + currency + "\nExpense date: " + expenseDate + "\nUnnecessary: " + unnecessary;
    }

}

