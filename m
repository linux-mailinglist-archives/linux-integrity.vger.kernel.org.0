Return-Path: <linux-integrity+bounces-7724-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1E5C90AA5
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 03:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7C03AC74D
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 02:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14582877EA;
	Fri, 28 Nov 2025 02:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdvu2zMJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7A285419;
	Fri, 28 Nov 2025 02:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298462; cv=none; b=c/+/vkRmCJbRMW+tezdp4ZDnycNybKc4q3W6LUvmTE/LLblHzecn5r3JRgMaQxVu4dUECWklJlP8HtpAZfIH9tF8wyKeRYq4fZt0gakLwjlvGn4F8+4Jq9B9FYHTxswnmqUdkkPCHjn9bSlUU4IAacSeuSk/3/owlIs5QZTOp/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298462; c=relaxed/simple;
	bh=C2FItyHn/qd6F6BkkkWLwdGwSNWgat9yrRBTHve2IKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8Wf1TI4Z0YwNpfTzy5pnfqdWRyedlhmmst+bsCFV/jAD4X2xdmEys3tfnRgBA7FWlngTEdY3M3/BJiv4n3/y4CsMJHEithuaAW0OyTk7JdbMAPyTgikuecGuDwGVFKZjccs3nvj88Wj5XkizispvxL/8W7qsvCjB6KLHhITCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdvu2zMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182B2C116D0;
	Fri, 28 Nov 2025 02:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764298461;
	bh=C2FItyHn/qd6F6BkkkWLwdGwSNWgat9yrRBTHve2IKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdvu2zMJjku8R5hgxQnecYsAhRo6ut5QZ3RbghOrfzcZtUeptUCt51RT66o98MfEM
	 fydN7f2l1K6mtRqkQ7hPAHyOPzv++EUCfakTOmxc9ZIjymPoEqWmkGZ2bV46orMKKd
	 bew7/cHD54mZQIJSEtkKq+DArpOTtSZtl+32thG6Lr+LhkIKAbATUOgLOBc0Y/MuIs
	 Z4AV4WZN94lpQOZ5Lyxx+U0ear8u1LMtCYUoGUFDG3lf3nlsQzUlQnHrpc1cXH46X2
	 qSM615e9F3crztp6w3HddXi4wzZvMMebuf0/wlsV7qeCTk6vNqb+6KIrTnq9nPcYxD
	 5vy9rysFr8yCA==
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
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/8] tpm2-sessions: Remove 'attributes' parameter from tpm_buf_append_auth
Date: Fri, 28 Nov 2025 04:53:53 +0200
Message-ID: <20251128025402.4147024-2-jarkko@kernel.org>
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

Remove 'attributes' parameter from 'tpm_buf_append_auth', as it is not used
by the function.

Fixes: 27184f8905ba ("tpm: Opt-in in disable PCR integrity protection")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
---
v9:
- Improved the language in the commit message.
v8:
- No changes.
v7:
- No changes.
v6:
- No changes.
v5:
- No changes.
v4:
- No changes.
v3:
- No changes
v2:
- Uncorrupt the patch.
---
 drivers/char/tpm/tpm2-cmd.c      | 2 +-
 drivers/char/tpm/tpm2-sessions.c | 5 ++---
 include/linux/tpm.h              | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 5b6ccf901623..e6cb4083c14e 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -191,7 +191,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
 		tpm_buf_append_handle(chip, &buf, pcr_idx);
-		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
+		tpm_buf_append_auth(chip, &buf, NULL, 0);
 	}
 
 	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 6d03c224e6b2..13f019d1312a 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -266,7 +266,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
 
 void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u8 attributes, u8 *passphrase, int passphrase_len)
+			 u8 *passphrase, int passphrase_len)
 {
 	/* offset tells us where the sessions area begins */
 	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
@@ -327,8 +327,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_auth(chip, buf, attributes, passphrase,
-				    passphrase_len);
+		tpm_buf_append_auth(chip, buf, passphrase, passphrase_len);
 		return;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0e9e043f728c..004680757923 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -534,7 +534,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
 void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u8 attributes, u8 *passphrase, int passphraselen);
+			 u8 *passphrase, int passphraselen);
 static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
 						   struct tpm_buf *buf,
 						   u8 attributes,
-- 
2.52.0


