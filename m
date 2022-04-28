Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A28F51362B
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Apr 2022 16:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbiD1OFg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Apr 2022 10:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343777AbiD1OFc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Apr 2022 10:05:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C13AC074
        for <linux-integrity@vger.kernel.org>; Thu, 28 Apr 2022 07:02:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1nk4iN-0000Au-SF; Thu, 28 Apr 2022 16:01:51 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nk4iO-005lwl-24; Thu, 28 Apr 2022 16:01:50 +0200
Received: from afa by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nk4iL-003i19-E5; Thu, 28 Apr 2022 16:01:49 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     kernel@pengutronix.de, David Gstir <david@sigma-star.at>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v8 4/6] KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
Date:   Thu, 28 Apr 2022 16:01:43 +0200
Message-Id: <20220428140145.870527-5-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428140145.870527-1-a.fatoum@pengutronix.de>
References: <20220428140145.870527-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
built into many newer i.MX and QorIQ SoCs by NXP.

The CAAM does crypto acceleration, hardware number generation and
has a blob mechanism for encapsulation/decapsulation of sensitive material.

This blob mechanism depends on a device specific random 256-bit One Time
Programmable Master Key that is fused in each SoC at manufacturing
time. This key is unreadable and can only be used by the CAAM for AES
encryption/decryption of user data.

This makes it a suitable backend (source) for kernel trusted keys.

Previous commits generalized trusted keys to support multiple backends
and added an API to access the CAAM blob mechanism. Based on these,
provide the necessary glue to use the CAAM for trusted keys.

Reviewed-by: David Gstir <david@sigma-star.at>
Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Tested-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v7 -> v8:
  - add Jarkko's Reviewed-by
v6 -> v7:
  - Split off MAINTAINERS and documentation chanes into separate patches
    (Jarkko)
  - Use new struct caam_blob_info API (Pankaj)
v5 -> v6:
  - Rename caam_trusted_key_ops to trusted_key_caam_ops for symmetry
    with other trust sources (Pankaj)
  - Collected Pankaj's Reviewed-by
v4 -> v5:
  - Collected Reviewed-by's and Tested-by's
  - Changed modifier to SECURE_KEY for compatibility with linux-imx
    (Matthias)
v3 -> v4:
  - Collected Acked-by's, Reviewed-by's and Tested-by
v2 -> v3:
 - add MAINTAINERS entry
v1 -> v2:
 - Extend trusted keys documentation for CAAM

To: Jonathan Corbet <corbet@lwn.net>
To: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <jejb@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Jan Luebbe <j.luebbe@pengutronix.de>
Cc: David Gstir <david@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>
Cc: Franck LENORMAND <franck.lenormand@nxp.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 include/keys/trusted_caam.h                   | 11 +++
 security/keys/trusted-keys/Kconfig            | 11 ++-
 security/keys/trusted-keys/Makefile           |  2 +
 security/keys/trusted-keys/trusted_caam.c     | 82 +++++++++++++++++++
 security/keys/trusted-keys/trusted_core.c     |  6 +-
 6 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 include/keys/trusted_caam.h
 create mode 100644 security/keys/trusted-keys/trusted_caam.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4deed1908a75..9afb7046ce97 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5958,6 +5958,7 @@
 			sources:
 			- "tpm"
 			- "tee"
+			- "caam"
 			If not specified then it defaults to iterating through
 			the trust source list starting with TPM and assigns the
 			first trust source as a backend which is initialized
diff --git a/include/keys/trusted_caam.h b/include/keys/trusted_caam.h
new file mode 100644
index 000000000000..73fe2f32f65e
--- /dev/null
+++ b/include/keys/trusted_caam.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ */
+
+#ifndef __CAAM_TRUSTED_KEY_H
+#define __CAAM_TRUSTED_KEY_H
+
+extern struct trusted_key_ops trusted_key_caam_ops;
+
+#endif
diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
index fc4abd581abb..dbfdd8536468 100644
--- a/security/keys/trusted-keys/Kconfig
+++ b/security/keys/trusted-keys/Kconfig
@@ -24,6 +24,15 @@ config TRUSTED_KEYS_TEE
 	  Enable use of the Trusted Execution Environment (TEE) as trusted
 	  key backend.
 
