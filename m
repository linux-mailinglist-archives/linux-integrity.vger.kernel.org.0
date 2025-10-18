Return-Path: <linux-integrity+bounces-7492-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B43BECE78
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 13:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E275A19A8353
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 11:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9AC2FB96A;
	Sat, 18 Oct 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr4tMiHe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E132FB08F;
	Sat, 18 Oct 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760786294; cv=none; b=HJeOK5hrdFPwAi/VNW7i+yX0RwcDEArD4w+Y1qXCj9UppM7MZRHdxhDY7+AQlSbe8C35U9ZeAkA2IciZPJwPyOEgfUPe6n9AyuU0lmUoQYCu1o77GvvvMpmKtxFOoESKRPVmSv02eG2FzaUHcI2ckoiCKl3BNXluZSrxe40M9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760786294; c=relaxed/simple;
	bh=XpJHX/fukvR1EVJDNCEOJACnshwHu5GcOTkhk6nqXlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8WtvEEOfJIHWLfSBxNI6YqNBox6IsAFzkxFmHBQpM7QJJXTavWLnldPisCJgTIMlh8GcdQBw/8jDu4FJa/1MhSsOAbpgjFF8/tUpLjx6yr4DQoNtEdq251bjL/azHlMHKqorbJFNzJ4jsiTGgA4ehXEs0v2gkrSRJv6OdPiG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr4tMiHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4812C113D0;
	Sat, 18 Oct 2025 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760786294;
	bh=XpJHX/fukvR1EVJDNCEOJACnshwHu5GcOTkhk6nqXlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qr4tMiHelniUZ/F/yw4xyyhzvE6bSFToOlDKeIQt8TK+/FnD5KoitnkAwTXcunFRk
	 iLzoWR2daw9Vn8kodrBLQx6u9LqnWh8EG46bRnfVWkAsNbsJ06bvLhMeJmYmDePhQi
	 SaPd8rLazqnjLxWIJd5EfX2ZPnT8VhPj/2BJ7/hBEPnziALkfV27uu9FKlX2lpJCHf
	 VUf8HNzeeDXyankwax/OdecvbcZKJJ5bza5qAGvt3bn7bbyUpCwcleM7swT87ZT+sv
	 X2GUHGa91kMeHaYZLkv0Q4aV9ZH7lf0CvLidqr5VIQHBIIINui4pnvbJhDtQh04RhS
	 aiEihvzFaATjg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyring@vger.kernel.org,
	dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@meta.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/10] tpm-buf: Remove chip parameter from tpm_buf_append_handle
Date: Sat, 18 Oct 2025 14:17:24 +0300
Message-Id: <20251018111725.3116386-10-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251018111725.3116386-1-jarkko@kernel.org>
References: <20251018111725.3116386-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Remove @chip from tpm_buf_append_handle() in order to decouple it from
driver. This allows tpm-buf.c to be compiled as part of early boot code,
thus providing a mechanism to build and parse TPM data.

E.g., Trenchboot can use this to manage TPM2_PcrExtend protocol data as
part of its early boot blob simply by compiling and linking the object
file.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
---
v6:
- Rewrote the commit message.
v5:
- No changes.
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
index 3eae22a06558..6ff76a4b8a53 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -426,7 +426,7 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle);
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.39.5


