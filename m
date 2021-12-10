Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FB44702E5
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 15:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242169AbhLJOjJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 09:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241946AbhLJOjJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 09:39:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C10C061746
        for <linux-integrity@vger.kernel.org>; Fri, 10 Dec 2021 06:35:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l75-20020a25254e000000b005f763be2fecso16832231ybl.7
        for <linux-integrity@vger.kernel.org>; Fri, 10 Dec 2021 06:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=xLc09WV6Qu2dzEO8WHxbqWb2CklMj2w1g9g/RlmotlE=;
        b=GCwE77RIhPT5+AoF5eq/A+g677ivslfAwc3yi64DLBEaXqNYrHb8e/T8Mv466zwfsg
         iP7lHVQOj7GuS7D4iBL2JEBoeDNkEaxXcCaRN1Fuqz21OK7KOEZorWROLhaKFwe8bW0Z
         aHcywAm+oRwKNXsZNSYs3a1UYQKM1Ow5cH1UcDNXrndt8+/KOep9i2iP5Wc/9n5kEKkY
         PBq4shOnZ95Q8TQY0WC6eWcsYTraBGGiDxGJxeg6JYKvEoTGDYEjE+2wJLb2RWu0OVim
         z/AltvYuIotLPZUUwH9IV51mbWKs/nEMnL6xmMP2RmXIUTcEZRpymsIoTDnbt/Ucsm28
         OQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=xLc09WV6Qu2dzEO8WHxbqWb2CklMj2w1g9g/RlmotlE=;
        b=pZitcQblUWgHo6hFACdr+ody+KGbU/3xfIBCGgbZUSEOcqc5Ve148mtxWIpatgGTt5
         wYKrLru/WNMVQIMixp5SAhcqWHiEe7QjXZaSIhHBs6Kpzf8jR28iZR7X5H19L9WxS3S3
         XeR2OgQjshF/lLDxv7qfbRqtqJFPpFLpN07/rM/zPRUXHiFGGIovgWco3GmgnnxUPvzh
         XSWav2obgMc9IOU1zMIMnptwq8MqGQQz9+rfpxfq4vAkXO5JS89Ad7GTc4z/qMPhyttj
         K/qxHzjnMaFVjOuCtX4qul076FslMgw9/P6CHyeg0FnZK2sGAFLqZbTzbDcN5PGMXSmO
         tDPA==
X-Gm-Message-State: AOAM5336njPFTwgnLvse0tfJ4/lpJCVOl387gFvtDteDgGsK3sbNXRo0
        hVykMqGjRwn33SfujmvotxKSwR+1BrTrhpmWrjs3i5QxGdJ1JnzQAR4TiFZjvG6oi1ebYWTC3z0
        eRBYpwhq6X9Cc3lbbFgSgxYliWhMjppY48KjcfbO3nBEsrMVlYCk3Nja+TBgLsJb6zfsde2o=
X-Google-Smtp-Source: ABdhPJxcUGzlv0vf4fBaLEd8VHYKcvgwciIYUmDntBSdz9kAw5y6fCD/YsE3G+DQzSal447OhyLWyotg/A==
X-Received: from yaelt.nyc.corp.google.com ([2620:0:1003:415:78e8:100b:1fab:e86a])
 (user=yaelt job=sendgmr) by 2002:a25:808c:: with SMTP id n12mr15235156ybk.71.1639146933384;
 Fri, 10 Dec 2021 06:35:33 -0800 (PST)
Date:   Fri, 10 Dec 2021 09:35:31 -0500
Message-Id: <20211210143531.1948911-1-yaelt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] Instantiate key with user-provided decrypted data.
From:   Yael Tiomkin <yaelt@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     Yael Tiomkin <yaelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The encrypted.c class supports instantiation of encrypted keys with
either an already-encrypted key material, or by generating new key
material based on random numbers. To support encryption of
user-provided decrypted data, this patch defines a new datablob
format: [<format>] <master-key name> <decrypted data length>
<decrypted data>.

