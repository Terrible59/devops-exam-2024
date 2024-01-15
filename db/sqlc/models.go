// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.17.2

package db

import (
	"github.com/gofrs/uuid"
	"github.com/guregu/null"
)

type Car struct {
	ID                 uuid.UUID   `json:"id"`
	Model              null.String `json:"model"`
	RegistrationNumber null.String `json:"registration_number"`
	FuelLevel          null.Int    `json:"fuel_level"`
	IsReserve          bool        `json:"is_reserve"`
}

type Ride struct {
	ID        uuid.UUID `json:"id"`
	UserID    uuid.UUID `json:"user_id"`
	CarID     uuid.UUID `json:"car_id"`
	CreatedAt null.Time `json:"created_at"`
}

type Token struct {
	ID        uuid.UUID `json:"id"`
	Token     string    `json:"token"`
	UserID    uuid.UUID `json:"user_id"`
	CreatedAt null.Time `json:"created_at"`
	ExpiresAt null.Time `json:"expires_at"`
}

type User struct {
	ID        uuid.UUID `json:"id"`
	Email     string    `json:"email"`
	Password  string    `json:"password"`
	Role      int32     `json:"role"`
	CreatedAt null.Time `json:"created_at"`
}
