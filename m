Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9D48ACB1
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jan 2022 12:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349661AbiAKLiG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jan 2022 06:38:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34626 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbiAKLiA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jan 2022 06:38:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 87B8B21639;
        Tue, 11 Jan 2022 11:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641901078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nnudm31TWLhKvg8iKBvA1bfNToyh2dvEbi+Aqj3JOf0=;
        b=Fp+F/vKcFMIPQuUQo8UVNYTohpH+hIN5v1sf3mvXCWYdHNhkYzinY1elREcV4EAoB2XrU6
        w2s4w4eM6vF23rHLly3Thnnn0hO/93uEQ4XB3IwNPW+WsrvbrFTAcuNCfdHfprvBEaNnhb
        E9kPOPr5vwJdhr6w0HzffkSX82F0lPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641901078;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nnudm31TWLhKvg8iKBvA1bfNToyh2dvEbi+Aqj3JOf0=;
        b=fAw0JhWNwop5nDbpxOR5hDu1JdKpGwH7AXDTV128GOp5d8eA8ZaWvQxIzuH9ztG3pbiEh0
        VT07iLtEGTaYHwAA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 3A301A3B92;
        Tue, 11 Jan 2022 11:37:58 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 6/6] module: Move duplicate mod_check_sig users code to mod_parse_sig
Date:   Tue, 11 Jan 2022 12:37:48 +0100
Message-Id: <687db74a714d50b9c83d7ac024da4f7dec0d9a1d.1641900831.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641900831.git.msuchanek@suse.de>
References: <cover.1641900831.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Multiple users of mod_check_sig check for the marker, then call
mod_check_sig, extract signature length, and remove the signature.

Put this code in one place together with mod_check_sig.

This changes the error from ENOENT to ENODATA for ima_read_modsig in the
case the signature marker is missing.

This also changes the buffer length in ima_read_modsig from size_t to
unsigned long. This reduces the possible value range on 32bit but the
length refers to kernel in-memory buffer which cannot be longer than
ULONG_MAX.

Also change mod_check_sig to unsigned long while at it.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v3: - Philipp Rudo <prudo@redhat.com>: Update the commit with note about
      change of raturn value
    - Preserve the EBADMSG error code while moving code araound
v4: - remove unused variable ms in module_signing.c
    - note about buffer length
v5: - also change the functions in module_signature.c to unsigned long
---
 include/linux/module_signature.h    |  4 +-
 kernel/module_signature.c           | 58 ++++++++++++++++++++++++++++-
 kernel/module_signing.c             | 27 ++------------
 security/integrity/ima/ima_modsig.c | 22 ++---------
 4 files changed, 66 insertions(+), 45 deletions(-)

diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
index 7eb4b00381ac..e5fb157c085c 100644
--- a/include/linux/module_signature.h
+++ b/include/linux/module_signature.h
@@ -40,7 +40,9 @@ struct module_signature {
 	__be32	sig_len;	/* Length of signature data */
 };
 
