package com.example.expenseTrackerService.controller;

import java.util.Optional;
import com.example.expenseTrackerService.entity.ExpenseCategory;
import com.example.expenseTrackerService.repository.ExpenseCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.ResourceNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/categories")
public class ExpenseCategoryController {
    
    @Autowired
    ExpenseCategoryRepository categoriesRepository;

    @RequestMapping
    public ResponseEntity<Object> findCategories() {
        return ResponseEntity.ok(categoriesRepository.findAll());
    }

    @PostMapping
    public ResponseEntity<Object> Insert(@RequestBody ExpenseCategory category){
        return ResponseEntity.ok(categoriesRepository.save(category));
    }

    @RequestMapping("/{id}")
    public ResponseEntity<Object> findCategoryById(@PathVariable long id) {
        Optional<ExpenseCategory> expenseCategory = categoriesRepository.findById(id);
        if (expenseCategory != null) {
            return ResponseEntity.ok(expenseCategory);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @PatchMapping("/{id}")
    public ResponseEntity<ExpenseCategory> updateExpenseCategory(@PathVariable("id") long id, @RequestBody ExpenseCategory expenseCategory) {
        ExpenseCategory foundedCategory = categoriesRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Expense category with id " + id + " not found"));
        foundedCategory.setName(expenseCategory.getName());
        foundedCategory.setIcon(expenseCategory.getIcon());
        foundedCategory.setExpenses(expenseCategory.getExpenses());
        final ExpenseCategory updatedCategory = categoriesRepository.save(foundedCategory);
        return ResponseEntity.ok(updatedCategory);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        categoriesRepository.deleteById(id);
    }
}
