Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AECB48771E
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jan 2022 12:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiAGL4A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jan 2022 06:56:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35992 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347372AbiAGLzx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jan 2022 06:55:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DC0B91F3A5;
        Fri,  7 Jan 2022 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641556550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSP3DtrUvsB008A1vZgft6mTsejxpxbZMO5DwVkTKmI=;
        b=vmLnp94LnEypl7VDljS0WA3Dt1jRx7gpEWKLclt3vNv2iFEU9dLIyM8wZO5Wps/n5BLHR0
        tqLsl7WKurNntpNMTWS29xFkes6zQGLMkf4AtczV9Snvu+tsC4gp2lhDqtFPFvXm+RDJSP
        Rdn5D/d8iHgp1mCLbdM21yiPPbABltQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641556550;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSP3DtrUvsB008A1vZgft6mTsejxpxbZMO5DwVkTKmI=;
        b=bakk+vg6AdyD41vtUiNYJA9ZqXBl4gAtm4oZdqVZdI2m1ryWswjHv9T7hOFR8Lj3YwA9mH
        dXt6zmOb8j4j/oDw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 851C8A3B98;
        Fri,  7 Jan 2022 11:55:50 +0000 (UTC)
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
Subject: [PATCH v3 6/6] module: Move duplicate mod_check_sig users code to mod_parse_sig
Date:   Fri,  7 Jan 2022 12:53:50 +0100
Message-Id: <4d46b065410a675431415105ba697bf9ceda424e.1641555875.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641555875.git.msuchanek@suse.de>
References: <cover.1641555875.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Multiple users of mod_check_sig check for the marker, then call
mod_check_sig, extract signature length, and remove the signature.

Put this code in one place together with mod_check_sig.

Note: This changes the error from ENOENT to ENODATA for ima_read_modsig
in the case the signature marker is missing.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v3: - Philipp Rudo <prudo@redhat.com>: Update the commit with note about
      change of raturn value
    - Preserve the EBADMSG error code while moving code araound
---
 include/linux/module_signature.h    |  1 +
 kernel/module_signature.c           | 56 ++++++++++++++++++++++++++++-
 kernel/module_signing.c             | 26 +++-----------
 security/integrity/ima/ima_modsig.c | 22 ++----------
 4 files changed, 63 insertions(+), 42 deletions(-)

diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
index 7eb4b00381ac..1343879b72b3 100644
--- a/include/linux/module_signature.h
+++ b/include/linux/module_signature.h
@@ -42,5 +42,6 @@ struct module_signature {
 
 int mod_check_sig(const struct module_signature *ms, size_t file_len,
 		  const char *name);
+int mod_parse_sig(const void *data, size_t *len, size_t *sig_len, const char *name);
 
 #endif /* _LINUX_MODULE_SIGNATURE_H */
diff --git a/kernel/module_signature.c b/kernel/module_signature.c
index 00132d12487c..b8eb30182183 100644
--- a/kernel/module_signature.c
+++ b/kernel/module_signature.c
@@ -8,14 +8,36 @@
 
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
+static inline int mod_check_sig_marker(const void *data, size_t *len)
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
 int mod_check_sig(const struct module_signature *ms, size_t file_len,
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
+int mod_parse_sig(const void *data, size_t *len, size_t *sig_len, const char *name)
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
+	sig = (const struct module_signature *)(data + (*len - sizeof(*sig)));
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
index cef72a6f6b5d..02bbca90f467 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -25,35 +25,17 @@ int verify_appended_signature(const void *data, size_t *len,
 			      struct key *trusted_keys,
 			      enum key_being_used_for purpose)
 {
-	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature ms;
-	size_t sig_len, modlen = *len;
+	size_t sig_len;
 	int ret;
 
-	pr_devel("==>%s %s(,%zu)\n", __func__, key_being_used_for[purpose], modlen);
+	pr_devel("==>%s %s(,%zu)\n", __func__, key_being_used_for[purpose], *len);
 
-	if (markerlen > modlen)
-		return -ENODATA;
-
-	if (memcmp(data + modlen - markerlen, MODULE_SIG_STRING,
-		   markerlen))
-		return -ENODATA;
-	modlen -= markerlen;
-
-	if (modlen <= sizeof(ms))
-		return -EBADMSG;
-
-	memcpy(&ms, data + (modlen - sizeof(ms)), sizeof(ms));
-
-	ret = mod_check_sig(&ms, modlen, key_being_used_for[purpose]);
+	ret = mod_parse_sig(data, len, &sig_len, key_being_used_for[purpose]);
 	if (ret)
 		return ret;
 
-	sig_len = be32_to_cpu(ms.sig_len);
-	modlen -= sig_len + sizeof(ms);
-	*len = modlen;
-
-	return verify_pkcs7_signature(data, modlen, data + modlen, sig_len,
+	return verify_pkcs7_signature(data, *len, data + *len, sig_len,
 				      trusted_keys,
 				      purpose,
 				      NULL, NULL);
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index fb25723c65bc..46917eb37fd8 100644
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
+	size_t sig_len, buf_len = len;
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

