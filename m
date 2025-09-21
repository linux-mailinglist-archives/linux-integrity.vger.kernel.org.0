Return-Path: <linux-integrity+bounces-7209-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4691B8D367
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 04:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797247B403B
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 02:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114291A0BE0;
	Sun, 21 Sep 2025 02:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQl+2uD+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BFD17B418;
	Sun, 21 Sep 2025 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758420502; cv=none; b=G2zof7z+x7Hw/3r/ozE2qrhvPHEZia/gHIBUx+QE0dgszOydSU5aPadM9CLqY0tuCge6V8mTaxj1Q34Kfe8cpis545gMc+tDwQafc3UdEKJ3DRPcbQwXcDC0vRafgyV1OwviJ9roO5wAQOyUrj0geYAvjtvVVQgOTnM4DgEhu+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758420502; c=relaxed/simple;
	bh=UV3R8CpoK0bhJilvbeIrtSGZgeI3h8ufvGlLTH32N+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QtRxkCdbYddCfuf0qCAVl5PUHQflw1FOwihh7RciRLxKZMkvssOEbkmH1AVB1/fLnOhoteAhUHOncfaND9f0O7b4DCrjC6PDlkX3jeU0dhB/+MK0AxFNqVMLkBkrXyQEjxWk4FJdRLM6zdd58wd76L8OJKCmLkOrJlNE2xxVcEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQl+2uD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610B4C4CEF9;
	Sun, 21 Sep 2025 02:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758420501;
	bh=UV3R8CpoK0bhJilvbeIrtSGZgeI3h8ufvGlLTH32N+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQl+2uD+f8Brcx+8cF4Si8R0SAQhNCIpRCv5xf+DEREe9D6nBwCCs1EMC8Jzv/rap
	 1kWcUdiJ6WzLh9n50HKraOVaJLczvLf7TjwS0mMVLz4ThM7aP0Kna7ldl/p/WVZyjz
	 c/l+7Q5G5UprscT+Mp0lRfKz1eyJOkXgzleUSAXlaSxs2xzq3HEIE2hzXoITDvEDY1
	 6Hg1ofkYaOeXVRYiOSELhvmM1m50jfaKMvbM7jtjHgVKMEiuyIKHkJ3mDpMAsOHTzf
	 gBCMfOacqCuxL4vWkk7tw2ZrgKsY3v045wRXVKzxGx5aIG4BNq11sbHAOMUqfhJO2z
	 A2b3y8DIbVAPw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v10 2/4] tpm, tpm1-cmd: Use stack for trivial cases
Date: Sun, 21 Sep 2025 05:08:02 +0300
Message-Id: <20250921020804.1088824-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250921020804.1088824-1-jarkko@kernel.org>
References: <20250921020804.1088824-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Use stack allocation for trivial "low-hanging fruit" sites, which are often
also critical code paths associated with probing and power management.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
 drivers/char/tpm/tpm1-cmd.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index ca3e7f9a105d..11c16ad9b2a7 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -323,19 +323,15 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
  */
 static int tpm1_startup(struct tpm_chip *chip)
 {
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 	int rc;
 
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	dev_info(&chip->dev, "starting up the TPM manually\n");
-
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
+	dev_info(&chip->dev, "TPM_Startup\n");
+	tpm_buf_init(buf, TPM_BUF_INT_SIZE);
 	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
 	tpm_buf_append_u16(buf, TPM_ST_CLEAR);
-
-	rc = tpm_transmit_cmd(chip, buf, 0, "attempting to start the TPM");
+	rc = tpm_transmit_cmd(chip, buf, 0, "TPM_Startup");
 	return rc;
 }
 
-- 
2.39.5


