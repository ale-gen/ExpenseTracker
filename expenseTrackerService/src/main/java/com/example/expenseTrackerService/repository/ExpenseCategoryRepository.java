package com.example.expenseTrackerService.repository;

import com.example.expenseTrackerService.entity.ExpenseCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource
public interface ExpenseCategoryRepository extends JpaRepository<ExpenseCategory, Long> {
    
}
