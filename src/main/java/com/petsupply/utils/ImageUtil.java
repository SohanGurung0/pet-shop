package com.petsupply.utils;

import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;

/**
 * Utility class for handling product image file uploads.
 *
 * <p>Provides methods to upload image files to an external
 * folder and delete previously uploaded images.
 * Supported formats: JPG, JPEG, PNG.</p>
 *
 * <p><strong>Note:</strong> Files are stored in
 * {@code ~/pet-supply-uploads/} (outside the project).
 * They persist across {@code mvn clean} rebuilds.</p>
 */
public class ImageUtil {

    /** The external folder where uploaded images are stored. */
    private static final String UPLOAD_FOLDER = "pet-supply-uploads";

    /** The default fallback image path (static asset inside the project). */
    private static final String DEFAULT_IMAGE = "images/default-product.png";

    /**
     * Saves an uploaded image file to the external uploads folder.
     *
     * <p>Validates the file extension (only .jpg, .jpeg, .png allowed)
     * and generates a unique filename using a timestamp prefix to
     * prevent collisions.</p>
     *
     * @param imagePart the file part from the multipart form submission
     * @return the filename (e.g., "2026-05-03_cat.jpg"),
     *         or {@code null} if the file is invalid or the upload fails
     */
    public static String uploadImage(Part imagePart) {
        if (imagePart == null) {
            return null;
        }

        String fileName = imagePart.getSubmittedFileName();
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }

        // Validate file extension
        String extension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
        if (!extension.equals(".jpg") && !extension.equals(".jpeg") && !extension.equals(".png")) {
            return null;
        }

        // Generate unique filename with timestamp
        String uniqueName = LocalDateTime.now().toString().replace(":", "-") + "_" + fileName;

        // Create upload directory if it doesn't exist
        String uploadPath = System.getProperty("user.home") + File.separator + UPLOAD_FOLDER;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            imagePart.write(uploadPath + File.separator + uniqueName);
            return uniqueName;
        } catch (IOException e) {
            System.out.println("Error uploading image: " + e.getMessage());
            return null;
        }
    }

    /**
     * Deletes a previously uploaded image file from the external folder.
     *
     * <p>Safely skips deletion if the path is null, empty, or points
     * to the default fallback image or any static asset path
     * (paths starting with "images/").</p>
     *
     * @param imagePath the filename of the image to delete
     */
    public static void deleteImage(String imagePath) {
        if (imagePath == null || imagePath.isEmpty()) {
            return;
        }
        // Don't delete static assets bundled in the project
        if (imagePath.startsWith("images/")) {
            return;
        }
        if (imagePath.equals(DEFAULT_IMAGE)) {
            return;
        }

        String uploadPath = System.getProperty("user.home") + File.separator + UPLOAD_FOLDER;
        File file = new File(uploadPath + File.separator + imagePath);
        if (file.exists()) {
            file.delete();
        }
    }

    /**
     * Checks whether an image path refers to an uploaded file
     * (stored externally) rather than a static asset bundled in the project.
     *
     * @param imagePath the image path to check
     * @return {@code true} if the image is an uploaded file, {@code false} otherwise
     */
    public static boolean isUploadedImage(String imagePath) {
        if (imagePath == null || imagePath.isEmpty()) {
            return false;
        }
        // Static assets start with "images/" — uploaded files don't
        return !imagePath.startsWith("images/");
    }
}
