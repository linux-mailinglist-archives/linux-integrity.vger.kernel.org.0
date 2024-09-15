Return-Path: <linux-integrity+bounces-3606-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1DC97980A
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 20:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9B61F219A0
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5711CB31B;
	Sun, 15 Sep 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKX9Uuk1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350B81CB318;
	Sun, 15 Sep 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726423512; cv=none; b=mpB1Opd7O+1JvbLDbjvRHJihni8e6mRqhDbCpphvNyvn/fLGPqrv9i9N0/yWgBJskYTYyMV3agneXbfym8vPVqfHG9lXhoIkBfeHTixj2lcmMD0kdK9ASMC6gB72xyJK/2eUuTNYYtoRqYSx/TuW55MtiMguKAGqTvZswXLAgsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726423512; c=relaxed/simple;
	bh=pJB+gvoxB2IwXeXptgWGI8FB54z9gpIY0FmdSPIoBaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpgaURt2JoOB+Nbtd/LtSAJuKE3d5SZP1kxE1aoW3SbvTHEnl3+jjhr2trdEIMqk0/g5C0wCLAcP3qzne0NyYYNOpwMlEKBHJBVTGVwIq03Mwl2chKGuQIp62hqZUGuUjS+AdQV6+if4+S02np3SIzsD9PSPrL3i+ZTow1wZO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKX9Uuk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E10C4CEC3;
	Sun, 15 Sep 2024 18:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726423511;
	bh=pJB+gvoxB2IwXeXptgWGI8FB54z9gpIY0FmdSPIoBaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKX9Uuk1spKCi+Hw0guxSwKslWX0t9gJGaHTEwK7+8Ihf/mh+yw2vOme/lnos4xHe
	 h7KlbX+hohx5Cz4HPYVoS09o5fNJ4BagOgaeE1y/HoqGPMl4Uh48bkICkuaqljsS4E
	 k92Y0G1Chlx171QumRuE/TJwftB2Xc6cytenkAndIgW7mfWElsu9XHbkZRyqKX1Q0W
	 JHOYTmM6wgjotukZaAwRyxy/aI7Bx7slJ6ucsErsfwUfTA0vjQIuLLRD0UBGNUzwYj
	 bA1XS8H+OuxVoQmPnsgj2+/rzHbmzrOkilEPvyvSVpGYXG4gFHgUhHgk5Zs2l/aOgv
	 SiTejSKVcTtDQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] tpm: flush the session null key only when required
Date: Sun, 15 Sep 2024 21:04:46 +0300
Message-ID: <20240915180448.2030115-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240915180448.2030115-1-jarkko@kernel.org>
References: <20240915180448.2030115-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of flushing and reloading the null key for every single auth
session, flush it only when:

1. User space needs to access /dev/tpm{rm}0.
2. When going to sleep.
3. When unregistering the chip.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-chip.c       | 13 +++++++++++++
 drivers/char/tpm/tpm-dev-common.c |  7 +++++++
 drivers/char/tpm/tpm-interface.c  |  9 +++++++--
 drivers/char/tpm/tpm2-cmd.c       |  3 +++
 drivers/char/tpm/tpm2-sessions.c  | 23 +++++++++++++++++++----
 include/linux/tpm.h               |  2 ++
 6 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 854546000c92..0ea00e32f575 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -674,6 +674,19 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
  */
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
+#ifdef CONFIG_TCG_TPM2_HMAC
+	int rc;
+
+	rc = tpm_try_get_ops(chip);
+	if (!rc) {
+		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+			tpm2_flush_context(chip, chip->null_key);
+			chip->null_key = 0;
+		}
+		tpm_put_ops(chip);
+	}
+#endif
+
 	tpm_del_legacy_sysfs(chip);
 	if (tpm_is_hwrng_enabled(chip))
 		hwrng_unregister(&chip->hwrng);
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index c3fbbf4d3db7..4bc07963e260 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -27,6 +27,13 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	struct tpm_header *header = (void *)buf;
 	ssize_t ret, len;
 
+#ifdef CONFIG_TCG_TPM2_HMAC
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		tpm2_flush_context(chip, chip->null_key);
+		chip->null_key = 0;
+	}
+#endif
+
 	ret = tpm2_prepare_space(chip, space, buf, bufsiz);
 	/* If the command is not implemented by the TPM, synthesize a
 	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 5da134f12c9a..bfa47d48b0f2 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -379,10 +379,15 @@ int tpm_pm_suspend(struct device *dev)
 
 	rc = tpm_try_get_ops(chip);
 	if (!rc) {
-		if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+#ifdef CONFIG_TCG_TPM2_HMAC
+			tpm2_flush_context(chip, chip->null_key);
+			chip->null_key = 0;
+#endif
 			tpm2_shutdown(chip, TPM2_SU_STATE);
-		else
+		} else {
 			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
+		}
 
 		tpm_put_ops(chip);
 	}
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 1e856259219e..aba024cbe7c5 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -364,6 +364,9 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 	struct tpm_buf buf;
 	int rc;
 
+	if (!handle)
+		return;
+
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
 	if (rc) {
 		dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 34ce0d9d4577..8d7b708ce566 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -855,10 +855,21 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
 	u32 tmp_null_key;
 	int rc;
 
+	/* fast path */
+	if (chip->null_key) {
+		*null_key = chip->null_key;
+		return 0;
+	}
+
 	rc = tpm2_load_context(chip, chip->null_key_context, &offset,
-			       null_key);
-	if (rc != -EINVAL)
+			       &tmp_null_key);
+	if (rc != -EINVAL) {
+		if (!rc) {
+			chip->null_key = tmp_null_key;
+			*null_key = tmp_null_key;
+		}
 		return rc;
+	}
 
 	/* an integrity failure may mean the TPM has been reset */
 	dev_err(&chip->dev, "NULL key integrity failure!\n");
@@ -869,6 +880,7 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
 
 	/* Return the null key if the name has not been changed: */
 	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0) {
+		chip->null_key = tmp_null_key;
 		*null_key = tmp_null_key;
 		return 0;
 	}
@@ -946,7 +958,6 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
 
 	rc = tpm_transmit_cmd(chip, &buf, 0, "start auth session");
-	tpm2_flush_context(chip, null_key);
 
 	if (rc == TPM2_RC_SUCCESS)
 		rc = tpm2_parse_start_auth_session(auth, &buf);
@@ -1275,7 +1286,11 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
 
 		rc = tpm2_save_context(chip, null_key, chip->null_key_context,
 				       sizeof(chip->null_key_context), &offset);
-		tpm2_flush_context(chip, null_key);
+		pr_info("%s: rc=0x%08x\n", __func__, rc);
+		if (rc)
+			tpm2_flush_context(chip, null_key);
+		else
+			chip->null_key = null_key;
 	}
 
 	return rc;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index e93ee8d936a9..4eb39db80e05 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -205,6 +205,8 @@ struct tpm_chip {
 #ifdef CONFIG_TCG_TPM2_HMAC
 	/* details for communication security via sessions */
 
+	/* loaded null key */
+	u32 null_key;
 	/* saved context for NULL seed */
 	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE];
 	 /* name of NULL seed */
-- 
2.46.0


