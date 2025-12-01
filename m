Return-Path: <linux-integrity+bounces-7756-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BA4C996C0
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Dec 2025 23:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 418C03452DD
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Dec 2025 22:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2440428F50F;
	Mon,  1 Dec 2025 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kdeoybpi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D428D850;
	Mon,  1 Dec 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629180; cv=none; b=iZrJm7WMN4yrpyIrUoRZFcfCzbeckgiWqe817GRYIlgxtv79+8CuMhnnEdpdeFVhe/p/8U/CHbqxn2v6fjbVerJBkjodkBXsaTyiry/5/TBO+XOqFst0JpArJ/IzBwO53oVvCALhhrKoX07YaVd1HBvYcm4//vr4K9Y3Usle8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629180; c=relaxed/simple;
	bh=cCxgHqAVbCoH0zWZfGp3OUXwFuqsPl/oDqpXy/Sdfn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bc9CUvSrZdMd3SYLVCL8thlKSEJ4h9lS8ZQl0nR8yL1bxRVM9blC8uR9DD10YtRSi/IR66jvqeFNr0a44dVynK5Peu6iYKeCmhJdhsWW6DRthNzh3nLdQAEe+ebuf5c5mxazAyhup3Mq/nJFCuj1fMHbGa3QzyU0y5mCru5e1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kdeoybpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB6AC4CEF1;
	Mon,  1 Dec 2025 22:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629179;
	bh=cCxgHqAVbCoH0zWZfGp3OUXwFuqsPl/oDqpXy/Sdfn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdeoybpihxcDMxJFFau7jPg4mEBQ7meG6/xn4PCOXpbfAz1ueYc20nSWRD56UTt0F
	 EWTf9P4JGHqW4J9lCOJHnW2Bg81UnDAVvaodDZ4rzq4eJ0MNmUGmtHYjOKRzA2kTYE
	 ceZw2V1CGmB//yyKz/bseiLyhHXI+AzX6w47I828GaS5oEvkbWA7kBl/FDjIfZ0nYf
	 cZNIPP+feHZDOfx29vLdzzVx5/KQUV2aVM3g9Yoth5gMCmdB02Akf1fzP+xUreuti7
	 UvO5SuKo2/YhcMeEWvmmz4poRtyhPQDELU7dopY7wKD+PrwZB4yL0S+cDD7asQB5aC
	 HfzYM5+3sYlxQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@meta.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] tpm2-sessions: Remove 'attributes' parameter from tpm_buf_append_auth
Date: Tue,  2 Dec 2025 00:45:51 +0200
Message-ID: <20251201224554.1717104-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201224554.1717104-1-jarkko@kernel.org>
References: <20251201224554.1717104-1-jarkko@kernel.org>
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
index afbca03f639e..04ec4eb394d9 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -310,7 +310,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
 
 void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u8 attributes, u8 *passphrase, int passphrase_len)
+			 u8 *passphrase, int passphrase_len)
 {
 	/* offset tells us where the sessions area begins */
 	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
@@ -371,8 +371,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
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


