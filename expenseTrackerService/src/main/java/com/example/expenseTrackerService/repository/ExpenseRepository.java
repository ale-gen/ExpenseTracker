package com.example.expenseTrackerService.repository;

import com.example.expenseTrackerService.entity.Expense;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource
public interface ExpenseRepository extends JpaRepository<Expense, Long> {
    
}
