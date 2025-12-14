Return-Path: <linux-integrity+bounces-7972-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F71CBBD03
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF8B63036A7F
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCF92D5935;
	Sun, 14 Dec 2025 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn70dOeB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD081DF75B;
	Sun, 14 Dec 2025 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765726736; cv=none; b=rLHu380p7r/TiSHe01sCfD8fGpvKWEqux36wXIN2Aw5BKI9Z7mf7WGSQiqdq17PVdGAdHLGuJAgRDTTm1xfQ8Yo24EZX7/o0HjOvXnf3E+uuJuY9/Ul7sVoOJ8acG5Dt+0LSk3vJo9EFbSyEomlGryPkgHAxk6c0Hz7TR3g5BaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765726736; c=relaxed/simple;
	bh=MrMWL3WG+BXhBXQ55wL3ZjExZZg8GGPbLZZwCSw3ePg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IOdzTlsfxjtFaa4Z7lIUI0ntLXWOF2x4CWEbpkqDCa5GSgJIYI/Xk/tZb8qB8xcf/u+QRIBcTtViwVYxQd/nghVObr9AbSJMCn+u4sRgipNt8N1nWuCSx/V8csJ1L7CNetK9EQTdQc1rpqZv4MlYbJgtUQTprm483YXV706MNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn70dOeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B40C4CEF1;
	Sun, 14 Dec 2025 15:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765726736;
	bh=MrMWL3WG+BXhBXQ55wL3ZjExZZg8GGPbLZZwCSw3ePg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yn70dOeB2Fcaujn0VbNV8kQbxsbimYqYqQ3vqXL9Go4zXA3F0R67xVq5Yybkcrt1I
	 gkWqVbmXeeoBAv317Wjo1Lv1ZmXjIQXkOBO7ALT48ON/z0ifJKATL2uMmwX7ol8//5
	 VXoYV9wT3dR+1Hd2ePSfgjaOW91f6+ihtWJpdZ9zNVjAxx1c2R/BK+0aldDybeL7j6
	 Hv1uk1eBrZsd8nfsUJaDpbCqseLMjRt08h+8Yl4I2ATjAMH8hs7Ka787LibPkK9VeW
	 5QEMSWwNHqPS+b5kPSlvKcaOhjeNCGmlOMC4+N8R/d/xF7RJ/UkruayEqEduN+qQDC
	 0WCdD2ANK65Rg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v6 08/11] tpm: In tpm_get_random() replace 'retries' with a zero check
Date: Sun, 14 Dec 2025 17:38:05 +0200
Message-Id: <20251214153808.73831-9-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251214153808.73831-1-jarkko@kernel.org>
References: <20251214153808.73831-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for zero byte read instead of having retries counter in order to make
wait flag properly enforcing. Progress is still guaranteed given the zero
check and iterations are capped up to TPM_MAX_RNG_DATA iterations at most
(as per theoretical limit).

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-interface.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 0a79ed3696b7..021553e8a314 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -630,7 +630,6 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max, bool wait)
 {
 	u32 num_bytes = max;
 	u8 *out_ptr = out;
-	int retries = 5;
 	int total = 0;
 	int rc;
 
@@ -656,8 +655,12 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max, bool wait)
 		else
 			rc = tpm1_get_random(chip, out_ptr, num_bytes);
 
-		if (rc < 0)
+		if (rc <= 0) {
+			if (!rc)
+				rc = -EIO;
+
 			goto err;
+		}
 
 		if (!wait) {
 			total = rc;
@@ -667,7 +670,7 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max, bool wait)
 		out_ptr += rc;
 		total += rc;
 		num_bytes -= rc;
-	} while (retries-- && total < max);
+	} while (total < max);
 
 	tpm_put_ops(chip);
 	return total ? total : -EIO;
-- 
2.39.5


