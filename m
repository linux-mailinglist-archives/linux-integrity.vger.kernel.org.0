Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD233B0513
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jun 2021 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhFVMsH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Jun 2021 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhFVMsG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Jun 2021 08:48:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45394C061574
        for <linux-integrity@vger.kernel.org>; Tue, 22 Jun 2021 05:45:51 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lvfma-0002yw-65; Tue, 22 Jun 2021 14:45:36 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lvfmY-0000ic-Hs; Tue, 22 Jun 2021 14:45:34 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     kernel@pengutronix.de, Jan Luebbe <jlu@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
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
Subject: [PATCH v2 2/6] KEYS: trusted: Allow import from existing key material for development
Date:   Tue, 22 Jun 2021 14:45:19 +0200
Message-Id: <342fe12286b5582b11e8c899bd9a63db2d4bf61c.1624365751.git-series.a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.0e5d15050ce7cbc93b9b2f950cbd035bffc655fd.1624365751.git-series.a.fatoum@pengutronix.de>
References: <cover.0e5d15050ce7cbc93b9b2f950cbd035bffc655fd.1624365751.git-series.a.fatoum@pengutronix.de>
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

A key aspect of trusted keys is that they are never disclosed to
userspace in plain text. For development and debugging, it can be still
useful to be able to supply a key in plain text from userspace.

Implement an optional knob to support this according to the semantics
Jan and Mimi had agreed on here[1].

[1] https://lore.kernel.org/linux-integrity/e8f149cddce55a4e4615396108e4c900cbec75a8.camel@pengutronix.de/

Suggested-by: Jan Luebbe <jlu@pengutronix.de>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
Manual resend.

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
 Documentation/security/keys/trusted-encrypted.rst | 14 +++++++++++-
 security/keys/trusted-keys/Kconfig                | 15 +++++++++++-
 security/keys/trusted-keys/trusted_core.c         | 21 ++++++++++++++--
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 80d5a5af62a1..cc2e677b3bb6 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -188,6 +188,20 @@ Usage::
 specific to TEE device implementation.  The key length for new keys is always
 in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
 
+Trusted Keys: import plain-text key for development
+---------------------------------------------------
+
+Usage::
+
+    keyctl add trusted name "import hex_key_material" ring
+
+For kernels built with ``CONFIG_TRUSTED_KEYS_DEVELOPMENT_IMPORT=y``, new
+trusted keys can be created from existing key material supplied by userspace,
+instead of using random numbers. Once defined, as with random trusted keys,
+userspace cannot extract the plain-text key material again and will only
+ever see encrypted blobs. This option should *not* be enabled for production
+kernels.
+
 Encrypted Keys usage
 --------------------
 
diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
index 24af4aaceebf..8bd69b252bf9 100644
--- a/security/keys/trusted-keys/Kconfig
+++ b/security/keys/trusted-keys/Kconfig
@@ -23,3 +23,18 @@ config TRUSTED_KEYS_TEE
 if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE
 comment "No trust source selected!"
 endif
+
+config TRUSTED_KEYS_DEVELOPMENT_IMPORT
+        bool "Allow creating TRUSTED KEYS from existing key material for development"
+        help
+          This option adds support for creating new trusted keys from
+          existing key material supplied by userspace, instead of using
+          random numbers. Once defined,  as with random trusted keys,
+          userspace cannot extract the plain-text key material again
+          and will only ever see encrypted blobs.
+
+          This option should *only* be enabled for debugging/development.
+          Also, consider using 'keyctl padd' instead of 'keyctl add' to
+          avoid exposing the plain-text key on the process command line.
+
+          If you are unsure as to whether this is required, answer N.
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 8cab69e5d0da..2223e11c8bb5 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -46,12 +46,13 @@ static unsigned char migratable;
 
 enum {
 	Opt_err,
-	Opt_new, Opt_load, Opt_update,
+	Opt_new, Opt_load, Opt_import, Opt_update,
 };
 
 static const match_table_t key_tokens = {
 	{Opt_new, "new"},
 	{Opt_load, "load"},
+	{Opt_import, "import"},
 	{Opt_update, "update"},
 	{Opt_err, NULL}
 };
@@ -100,6 +101,21 @@ static int datablob_parse(char **datablob, struct trusted_key_payload *p)
 			return -EINVAL;
 		ret = Opt_load;
 		break;
+	case Opt_import:
+		if (!IS_ENABLED(CONFIG_TRUSTED_KEYS_DEVELOPMENT_IMPORT))
+			return -EINVAL;
+		/* first argument is unsealed blob */
+		c = strsep(datablob, " \t");
+		if (!c)
+			return -EINVAL;
+		p->key_len = strlen(c) / 2;
+		if (p->key_len < MIN_KEY_SIZE || p->key_len > MAX_KEY_SIZE)
+			return -EINVAL;
+		ret = hex2bin(p->key, c, p->key_len);
+		if (ret < 0)
+			return -EINVAL;
+		ret = Opt_import;
+		break;
 	case Opt_update:
 		ret = Opt_update;
 		break;
@@ -187,7 +203,8 @@ static int trusted_instantiate(struct key *key,
 			ret = -EIO;
 			goto out;
 		}
-
+		fallthrough;
+	case Opt_import:
 		ret = static_call(trusted_key_seal)(payload, datablob);
 		if (ret < 0)
 			pr_info("key_seal failed (%d)\n", ret);
-- 
git-series 0.9.1