Signed-off-by: Yael Tiomkin <yaelt@google.com>
---
 .../security/keys/trusted-encrypted.rst       | 25 +++++++---
 security/keys/encrypted-keys/encrypted.c      | 48 +++++++++++++------
 2 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentat=
ion/security/keys/trusted-encrypted.rst
index 80d5a5af62a1..2ea6fad394fe 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -107,12 +107,13 @@ Encrypted Keys
 --------------
=20
 Encrypted keys do not depend on a trust source, and are faster, as they us=
e AES
-for encryption/decryption. New keys are created from kernel-generated rand=
om
-numbers, and are encrypted/decrypted using a specified =E2=80=98master=E2=
=80=99 key. The
-=E2=80=98master=E2=80=99 key can either be a trusted-key or user-key type.=
 The main disadvantage
-of encrypted keys is that if they are not rooted in a trusted key, they ar=
e only
-as secure as the user key encrypting them. The master user key should ther=
efore
-be loaded in as secure a way as possible, preferably early in boot.
+for encryption/decryption. New keys are created either from kernel-generat=
ed
+random numbers or user-provided decrypted data, and are encrypted/decrypte=
d
+using a specified =E2=80=98master=E2=80=99 key. The =E2=80=98master=E2=80=
=99 key can either be a trusted-key or
+user-key type. The main disadvantage of encrypted keys is that if they are=
 not
+rooted in a trusted key, they are only as secure as the user key encryptin=
g
+them. The master user key should therefore be loaded in as secure a way as
+possible, preferably early in boot.
=20
=20
 Usage
@@ -199,6 +200,8 @@ Usage::
=20
     keyctl add encrypted name "new [format] key-type:master-key-name keyle=
n"
         ring
+    keyctl add encrypted name "new [format] key-type:master-key-name keyle=
n
+        decrypted-data" ring
     keyctl add encrypted name "load hex_blob" ring
     keyctl update keyid "update key-type:master-key-name"
=20
@@ -303,6 +306,16 @@ Load an encrypted key "evm" from saved blob::
     82dbbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564=
e0
     24717c64 5972dcb82ab2dde83376d82b2e3c09ffc
