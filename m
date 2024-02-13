Return-Path: <linux-integrity+bounces-1180-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E18D085372A
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 18:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200561C243A1
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549805FEEB;
	Tue, 13 Feb 2024 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="oTXtnjlt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6605FDDF;
	Tue, 13 Feb 2024 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844902; cv=none; b=ZMXrutiXdtnZuCCDiJtk9K0Nu2xl8vMFVQuUwWSFbiiL53PK31GmD/ExF3Hf4yseHgoRxjrRYdwoN/C1H8MzsS1RFEnDL92mief26p6+qWz3hO0exOrbLqVRnU35frxTPyGmZsS6pWvGppjKEiGoiax0UUdpxxaLen646RY8jM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844902; c=relaxed/simple;
	bh=Cko+6A+nnZkw5y/pYgGYflP0aP9gR/kov7SixeNqKaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTx337YTwyUjQ+uKlJejoq5In5GKjFKPNBeQICshd8aZarYHXFH90Mpwl6Ds+vQPQYRKIw27eJD8wUWorzuk9cYrML2eHoDZJN/jOh4CKc81jezpKvA4XvRo/OrmFnhXZRnvZ/H0qxOwOkKXrTB7EtUEbnNpwjF4830jHQme8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=oTXtnjlt; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707844899;
	bh=Cko+6A+nnZkw5y/pYgGYflP0aP9gR/kov7SixeNqKaI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=oTXtnjlt/zObEsy8crooKV9ON558AQKWQlvs/OnsAIIAPJlK9BDavnAfiy1zrj7yT
	 IB8KptYQNlyP3szfjv97c4KuHj/EvGmsJmLwDkJ9T0uul2z+sNaqQnfryrsCluh1oQ
	 365Awv7EiX5gIFkgTipqZ+OU4PSmSAHESktSoJK4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8DF701280D89;
	Tue, 13 Feb 2024 12:21:39 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Dwf2YOTG0V87; Tue, 13 Feb 2024 12:21:39 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id A4B7E1280C16;
	Tue, 13 Feb 2024 12:21:38 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v7 17/21] tpm: add session encryption protection to tpm2_get_random()
Date: Tue, 13 Feb 2024 12:13:30 -0500
Message-Id: <20240213171334.30479-18-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If some entity is snooping the TPM bus, they can see the random
numbers we're extracting from the TPM and do prediction attacks
against their consumers.  Foil this attack by using response
encryption to prevent the attacker from seeing the random sequence.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

---
v7: add review
---
 drivers/char/tpm/tpm2-cmd.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a53a843294ed..0cdf892ec2a7 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -292,25 +292,35 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	if (!num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	err = tpm_buf_init(&buf, 0, 0);
+	err = tpm2_start_auth_session(chip);
 	if (err)
 		return err;
 
+	err = tpm_buf_init(&buf, 0, 0);
+	if (err) {
+		tpm2_end_auth_session(chip);
+		return err;
+	}
+
 	do {
-		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT
+						| TPM2_SA_CONTINUE_SESSION,
+						NULL, 0);
 		tpm_buf_append_u16(&buf, num_bytes);
+		tpm_buf_fill_hmac_session(chip, &buf);
 		err = tpm_transmit_cmd(chip, &buf,
 				       offsetof(struct tpm2_get_random_out,
 						buffer),
 				       "attempting get random");
+		err = tpm_buf_check_hmac_response(chip, &buf, err);
 		if (err) {
 			if (err > 0)
 				err = -EIO;
 			goto out;
 		}
 
-		out = (struct tpm2_get_random_out *)
-			&buf.data[TPM_HEADER_SIZE];
+		out = (struct tpm2_get_random_out *)tpm_buf_parameters(&buf);
 		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
 		if (tpm_buf_length(&buf) <
 		    TPM_HEADER_SIZE +
@@ -327,9 +337,12 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	} while (retries-- && total < max);
 
 	tpm_buf_destroy(&buf);
+	tpm2_end_auth_session(chip);
+
 	return total ? total : -EIO;
 out:
 	tpm_buf_destroy(&buf);
+	tpm2_end_auth_session(chip);
 	return err;
 }
 
-- 
2.35.3


