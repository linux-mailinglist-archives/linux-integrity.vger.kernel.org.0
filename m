Return-Path: <linux-integrity+bounces-3883-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D76B9A59BC
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2024 07:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC30E1C2103F
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2024 05:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BED01CF5C5;
	Mon, 21 Oct 2024 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB/ijjWx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD41CF2B9;
	Mon, 21 Oct 2024 05:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489175; cv=none; b=GXwQNdXJpMLe31sDcq/y03SK3XV2XEmf5JIQakRhshSFFOR/Cgh3tBWZl7ozhFP38G233aujQsazK+tI48XilvrCeu8V6Hk/+KWfY+0gvB5/10Y+ZIXM/PELLM/rhpKwJGP8UuqwXraYgpZv/CXSRHMD1L1u6TbHhVtZfAf/V+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489175; c=relaxed/simple;
	bh=ClrpSHkVHottrltLmH7Rp4WsaHoZ3VFbzU0VMLWpIHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buRtDcCx6DEl7CXi2UinzAHLAByS6bVE9CNT/g27f2Id5uPAANfEERl8CftoFsadO5DU9GjRFcE85gojvrC0pV22copYFi7Lf+Hn/jibu2s1UG0vC+urr9rZ1bhG96Yo0S1/aEzW4qbv85wNDIPgIzcMyAwff520abdQTmiMbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB/ijjWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04917C4CEE4;
	Mon, 21 Oct 2024 05:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729489174;
	bh=ClrpSHkVHottrltLmH7Rp4WsaHoZ3VFbzU0VMLWpIHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eB/ijjWx0Ki7CwzyliqkJIGspPsg1wLnv1gVWpAQchlLmnUvWIRrGVU2wWP48FHNR
	 UnUFA+/sH31YjkbZFFIEEFaNGz5RFLz/lHj2uS5PtYHi3XBHIZZxOQRog76w9cMY8n
	 OdZWmlgp1fMWQfJiGh50BJnW+CR9miA3WCNmR/Ou7u45kEPDaFoMUEqUJHI/ia1od8
	 Vzq3WZvD2a4b1rsJKl9vl1/JpJznz+ExEyLqLyp9Nn1oKr5hDTyCha/rYP3UhTO/E1
	 GfPHW02MXldtQA/qD+JYagAyPpxF6JrhAvJzdDl2hGAsSclrywS50eTY5sv1GJBEk/
	 vR7LYgzTExPww==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v7 1/5] tpm: Return on tpm2_create_null_primary() failure
Date: Mon, 21 Oct 2024 08:39:15 +0300
Message-ID: <20241021053921.33274-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021053921.33274-1-jarkko@kernel.org>
References: <20241021053921.33274-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_sessions_init() does not ignore the result of
tpm2_create_null_primary(). Address this by returning -ENODEV to the
caller. Given that upper layers cannot help healing the situation
further, deal with the TPM error here by

Cc: stable@vger.kernel.org # v6.10+
Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v7:
- Add the error message back but fix it up a bit:
  1. Remove 'TPM:' given dev_err().
  2. s/NULL/null/ as this has nothing to do with the macro in libc.
  3. Fix the reasoning: null key creation failed
v6:
- Address:
  https://lore.kernel.org/linux-integrity/69c893e7-6b87-4daa-80db-44d1120e80fe@linux.ibm.com/
  as TPM RC is taken care of at the call site. Add also the missing
  documentation for the return values.
v5:
- Do not print klog messages on error, as tpm2_save_context() already
  takes care of this.
v4:
- Fixed up stable version.
v3:
- Handle TPM and POSIX error separately and return -ENODEV always back
  to the caller.
v2:
- Refined the commit message.
---
 drivers/char/tpm/tpm2-sessions.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d3521aadd43e..1e12e0b2492e 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1347,14 +1347,21 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
  *
  * Derive and context save the null primary and allocate memory in the
  * struct tpm_chip for the authorizations.
+ *
+ * Return:
+ * * 0		- OK
+ * * -errno	- A system error
+ * * TPM_RC	- A TPM error
  */
 int tpm2_sessions_init(struct tpm_chip *chip)
 {
 	int rc;
 
 	rc = tpm2_create_null_primary(chip);
-	if (rc)
-		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
+	if (rc) {
+		dev_err(&chip->dev, "null primary key creation failed with %d\n", rc);
+		return rc;
+	}
 
 	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
 	if (!chip->auth)
-- 
2.47.0


