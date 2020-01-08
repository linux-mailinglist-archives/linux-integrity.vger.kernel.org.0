Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13E113471A
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jan 2020 17:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgAHQFO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jan 2020 11:05:14 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51752 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgAHQFN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jan 2020 11:05:13 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8352C20B4798;
        Wed,  8 Jan 2020 08:05:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8352C20B4798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578499512;
        bh=KrknY3LiZv+UW2WvDhkkxFbk6VfTO+2SgVUx/zg5yx8=;
        h=From:To:Cc:Subject:Date:From;
        b=ODwxIqg6c19Ihnn1BDvr4kZ84df6p8m8V4Ob7p7QA9/JBsyhwRTt1UM1Q64cN1s6F
         c5oFKrsms0zcyEk7JH1IUdL492lV4RmN2YmsV16CPkXoLvdw3DdtG42FkrwuxTzKOY
         ZfaebksJbDKG9nSqtQ9YDaEAzP341D1dhGMsaKjo=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        arnd@arndb.de, linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, sashal@kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v1] IMA: fix measuring asymmetric keys Kconfig
Date:   Wed,  8 Jan 2020 08:05:08 -0800
Message-Id: <20200108160508.5938-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is a tristate. If this config
is set to "=m", ima_asymmetric_keys.c is built as a kernel module.

Defined an intermediate boolean config namely
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS that is
defined when CONFIG_IMA and CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
are defined.

Asymmetric key structure is defined only when
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is defined. Since the IMA hook
measures asymmetric keys, the IMA hook is defined in
ima_asymmetric_keys.c which is built only if
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is defined.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: James.Bottomley <James.Bottomley@HansenPartnership.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reported-by: kbuild test robot <lkp@intel.com> # ima_asymmetric_keys.c
is built as a kernel module.
Fixes: 88e70da170e8 ("IMA: Define an IMA hook to measure keys")
Fixes: cb1aa3823c92 ("KEYS: Call the IMA hook to measure keys")
---
 include/linux/ima.h             | 4 ++--
 security/integrity/ima/Kconfig  | 6 ++++++
 security/integrity/ima/Makefile | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 3b89136bc218..f4644c54f648 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -101,7 +101,7 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
 {}
 #endif
 
-#if defined(CONFIG_IMA) && defined(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
+#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
 extern void ima_post_key_create_or_update(struct key *keyring,
 					  struct key *key,
 					  const void *payload, size_t plen,
@@ -113,7 +113,7 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
 						 size_t plen,
 						 unsigned long flags,
 						 bool create) {}
-#endif  /* CONFIG_IMA && CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
+#endif  /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
 
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 838476d780e5..355754a6b6ca 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -310,3 +310,9 @@ config IMA_APPRAISE_SIGNED_INIT
 	default n
 	help
 	   This option requires user-space init to be signed.
+
+config IMA_MEASURE_ASYMMETRIC_KEYS
+	bool
+	depends on IMA
+	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
+	default y
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 207a0a9eb72c..3e9d0ad68c7b 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -12,4 +12,4 @@ ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
-obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += ima_asymmetric_keys.o
+obj-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
-- 
2.17.1

