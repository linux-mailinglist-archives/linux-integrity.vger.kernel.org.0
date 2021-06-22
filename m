Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2923B04BC
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jun 2021 14:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhFVMlF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Jun 2021 08:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFVMlB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Jun 2021 08:41:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20A8C061787
        for <linux-integrity@vger.kernel.org>; Tue, 22 Jun 2021 05:38:44 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lvffV-0001dk-Sp; Tue, 22 Jun 2021 14:38:17 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lvffS-0002Py-KA; Tue, 22 Jun 2021 14:38:14 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v2 1/6] KEYS: trusted: allow use of TEE as backend without TCG_TPM support
Date:   Tue, 22 Jun 2021 14:37:47 +0200
Message-Id: <f8285eb0135ba30c9d846cf9dd395d1f5f8b1efc.1624364386.git-series.a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1dfbb73645d917b3c76d01290804a3410bd9932e.1624364386.git-series.a.fatoum@pengutronix.de>
References: <cover.1dfbb73645d917b3c76d01290804a3410bd9932e.1624364386.git-series.a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With recent rework, trusted keys are no longer limited to TPM as trust
source. The Kconfig symbol is unchanged however leading to a few issues:

 - TCG_TPM is required, even if only TEE is to be used
 - Enabling TCG_TPM, but excluding it from available trusted sources
   is not possible
 - TEE=m && TRUSTED_KEYS=y will lead to TEE support being silently
   dropped, which is not the best user experience

Remedy these issues by introducing two new Kconfig symbols:
TRUSTED_KEYS_TPM and TRUSTED_KEYS_TEE with the appropriate
dependencies.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
To: James Bottomley <jejb@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Udit Agarwal <udit.agarwal@nxp.com>
Cc: Jan Luebbe <j.luebbe@pengutronix.de>
Cc: David Gstir <david@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>
Cc: Franck LENORMAND <franck.lenormand@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 security/keys/Kconfig                     | 14 ++++++-------
 security/keys/trusted-keys/Kconfig        | 25 ++++++++++++++++++++++++-
 security/keys/trusted-keys/Makefile       |  8 +++++---
 security/keys/trusted-keys/trusted_core.c |  4 ++--
 4 files changed, 39 insertions(+), 12 deletions(-)
 create mode 100644 security/keys/trusted-keys/Kconfig

diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 64b81abd087e..6fdb953b319f 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -70,23 +70,23 @@ config BIG_KEYS
 
 config TRUSTED_KEYS
 	tristate "TRUSTED KEYS"
-	depends on KEYS && TCG_TPM
+	depends on KEYS
 	select CRYPTO
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
-	select ASN1_ENCODER
-	select OID_REGISTRY
-	select ASN1
 	help
 	  This option provides support for creating, sealing, and unsealing
 	  keys in the kernel. Trusted keys are random number symmetric keys,
-	  generated and RSA-sealed by the TPM. The TPM only unseals the keys,
-	  if the boot PCRs and other criteria match.  Userspace will only ever
-	  see encrypted blobs.
+	  generated and sealed by a trust source selected at kernel boot-time.
+	  Userspace will only ever see encrypted blobs.
 
 	  If you are unsure as to whether this is required, answer N.
 
+if TRUSTED_KEYS
+source "security/keys/trusted-keys/Kconfig"
+endif
+
 config ENCRYPTED_KEYS
 	tristate "ENCRYPTED KEYS"
 	depends on KEYS
diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
new file mode 100644
index 000000000000..24af4aaceebf
--- /dev/null
+++ b/security/keys/trusted-keys/Kconfig
@@ -0,0 +1,25 @@
+config TRUSTED_KEYS_TPM
+	bool "TPM-based trusted keys"
+	depends on TCG_TPM >= TRUSTED_KEYS
+	default y
+ 	select ASN1_ENCODER
+	select OID_REGISTRY
+	select ASN1
+	help
+	  Enable use of the Trusted Platform Module (TPM) as trusted key
+	  backend. Trusted keys are are random number symmetric keys,
+	  which will be generated and RSA-sealed by the TPM.
+	  The TPM only unseals the keys, if the boot PCRs and other
+	  criteria match.
+
+config TRUSTED_KEYS_TEE
+	bool "TEE-based trusted keys"
+	depends on TEE >= TRUSTED_KEYS
+	default y
+	help
+	  Enable use of the Trusted Execution Environment (TEE) as trusted
+	  key backend.
+
+if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE
+comment "No trust source selected!"
+endif
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index feb8b6c3cc79..96fc6c377398 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -5,10 +5,12 @@
 
 obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
 trusted-y += trusted_core.o
-trusted-y += trusted_tpm1.o
+trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm1.o
 
 $(obj)/trusted_tpm2.o: $(obj)/tpm2key.asn1.h
-trusted-y += trusted_tpm2.o
-trusted-y += tpm2key.asn1.o
+trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm2.o
+trusted-$(CONFIG_TRUSTED_KEYS_TPM) += tpm2key.asn1.o
+
+trusted-$(CONFIG_TRUSTED_KEYS_TEE) += trusted_tee.o
 
 trusted-$(CONFIG_TEE) += trusted_tee.o
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index d5c891d8d353..8cab69e5d0da 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp, 0);
 MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
 
 static const struct trusted_key_source trusted_key_sources[] = {
-#if defined(CONFIG_TCG_TPM)
+#if defined(CONFIG_TRUSTED_KEYS_TPM)
 	{ "tpm", &trusted_key_tpm_ops },
 #endif
-#if defined(CONFIG_TEE)
+#if defined(CONFIG_TRUSTED_KEYS_TEE)
 	{ "tee", &trusted_key_tee_ops },
 #endif
 };
-- 
git-series 0.9.1
