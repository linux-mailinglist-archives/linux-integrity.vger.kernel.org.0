Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1884045E053
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Nov 2021 19:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355661AbhKYSIz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Nov 2021 13:08:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57292 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbhKYSGr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Nov 2021 13:06:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8DCCC1FD3D;
        Thu, 25 Nov 2021 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637863413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ppmq8eXKBK48QzJtq64n/wfpJftndpEVG5gddVJ3g6c=;
        b=wD+eaSjEG00QXyzDIRqHqnRO+4kJ6iC2LANK/e9fdWmLOiKnTtW2rT+V25o1mQvwPhAsix
        XqJ5HkwY25TfdzprAyuuvdWeZrdoB2xovlGm8w3H+6qWSBFmxBy9uK18/8OVGkA+Q+pLkj
        37YBacWAHlGP0LkjRieY3HHOOYgNqjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637863413;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ppmq8eXKBK48QzJtq64n/wfpJftndpEVG5gddVJ3g6c=;
        b=QnHZcLCIiAGFD/VT22aaPOqT2vPKtWkux4fBsS9cU/KIKntpTSQHeES1zAAeX54Qm64s5N
        WBtbd/iX/un1thAA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 4317CA3B89;
        Thu, 25 Nov 2021 18:03:33 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     keyrings@vger.kernel.org
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
        Baoquan He <bhe@redhat.com>, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 3/6] kexec_file: Don't opencode appended signature verification.
Date:   Thu, 25 Nov 2021 19:02:41 +0100
Message-Id: <911210845d863b06de2404acae6fff06241f0458.1637862358.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637862358.git.msuchanek@suse.de>
References: <cover.1637862358.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Module verification already implements appeded signature verification.

Reuse it for kexec_file.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kexec/elf_64.c           | 21 ++++-----------------
 arch/s390/kernel/machine_kexec_file.c | 21 ++++-----------------
 include/linux/verification.h          |  3 +++
 kernel/module-internal.h              |  2 --
 kernel/module.c                       |  4 +++-
 kernel/module_signing.c               | 24 +++++++++++++++---------
 6 files changed, 29 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index 25dc1071feec..266cb26d3ca0 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -153,12 +153,10 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 }
 
 #ifdef CONFIG_KEXEC_SIG
-int elf64_verify_sig(const char *kernel, unsigned long kernel_len)
+int elf64_verify_sig(const char *kernel, unsigned long length)
 {
+	size_t kernel_len = length;
 	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
-	struct module_signature *ms;
-	unsigned long sig_len;
-	int ret;
 
 	if (marker_len > kernel_len)
 		return -EKEYREJECTED;
@@ -168,19 +166,8 @@ int elf64_verify_sig(const char *kernel, unsigned long kernel_len)
 		return -EKEYREJECTED;
 	kernel_len -= marker_len;
 
-	ms = (void *)kernel + kernel_len - sizeof(*ms);
-	ret = mod_check_sig(ms, kernel_len, "kexec");
-	if (ret)
-		return ret;
-
-	sig_len = be32_to_cpu(ms->sig_len);
-	kernel_len -= sizeof(*ms) + sig_len;
-
-	return verify_pkcs7_signature(kernel, kernel_len,
-				      kernel + kernel_len, sig_len,
-				      VERIFY_USE_PLATFORM_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
+	return verify_appended_signature(kernel, &kernel_len, VERIFY_USE_PLATFORM_KEYRING,
+					"kexec_file");
 }
 #endif /* CONFIG_KEXEC_SIG */
 
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 43a9abe48abd..432797249db3 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -24,12 +24,10 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 };
 
 #ifdef CONFIG_KEXEC_SIG
