package handlers

import (
	"context"
	"github.com/gofiber/fiber/v2"
)

func (h *Handlers) getFreeCars(c *fiber.Ctx) error {
	cars, err := h.Repo.GetFreeCars(context.Background())
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "something went wrong",
		})
	}

	return c.Status(fiber.StatusOK).JSON(cars)
}
