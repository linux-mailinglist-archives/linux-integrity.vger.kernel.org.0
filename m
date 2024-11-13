Return-Path: <linux-integrity+bounces-4098-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A49C65ED
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 01:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995DD285D1E
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 00:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735378F6C;
	Wed, 13 Nov 2024 00:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdKiHvRJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD5A5680;
	Wed, 13 Nov 2024 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457462; cv=none; b=iETuJL5J9qaIWBJXjH4UFvW2DoNA9ggL9/34PTVpYSiTuraXjGxyQjGkF2WEqUsI/6wHsi7dW75a4nqExkyJIzsDxI1+09QryyQ2RDvXIFlLjKUMd3K65eHdTF6RO1ckGcpT2KjSNe4liBpyGs+bg2tKpdNi8KdPSwAwEVV48vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457462; c=relaxed/simple;
	bh=zPGDDofFmfmk/Ba1bQlRmIX92zLydbyjQuQhjINhw2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXf2bVW0Ve4SdUHXEJyzhYi3XgT1Ii55X2kU78S0dRG7Sc/W/vIxdwHguNeezeNNacVmczZU7Mzju+sHIzXwLIOnMR5qWaFSMsK2Wgl6rYPu4yxQzb9AntR4r0EFzo+E1Y79ruUJCt4RnwHhZ4GAbRylJ+4gmwgcPg3pjsI1nRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdKiHvRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30645C4CECD;
	Wed, 13 Nov 2024 00:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731457460;
	bh=zPGDDofFmfmk/Ba1bQlRmIX92zLydbyjQuQhjINhw2M=;
	h=From:To:Cc:Subject:Date:From;
	b=mdKiHvRJq5u0OLwL50GIUPj+y26VWhpo4WpGbHP1iZx+6JYgjiFseTMhAbsL/B85w
	 Al3lYewk5r8oZtDkSfHmqRVmPLQtfApLyIfQYy5HU85kAEQaKPpodh23xdW6UHP1or
	 3pEkYZfCtz9u7zzQs2Fs9xivQ2SLgFsgfbrmwYpAuXk+JYkmfamZxO+1CEgdU+5JwN
	 16Z1GOlUAeaEJyHtyj4rTmlpVESKskSDS3gjMI4G63o+yJxUUt8ntsTjyzKeAu39LY
	 hkOoE1lZ+pCverSHMJhaW7kAxdaEwYfmJ4vMPlZVsox1r3HdkCF3Vc/Ji4/AnkCbHt
	 eJPkx/W6KHePQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Thomas Huth <thuth@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH v3] tpm: Opt-in in disable PCR integrity protection
Date: Wed, 13 Nov 2024 02:24:07 +0200
Message-ID: <20241113002414.609168-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial HMAC session feature added TPM bus encryption and/or integrity
protection to various in-kernel TPM operations. This can cause performance
bottlenecks with IMA, as it heavily utilizes PCR extend operations.

In order to mitigate this performance issue, introduce a kernel
command-line parameter to the TPM driver for disabling the integrity
protection for PCR extend operations (i.e. TPM2_PCR_Extend).

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Link: https://lore.kernel.org/linux-integrity/20241015193916.59964-1-zohar@linux.ibm.com/
Fixes: 6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()")
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
- Please test this too ;-) I did quick testing only.
- Fixed the reported glitches and mistakes.
v2:
- Followed Mimi's suggestions.
---
 .../admin-guide/kernel-parameters.txt         |  9 ++++
 drivers/char/tpm/tpm-buf.c                    | 20 ++++++++
 drivers/char/tpm/tpm2-cmd.c                   | 30 ++++++++---
 drivers/char/tpm/tpm2-sessions.c              | 51 ++++++++++---------
 include/linux/tpm.h                           |  3 ++
 5 files changed, 82 insertions(+), 31 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1666576acc0e..7107ad322b2e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6727,6 +6727,15 @@
 	torture.verbose_sleep_duration= [KNL]
 			Duration of each verbose-printk() sleep in jiffies.
 
+	tpm.disable_pcr_integrity_protection= [HW,TPM]
+			Do not protect PCR registers from unintended physical
+			access, or interposers in the bus by the means of
+			having an integrity protected session wrapped around
+			TPM2_PCR_Extend command. Consider this in a situation
+			where TPM is heavily utilized by IMA, thus protection
+			causing a major performance hit, and the space where
+			machines are deployed is by other means guarded.
+
 	tpm_suspend_pcr=[HW,TPM]
 			Format: integer pcr id
 			Specify that at suspend time, the tpm driver
diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index cad0048bcc3c..e49a19fea3bd 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -146,6 +146,26 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
 
