package com.bookleaf.app.service;

import com.bookleaf.app.model.*;
import org.springframework.stereotype.Service;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;


@Service
public class FileHandlingService {

    private static final String DATA_DIR = "src/data/";
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");


    private void ensureDirectoryExists() {
        File dir = new File(DATA_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }


    public synchronized void writeUsersToFile(List<User> users) {
        ensureDirectoryExists();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + "users.txt"))) {
            writer.write("=== BookLeaf Users Database ===");
            writer.newLine();
            writer.write("Generated: " + LocalDateTime.now().format(FORMATTER));
            writer.newLine();
            writer.write("Total Records: " + users.size());
            writer.newLine();
            writer.write("================================================");
            writer.newLine();
            writer.newLine();

            for (User user : users) {
                writer.write("ID: " + user.getId());
                writer.newLine();
                writer.write("Name: " + user.getFullName());
                writer.newLine();
                writer.write("Email: " + user.getEmail());
                writer.newLine();
                writer.write("Phone: " + (user.getPhone() != null ? user.getPhone() : "N/A"));
                writer.newLine();
                writer.write("Role: " + user.getRole());
                writer.newLine();
                writer.write("Approved: " + (user.isApproved() ? "Yes" : "Pending"));
                writer.newLine();
                writer.write("Created: " + (user.getCreatedAt() != null ? user.getCreatedAt().format(FORMATTER) : "N/A"));
                writer.newLine();
                writer.write("------------------------------------------------");
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing users file: " + e.getMessage());
        }
    }

    /**
     * Write all books to books.txt
     */
    public synchronized void writeBooksToFile(List<Book> books) {
        ensureDirectoryExists();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + "books.txt"))) {
            writer.write("=== BookLeaf Books Catalog ===");
            writer.newLine();
            writer.write("Generated: " + LocalDateTime.now().format(FORMATTER));
            writer.newLine();
            writer.write("Total Records: " + books.size());
            writer.newLine();
            writer.write("================================================");
            writer.newLine();
            writer.newLine();

            for (Book book : books) {
                writer.write("ID: " + book.getId());
                writer.newLine();
                writer.write("Title: " + book.getTitle());
                writer.newLine();
                writer.write("ISBN: " + (book.getIsbn() != null ? book.getIsbn() : "N/A"));
                writer.newLine();
                writer.write("Category: " + (book.getCategory() != null ? book.getCategory() : "N/A"));
                writer.newLine();
                writer.write("Price: LKR " + String.format("%.2f", book.getPrice()));
                writer.newLine();
                writer.write("Quantity: " + book.getQuantity());
                writer.newLine();
                writer.write("Author: " + (book.getAuthor() != null ? book.getAuthor().getName() : "Unknown"));
                writer.newLine();
                writer.write("E-Book: " + (book.isHasEbook() ? "Available" : "Not Available"));
                writer.newLine();
                writer.write("------------------------------------------------");
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing books file: " + e.getMessage());
        }
    }

    public synchronized void writeAuthorsToFile(List<Author> authors) {
        ensureDirectoryExists();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + "authors.txt"))) {
            writer.write("=== BookLeaf Authors Directory ===");
            writer.newLine();
            writer.write("Generated: " + LocalDateTime.now().format(FORMATTER));
            writer.newLine();
            writer.write("Total Records: " + authors.size());
            writer.newLine();
            writer.write("================================================");
            writer.newLine();
            writer.newLine();

            for (Author author : authors) {
                writer.write("ID: " + author.getId());
                writer.newLine();
                writer.write("Name: " + author.getName());
                writer.newLine();
                writer.write("Bio: " + (author.getBio() != null ? author.getBio() : "N/A"));
                writer.newLine();
                writer.write("Linked User: " + (author.getUser() != null ? author.getUser().getEmail() : "Admin-created"));
                writer.newLine();
                writer.write("------------------------------------------------");
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing authors file: " + e.getMessage());
        }
    }


    public synchronized void writeOrdersToFile(List<Order> orders) {
        ensureDirectoryExists();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + "orders.txt"))) {
            writer.write("=== BookLeaf Orders Record ===");
            writer.newLine();
            writer.write("Generated: " + LocalDateTime.now().format(FORMATTER));
            writer.newLine();
            writer.write("Total Records: " + orders.size());
            writer.newLine();
            writer.write("================================================");
            writer.newLine();
            writer.newLine();

            for (Order order : orders) {
                writer.write("Order ID: " + order.getId());
                writer.newLine();
                writer.write("Customer: " + order.getUser().getFullName());
                writer.newLine();
                writer.write("Total: LKR " + String.format("%.2f", order.getTotalAmount()));
                writer.newLine();
                writer.write("Payment: " + order.getPaymentMethod());
                writer.newLine();
                writer.write("Status: " + order.getOrderStatus());
                writer.newLine();
                writer.write("Date: " + (order.getCreatedAt() != null ? order.getCreatedAt().format(FORMATTER) : "N/A"));
                writer.newLine();
                if (order.getItems() != null) {
                    for (OrderItem item : order.getItems()) {
                        writer.write("  - " + item.getBook().getTitle() + " x" + item.getQuantity()
                                + " (" + item.getFormat() + ") = LKR " + String.format("%.2f", item.getSubtotal()));
                        writer.newLine();
                    }
                }
                writer.write("------------------------------------------------");
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing orders file: " + e.getMessage());
        }
    }

    public synchronized void writeReviewsToFile(List<Review> reviews) {
        ensureDirectoryExists();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + "reviews.txt"))) {
            writer.write("=== BookLeaf Reviews Record ===");
            writer.newLine();
            writer.write("Generated: " + LocalDateTime.now().format(FORMATTER));
            writer.newLine();
            writer.write("Total Records: " + reviews.size());
            writer.newLine();
            writer.write("================================================");
            writer.newLine();
            writer.newLine();

            for (Review review : reviews) {
                writer.write("Review ID: " + review.getId());
                writer.newLine();
                writer.write("Book: " + review.getBook().getTitle());
                writer.newLine();
                writer.write("User: " + review.getUser().getFullName());
                writer.newLine();
                writer.write("Rating: " + review.getRating() + "/5");
                writer.newLine();
                writer.write("Comment: " + (review.getComment() != null ? review.getComment() : "No comment"));
                writer.newLine();
                writer.write("Date: " + (review.getCreatedAt() != null ? review.getCreatedAt().format(FORMATTER) : "N/A"));
                writer.newLine();
                writer.write("------------------------------------------------");
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing reviews file: " + e.getMessage());
        }
    }

    /**
     * Write wishlist items to wishlist.txt for a specific user
     */
    public synchronized void writeWishlistToFile(List<WishlistItem> items, User user) {
        ensureDirectoryExists();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + "wishlist_" + user.getId() + ".txt"))) {
            writer.write("=== BookLeaf Wishlist - " + user.getFullName() + " ===");
            writer.newLine();
            writer.write("Generated: " + LocalDateTime.now().format(FORMATTER));
            writer.newLine();
            writer.write("Total Items: " + items.size());
            writer.newLine();
            writer.write("================================================");
            writer.newLine();
            writer.newLine();

            for (WishlistItem item : items) {
                writer.write("Book: " + item.getBook().getTitle());
                writer.newLine();
                writer.write("Author: " + (item.getBook().getAuthor() != null ? item.getBook().getAuthor().getName() : "Unknown"));
                writer.newLine();
                writer.write("Price: LKR " + String.format("%.2f", item.getBook().getPrice()));
                writer.newLine();
                writer.write("Added: " + (item.getAddedAt() != null ? item.getAddedAt().format(FORMATTER) : "N/A"));
                writer.newLine();
                writer.write("------------------------------------------------");
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing wishlist file: " + e.getMessage());
        }
    }

    /**
     * Write all discounts to discounts.txt
     */
    public synchronized void writeDiscountsToFile(List<Discount> discounts) {
        ensureDirectoryExists();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + "discounts.txt"))) {
            writer.write("=== BookLeaf Discounts Record ===");
            writer.newLine();
            writer.write("Generated: " + LocalDateTime.now().format(FORMATTER));
            writer.newLine();
            writer.write("Total Records: " + discounts.size());
            writer.newLine();
            writer.write("================================================");
            writer.newLine();
            writer.newLine();

            for (Discount discount : discounts) {
                writer.write("ID: " + discount.getId());
                writer.newLine();
                writer.write("Name: " + discount.getName());
                writer.newLine();
                writer.write("Type: " + discount.getDiscountType());
                writer.newLine();
                writer.write("Percentage: " + discount.getPercentage() + "%");
                writer.newLine();
                writer.write("Active: " + (discount.isActive() ? "Yes" : "No"));
                writer.newLine();
                if (discount.getStartDate() != null) {
                    writer.write("Start Date: " + discount.getStartDate());
                    writer.newLine();
                }
                if (discount.getEndDate() != null) {
                    writer.write("End Date: " + discount.getEndDate());
                    writer.newLine();
                }
                if (discount.getPriceCap() != null) {
                    writer.write("Price Cap: LKR " + String.format("%.2f", discount.getPriceCap()));
                    writer.newLine();
                }
                writer.write("Description: " + (discount.getDescription() != null ? discount.getDescription() : "N/A"));
                writer.newLine();
                writer.write("------------------------------------------------");
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing discounts file: " + e.getMessage());
        }
    }

    public synchronized void writeQueriesToFile(List<Query> queries) {
        ensureDirectoryExists();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + "queries.txt"))) {
            writer.write("=== BookLeaf Support Queries Record ===");
            writer.newLine();
            writer.write("Generated: " + LocalDateTime.now().format(FORMATTER));
            writer.newLine();
            writer.write("Total Records: " + queries.size());
            writer.newLine();
            writer.write("================================================");
            writer.newLine();
            writer.newLine();

            for (Query query : queries) {
                writer.write("Query ID: " + query.getId());
                writer.newLine();
                writer.write("Subject: " + query.getSubject());
                writer.newLine();
                writer.write("Customer: " + (query.getUser() != null ? query.getUser().getFullName() : "Unknown"));
                writer.newLine();
                writer.write("Status: " + query.getStatus());
                writer.newLine();
                writer.write("Created: " + (query.getCreatedAt() != null ? query.getCreatedAt().format(FORMATTER) : "N/A"));
                writer.newLine();
                writer.write("Message: " + query.getMessage());
                writer.newLine();
                if (query.getReplies() != null && !query.getReplies().isEmpty()) {
                    writer.write("Replies:");
                    writer.newLine();
                    for (QueryMessage msg : query.getReplies()) {
                        writer.write("  [" + msg.getSender().getRole() + "] " + msg.getSender().getFullName() + ": " + msg.getMessage());
                        writer.newLine();
                    }
                }
                writer.write("------------------------------------------------");
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing queries file: " + e.getMessage());
        }
    }

    public synchronized void writeNotificationsToFile(List<Notification> notifications) {
        ensureDirectoryExists();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + "notifications.txt"))) {
            writer.write("=== BookLeaf System Notifications Record ===");
            writer.newLine();
            writer.write("Generated: " + LocalDateTime.now().format(FORMATTER));
            writer.newLine();
            writer.write("Total Records: " + notifications.size());
            writer.newLine();
            writer.write("================================================");
            writer.newLine();
            writer.newLine();

            for (Notification n : notifications) {
                writer.write("Notification ID: " + n.getId());
                writer.newLine();
                writer.write("Recipient: " + (n.getUser() != null ? n.getUser().getFullName() : "System"));
                writer.newLine();
                writer.write("Message: " + n.getMessage());
                writer.newLine();
                writer.write("Type: " + n.getType());
                writer.newLine();
                writer.write("Target URL: " + n.getTargetUrl());
                writer.newLine();
                writer.write("Status: " + (n.isRead() ? "Read" : "Unread"));
                writer.newLine();
                writer.write("Created: " + (n.getCreatedAt() != null ? n.getCreatedAt().format(FORMATTER) : "N/A"));
                writer.newLine();
                writer.write("------------------------------------------------");
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing notifications file: " + e.getMessage());
        }
    }

    public String readFromFile(String filename) {
        ensureDirectoryExists();
        StringBuilder content = new StringBuilder();
        File file = new File(DATA_DIR + filename);
        if (!file.exists()) return "File not found: " + filename;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line).append("\n");
            }
        } catch (IOException e) {
            System.err.println("Error reading file: " + e.getMessage());
        }
        return content.toString();
    }
}
        // DEBUG: temporary verify point for this module
        // DEBUG: temporary verify point for this module
