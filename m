Return-Path: <linux-integrity+bounces-7730-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32536C90AF4
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 03:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89E884E9697
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 02:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0047F2882CD;
	Fri, 28 Nov 2025 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6GR4UYr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC576285419;
	Fri, 28 Nov 2025 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298492; cv=none; b=YF619tQ90WjL6FenaVKdq85KkpK5dFKNtsm8tqn7Lk0K1vfyFnw2l1txUnLjvTsb+g8Rx6L4rrjDwtru0xU/vXahqSv0KTGm9lIXXWtOfpZHFfqBDR2nrEQjpJkspPvQSxA9WPgN6qit0SotIDgLR5/hAt63z+gnTJ+Bztaffuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298492; c=relaxed/simple;
	bh=96R32kettYlpJ5wL4HuJG5JF1DQk9o1sR8z3uFSMGEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5V5sMqWz66BD9WYaGR4F6JG+6H/6MquWB3X4TcJEcIfewbSKI8CeCtzBgRSdASwrM+jBRTN11H7khej2f8y2V4wOa+SIiFmXeKn52Ved7dc4FeTpokzmEc9a5a30n+AeyeKrwMt9QlHwdFMwEOyB2Ad/iRxRqRr38ESvDbw4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6GR4UYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AB0C4CEF8;
	Fri, 28 Nov 2025 02:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764298492;
	bh=96R32kettYlpJ5wL4HuJG5JF1DQk9o1sR8z3uFSMGEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6GR4UYrkNaBOpzgvaRrVcWrLndyWUDbs4MgKIDAb3z6gjwYuiIR1qflfFxHYoBRx
	 /+NDlJB2vYBGJl24oVhjuWiBFleK+Ac1QomPnnoZJBjKEyQtCKgFHyCy0mrwHnHYDd
	 39aPY76CZ+H2HIzwMvhGp+CMK67dVN7EJw2PAahaENylXke6flH5nOStdwV1yI4tsh
	 7ry+HzzTPVQGljsgTIddcGLoygbNQj5qesL8S7jLbCXCTFQoMo7mpw+d/jsxD2vEhB
	 mYZaJ9Afwv5USygDuJjL2HxEb0vHIL+cRaMA6sAE5gzc+9Kiumllfi2RXk0AvsUn3c
	 B7UUwby98Gutg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@meta.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 7/8] tpm-buf: Remove chip parameter from tpm_buf_append_handle
Date: Fri, 28 Nov 2025 04:53:59 +0200
Message-ID: <20251128025402.4147024-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128025402.4147024-1-jarkko@kernel.org>
References: <20251128025402.4147024-1-jarkko@kernel.org>
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
index a121c518ff6f..b7dc9c3dd15f 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -202,7 +202,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
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
index 2796bac2a114..a52334c36855 100644
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
2.52.0


