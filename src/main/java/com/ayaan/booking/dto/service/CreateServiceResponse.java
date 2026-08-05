package com.ayaan.booking.dto.service;

import lombok.Builder;
import lombok.Getter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Builder
public class CreateServiceResponse {

    private Long id;

    private String name;

    private String description;

    private Integer durationMinutes;

    private BigDecimal price;

    private Boolean active;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
}