-int mod_check_sig(const struct module_signature *ms, size_t file_len,
+int mod_check_sig(const struct module_signature *ms, unsigned long file_len,
+		  const char *name);
+int mod_parse_sig(const void *data, unsigned long *len, unsigned long *sig_len,
 		  const char *name);
 
 #endif /* _LINUX_MODULE_SIGNATURE_H */
diff --git a/kernel/module_signature.c b/kernel/module_signature.c
index 00132d12487c..4a36405ecd08 100644
--- a/kernel/module_signature.c
+++ b/kernel/module_signature.c
@@ -8,17 +8,39 @@
 
 #include <linux/errno.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/module_signature.h>
 #include <asm/byteorder.h>
 
+/**
+ * mod_check_sig_marker - check that the given data has signature marker at the end
+ *
+ * @data:	Data with appended signature
+ * @len:	Length of data. Signature marker length is subtracted on success.
+ */
+static inline int mod_check_sig_marker(const void *data, unsigned long *len)
+{
+	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+
+	if (markerlen > *len)
+		return -ENODATA;
+
+	if (memcmp(data + *len - markerlen, MODULE_SIG_STRING,
+		   markerlen))
+		return -ENODATA;
+
+	*len -= markerlen;
+	return 0;
+}
+
 /**
  * mod_check_sig - check that the given signature is sane
  *
  * @ms:		Signature to check.
- * @file_len:	Size of the file to which @ms is appended.
+ * @file_len:	Size of the file to which @ms is appended (without the marker).
  * @name:	What is being checked. Used for error messages.
  */
-int mod_check_sig(const struct module_signature *ms, size_t file_len,
+int mod_check_sig(const struct module_signature *ms, unsigned long file_len,
 		  const char *name)
 {
 	if (be32_to_cpu(ms->sig_len) >= file_len - sizeof(*ms))
@@ -44,3 +66,35 @@ int mod_check_sig(const struct module_signature *ms, size_t file_len,
 
 	return 0;
 }
+
+/**
+ * mod_parse_sig - check that the given signature is sane and determine signature length
+ *
+ * @data:	Data with appended signature.
+ * @len:	Length of data. Signature and marker length is subtracted on success.
+ * @sig_len:	Length of signature. Filled on success.
+ * @name:	What is being checked. Used for error messages.
+ */
+int mod_parse_sig(const void *data, unsigned long *len, unsigned long *sig_len, const char *name)
+{
+	const struct module_signature *sig;
+	int rc;
+
+	rc = mod_check_sig_marker(data, len);
+	if (rc)
+		return rc;
+
+	if (*len < sizeof(*sig))
+		return -EBADMSG;
+
+	sig = data + (*len - sizeof(*sig));
+
+	rc = mod_check_sig(sig, *len, name);
+	if (rc)
+		return rc;
+
+	*sig_len = be32_to_cpu(sig->sig_len);
+	*len -= *sig_len + sizeof(*sig);
+
+	return 0;
+}
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 20857d2a15ca..1d4cb03cce21 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -25,35 +25,16 @@ int verify_appended_signature(const void *data, unsigned long *len,
 			      struct key *trusted_keys,
 			      enum key_being_used_for purpose)
 {
-	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
-	struct module_signature *ms;
-	unsigned long sig_len, modlen = *len;
+	unsigned long sig_len;
 	int ret;
 
-	pr_devel("==>%s %s(,%lu)\n", __func__, key_being_used_for[purpose], modlen);
+	pr_devel("==>%s %s(,%lu)\n", __func__, key_being_used_for[purpose], *len);
 
-	if (markerlen > modlen)
-		return -ENODATA;
-
-	if (memcmp(data + modlen - markerlen, MODULE_SIG_STRING,
-		   markerlen))
-		return -ENODATA;
-	modlen -= markerlen;
-
-	if (modlen <= sizeof(*ms))
-		return -EBADMSG;
-
-	ms = data + modlen - sizeof(*ms);
-
-	ret = mod_check_sig(ms, modlen, key_being_used_for[purpose]);
+	ret = mod_parse_sig(data, len, &sig_len, key_being_used_for[purpose]);
 	if (ret)
 		return ret;
 
-	sig_len = be32_to_cpu(ms->sig_len);
-	modlen -= sig_len + sizeof(*ms);
-	*len = modlen;
-
-	return verify_pkcs7_signature(data, modlen, data + modlen, sig_len,
+	return verify_pkcs7_signature(data, *len, data + *len, sig_len,
 				      trusted_keys,
 				      purpose,
 				      NULL, NULL);
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index fb25723c65bc..b40c8fdf6139 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -37,33 +37,17 @@ struct modsig {
  *
  * Return: 0 on success, error code otherwise.
  */
-int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
+int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t len,
 		    struct modsig **modsig)
 {
-	const size_t marker_len = strlen(MODULE_SIG_STRING);
-	const struct module_signature *sig;
 	struct modsig *hdr;
-	size_t sig_len;
-	const void *p;
+	unsigned long sig_len, buf_len = len;
 	int rc;
 
-	if (buf_len <= marker_len + sizeof(*sig))
-		return -ENOENT;
-
-	p = buf + buf_len - marker_len;
-	if (memcmp(p, MODULE_SIG_STRING, marker_len))
-		return -ENOENT;
-
-	buf_len -= marker_len;
-	sig = (const struct module_signature *)(p - sizeof(*sig));
-
-	rc = mod_check_sig(sig, buf_len, func_tokens[func]);
+	rc = mod_parse_sig(buf, &buf_len, &sig_len, func_tokens[func]);
 	if (rc)
 		return rc;
 
-	sig_len = be32_to_cpu(sig->sig_len);
-	buf_len -= sig_len + sizeof(*sig);
-
 	/* Allocate sig_len additional bytes to hold the raw PKCS#7 data. */
 	hdr = kzalloc(sizeof(*hdr) + sig_len, GFP_KERNEL);
 	if (!hdr)
-- 
2.31.1