=20
+Instantiate an encrypted key "evm" using user-provided decrypted data::
+
+    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm.blob`" @u
+    794890253
+
+    $ keyctl print 794890253
+    default user:kmk 32 2375725ad57798846a9bbd240de8906f006e66c03af53b1b38=
2d
+    bbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e02=
47
+    17c64 5972dcb82ab2dde83376d82b2e3c09ffc
+
 Other uses for trusted and encrypted keys, such as for disk and file encry=
ption
 are anticipated.  In particular the new format 'ecryptfs' has been defined
 in order to use encrypted keys to mount an eCryptfs filesystem.  More deta=
ils
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encry=
pted-keys/encrypted.c
index 87432b35d771..af32c8a07dbc 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -159,6 +159,7 @@ static int valid_master_desc(const char *new_desc, cons=
t char *orig_desc)
  *
  * datablob format:
  * new [<format>] <master-key name> <decrypted data length>
+ * new [<format>] <master-key name> <decrypted data length> <decrypted dat=
a>
  * load [<format>] <master-key name> <decrypted data length>
  *     <encrypted iv + data>
  * update <new-master-key name>
@@ -170,7 +171,7 @@ static int valid_master_desc(const char *new_desc, cons=
t char *orig_desc)
  */
 static int datablob_parse(char *datablob, const char **format,
 			  char **master_desc, char **decrypted_datalen,
-			  char **hex_encoded_iv)
+			  char **hex_encoded_iv, char **decrypted_data)
 {
 	substring_t args[MAX_OPT_ARGS];
 	int ret =3D -EINVAL;
@@ -231,6 +232,17 @@ static int datablob_parse(char *datablob, const char *=
*format,
 				"when called from .update method\n", keyword);
 			break;
 		}
+		*decrypted_data =3D strsep(&datablob, " \t");
+		if (decrypted_data) {
+			if (strlen(decrypted_data) !=3D decrypted_datalen) {
+				pr_info("encrypted_key: decrypted data provided does not match decrypt=
ed data length provided\n");
+				break;
+			}
+			if (!isalnum(decrypted_data)) {
+				pr_info("encrypted_key: decrypted data provided must be alphanumeric\n=
");
+				break;
+			}
+		}
 		ret =3D 0;
 		break;
 	case Opt_load:
@@ -740,13 +752,14 @@ static void __ekey_init(struct encrypted_key_payload =
*epayload,
 /*
  * encrypted_init - initialize an encrypted key
  *
- * For a new key, use a random number for both the iv and data
- * itself.  For an old key, decrypt the hex encoded data.
+ * For a new key, use either a random number or user-provided decrypted da=
ta in
+ * case it is provided. A random number is used for the iv in both cases. =
For
+ * an old key, decrypt the hex encoded data.
  */
 static int encrypted_init(struct encrypted_key_payload *epayload,
 			  const char *key_desc, const char *format,
 			  const char *master_desc, const char *datalen,
-			  const char *hex_encoded_iv)
+			  const char *hex_encoded_iv, const char *decrypted_data)
 {
 	int ret =3D 0;
=20
@@ -760,21 +773,25 @@ static int encrypted_init(struct encrypted_key_payloa=
d *epayload,
 	}
=20
 	__ekey_init(epayload, format, master_desc, datalen);
-	if (!hex_encoded_iv) {
-		get_random_bytes(epayload->iv, ivsize);
-
-		get_random_bytes(epayload->decrypted_data,
-				 epayload->decrypted_datalen);
-	} else
+	if (hex_encoded_iv) {
 		ret =3D encrypted_key_decrypt(epayload, format, hex_encoded_iv);
+	} else if (decrypted_data) {
+		get_random_bytes(epayload->iv, ivsize);
+		memcpy(epayload->decrypted_data, decrypted_data, epayload->decrypted_dat=
alen);
+	} else {
+		get_random_bytes(epayload->iv, ivsize);
+		get_random_bytes(epayload->decrypted_data, epayload->decrypted_datalen);
+	}
 	return ret;
 }
=20
 /*
  * encrypted_instantiate - instantiate an encrypted key
  *
- * Decrypt an existing encrypted datablob or create a new encrypted key
- * based on a kernel random number.
+ * Instantiates the key:
+ * - by decrypting an existing encrypted datablob, or
+ * - by creating a new encrypted key based on a kernel random number, or
+ * - using provided decrypted data.
  *
  * On success, return 0. Otherwise return errno.
  */
@@ -787,6 +804,7 @@ static int encrypted_instantiate(struct key *key,
 	char *master_desc =3D NULL;
 	char *decrypted_datalen =3D NULL;
 	char *hex_encoded_iv =3D NULL;
+	char *decrypted_data =3D NULL;
 	size_t datalen =3D prep->datalen;
 	int ret;
=20
@@ -799,7 +817,7 @@ static int encrypted_instantiate(struct key *key,
 	datablob[datalen] =3D 0;
 	memcpy(datablob, prep->data, datalen);
 	ret =3D datablob_parse(datablob, &format, &master_desc,
-			     &decrypted_datalen, &hex_encoded_iv);
+			     &decrypted_datalen, &hex_encoded_iv, &decrypted_data);
 	if (ret < 0)
 		goto out;
=20
@@ -810,7 +828,7 @@ static int encrypted_instantiate(struct key *key,
 		goto out;
 	}
 	ret =3D encrypted_init(epayload, key->description, format, master_desc,
-			     decrypted_datalen, hex_encoded_iv);
+			     decrypted_datalen, hex_encoded_iv, decrypted_data);
 	if (ret < 0) {
 		kfree_sensitive(epayload);
 		goto out;
@@ -860,7 +878,7 @@ static int encrypted_update(struct key *key, struct key=
_preparsed_payload *prep)
=20
 	buf[datalen] =3D 0;
 	memcpy(buf, prep->data, datalen);
-	ret =3D datablob_parse(buf, &format, &new_master_desc, NULL, NULL);
+	ret =3D datablob_parse(buf, &format, &new_master_desc, NULL, NULL, NULL);
 	if (ret < 0)
 		goto out;
=20
--=20
2.34.1.173.g76aa8bc2d0-goog