+/**
+ * tpm_buf_append_handle() - Add a handle
+ * @chip:	&tpm_chip instance
+ * @buf:	&tpm_buf instance
+ * @handle:	a TPM object handle
+ *
+ * Add a handle to the buffer, and increase the count tracking the number of
+ * handles in the command buffer. Works only for command buffers.
+ */
+void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle)
+{
+	if (buf->flags & TPM_BUF_TPM2B) {
+		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
+		return;
+	}
+
+	tpm_buf_append_u32(buf, handle);
+	buf->handles++;
+}
+
 /**
  * tpm_buf_read() - Read from a TPM buffer
  * @buf:	&tpm_buf instance
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 1e856259219e..dfdcbd009720 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -14,6 +14,10 @@
 #include "tpm.h"
 #include <crypto/hash_info.h>
 
+static bool disable_pcr_integrity;
+module_param(disable_pcr_integrity, bool, 0444);
+MODULE_PARM_DESC(disable_pcr_integrity, "Disable integrity protection of TPM2_PCR_Extend");
+
 static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
@@ -232,18 +236,26 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	int rc;
 	int i;
 
-	rc = tpm2_start_auth_session(chip);
-	if (rc)
-		return rc;
+	if (!disable_pcr_integrity) {
+		rc = tpm2_start_auth_session(chip);
+		if (rc)
+			return rc;
+	}
 
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
 	if (rc) {
-		tpm2_end_auth_session(chip);
+		if (!disable_pcr_integrity)
+			tpm2_end_auth_session(chip);
 		return rc;
 	}
 
-	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
-	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
+	if (!disable_pcr_integrity) {
+		tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
+		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
+	} else {
+		tpm_buf_append_handle(chip, &buf, pcr_idx);
+		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
+	}
 
 	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
 
@@ -253,9 +265,11 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			       chip->allocated_banks[i].digest_size);
 	}
 
-	tpm_buf_fill_hmac_session(chip, &buf);
+	if (!disable_pcr_integrity)
+		tpm_buf_fill_hmac_session(chip, &buf);
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
-	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
+	if (!disable_pcr_integrity)
+		rc = tpm_buf_check_hmac_response(chip, &buf, rc);
 
 	tpm_buf_destroy(&buf);
 
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 42df980168b6..a7c1b162251b 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -237,9 +237,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_u32(buf, handle);
-		/* count the number of handles in the upper bits of flags */
-		buf->handles++;
+		tpm_buf_append_handle(chip, buf, handle);
 		return;
 	}
 
@@ -272,6 +270,31 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
 
+void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
+			 u8 attributes, u8 *passphrase, int passphrase_len)
+{
+	/* offset tells us where the sessions area begins */
+	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
+	u32 len = 9 + passphrase_len;
+
+	if (tpm_buf_length(buf) != offset) {
+		/* not the first session so update the existing length */
+		len += get_unaligned_be32(&buf->data[offset]);
+		put_unaligned_be32(len, &buf->data[offset]);
+	} else {
+		tpm_buf_append_u32(buf, len);
+	}
+	/* auth handle */
+	tpm_buf_append_u32(buf, TPM2_RS_PW);
+	/* nonce */
+	tpm_buf_append_u16(buf, 0);
+	/* attributes */
+	tpm_buf_append_u8(buf, 0);
+	/* passphrase */
+	tpm_buf_append_u16(buf, passphrase_len);
+	tpm_buf_append(buf, passphrase, passphrase_len);
+}
+
 /**
  * tpm_buf_append_hmac_session() - Append a TPM session element
  * @chip: the TPM chip structure
@@ -309,26 +332,8 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		/* offset tells us where the sessions area begins */
-		int offset = buf->handles * 4 + TPM_HEADER_SIZE;
-		u32 len = 9 + passphrase_len;
-
-		if (tpm_buf_length(buf) != offset) {
-			/* not the first session so update the existing length */
-			len += get_unaligned_be32(&buf->data[offset]);
-			put_unaligned_be32(len, &buf->data[offset]);
-		} else {
-			tpm_buf_append_u32(buf, len);
-		}
-		/* auth handle */
-		tpm_buf_append_u32(buf, TPM2_RS_PW);
-		/* nonce */
-		tpm_buf_append_u16(buf, 0);
-		/* attributes */
-		tpm_buf_append_u8(buf, 0);
-		/* passphrase */
-		tpm_buf_append_u16(buf, passphrase_len);
-		tpm_buf_append(buf, passphrase, passphrase_len);
+		tpm_buf_append_auth(chip, buf, attributes, passphrase,
+				    passphrase_len);
 		return;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 587b96b4418e..20a40ade8030 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -421,6 +421,7 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
+void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
@@ -505,6 +506,8 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
+void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
+			 u8 attributes, u8 *passphrase, int passphraselen);
 static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
 						   struct tpm_buf *buf,
 						   u8 attributes,
-- 
2.47.0


