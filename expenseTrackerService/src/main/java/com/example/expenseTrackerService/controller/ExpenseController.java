package com.example.expenseTrackerService.controller;

import java.util.Optional;
import com.example.expenseTrackerService.entity.Expense;
import com.example.expenseTrackerService.repository.ExpenseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.ResourceNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/expenses")
public class ExpenseController {
    @Autowired
    ExpenseRepository expensesRepository;

    @RequestMapping
    public ResponseEntity<Object> findExpenses() {
        return ResponseEntity.ok(expensesRepository.findAll());
    }

    @PostMapping
    public ResponseEntity<Object> Insert(@RequestBody Expense expense){
        return ResponseEntity.ok(expensesRepository.save(expense));
    }

    @RequestMapping("/{id}")
    public ResponseEntity<Object> findExpenseById(@PathVariable long id) {
        Optional<Expense> expense = expensesRepository.findById(id);
        if (expense != null) {
            return ResponseEntity.ok(expense);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @PatchMapping("/{id}")
    public ResponseEntity<Expense> updateExpense(@PathVariable("id") long id, @RequestBody Expense expense) {
        Expense foundedExpense = expensesRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Expense with id " + id + " not found"));
        foundedExpense.setName(expense.getName());
        foundedExpense.setAmount(expense.getAmount());
        foundedExpense.setCurrency(expense.getCurrency());
        foundedExpense.setExpenseDate(expense.getExpenseDate());
        foundedExpense.setUnnecessary(expense.isUnnecessary());
        final Expense updatedExpense = expensesRepository.save(foundedExpense);
        return ResponseEntity.ok(updatedExpense);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        expensesRepository.deleteById(id);
    }
}
