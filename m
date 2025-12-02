Return-Path: <linux-integrity+bounces-7768-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F57BC9CE7F
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Dec 2025 21:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A50A3A7378
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Dec 2025 20:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC912F25FE;
	Tue,  2 Dec 2025 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMR3LB2g"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456AF2F1FE1;
	Tue,  2 Dec 2025 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764707226; cv=none; b=Xd8XzzILQfcDmeJyEhEb5nBqTkZD1cz91nh6Hj7iGadBIhLW8r1h1o2mMy1A7mgbQ+j4ZYmM7Py+yfb0RZO0U9gjZnBFVUfF/L+Z5ovr1oYhE82azRbZLGAQnnuJLuo2RXxGuUm5dZSC8k2f7edP0SXMXJ6MnRJBV7w/747htAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764707226; c=relaxed/simple;
	bh=/fz2gUtisQmjO8JJgmrs1qRb3Vmy/w9noIBBKmaqlK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwQ13Dg/9/Y46W3mZ+jACNEX20qwBU9wW6OjFbxfQSzRaFvvxYEjkEC8V/xTrLHZwq6df1FK4+DgmSZW0295XGOzToHGsz7QPDHh/PINxxhQb2esHDbGrwxcrSKfIxi5/5eZGEjfAGv6g0HGU+uSqThtE8SbwQSXFNbVmDpsf5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMR3LB2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5ABC16AAE;
	Tue,  2 Dec 2025 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764707226;
	bh=/fz2gUtisQmjO8JJgmrs1qRb3Vmy/w9noIBBKmaqlK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMR3LB2gcC+ejHFCf9gir9sii6ZjWguwj+vBBU/OZjTGVhyLTbCRJYO9TAIxWKz5N
	 FKXd+pbDA+SEJ3T2XTjS1aVDXjew52orl8M8K3LztC/L2BWAVT7p+VStl4Hbw94vsp
	 srC+2S3ec2/EOFf7DBLcS7+UBXvOcS/80sRt4JPV0JlSV8jy4qn5UPApT/JVQY+Uxa
	 EieAZpe9ngvxHMLUt11oHg20aG5uElpsLFSgEGdCzDfpq2fENth2aiUqSa6VBurGAV
	 pUfXGmaCenAC8PO3UJZIbTFKLJdAHhHiNBojibUHFZX243DnWK+3JD04UluFifi3qz
	 o0Y8lf8fkwhEA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan McDowell <noodles@earth.li>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list),
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@meta.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v2 3/4] tpm2-sessions: Remove 'attributes' parameter from tpm_buf_append_auth
Date: Tue,  2 Dec 2025 22:26:40 +0200
Message-ID: <20251202202643.107108-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251202202643.107108-1-jarkko@kernel.org>
References: <20251202202643.107108-1-jarkko@kernel.org>
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
 drivers/char/tpm/tpm2-cmd.c      | 2 +-
 drivers/char/tpm/tpm2-sessions.c | 5 ++---
 include/linux/tpm.h              | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 58a8477cda85..f1e9c35f13a2 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -198,7 +198,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
 		tpm_buf_append_handle(chip, &buf, pcr_idx);
-		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
+		tpm_buf_append_auth(chip, &buf, NULL, 0);
 	}
 
 	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 964f44c2255d..7c7a9bc6ba2d 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -311,7 +311,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
 
 void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u8 attributes, u8 *passphrase, int passphrase_len)
+			 u8 *passphrase, int passphrase_len)
 {
 	/* offset tells us where the sessions area begins */
 	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
@@ -372,8 +372,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_auth(chip, buf, attributes, passphrase,
-				    passphrase_len);
+		tpm_buf_append_auth(chip, buf, passphrase, passphrase_len);
 		return;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 1a59f0190eb3..e3a6e2fb41a7 100644
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


