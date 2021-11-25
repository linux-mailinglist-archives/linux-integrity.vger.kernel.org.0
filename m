Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6225045E051
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Nov 2021 19:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355166AbhKYSIy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Nov 2021 13:08:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45858 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239249AbhKYSGr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Nov 2021 13:06:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DA31521958;
        Thu, 25 Nov 2021 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637863413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5Qpcz1gFX5OMpie9ThdpX+BDLCsg65byAFOIZtk2aU=;
        b=h8wbFNCvjRTtSvfcBEw0Et/K3sqpnTIVUS49o9y9mKpZXaBDrra4fbBAGrlNyBrSULQdN3
        /cosljaSDtvK5E11KBEo8/SrpylhCl9j896NQV/x1+nf3/dRMH8Yjpb1vWmI4Fbu8f5Zqu
        m2nFo3ipA/ayw9G5ptJgt6X4igQ/Ly0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637863413;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5Qpcz1gFX5OMpie9ThdpX+BDLCsg65byAFOIZtk2aU=;
        b=6WhAMlWErZSeNal6RoAurbokMncn+tOhC8kcNsoCPtfapCfBBfaNoSkXDFrNnvQouJtk42
        TDnjtteNPYRcUEBQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 8EC53A3B8A;
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
Subject: [PATCH v2 4/6] module: strip the signature marker in the verification function.
Date:   Thu, 25 Nov 2021 19:02:42 +0100
Message-Id: <0f9bbbc4800d5329485b6bdabbbe1ef3b2169b02.1637862358.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637862358.git.msuchanek@suse.de>
References: <cover.1637862358.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It is stripped by each caller separately.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kexec/elf_64.c           |  9 ---------
 arch/s390/kernel/machine_kexec_file.c |  9 ---------
 kernel/module.c                       |  7 +------
 kernel/module_signing.c               | 12 ++++++++++--
 4 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index 266cb26d3ca0..63634c95265d 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -156,15 +156,6 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
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
index 432797249db3..c4632c1a1b59 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -27,20 +27,11 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
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

