Return-Path: <linux-integrity+bounces-7177-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0946B86999
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 20:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB887AE37D
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F35D2D322C;
	Thu, 18 Sep 2025 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwfjXqhs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2802D24B2;
	Thu, 18 Sep 2025 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221861; cv=none; b=rp0Qia5moD9huFxCGxjmE/JgLheE+FfTQAmor93ADwmYkljqjQG5saNVWmxtvUV5zaEQJvCVxd5gWDTiR4zLqowkob0CRqM7a6+CE2IN/7BoBMpiv4Yw0ZRHQh08ATxBV1g88GDrfGQbROOG3I09mQmPROOJh6Qg6RbWcfM3PeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221861; c=relaxed/simple;
	bh=eo62sjvEW4m0PbQoyK5Dmy0ck/Z0ZRa8jx0aupoWN9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F2oVagHTm5ZrdkeSz98ZxWj2/NKHB2ST7G/l1eYMx/75gnD6uvp8tp+v1nrrxzckOvpmetflE4DRaYxOZqc9NOcoNtAuV+AedgYuydaRm+3H7LsYRg9Mh5/YMDMyp6bqn8NlRpYRQAAHgZo/lutaVdQiYOZabc/MJozszzktvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwfjXqhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0036C4CEE7;
	Thu, 18 Sep 2025 18:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758221861;
	bh=eo62sjvEW4m0PbQoyK5Dmy0ck/Z0ZRa8jx0aupoWN9w=;
	h=From:To:Cc:Subject:Date:From;
	b=TwfjXqhs6GWjpSKHXCVEbSMrAF9uXoBYY8EgrY3lHvRSgeDktbzWE1yv6A9Vd8ciL
	 7m+nA+OQpskMkUUnvPRdLah+5wACMS4yKr6flUWk7qVOin/29IieiMGt+1dajF0PGI
	 Q9ofJuwVnih9Hu8QqDFqZtbvzRbtGLdMIlKE3TC9JNOCub2S+3tWRjmseFdcBSP8kG
	 aGNFzlcNUN7j4CdjpExpzJdJAnxmsArSlY/AN8jPokKfYNR8rVa1OVHbS4+rclNBv6
	 ro37XiImEpujfBLNnT0OQiWJGmOgqzmB//IGcL0iLvRwKHz7zdQmRAsdNAZ6OClM1B
	 jnHBi3RUwvNQg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Jouen?= <fjouen@sealsq.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH] tpm: use a map for tpm2_calc_ordinal_duration()
Date: Thu, 18 Sep 2025 21:57:30 +0300
Message-Id: <20250918185730.3529317-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current shenanigans for duration calculation introduce too much
complexity for a trivial problem, and further the code is hard to patch and
maintain.

Address these issues with a flat look-up table, which is easy to understand
and patch. If leaf driver specific patching is required in future, it is
easy enough to make a copy of this table during driver initialization and
add the chip parameter back.

'chip->duration' is retained for TPM 1.x.

As the first entry for this new behavior address TCG spec update mentioned
in this issue:

https://github.com/raspberrypi/linux/issues/7054

Therefore, for TPM_SelfTest the duration is set to 3000 ms.

This does not categorize a as bug, given that this is introduced to the
spec after the feature was originally made.

Cc: Frédéric Jouen <fjouen@sealsq.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-interface.c |   2 +-
 drivers/char/tpm/tpm.h           |   2 +-
 drivers/char/tpm/tpm2-cmd.c      | 115 +++++++++----------------------
 3 files changed, 34 insertions(+), 85 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index b71725827743..c9f173001d0e 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -52,7 +52,7 @@ MODULE_PARM_DESC(suspend_pcr,
 unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 {
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		return tpm2_calc_ordinal_duration(chip, ordinal);
+		return tpm2_calc_ordinal_duration(ordinal);
 	else
 		return tpm1_calc_ordinal_duration(chip, ordinal);
 }
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 7bb87fa5f7a1..2726bd38e5ac 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -299,7 +299,7 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
 int tpm2_auto_startup(struct tpm_chip *chip);
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
-unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
+unsigned long tpm2_calc_ordinal_duration(u32 ordinal);
 int tpm2_probe(struct tpm_chip *chip);
 int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
 int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 524d802ede26..29c0d6a8ec20 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -48,100 +48,49 @@ int tpm2_get_timeouts(struct tpm_chip *chip)
 	return 0;
 }
 
-/**
- * tpm2_ordinal_duration_index() - returns an index to the chip duration table
- * @ordinal: TPM command ordinal.
- *
- * The function returns an index to the chip duration table
- * (enum tpm_duration), that describes the maximum amount of
- * time the chip could take to return the result for a  particular ordinal.
- *
- * The values of the MEDIUM, and LONG durations are taken
- * from the PC Client Profile (PTP) specification (750, 2000 msec)
- *
- * LONG_LONG is for commands that generates keys which empirically takes
- * a longer time on some systems.
- *
- * Return:
- * * TPM_MEDIUM
- * * TPM_LONG
- * * TPM_LONG_LONG
- * * TPM_UNDEFINED
+/*
+ * Contains the maximum durations in milliseconds for TPM2 commands.
  */
