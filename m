Return-Path: <linux-integrity+bounces-7338-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838DFBAEB25
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 00:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6328A4A7E84
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 22:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BA32D249E;
	Tue, 30 Sep 2025 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDR1G4Gf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005792C2375;
	Tue, 30 Sep 2025 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759270671; cv=none; b=nCO1Jo149+z+8y2LZIGWOAabu6VUQBZFmNk1WqSzI4s9JlSFw9Ia/bzf0QstJL8N1T7uYqfV+xlz3uibe+iWT73Ow0m7XZZfVZCc8B0LEeCSxJxGvHCqs4i/Luh5xpx6IvF5Lgud27CJFU2DWKCFITBsWuiutvY3W1xBuAIrv+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759270671; c=relaxed/simple;
	bh=1GuUWS7oZuy2It1bhxEzOSDxWmjL3rQtT/gkILDr5u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DsG9O/yZtBjiY6Jw0GP+ARrlZaBb38JmwRK4ZgVfVxgBa5f/Xxqay+RVwf82SRFKUsu5gqp/VyCE/jZWeZZYTZ8DIm6lYE/Se7rBfISBaDM3w7rcaCMEqD/EeyXdO2facGqAdM04KsY8HgkECKqvAsEPDgHO/XM+Vc3rWsgLtM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDR1G4Gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D204C4CEF0;
	Tue, 30 Sep 2025 22:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759270670;
	bh=1GuUWS7oZuy2It1bhxEzOSDxWmjL3rQtT/gkILDr5u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDR1G4GfNsJB7jWdfgU6GD4HYlRGdhKcgJEeRoG0t1m/4IxC+7jiDhkKVAXZ1Mfc1
	 Je8qyhbsQBEr04X/EXQ1B2GZu2cqZIzQ6RGVpuXe46ujdRr+S/Gn5UZTHUJ/SC8o3T
	 lHCxMFDgpBDI+umrO+Q62JXypBiad0grrmPmoAjOfDbauqLYsdwl/2UseuL7GY6J3I
	 GiKCBV4+uHwsYKxJXAbBuUptG6nrBDx8qbptjJvr+Qs/A4gxkmrVkEhmoSGIiQ7DJN
	 n+Q7yx3Z+BJiVnBPAvHuDGEfY7hziqboibci1uWfkRjW+VdQPagHSZDWoW/2LEiWYG
	 NZhrqrkp798BA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@meta.com>,
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
Subject: [PATCH v4 8/9] tpm-buf: Remove chip parameter from tpm_buf_append_handle
Date: Wed,  1 Oct 2025 01:17:06 +0300
Message-Id: <20250930221707.1373912-9-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930221707.1373912-1-jarkko@kernel.org>
References: <20250930221707.1373912-1-jarkko@kernel.org>
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
Reviewed-by: Jonathan McDowell <noodles@meta.com>
---
v4:
- No changes.
v3:
- No changes.
v2:
- No changes.
---
 drivers/char/tpm/tpm-buf.c       | 5 ++---
 drivers/char/tpm/tpm2-cmd.c      | 2 +-
 drivers/char/tpm/tpm2-sessions.c | 2 +-
 include/linux/tpm.h              | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 69ee77400539..1b9dee0d0681 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -147,20 +147,19 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
 
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
-		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
+		WARN(1, "tpm-buf: invalid type: TPM2B\n");
 		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 254003e5dd8b..e548b0ac7654 100644
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
index 4613216e9d95..e86c22b30153 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -427,7 +427,7 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle);
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.39.5


