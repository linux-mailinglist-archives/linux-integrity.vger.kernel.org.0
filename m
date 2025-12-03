Return-Path: <linux-integrity+bounces-7791-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2681CA1CA8
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 23:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D3DB304D4BD
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Dec 2025 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CA41C84BB;
	Wed,  3 Dec 2025 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeRFHXhl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ABA2D24A0;
	Wed,  3 Dec 2025 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799957; cv=none; b=hu/JvYdxhs1P31+4RLCCCDVbdl1QVbywlLL3JPmGL06UjUo6vWr8hK5XlHQoXKYtZcipV825Uq+gi2NzW+O9PkWhA7gaP3DbyIA2K+9GAQ3BjMoynxPbTO9lAuG/jnrfvAXS+Ks/LWHkUXaFk5CsSCqSLbq2oxVww048NamxSxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799957; c=relaxed/simple;
	bh=cGTLEnw01ps83k1bUkb8e0QDP1zRrlJWhMtwwWuXU28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2aY0j5nt1jOatSR0rNc3yNDaiP5tOkVBHfgnNTJBMYckQVZYGZ9fLcuGfSPvDy0+XRERl4bo9HtAwdpdAEzTemMv2fwiZUcU6h4idWZcK4JcwY+4QOYYJHOcsP/Mh7kccPg40ikWox6qdKxPQVVxhQDP/7NQPg2E7rihRe7+UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeRFHXhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FC8C4CEFB;
	Wed,  3 Dec 2025 22:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764799957;
	bh=cGTLEnw01ps83k1bUkb8e0QDP1zRrlJWhMtwwWuXU28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KeRFHXhl1LQVf143eihXl4VqMKCBuEHflsPgpLbpmcO+DTJ0sYTKaiT0j+QHJrWaV
	 c7B8DmCr6NcuxTrwq/bJVKkytaSCtwAMZ9PyJm88Bn6eMBCkeaN6LtWTvaZNpX1Hgv
	 3UpWe9zL1Uw4GEJq7JB9MkEoGeq4xPUHPkFJ/x1kkIxfxW1wr6IWlNgzLSXXs+hoXy
	 SlOwFU9S560zSgFRejq2NOG7/Mc7U2p/DOLlzwiLvBRLqWIxW/ebXWjcSkbUgFKOQI
	 k0zBhXcDnhMMH7n9rh8sROJivgdHdmoYKvIcRtYnvsR4lJM3qhlxx113VxemM2fEoZ
	 tw0si5d8vSZTg==
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
Subject: [PATCH v3 3/4] tpm2-sessions: Remove 'attributes' parameter from tpm_buf_append_auth
Date: Thu,  4 Dec 2025 00:12:13 +0200
Message-ID: <20251203221215.536031-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203221215.536031-1-jarkko@kernel.org>
References: <20251203221215.536031-1-jarkko@kernel.org>
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
index 34e3599f094f..ce0a1c6b0596 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -210,7 +210,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
 		tpm_buf_append_handle(chip, &buf, pcr_idx);
-		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
+		tpm_buf_append_auth(chip, &buf, NULL, 0);
 	}
 
 	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index e9f439be3916..f0eb8a7d8f72 100644
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
index aa816b144ab3..afa51723296a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -535,7 +535,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
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