-static u8 tpm2_ordinal_duration_index(u32 ordinal)
-{
-	switch (ordinal) {
-	/* Startup */
-	case TPM2_CC_STARTUP:                 /* 144 */
-		return TPM_MEDIUM;
-
-	case TPM2_CC_SELF_TEST:               /* 143 */
-		return TPM_LONG;
-
-	case TPM2_CC_GET_RANDOM:              /* 17B */
-		return TPM_LONG;
-
-	case TPM2_CC_SEQUENCE_UPDATE:         /* 15C */
-		return TPM_MEDIUM;
-	case TPM2_CC_SEQUENCE_COMPLETE:       /* 13E */
-		return TPM_MEDIUM;
-	case TPM2_CC_EVENT_SEQUENCE_COMPLETE: /* 185 */
-		return TPM_MEDIUM;
-	case TPM2_CC_HASH_SEQUENCE_START:     /* 186 */
-		return TPM_MEDIUM;
-
-	case TPM2_CC_VERIFY_SIGNATURE:        /* 177 */
-		return TPM_LONG_LONG;
-
-	case TPM2_CC_PCR_EXTEND:              /* 182 */
-		return TPM_MEDIUM;
-
-	case TPM2_CC_HIERARCHY_CONTROL:       /* 121 */
-		return TPM_LONG;
-	case TPM2_CC_HIERARCHY_CHANGE_AUTH:   /* 129 */
-		return TPM_LONG;
-
-	case TPM2_CC_GET_CAPABILITY:          /* 17A */
-		return TPM_MEDIUM;
-
-	case TPM2_CC_NV_READ:                 /* 14E */
-		return TPM_LONG;
-
-	case TPM2_CC_CREATE_PRIMARY:          /* 131 */
-		return TPM_LONG_LONG;
-	case TPM2_CC_CREATE:                  /* 153 */
-		return TPM_LONG_LONG;
-	case TPM2_CC_CREATE_LOADED:           /* 191 */
-		return TPM_LONG_LONG;
-
-	default:
-		return TPM_UNDEFINED;
-	}
-}
+static const struct {
+	unsigned long ordinal;
+	unsigned long duration;
+} tpm2_ordinal_duration_map[] = {
+	{TPM2_CC_STARTUP, 750},
+	{TPM2_CC_SELF_TEST, 3000},
+	{TPM2_CC_GET_RANDOM, 2000},
+	{TPM2_CC_SEQUENCE_UPDATE, 750},
+	{TPM2_CC_SEQUENCE_COMPLETE, 750},
+	{TPM2_CC_EVENT_SEQUENCE_COMPLETE, 750},
+	{TPM2_CC_HASH_SEQUENCE_START, 750},
+	{TPM2_CC_VERIFY_SIGNATURE, 30000},
+	{TPM2_CC_PCR_EXTEND, 750},
+	{TPM2_CC_HIERARCHY_CONTROL, 2000},
+	{TPM2_CC_HIERARCHY_CHANGE_AUTH, 2000},
+	{TPM2_CC_GET_CAPABILITY, 750},
+	{TPM2_CC_NV_READ, 2000},
+	{TPM2_CC_CREATE_PRIMARY, 30000},
+	{TPM2_CC_CREATE, 30000},
+	{TPM2_CC_CREATE_LOADED, 30000},
+};
 
 /**
- * tpm2_calc_ordinal_duration() - calculate the maximum command duration
- * @chip:    TPM chip to use.
+ * tpm2_calc_ordinal_duration() - Calculate the maximum command duration
  * @ordinal: TPM command ordinal.
  *
- * The function returns the maximum amount of time the chip could take
- * to return the result for a particular ordinal in jiffies.
- *
- * Return: A maximal duration time for an ordinal in jiffies.
+ * Returns the maximum amount of time the chip is expected by kernel to
+ * take in jiffies.
  */
-unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
+unsigned long tpm2_calc_ordinal_duration(u32 ordinal)
 {
-	unsigned int index;
+	int i;
 
-	index = tpm2_ordinal_duration_index(ordinal);
+	for (i = 0; i < ARRAY_SIZE(tpm2_ordinal_duration_map); i++)
+		if (ordinal == tpm2_ordinal_duration_map[i].ordinal)
+			return tpm2_ordinal_duration_map[i].duration;
 
-	if (index != TPM_UNDEFINED)
-		return chip->duration[index];
-	else
-		return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
+	return TPM2_DURATION_DEFAULT;
 }
 
-
 struct tpm2_pcr_read_out {
 	__be32	update_cnt;
 	__be32	pcr_selects_cnt;
-- 
2.39.5


