Return-Path: <linux-integrity+bounces-7488-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6D6BECE48
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 13:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B48D19A7F89
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 11:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2305E2DAFB5;
	Sat, 18 Oct 2025 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ansG3y5U"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D3285C98;
	Sat, 18 Oct 2025 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760786277; cv=none; b=XMHHseBLfaactKDX58LGvGYqMXKbck2jO1pnyQpsx4b6R3Vx/Wvs0Np6oHoj5WQHgSNKVM8+zezY0iyMAEIUn5tdY9pA3nCRbw6UWVcVM+g0xcOJvLYpha5tvdrpwOwwKXoCuCmUxhbB11Q3N6KR5XbJun1VkrT5qM85jjApwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760786277; c=relaxed/simple;
	bh=VpTSKCPhZQKNnV3xX+WsM9i8yXowWhs5/dg4hC9MI8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L3wW9s5RE0y+JUBo9VKPtEZpAjUM+Xx3L3R2Hj0vxwz2pbqnxpyd9C23qd17VHfFJNz8xvs+0HCZGWaLWpi9/ELVlIgStxvJDO/2U/v52aJzTaVD53H1QLvgbwhY7ndIJ3Ual2SdQFuoMx2YIkE1GeY8D3HetZSxazurLK7FxWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ansG3y5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A945C4CEF8;
	Sat, 18 Oct 2025 11:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760786276;
	bh=VpTSKCPhZQKNnV3xX+WsM9i8yXowWhs5/dg4hC9MI8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ansG3y5UjdZ5ApL498EGUQPDbo0jBVs1i2h75HCMPIlXghw+rUSYWzvo6fWzTnLED
	 HJDCHohqfU3aPc/fQj8BDRyU3V7ytAdddr12WFlv2xJLgylnLbFBVKcut2uz685ps+
	 0eMPeTwwnD3z65WUI268WTelzpXwWDvf6veaW1EKuQC34XglBxTofQNWUi6VsIzok3
	 mD1gA6007yTtwL1oi16R0E3FVBF57BIl9Ycp0tLsuO96vfYXk6ILdk4rnPmT+j1Spf
	 PLtGoeLUMJ3eb7gNrKQjZ6gAyhuFpfumN23ryOyuksPSc9A/JbLbqXF/NwsKIWa5HJ
	 DNXvoDLBkeatw==
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
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/10] tpm2-sessions: Remove 'attributes' from tpm_buf_append_auth
Date: Sat, 18 Oct 2025 14:17:20 +0300
Message-Id: <20251018111725.3116386-6-jarkko@kernel.org>
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

In a previous bug fix, 'attributes' was added by mistake to
tpm_buf_append_auth(). Remove the parameter.

Fixes: 27184f8905ba ("tpm: Opt-in in disable PCR integrity protection")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
---
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
index 97501c567c34..bf8294e3d8f2 100644
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
2.39.5


