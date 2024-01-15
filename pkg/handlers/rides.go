package handlers

import (
	"context"
	"github.com/gofiber/fiber/v2"
	"github.com/gofrs/uuid"
)

func (h *Handlers) getRides(c *fiber.Ctx) error {
	userID := c.Locals("userId").(uuid.UUID)

	rides, err := h.Repo.GetUserRides(context.Background(), userID)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "something went wrong",
		})
	}

	return c.Status(fiber.StatusOK).JSON(rides)
}
