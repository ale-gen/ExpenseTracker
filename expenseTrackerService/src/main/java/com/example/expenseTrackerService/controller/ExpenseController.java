package com.example.expenseTrackerService.controller;

import java.util.List;
import java.util.Optional;
import com.example.expenseTrackerService.entity.Expense;
import com.example.expenseTrackerService.entity.ExpenseCategory;
import com.example.expenseTrackerService.repository.ExpenseCategoryRepository;
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

    @Autowired
    ExpenseCategoryRepository categoriesRepository;

    @RequestMapping
    public ResponseEntity<Object> findExpenses() {
        return ResponseEntity.ok(expensesRepository.findAll());
    }

    @PostMapping
    public ResponseEntity<Object> Insert(@RequestBody Expense expense){
        return ResponseEntity.ok(expensesRepository.save(expense));
    }

    @PostMapping("/categoryId={categoryId}")
    public ResponseEntity<Object> Insert(@PathVariable long categoryId, @RequestBody Expense expense){
        Optional<ExpenseCategory> category = categoriesRepository.findById(categoryId);
        if (category != null) {
            List<Expense> expenses = category.get().getExpenses();
            expenses.add(expense);
            category.get().setExpenses(expenses);
            return ResponseEntity.ok(expensesRepository.save(expense));
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @GetMapping("/categoryId={categoryId}")
    public ResponseEntity<Object> findExpensesForCategory(@PathVariable long categoryId) {
        Optional<ExpenseCategory> category = categoriesRepository.findById(categoryId);
        if (category != null) {
            List<Expense> expenses = category.get().getExpenses();
            return ResponseEntity.ok(expenses);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
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
