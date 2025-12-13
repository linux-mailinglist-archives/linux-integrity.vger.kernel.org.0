Return-Path: <linux-integrity+bounces-7956-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4BCBB375
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 21:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E84B300FE15
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 20:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2281820CCCA;
	Sat, 13 Dec 2025 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtMvtwBh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80EC256D;
	Sat, 13 Dec 2025 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765657982; cv=none; b=deDRQ0Xzjttwq7fHR4L+SCXlfSLYz0GeGefL2o09DgVW9IGs+RCle5YOMjsFSIOArliTBx9X3lUvGq4IfcE4mJxnPBMmXep0cK/wWqQUVq0+KEhsK8KWAiiyZyrEHXXHokIX/Ota5NJZlM3T+ZDGL3UY2+r2zf/YxpVzTZcGYGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765657982; c=relaxed/simple;
	bh=yHzizVadHMmiydQeMtw693Y9eN/J++YL3EFDtCKt65k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ovalLyeZB11f/CxgsbkWtlwxXj4JApoHTglyOXmIsFJQjaYLmlNaZrCglLaQBaN+geiGb1bHfODsmtWuG2IOClKZ5rti1Dv2kTN+pcLOJ+H2B6CZfU4fFH48DDwOVffrGuf3uDamjDAGvwhqheyeXvMabmvucp58KgUGet7o5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtMvtwBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4C4C4CEF7;
	Sat, 13 Dec 2025 20:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765657981;
	bh=yHzizVadHMmiydQeMtw693Y9eN/J++YL3EFDtCKt65k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YtMvtwBhIGq+uKKRUwouz/xdgp0mhlrrU3M4dqMpmps2lbkODuGgzEnfmUjJlkwVt
	 lOlubFqZdeUzpXtDQu9+7jbfDx5c5SRL4bAW5F9Yno2Q6HIJFxEAZifSw/0dy0SQpf
	 Q+2b17EJYodI9L2+DITlgea6oJNNdUty4rkRf4Z8xGPPEMTnkI3gpDVZVqTVNj3Zsn
	 9ZjgnUOUu5kqhnxmsl/AEa71dFr31KaIyWXMuihfxyWZqr1Gv9Hb7JLYOft0c20L1B
	 5m4e16rqJeZpwKf/4ddmUGqhT23EJbr35KFtTZ5zh/W65xMAU7IxxbptotgTsYF8B0
	 z3f7D19wfzA3w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
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
Subject: [PATCH v5 05/12] tpm-buf: Remove chip parameter from tpm_buf_append_handle
Date: Sat, 13 Dec 2025 22:32:12 +0200
Message-Id: <20251213203220.317498-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251213203220.317498-1-jarkko@kernel.org>
References: <20251213203220.317498-1-jarkko@kernel.org>
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
index 3a77be7ebf4a..82076b6cfcf7 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -209,7 +209,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		}
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
-		tpm_buf_append_handle(chip, &buf, pcr_idx);
+		tpm_buf_append_handle(&buf, pcr_idx);
 		tpm_buf_append_auth(chip, &buf, NULL, 0);
 	}
 
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 525b8622d1c3..4432f123af97 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -257,7 +257,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_handle(chip, buf, handle);
+		tpm_buf_append_handle(buf, handle);
 		return 0;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index f43725c52204..f07376eae4cb 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -439,7 +439,7 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle);
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.39.5


