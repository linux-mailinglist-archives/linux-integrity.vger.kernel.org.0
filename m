Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EBE205EDC
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 22:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390722AbgFWU04 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 16:26:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59052 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390718AbgFWU0y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 16:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592944013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mnJkRHe4VG45YqV9Mdm7ZoeBg+XZ/Hh78DcdlWBycFE=;
        b=DSkYI3060yuseWbSi1/q7U0X3nmsnQOz6SZXbvX3rITx4YwSuhKT0DYTi33/jYUO/pzzi2
        GXt9dIbvl7SdhEtNUd6bPNS4UcNNCpEKjTDp/i2fmiCOUzcbRwb50qG8nqBhYAK84TmMeP
        UFKBL2+sch8JpXRQQXqnstQPmouOZLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-xCbn5gnGOdykG_wvFVlQpA-1; Tue, 23 Jun 2020 16:26:49 -0400
X-MC-Unique: xCbn5gnGOdykG_wvFVlQpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81A1F106BB8F;
        Tue, 23 Jun 2020 20:26:48 +0000 (UTC)
Received: from localhost (ovpn-116-10.gru2.redhat.com [10.97.116.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E7909F63;
        Tue, 23 Jun 2020 20:26:47 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, erichte@linux.ibm.com, nayna@linux.ibm.com,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v3 1/2] arch/ima: extend secure boot check to include trusted boot
Date:   Tue, 23 Jun 2020 17:26:39 -0300
Message-Id: <20200623202640.4936-2-bmeneg@redhat.com>
In-Reply-To: <20200623202640.4936-1-bmeneg@redhat.com>
References: <20200623202640.4936-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima_get_secureboot() has been used for checking platform's secure boot
state for enabling different arch specific IMA policies where available.
However, for powerpc there also is the concept of Trusted Boot, which is
also relevant to the check code.

This patch extend the code or'ing the Trusted Boot state in PowerPC arch
while leaving the other arches (x86 and s390) unchanged. The only changes
performed in the other arches is related to the function name change.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 arch/powerpc/kernel/ima_arch.c    | 5 +++--
 arch/s390/kernel/ima_arch.c       | 2 +-
 arch/x86/kernel/ima_arch.c        | 5 +++--
 include/linux/ima.h               | 4 ++--
 security/integrity/ima/ima_main.c | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
index 957abd592075..32b26b491c07 100644
--- a/arch/powerpc/kernel/ima_arch.c
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -7,9 +7,10 @@
 #include <linux/ima.h>
 #include <asm/secure_boot.h>
 
-bool arch_ima_get_secureboot(void)
+bool arch_ima_secure_or_trusted_boot(void)
 {
-	return is_ppc_secureboot_enabled();
+	return (is_ppc_secureboot_enabled() ||
+		is_ppc_trustedboot_enabled());
 }
 
 /*
diff --git a/arch/s390/kernel/ima_arch.c b/arch/s390/kernel/ima_arch.c
index f3c3e6e1c5d3..9cf823cf2b79 100644
--- a/arch/s390/kernel/ima_arch.c
+++ b/arch/s390/kernel/ima_arch.c
@@ -3,7 +3,7 @@
 #include <linux/ima.h>
 #include <asm/boot_data.h>
 
-bool arch_ima_get_secureboot(void)
+bool arch_ima_secure_or_trusted_boot(void)
 {
 	return ipl_secure_flag;
 }
diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index 7dfb1e808928..168393d399ba 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -51,7 +51,7 @@ static enum efi_secureboot_mode get_sb_mode(void)
 	return efi_secureboot_mode_enabled;
 }
 
-bool arch_ima_get_secureboot(void)
+bool arch_ima_secure_or_trusted_boot(void)
 {
 	static enum efi_secureboot_mode sb_mode;
 	static bool initialized;
@@ -85,7 +85,8 @@ static const char * const sb_arch_rules[] = {
 
 const char * const *arch_get_ima_policy(void)
 {
-	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
+	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) &&
+	    arch_ima_secure_or_tusted_boot()) {
 		if (IS_ENABLED(CONFIG_MODULE_SIG))
 			set_module_sig_enforced();
 		return sb_arch_rules;
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 9164e1534ec9..839b5c376ed6 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -32,10 +32,10 @@ extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
 
 #ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
-extern bool arch_ima_get_secureboot(void);
+extern bool arch_ima_secure_or_trusted_boot(void);
 extern const char * const *arch_get_ima_policy(void);
 #else
-static inline bool arch_ima_get_secureboot(void)
+static inline bool arch_ima_secure_or_trusted_boot(void)
 {
 	return false;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c1583d98c5e5..a760094e8f8d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -694,7 +694,7 @@ int ima_load_data(enum kernel_load_data_id id)
 	switch (id) {
 	case LOADING_KEXEC_IMAGE:
 		if (IS_ENABLED(CONFIG_KEXEC_SIG)
-		    && arch_ima_get_secureboot()) {
+		    && arch_ima_secure_or_trusted_boot()) {
 			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
 			return -EACCES;
 		}
-- 
2.26.2

