Return-Path: <linux-integrity+bounces-7180-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBBDB86ADE
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 21:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 659027BFC97
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 19:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487B2D5930;
	Thu, 18 Sep 2025 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmfYHpIV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3BF2D480E;
	Thu, 18 Sep 2025 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223829; cv=none; b=DjRbnu/EqW96WTE7m6ahjoK6fvNCccqSYvkLLbBSegcQnUFHKMqkVSINsgvx6v+EeYu0Vl47Sjyn9Gtbl/8n0uAprkqsJPIU1KmnzReYPO7BoBrmJP3urZUQQNIGvSnL4/b2zZAojLtIU5QQ89G7yMG4UCerlPQPNcDKSMUPs9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223829; c=relaxed/simple;
	bh=+5YCwqKLVc63p4jRgCYQdSr3lyy+0EyHai1PV57LIZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Vuj48JqEiFRnVIz02nQn1ch6Tt8kCBPLpNnjf8yyNsRsTRk4Q0dIvTz41XxZqYDBmmG4RmI5ZMvbjqZs3Lan3nOav33Og1UjSs5+xqQH7ZT5xxV14HYM4B4D37LKRoaBDLsGIUpCl3HS+0NFKuWRD4jFvanG7XIoSxz9LvgY/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmfYHpIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBC4C4CEE7;
	Thu, 18 Sep 2025 19:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758223828;
	bh=+5YCwqKLVc63p4jRgCYQdSr3lyy+0EyHai1PV57LIZQ=;
	h=From:To:Cc:Subject:Date:From;
	b=hmfYHpIVAik1Db2b/J0mNgdgv4akeIofNIw/TjWmPPwPv5A9z069H46fYym2n68vb
	 WRqYhlsj1dm4ybjR5utG2x2FusDVrW9uteCB7LvwL68HiWnFTFT4JtJhaM02+7cW9g
	 sRlmF7Fympb+icAxp6DIxFDLWOz4Na/HhDrPn4j324XBCfuIo1ak+CX0FEfb+jdH3S
	 V27suQ87tE7EABThy7RY0UuMdV1HrJ+legsv7gS9nfnojYs2mNjqvjvW3gYr2wZKvA
	 oed5m5qmnTMKk+N5Nu/FVlO1T6S/LGg/PrMcBGxGl8rUczzcFW7ONhPL0P4Oc7N0c9
	 TWmTyKtzSEzQw==
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
Subject: [PATCH v2] tpm: use a map for tpm2_calc_ordinal_duration()
Date: Thu, 18 Sep 2025 22:30:18 +0300
Message-Id: <20250918193019.4018706-1-jarkko@kernel.org>
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
v2:
- Add the missing msec_to_jiffies() calls.
- Drop redundant stuff.
---
 drivers/char/tpm/tpm-interface.c |   2 +-
 drivers/char/tpm/tpm.h           |   2 +-
 drivers/char/tpm/tpm2-cmd.c      | 127 ++++++++-----------------------
 include/linux/tpm.h              |   5 +-
 4 files changed, 37 insertions(+), 99 deletions(-)

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
index 524d802ede26..7d77f6fbc152 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -28,120 +28,57 @@ static struct tpm2_hash tpm2_hash_map[] = {
 
 int tpm2_get_timeouts(struct tpm_chip *chip)
 {
-	/* Fixed timeouts for TPM2 */
 	chip->timeout_a = msecs_to_jiffies(TPM2_TIMEOUT_A);
 	chip->timeout_b = msecs_to_jiffies(TPM2_TIMEOUT_B);
 	chip->timeout_c = msecs_to_jiffies(TPM2_TIMEOUT_C);
 	chip->timeout_d = msecs_to_jiffies(TPM2_TIMEOUT_D);
-
-	/* PTP spec timeouts */
-	chip->duration[TPM_SHORT] = msecs_to_jiffies(TPM2_DURATION_SHORT);
-	chip->duration[TPM_MEDIUM] = msecs_to_jiffies(TPM2_DURATION_MEDIUM);
-	chip->duration[TPM_LONG] = msecs_to_jiffies(TPM2_DURATION_LONG);
-
-	/* Key creation commands long timeouts */
-	chip->duration[TPM_LONG_LONG] =
-		msecs_to_jiffies(TPM2_DURATION_LONG_LONG);
-
 	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
-
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
+			return msecs_to_jiffies(tpm2_ordinal_duration_map[i].duration);
 
-	if (index != TPM_UNDEFINED)
-		return chip->duration[index];
-	else
-		return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
+	return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
 }
 
-
 struct tpm2_pcr_read_out {
 	__be32	update_cnt;
 	__be32	pcr_selects_cnt;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index b0e9eb5ef022..dc0338a783f3 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -228,10 +228,11 @@ enum tpm2_timeouts {
 	TPM2_TIMEOUT_B          =   4000,
 	TPM2_TIMEOUT_C          =    200,
 	TPM2_TIMEOUT_D          =     30,
+};
+
+enum tpm2_durations {
 	TPM2_DURATION_SHORT     =     20,
-	TPM2_DURATION_MEDIUM    =    750,
 	TPM2_DURATION_LONG      =   2000,
-	TPM2_DURATION_LONG_LONG = 300000,
 	TPM2_DURATION_DEFAULT   = 120000,
 };
 
-- 
2.39.5


