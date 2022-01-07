Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A37548770C
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jan 2022 12:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347405AbiAGLz6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jan 2022 06:55:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35944 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbiAGLzw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jan 2022 06:55:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 33CC81F3A3;
        Fri,  7 Jan 2022 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641556550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=leEfioXeF93W1Hkfv/+kj52956fIklUGG6r0+SpHDc4=;
        b=q8AYGlxAmyWl3bwcMolaeSxYLFegccuABfs/uP8H0Axg7ZUnOD2rQyugyJ8tuyq8NdLDZk
        t7g7DX1sMLFqIG3q0eo9DgcaUxoEgQfjKDCce8xFB3RnRf3ZQQDRin7qFrFco+URLzzlHe
        Kfga1jWkvB1FJQIUSy5rwZksz45Ul4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641556550;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=leEfioXeF93W1Hkfv/+kj52956fIklUGG6r0+SpHDc4=;
        b=XHJLybGDy0CVMKm9FdWSFWqRnxFC52IBImfdqQ9AJfYk+QedeAIZrOXH6HfBRYXcinDFNG
        3u6lASWGIWf/Q0Ag==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id D7BE3A3B91;
        Fri,  7 Jan 2022 11:55:49 +0000 (UTC)
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
Subject: [PATCH v3 4/6] module: strip the signature marker in the verification function.
Date:   Fri,  7 Jan 2022 12:53:48 +0100
Message-Id: <8ac1ed7dc050477c70c6fa4038ea84e56ec47815.1641555875.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641555875.git.msuchanek@suse.de>
References: <cover.1641555875.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It is stripped by each caller separately.

Note: this changes the error for kexec_file from EKEYREJECTED to ENODATA
when the signature marker is missing.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v3: - Philipp Rudo <prudo@redhat.com>: Update the commit with note about
      change of raturn value
    - the module_signature.h is now no longer needed for kexec_file
---
 arch/powerpc/kexec/elf_64.c           | 10 ----------
 arch/s390/kernel/machine_kexec_file.c | 10 ----------
 kernel/module.c                       |  7 +------
 kernel/module_signing.c               | 12 ++++++++++--
 4 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index 9442666ca69d..e8dff6b23ac5 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -24,7 +24,6 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/verification.h>
-#include <linux/module_signature.h>
 
 static void *elf64_load(struct kimage *image, char *kernel_buf,
 			unsigned long kernel_len, char *initrd,
@@ -157,15 +156,6 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 int elf64_verify_sig(const char *kernel, unsigned long length)
 {
 	size_t kernel_len = length;
-	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
-
-	if (marker_len > kernel_len)
-		return -EKEYREJECTED;
-
-	if (memcmp(kernel + kernel_len - marker_len, MODULE_SIG_STRING,
-		   marker_len))
-		return -EKEYREJECTED;
-	kernel_len -= marker_len;
 
 	return verify_appended_signature(kernel, &kernel_len, VERIFY_USE_PLATFORM_KEYRING,
 					 "kexec_file");
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 75e0c17cf0eb..3e3bc7bcae86 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -12,7 +12,6 @@
 #include <linux/elf.h>
 #include <linux/errno.h>
 #include <linux/kexec.h>
-#include <linux/module_signature.h>
 #include <linux/verification.h>
 #include <linux/vmalloc.h>
 #include <asm/boot_data.h>
@@ -29,20 +28,11 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 int s390_verify_sig(const char *kernel, unsigned long length)
 {
 	size_t kernel_len = length;
-	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
 
 	/* Skip signature verification when not secure IPLed. */
 	if (!ipl_secure_flag)
 		return 0;
 
-	if (marker_len > kernel_len)
-		return -EKEYREJECTED;
-
-	if (memcmp(kernel + kernel_len - marker_len, MODULE_SIG_STRING,
-		   marker_len))
-		return -EKEYREJECTED;
-	kernel_len -= marker_len;
-
 	return verify_appended_signature(kernel, &kernel_len, VERIFY_USE_PLATFORM_KEYRING,
 					"kexec_file");
 }
diff --git a/kernel/module.c b/kernel/module.c
index 8481933dfa92..d91ca0f93a40 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2882,7 +2882,6 @@ static inline void kmemleak_load_module(const struct module *mod,
 static int module_sig_check(struct load_info *info, int flags)
 {
 	int err = -ENODATA;
-	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
 	const char *reason;
 	const void *mod = info->hdr;
 
@@ -2890,11 +2889,7 @@ static int module_sig_check(struct load_info *info, int flags)
 	 * Require flags == 0, as a module with version information
 	 * removed is no longer the module that was signed
 	 */
-	if (flags == 0 &&
-	    info->len > markerlen &&
-	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
-		/* We truncate the module to discard the signature */
-		info->len -= markerlen;
+	if (flags == 0) {
 		err = verify_appended_signature(mod, &info->len,
 						VERIFY_USE_SECONDARY_KEYRING, "module");
 		if (!err) {
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index f492e410564d..4c28cb55275f 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -15,8 +15,7 @@
 #include "module-internal.h"
 
 /**
- * verify_appended_signature - Verify the signature on a module with the
- * signature marker stripped.
+ * verify_appended_signature - Verify the signature on a module
  * @data: The data to be verified
  * @len: Size of @data.
  * @trusted_keys: Keyring to use for verification
@@ -25,12 +24,21 @@
 int verify_appended_signature(const void *data, size_t *len,
 			      struct key *trusted_keys, const char *what)
 {
+	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature ms;
 	size_t sig_len, modlen = *len;
 	int ret;
 
 	pr_devel("==>%s(,%zu)\n", __func__, modlen);
 
+	if (markerlen > modlen)
+		return -ENODATA;
+
+	if (memcmp(data + modlen - markerlen, MODULE_SIG_STRING,
+		   markerlen))
+		return -ENODATA;
+	modlen -= markerlen;
+
 	if (modlen <= sizeof(ms))
 		return -EBADMSG;
 
-- 
2.31.1

