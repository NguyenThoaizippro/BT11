package vn.iotstar.service.impl;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import vn.iotstar.service.EmailService_24110342;

import java.util.Properties;

public class EmailServiceImpl_24110342 implements EmailService_24110342 {

    private static final String DEFAULT_SMTP_HOST = "smtp-relay.brevo.com";
    private static final int DEFAULT_SMTP_PORT = 587;
    private static final String DEFAULT_SMTP_USER = "ae9a68001@smtp-brevo.com";
    private static final String DEFAULT_FROM_EMAIL = "thoain.n2006@gmail.com";
    private static final String DEFAULT_FROM_NAME = "Nhà Sách Đề 01 - Nguyễn Ngọc Thoại (24110342)";

    /** Bí mật KHÔNG hardcode: ưu tiên env SMTP_PASSWORD, sau đó file .env (gitignored). */
    private static final String SMTP_PASSWORD = resolveSmtpPassword();

    private static String resolveSmtpPassword() {
        String env = System.getenv("SMTP_PASSWORD");
        if (env != null && !env.trim().isEmpty()) {
            return env.trim();
        }
        java.io.InputStream[] candidates = new java.io.InputStream[]{
                tryOpen(".env"),
                EmailServiceImpl_24110342.class.getResourceAsStream("/.env")
        };
        for (java.io.InputStream candidate : candidates) {
            if (candidate == null) {
                continue;
            }
            try (java.io.InputStream in = candidate) {
                for (String line : new java.io.BufferedReader(new java.io.InputStreamReader(in, java.nio.charset.StandardCharsets.UTF_8)).lines().toList()) {
                    String trimmed = line.trim();
                    if (trimmed.startsWith("SMTP_PASSWORD=")) {
                        String value = trimmed.substring("SMTP_PASSWORD=".length()).trim();
                        if (!value.isEmpty()) {
                            return value;
                        }
                    }
                }
            } catch (Exception ignored) {
                // chuyển sang ứng viên tiếp theo
            }
        }
        return null;
    }

    private static java.io.InputStream tryOpen(String path) {
        try {
            return new java.io.FileInputStream(path);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public void sendOtp(String toEmail, String otp, String purpose) {
        if (toEmail == null || toEmail.trim().isEmpty()) {
            return;
        }

        // 1. Luôn in ra Terminal để kiểm thử / chấm bài ngoại tuyến
        System.out.println("==========================================================");
        System.out.println("=== [MÃ OTP XÁC THỰC EMAIL]");
        System.out.println("=== Người nhận: " + toEmail);
        System.out.println("=== Mục đích:   " + purpose);
        System.out.println("=== Mã OTP:     " + otp);
        System.out.println("==========================================================");

        // 2. Gửi email THẬT qua giao thức SMTP TLS (Brevo Relay)
        String smtpHost = System.getenv("SMTP_HOST") != null ? System.getenv("SMTP_HOST") : DEFAULT_SMTP_HOST;
        String smtpUser = System.getenv("SMTP_USER") != null ? System.getenv("SMTP_USER") : DEFAULT_SMTP_USER;
        String smtpPass = SMTP_PASSWORD;
        String fromEmail = System.getenv("FROM_EMAIL") != null ? System.getenv("FROM_EMAIL") : DEFAULT_FROM_EMAIL;
        String fromName = DEFAULT_FROM_NAME;

        if (smtpPass == null) {
            System.out.println("=== [SMTP] Không tìm thấy SMTP_PASSWORD (env hoặc file .env) — chỉ in OTP ra console ===");
            return;
        }

        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", smtpHost);
            props.put("mail.smtp.port", String.valueOf(DEFAULT_SMTP_PORT));
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.connectiontimeout", "10000");
            props.put("mail.smtp.timeout", "10000");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(smtpUser, smtpPass);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, fromName, "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail.trim()));
            message.setSubject("[Nhà Sách Đề 01] Mã OTP " + purpose + " - " + otp);

            String contentHtml = "<div style='font-family:Arial,sans-serif;padding:24px;max-width:520px;border:1px solid #dee2e6;border-radius:10px;background-color:#ffffff;'>"
                    + "<div style='text-align:center;margin-bottom:20px;'>"
                    + "<h2 style='color:#0d6efd;margin:0;'>MÃ XÁC THỰC OTP</h2>"
                    + "<p style='color:#6c757d;font-size:14px;margin-top:6px;'>Đề thi Lập Trình Web (Đề số 01) - Nguyễn Ngọc Thoại (24110342)</p>"
                    + "</div>"
                    + "<p style='color:#212529;font-size:15px;'>Xin chào <strong>" + toEmail + "</strong>,</p>"
                    + "<p style='color:#495057;font-size:14px;'>Bạn vừa thực hiện: <strong>" + purpose + "</strong>. Dưới đây là mã OTP xác thực của bạn:</p>"
                    + "<div style='background-color:#f8f9fa;padding:18px;text-align:center;border-radius:8px;margin:24px 0;border:1px dashed #0d6efd;'>"
                    + "<span style='font-size:34px;font-weight:bold;letter-spacing:10px;color:#0d6efd;'>" + otp + "</span>"
                    + "</div>"
                    + "<p style='color:#dc3545;font-size:13px;margin-bottom:8px;'>⚠️ Mã có hiệu lực trong vòng <strong>5 phút</strong>. Vui lòng không chia sẻ mã này cho bất kỳ ai.</p>"
                    + "<hr style='border:none;border-top:1px solid #e9ecef;margin:20px 0;'>"
                    + "<p style='font-size:12px;color:#adb5bd;margin:0;text-align:center;'>Email được gửi tự động từ hệ thống Lập Trình Web – HK1 2026-2027.</p>"
                    + "</div>";

            message.setContent(contentHtml, "text/html; charset=UTF-8");
            Transport.send(message);
            System.out.println("=== [SMTP SUCCESS] Đã gửi email thật thành công đến " + toEmail + " ===");
        } catch (Exception e) {
            System.err.println("=== [SMTP ERROR] Gửi email thất bại: " + e.getMessage() + " (Đã in mã ra console) ===");
        }
    }
}
