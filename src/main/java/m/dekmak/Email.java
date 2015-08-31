/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package m.dekmak;

/**
 *
 * @author mdekmak
 */
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Email {

    public Email() {

    }

    public String send(String toEmail, String content) {
        String response = "";
        final String username = "mohamad.dekmak0912@gmail.com";
        final String password = "is9wiwis";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("mohamad.dekmak0912@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));
            ConfigProperties confProp = new ConfigProperties();
            String appName = confProp.getPropValue("appName");
            message.setSubject("Notification from " + appName);
            message.setText(content);

            Transport.send(message);

            response = "Done";

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
        return response;
    }
}
