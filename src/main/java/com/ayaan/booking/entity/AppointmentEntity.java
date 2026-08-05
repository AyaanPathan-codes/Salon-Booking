package com.ayaan.booking.entity;

import com.ayaan.booking.enums.AppointmentStatus;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalTime;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)

@Entity
@Table(
        name = "appointments",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "uq_appointments_date_start_time",
                        columnNames = {
                                "appointment_date",
                                "start_time"
                        }
                )
        }
)
public class AppointmentEntity extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(
            name = "customer_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_appointments_customer")
    )
    private CustomerEntity customer;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(
            name = "service_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_appointments_service")
    )
    private ServiceEntity ServiceEntity;

    @Column(
            name = "appointment_date",
            nullable = false
    )
    private LocalDate appointmentDate;

    @Column(
            name = "start_time",
            nullable = false
    )
    private LocalTime startTime;

    @Column(
            name = "end_time",
            nullable = false
    )
    private LocalTime endTime;

    @Enumerated(EnumType.STRING)
    @Column(
            nullable = false
    )
    private AppointmentStatus status;

    @Column(
            columnDefinition = "TEXT"
    )
    private String notes;
}