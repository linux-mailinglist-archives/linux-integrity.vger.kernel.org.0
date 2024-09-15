Return-Path: <linux-integrity+bounces-3605-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF39E979808
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 20:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE4D1C20B18
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 18:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ECE1CA6B8;
	Sun, 15 Sep 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh23gf/I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE7917C91;
	Sun, 15 Sep 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726423506; cv=none; b=Y2g+TWPj0lWu7oPw9VY9g7K/AIyx6YIRKslQaMy4gOtpKTgfgNhSHyN0I7ZSLn2XHvyr684WX0Qvf48Mtx68vJCe4LO0xQHvn3XNudXgmrWWgmPrn8wszq3aHTRdchCdeENAdpEtkZG1pqAKYD8tPsh2IHzbSH3R/PUOlvWL6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726423506; c=relaxed/simple;
	bh=cDWRjXQdn9KpsOVLFzVh/g6BNIDKx0+yYAU65TAkxQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNFIuX6CZ6SQ6TJRdAgNetKbH4/xfiQEQOUlu8kY+j8Xao3D2MP4L+lSyhW70dOdiD6e9HEZSf7HigiLUwiE8HXt4jDDokKCnDKs32odAMK+C6DbrhVvj/4wrvPHtstDVdT5qAfQeGsl5W8lC6deFAvKeeRs7IWghE7JcIiCrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh23gf/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F50C4CEC3;
	Sun, 15 Sep 2024 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726423506;
	bh=cDWRjXQdn9KpsOVLFzVh/g6BNIDKx0+yYAU65TAkxQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gh23gf/IkEMu2/XaDYLRW5lfTA3UzZYwqVwOZ9cwxZbmYjevtS3sytwP8zRKVTqXe
	 VVum5obZXAIHWtVy1TcpRx3jjwb2w7MOXlITaQC0+D/55zcdf512SJ2HDaXSOEgcav
	 iylpDARmHpORFMchRrChfcqH8jgN9lyKvPojs43Y4gWoK+o51WTdKturvbeZWdvh+c
	 ZO/OmdYhoE+tgJB54+24P8jeiT4nmYYAL4X20uIkpyB3OkpFCn/Is3XyD4uIDPu742
	 21dw4K7a5ZyqMMp0F7X99NgLdaXh45tHKxaKdGtwFwNuQ2ufwQS5kAX5JRsSxNAkgB
	 tyYZxbAcJHApQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] tpm: address tpm2_create_primary() failure
Date: Sun, 15 Sep 2024 21:04:45 +0300
Message-ID: <20240915180448.2030115-4-jarkko@kernel.org>
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

tpm2_load_null() ignores the return value of tpm2_create_primary(). Return
instead on failure. On success when the null key name has not been changed
heal appropriately, and return the created key handle instead of flushing
it.

Fixes: eb24c9788cd9 ("tpm: disable the TPM if NULL name changes")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d63510ad44ab..34ce0d9d4577 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -850,9 +850,10 @@ static int tpm2_parse_start_auth_session(struct tpm2_auth *auth,
 
 static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
 {
-	int rc;
 	unsigned int offset = 0; /* dummy offset for null seed context */
 	u8 name[SHA256_DIGEST_SIZE + 2];
+	u32 tmp_null_key;
+	int rc;
 
 	rc = tpm2_load_context(chip, chip->null_key_context, &offset,
 			       null_key);
@@ -861,11 +862,17 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
 
 	/* an integrity failure may mean the TPM has been reset */
 	dev_err(&chip->dev, "NULL key integrity failure!\n");
-	/* check the null name against what we know */
-	tpm2_create_primary(chip, TPM2_RH_NULL, NULL, name);
-	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0)
-		/* name unchanged, assume transient integrity failure */
+
+	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &tmp_null_key, name);
+	if (rc)
 		return rc;
+
+	/* Return the null key if the name has not been changed: */
+	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0) {
+		*null_key = tmp_null_key;
+		return 0;
+	}
+
 	/*
 	 * Fatal TPM failure: the NULL seed has actually changed, so
 	 * the TPM must have been illegally reset.  All in-kernel TPM
@@ -874,6 +881,7 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
 	 * userspace programmes can't be compromised by it.
 	 */
 	dev_err(&chip->dev, "NULL name has changed, disabling TPM due to interference\n");
+	tpm2_flush_context(chip, tmp_null_key);
 	chip->flags |= TPM_CHIP_FLAG_DISABLE;
 
 	return rc;
@@ -991,10 +999,6 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
 	u32 val, param_len, keyhandle;
 
 	keyhandle = tpm_buf_read_u32(buf, &offset_r);
-	if (handle)
-		*handle = keyhandle;
-	else
-		tpm2_flush_context(chip, keyhandle);
 
 	param_len = tpm_buf_read_u32(buf, &offset_r);
 	/*
@@ -1135,6 +1139,7 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
 		return -EINVAL;
 	}
 
+	*handle = keyhandle;
 	return 0;
 }
 
-- 
2.46.0


