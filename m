Return-Path: <linux-integrity+bounces-7290-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFD0BA7EB7
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 06:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E7B3C2CD9
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 04:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339D122A4E1;
	Mon, 29 Sep 2025 04:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXaw6TH0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E43205E02;
	Mon, 29 Sep 2025 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759118431; cv=none; b=Mh6yCRJe+x3pAj8f2WqPbp73zQf6mh7zFBZpDBLi5rMTD4IaY2tjMCiecgzneXgF/lNJ94b2VNoXE09StBpKf/ZGpTle9c5BAQbnhScorRtZ1tFELdWmW/gFwyv7uNnUB6QOno5tZ7DI/tfpAMExFTG7gYrJnjbUk9ovbBUUYsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759118431; c=relaxed/simple;
	bh=0Q40GpSZtB6pCsgumq9WfNCq3yyKDUNbkzB2Cq6M9MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F4BqnZJG2HKH2x5PTsXqrdDswQ+ilOKzd5SzWtgYT7pomtrVIHasGK9d7v6umkkYXvMA25Vi+FLyOhdX/T73xLpSczXt740it+q/A7FyaOPod1A2zrnuX/IEcRPqQJbOGRNgMe4QLaoGr7hGjULb2bktNHlX4YUWqrDs/daqm9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXaw6TH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD1CC4CEF4;
	Mon, 29 Sep 2025 04:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759118430;
	bh=0Q40GpSZtB6pCsgumq9WfNCq3yyKDUNbkzB2Cq6M9MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXaw6TH0mJHuF1jBCEo7duCk5HC6JCCKyFoFKMYCseg1t+G5BNIxPpa19ElHqHije
	 TAs6Ix9ioJGU8Wtew/Y14f90a8rem03Vqf0UOvzgchzUPVH9jBA8y32l4kuLO+rYpx
	 +JMzVLyFmCfxsEcIBZWYHucTwM3voepmX16C/H4CyL+l5RsUk9omZ45yDTcdq7Z2vT
	 rICKjfPp9lpYEJsQk5q5ATJOe5roxAUnv1quL1SGYMN77QBymhhPGR0JuYkEwbUSDu
	 WTdpucAF30i+Sf1GRxEm24TrcQgS0+wDJ64XwkOyA+oniFUCgwEmFXxWSsMxaPJ5k+
	 RIXdyCOYI53Mg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
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
Subject: [PATCH v2 8/9] tpm-buf: Remove chip parameeter from tpm_buf_append_handle
Date: Mon, 29 Sep 2025 06:59:37 +0300
Message-Id: <20250929035938.1773341-9-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929035938.1773341-1-jarkko@kernel.org>
References: <20250929035938.1773341-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Remove chip parameter from tpm_buf_append_handle() in order to maintain
decoupled state with tpm-buf. This is mandatory change in order to re-use
the module in early boot code of Trenchboot, and the binding itself brings
no benefit. Use WARN like in other functions, as the error condition can
happen only as a net effect of a trivial programming mistake.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
v2:
- A new patch.
---
 drivers/char/tpm/tpm-buf.c       | 6 ++----
 drivers/char/tpm/tpm2-cmd.c      | 2 +-
 drivers/char/tpm/tpm2-sessions.c | 2 +-
 include/linux/tpm.h              | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 5526f548b4de..c2bf7556cb23 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -147,21 +147,19 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
 
 /**
  * tpm_buf_append_handle() - Add a handle
- * @chip:	&tpm_chip instance
  * @buf:	&tpm_buf instance
  * @handle:	a TPM object handle
  *
  * Add a handle to the buffer, and increase the count tracking the number of
  * handles in the command buffer. Works only for command buffers.
  */
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle)
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle)
 {
 	if (buf->flags & TPM_BUF_INVALID)
 		return;
 
 	if (buf->flags & TPM_BUF_TPM2B) {
-		buf->flags |= TPM_BUF_INVALID;
-		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
+		WARN(1, "tpm-buf: invalid type: TPM2B\n");
 		return;
 	}
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index eef324e61308..4248e59265aa 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -190,7 +190,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
-		tpm_buf_append_handle(chip, &buf, pcr_idx);
+		tpm_buf_append_handle(&buf, pcr_idx);
 		tpm_buf_append_auth(chip, &buf, NULL, 0);
 	}
 
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 13f019d1312a..bbc05f0997a8 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -232,7 +232,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_handle(chip, buf, handle);
+		tpm_buf_append_handle(buf, handle);
 		return;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 5283f32781c4..b2d89df70c18 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -423,7 +423,7 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle);
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.39.5


