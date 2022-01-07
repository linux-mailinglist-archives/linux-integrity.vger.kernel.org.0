Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E57487710
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jan 2022 12:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347402AbiAGLz7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jan 2022 06:55:59 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42352 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347369AbiAGLzw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jan 2022 06:55:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 82A79212BD;
        Fri,  7 Jan 2022 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641556550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YagoF4rvyErQa17K5Sd0ImBwrc4k6YzwTfC9+keJqp8=;
        b=xzHLeJi2kYp0GmPUU+ubT+fTYppTSj3FbgyUhzxL+e5CfMIE5KtlD9T/227XwFvRBPH07n
        tYbYhqXUtH3SQ4nks0Veu00G9ITkwjAv3fAbFUh04MLAGLCxAgOom5YFJ3n3dOim8WS/ac
        NTfL60o+JYpbfl9GZongWSAp3maMCm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641556550;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YagoF4rvyErQa17K5Sd0ImBwrc4k6YzwTfC9+keJqp8=;
        b=wmtDgBPCFEpWlZUOofVt1JL/fyNQCNhskMyPt/qx04OZXhkeCbcR7pxzPHQQ65E+ILjvCu
        KFaHJ/lKsfWx6tBw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 36229A3B95;
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
Subject: [PATCH v3 5/6] module: Use key_being_used_for for log messages in verify_appended_signature
Date:   Fri,  7 Jan 2022 12:53:49 +0100
Message-Id: <e75decffa906561f00573a1e92e14870af4d183f.1641555875.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641555875.git.msuchanek@suse.de>
References: <cover.1641555875.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add value for kexec appended signature and pass in key_being_used_for
enum rather than a string to verify_appended_signature to produce log
messages about the signature.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kexec/elf_64.c              |  2 +-
 arch/s390/kernel/machine_kexec_file.c    |  2 +-
 crypto/asymmetric_keys/asymmetric_type.c |  1 +
 include/linux/verification.h             |  3 ++-
 kernel/module.c                          |  3 ++-
 kernel/module_signing.c                  | 11 ++++++-----
 6 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index e8dff6b23ac5..3aa5269f6e0f 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -158,7 +158,7 @@ int elf64_verify_sig(const char *kernel, unsigned long length)
 	size_t kernel_len = length;
 
 	return verify_appended_signature(kernel, &kernel_len, VERIFY_USE_PLATFORM_KEYRING,
-					 "kexec_file");
+					 VERIFYING_KEXEC_APPENDED_SIGNATURE);
 }
 #endif /* CONFIG_KEXEC_SIG */
 
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 3e3bc7bcae86..18ba6df31d68 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -34,7 +34,7 @@ int s390_verify_sig(const char *kernel, unsigned long length)
 		return 0;
 
 	return verify_appended_signature(kernel, &kernel_len, VERIFY_USE_PLATFORM_KEYRING,
-					"kexec_file");
+					VERIFYING_KEXEC_APPENDED_SIGNATURE);
 }
 #endif /* CONFIG_KEXEC_SIG */
 
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index ad8af3d70ac0..6fd20eec3882 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -25,6 +25,7 @@ const char *const key_being_used_for[NR__KEY_BEING_USED_FOR] = {
 	[VERIFYING_KEXEC_PE_SIGNATURE]		= "kexec PE sig",
 	[VERIFYING_KEY_SIGNATURE]		= "key sig",
 	[VERIFYING_KEY_SELF_SIGNATURE]		= "key self sig",
+	[VERIFYING_KEXEC_APPENDED_SIGNATURE]	= "kexec appended sig",
 	[VERIFYING_UNSPECIFIED_SIGNATURE]	= "unspec sig",
 };
 EXPORT_SYMBOL_GPL(key_being_used_for);
diff --git a/include/linux/verification.h b/include/linux/verification.h
index c1cf0582012a..23748feb9e03 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -26,6 +26,7 @@ enum key_being_used_for {
 	VERIFYING_KEXEC_PE_SIGNATURE,
 	VERIFYING_KEY_SIGNATURE,
 	VERIFYING_KEY_SELF_SIGNATURE,
+	VERIFYING_KEXEC_APPENDED_SIGNATURE,
 	VERIFYING_UNSPECIFIED_SIGNATURE,
 	NR__KEY_BEING_USED_FOR
 };
@@ -61,7 +62,7 @@ extern int verify_pefile_signature(const void *pebuf, unsigned pelen,
 #endif
 
 int verify_appended_signature(const void *data, size_t *len, struct key *trusted_keys,
-			      const char *what);
+			      enum key_being_used_for purpose);
 
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 #endif /* _LINUX_VERIFY_PEFILE_H */
diff --git a/kernel/module.c b/kernel/module.c
index d91ca0f93a40..0a359dc6b690 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2891,7 +2891,8 @@ static int module_sig_check(struct load_info *info, int flags)
 	 */
 	if (flags == 0) {
 		err = verify_appended_signature(mod, &info->len,
-						VERIFY_USE_SECONDARY_KEYRING, "module");
+						VERIFY_USE_SECONDARY_KEYRING,
+						VERIFYING_MODULE_SIGNATURE);
 		if (!err) {
 			info->sig_ok = true;
 			return 0;
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 4c28cb55275f..cef72a6f6b5d 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -19,17 +19,18 @@
  * @data: The data to be verified
  * @len: Size of @data.
  * @trusted_keys: Keyring to use for verification
- * @what: Informational string for log messages
+ * @purpose: The use to which the key is being put
  */
 int verify_appended_signature(const void *data, size_t *len,
-			      struct key *trusted_keys, const char *what)
+			      struct key *trusted_keys,
+			      enum key_being_used_for purpose)
 {
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature ms;
 	size_t sig_len, modlen = *len;
 	int ret;
 
-	pr_devel("==>%s(,%zu)\n", __func__, modlen);
+	pr_devel("==>%s %s(,%zu)\n", __func__, key_being_used_for[purpose], modlen);
 
 	if (markerlen > modlen)
 		return -ENODATA;
@@ -44,7 +45,7 @@ int verify_appended_signature(const void *data, size_t *len,
 
 	memcpy(&ms, data + (modlen - sizeof(ms)), sizeof(ms));
 
-	ret = mod_check_sig(&ms, modlen, what);
+	ret = mod_check_sig(&ms, modlen, key_being_used_for[purpose]);
 	if (ret)
 		return ret;
 
@@ -54,6 +55,6 @@ int verify_appended_signature(const void *data, size_t *len,
 
 	return verify_pkcs7_signature(data, modlen, data + modlen, sig_len,
 				      trusted_keys,
-				      VERIFYING_MODULE_SIGNATURE,
+				      purpose,
 				      NULL, NULL);
 }
-- 
2.31.1

