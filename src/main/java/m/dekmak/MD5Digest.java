/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package m.dekmak;

import java.security.MessageDigest;

public class MD5Digest {

    public MD5Digest() {

    }

    /*
     admin:  900150983cd24fb0d6963f7d28e17f72
     secret: 5ebe2294ecd0e0f08eab7690d2a6ee69
     123: 202cb962ac59075b964b07152d234b70
     */
    public String generate(String clearText) throws Exception {
        try {
            if (clearText == "") {
                return "String to MD5 digest should be first and only parameter";
            }
            String original = clearText;
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(original.getBytes());
            byte[] digest = md.digest();
            StringBuffer sb = new StringBuffer();
            for (byte b : digest) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();
        } catch (Exception e) {
            return "Exception message" + e.getMessage();
        }

    }

}
