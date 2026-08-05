package com.ayaan.booking.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)

@Entity
@Table(
        name = "services",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "uq_services_name",
                        columnNames = "name"
                )
        }
)
public class ServiceEntity extends com.ayaan.booking.entity.BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(
            nullable = false,
            length = 100
    )
    private String name;

    @Column(
            columnDefinition = "TEXT"
    )
    private String description;

    @Column(
            name = "duration_minutes",
            nullable = false
    )
    private Integer durationMinutes;

    @Column(
            nullable = false,
            precision = 10,
            scale = 2
    )
    private BigDecimal price;

    @Column(
            nullable = false
    )
    @Builder.Default
    private Boolean active = true;
}