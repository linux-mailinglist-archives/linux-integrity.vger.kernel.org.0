Return-Path: <linux-integrity+bounces-7334-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB84BAEAEF
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 00:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA254A7D6D
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 22:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD4A2C237F;
	Tue, 30 Sep 2025 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba/tgwWK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D62C21F6;
	Tue, 30 Sep 2025 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759270653; cv=none; b=Jnd8dqqRq2KQYZNlSj83IniNX5CwpwVA9rs066W0EvtUuppEp87+RQwnkPuJ+hb+y6iGaD+DlZxTLveeO4LXDklqeqsOdJd+rBl/mhXBZb29WF9zC881a//VGxP7gXztj90FinC4QAJxnQaYnXCuyFqMp0Lx9T4dXjXVEYx4alY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759270653; c=relaxed/simple;
	bh=KAREBsCu1dJZGKugFNTvgn3OVciTbDOxRzABM+NYbbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQFXo5OQ3ZK1PzXWkPWbNngohDxM9rLX/rng0+DGjqmltIASJqkxp9kYD2zK2JJZkNfdjQgO0k0/vmZY+8WsKgqFvem7718q4q2H93F2W0tjRswBnpVgm5TwH1eVMO91xtXdZtbGYmtK2dVsHxpmFSKbgi7eCDX7Yz5ydKd4Cnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba/tgwWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E05C4CEF0;
	Tue, 30 Sep 2025 22:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759270653;
	bh=KAREBsCu1dJZGKugFNTvgn3OVciTbDOxRzABM+NYbbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ba/tgwWKiD2qVkUAL3eqbi2rC5eLkCxGPrDjt+b7aOoe3rZWCZzPP0fbqK4ab1R3p
	 oRSpaC9JB4lXJkNga+zlngVzizrolzW/yZoeo3h4BdXcQo8TaR9qXEfjnwqhdZQTwf
	 Eub1RHTBfJduAN7Lm0AzqjzgtBZ74ngOLN1y7YgtiaYBN7BPaRj4CniGvYMqNumshm
	 DBlwILkITJ6yhnTD+eJ/o9LYm0Qa4BmAtpd6DVfshuzg0T1HhLBeFxuIt5m0MVsAiO
	 TZbRmJSH6yoQxouNSdAYP1grG2y5Q7b6Fsv/iJo7m/rsy88qnEZ6+T4bl2T9fWMf71
	 ZAghgFRYsBiEw==
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
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v4 4/9] tpm2-sessions: Remove 'attributes' from tpm_buf_append_auth
Date: Wed,  1 Oct 2025 01:17:02 +0300
Message-Id: <20250930221707.1373912-5-jarkko@kernel.org>
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

In a previous bug fix, 'attributes' was added by mistake to
tpm_buf_append_auth(). Remove the parameter.

Fixes: 27184f8905ba ("tpm: Opt-in in disable PCR integrity protection")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
---
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
index dff558140c69..5b44222a36c4 100644
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
2.39.5