-if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE
+config TRUSTED_KEYS_CAAM
+	bool "CAAM-based trusted keys"
+	depends on CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS
+	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
+	default y
+	help
+	  Enable use of NXP's Cryptographic Accelerator and Assurance Module
+	  (CAAM) as trusted key backend.
+
+if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE && !TRUSTED_KEYS_CAAM
 comment "No trust source selected!"
 endif
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index 2e2371eae4d5..735aa0bc08ef 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -12,3 +12,5 @@ trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm2.o
 trusted-$(CONFIG_TRUSTED_KEYS_TPM) += tpm2key.asn1.o
 
 trusted-$(CONFIG_TRUSTED_KEYS_TEE) += trusted_tee.o
+
+trusted-$(CONFIG_TRUSTED_KEYS_CAAM) += trusted_caam.o
diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
new file mode 100644
index 000000000000..46cb2484ec36
--- /dev/null
+++ b/security/keys/trusted-keys/trusted_caam.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ */
+
+#include <keys/trusted_caam.h>
+#include <keys/trusted-type.h>
+#include <linux/build_bug.h>
+#include <linux/key-type.h>
+#include <soc/fsl/caam-blob.h>
+
+static struct caam_blob_priv *blobifier;
+
+#define KEYMOD "SECURE_KEY"
+
+static_assert(MAX_KEY_SIZE + CAAM_BLOB_OVERHEAD <= CAAM_BLOB_MAX_LEN);
+static_assert(MAX_BLOB_SIZE <= CAAM_BLOB_MAX_LEN);
+
+static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
+{
+	int ret;
+	struct caam_blob_info info = {
+		.input  = p->key,  .input_len   = p->key_len,
+		.output = p->blob, .output_len  = MAX_BLOB_SIZE,
+		.key_mod = KEYMOD, .key_mod_len = sizeof(KEYMOD) - 1,
+	};
+
+	ret = caam_encap_blob(blobifier, &info);
+	if (ret)
+		return ret;
+
+	p->blob_len = info.output_len;
+	return 0;
+}
+
+static int trusted_caam_unseal(struct trusted_key_payload *p, char *datablob)
+{
+	int ret;
+	struct caam_blob_info info = {
+		.input   = p->blob,  .input_len  = p->blob_len,
+		.output  = p->key,   .output_len = MAX_KEY_SIZE,
+		.key_mod = KEYMOD,  .key_mod_len = sizeof(KEYMOD) - 1,
+	};
+
+	ret = caam_decap_blob(blobifier, &info);
+	if (ret)
+		return ret;
+
+	p->key_len = info.output_len;
+	return 0;
+}
+
+static int trusted_caam_init(void)
+{
+	int ret;
+
+	blobifier = caam_blob_gen_init();
+	if (IS_ERR(blobifier)) {
+		pr_err("Job Ring Device allocation for transform failed\n");
+		return PTR_ERR(blobifier);
+	}
+
+	ret = register_key_type(&key_type_trusted);
+	if (ret)
+		caam_blob_gen_exit(blobifier);
+
+	return ret;
+}
+
+static void trusted_caam_exit(void)
+{
+	unregister_key_type(&key_type_trusted);
+	caam_blob_gen_exit(blobifier);
+}
+
+struct trusted_key_ops trusted_key_caam_ops = {
+	.migratable = 0, /* non-migratable */
+	.init = trusted_caam_init,
+	.seal = trusted_caam_seal,
+	.unseal = trusted_caam_unseal,
+	.exit = trusted_caam_exit,
+};
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 9235fb7d0ec9..c6fc50d67214 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -9,6 +9,7 @@
 #include <keys/user-type.h>
 #include <keys/trusted-type.h>
 #include <keys/trusted_tee.h>
+#include <keys/trusted_caam.h>
 #include <keys/trusted_tpm.h>
 #include <linux/capability.h>
 #include <linux/err.h>
@@ -29,7 +30,7 @@ MODULE_PARM_DESC(rng, "Select trusted key RNG");
 
 static char *trusted_key_source;
 module_param_named(source, trusted_key_source, charp, 0);
-MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
+MODULE_PARM_DESC(source, "Select trusted keys source (tpm, tee or caam)");
 
 static const struct trusted_key_source trusted_key_sources[] = {
 #if defined(CONFIG_TRUSTED_KEYS_TPM)
@@ -38,6 +39,9 @@ static const struct trusted_key_source trusted_key_sources[] = {
 #if defined(CONFIG_TRUSTED_KEYS_TEE)
 	{ "tee", &trusted_key_tee_ops },
 #endif
+#if defined(CONFIG_TRUSTED_KEYS_CAAM)
+	{ "caam", &trusted_key_caam_ops },
+#endif
 };
 
 DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
-- 
2.30.2