-int s390_verify_sig(const char *kernel, unsigned long kernel_len)
+int s390_verify_sig(const char *kernel, unsigned long length)
 {
+	size_t kernel_len = length;
 	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
-	struct module_signature *ms;
-	unsigned long sig_len;
-	int ret;
 
 	/* Skip signature verification when not secure IPLed. */
 	if (!ipl_secure_flag)
@@ -43,19 +41,8 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 		return -EKEYREJECTED;
 	kernel_len -= marker_len;
 
-	ms = (void *)kernel + kernel_len - sizeof(*ms);
-	ret = mod_check_sig(ms, kernel_len, "kexec");
-	if (ret)
-		return ret;
-
-	sig_len = be32_to_cpu(ms->sig_len);
-	kernel_len -= sizeof(*ms) + sig_len;
-
-	return verify_pkcs7_signature(kernel, kernel_len,
-				      kernel + kernel_len, sig_len,
-				      VERIFY_USE_PLATFORM_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
+	return verify_appended_signature(kernel, &kernel_len, VERIFY_USE_PLATFORM_KEYRING,
+					"kexec_file");
 }
 #endif /* CONFIG_KEXEC_SIG */
 
diff --git a/include/linux/verification.h b/include/linux/verification.h
index a655923335ae..c1cf0582012a 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -60,5 +60,8 @@ extern int verify_pefile_signature(const void *pebuf, unsigned pelen,
 				   enum key_being_used_for usage);
 #endif
 
+int verify_appended_signature(const void *data, size_t *len, struct key *trusted_keys,
+			      const char *what);
+
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 #endif /* _LINUX_VERIFY_PEFILE_H */
diff --git a/kernel/module-internal.h b/kernel/module-internal.h
index 33783abc377b..80461e14bf29 100644
--- a/kernel/module-internal.h
+++ b/kernel/module-internal.h
@@ -27,5 +27,3 @@ struct load_info {
 		unsigned int sym, str, mod, vers, info, pcpu;
 	} index;
 };
-
-extern int mod_verify_sig(const void *mod, struct load_info *info);
diff --git a/kernel/module.c b/kernel/module.c
index 84a9141a5e15..8481933dfa92 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -57,6 +57,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/verification.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
@@ -2894,7 +2895,8 @@ static int module_sig_check(struct load_info *info, int flags)
 	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
 		/* We truncate the module to discard the signature */
 		info->len -= markerlen;
-		err = mod_verify_sig(mod, info);
+		err = verify_appended_signature(mod, &info->len,
+						VERIFY_USE_SECONDARY_KEYRING, "module");
 		if (!err) {
 			info->sig_ok = true;
 			return 0;
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 8723ae70ea1f..f492e410564d 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -14,13 +14,19 @@
 #include <crypto/public_key.h>
 #include "module-internal.h"
 
-/*
- * Verify the signature on a module.
+/**
+ * verify_appended_signature - Verify the signature on a module with the
+ * signature marker stripped.
+ * @data: The data to be verified
+ * @len: Size of @data.
+ * @trusted_keys: Keyring to use for verification
+ * @what: Informational string for log messages
  */
-int mod_verify_sig(const void *mod, struct load_info *info)
+int verify_appended_signature(const void *data, size_t *len,
+			      struct key *trusted_keys, const char *what)
 {
 	struct module_signature ms;
-	size_t sig_len, modlen = info->len;
+	size_t sig_len, modlen = *len;
 	int ret;
 
 	pr_devel("==>%s(,%zu)\n", __func__, modlen);
@@ -28,18 +34,18 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 	if (modlen <= sizeof(ms))
 		return -EBADMSG;
 
-	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
+	memcpy(&ms, data + (modlen - sizeof(ms)), sizeof(ms));
 
-	ret = mod_check_sig(&ms, modlen, "module");
+	ret = mod_check_sig(&ms, modlen, what);
 	if (ret)
 		return ret;
 
 	sig_len = be32_to_cpu(ms.sig_len);
 	modlen -= sig_len + sizeof(ms);
-	info->len = modlen;
+	*len = modlen;
 
-	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
-				      VERIFY_USE_SECONDARY_KEYRING,
+	return verify_pkcs7_signature(data, modlen, data + modlen, sig_len,
+				      trusted_keys,
 				      VERIFYING_MODULE_SIGNATURE,
 				      NULL, NULL);
 }
-- 
2.31.1

