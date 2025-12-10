Return-Path: <linux-integrity+bounces-7902-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A36FCB39D0
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 18:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6578C31C88D2
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 17:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB18327783;
	Wed, 10 Dec 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpUfYW3C"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3961327201;
	Wed, 10 Dec 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765387279; cv=none; b=Yq8i5ou7K2zfVOp/iKMBYjscBW8JhrekyuH9o4JhaxqS6J14ZasK+tjzYPErJfwzU0hl41SW3IX6QiDK3poqx3MMMvybo0nkUdGFSV/HMEZbG52wc3FxqevQTHqGnsKdvBJodPIwj+Xng4QSzg5zwDB3CeBcM/IxNVR3JXaGE7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765387279; c=relaxed/simple;
	bh=ose2oB/fvx8BkW6CVHK5os3jHRlOiK5rAT97U08pq4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fj+5weI7sGHEW3bIlXIV0w0sn/ML5dLPNj8foCWDat+S+yeckr9Ef+isCR2UDgnBLthz3Bz7EpgypwuaWHOsmmG6ZfX0IHCyLQjewp0XRYF5YRa+DFfj7FC6n+fwbyWroiiCZfQmRtKBOKgzX+QAXo3/AoKv6kytkEEj6c2uu88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpUfYW3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57BDC4CEF1;
	Wed, 10 Dec 2025 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765387279;
	bh=ose2oB/fvx8BkW6CVHK5os3jHRlOiK5rAT97U08pq4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpUfYW3CJAtqL5S3ySrAUNOfthY6VO45ff4gk18o0lkNLxPBfZmHFQMcPnae6EsLL
	 JaTKlcPK1E+ttAmn4x0imK4gFb/wBqcz6ihhrIC37FPEu9Z/pJfuoTkl62ks28vBbg
	 9cWgHDAs1eTvwlqRC2he4zo0jyXPpU2Vkmaz+woclH44juIxRgd3splrFbuCgYyp1n
	 p7h+gzDJ9S/R0ZmAznq5qfClV2Npl5VlTo/pttVuOoKrcB9DRaoYhziTZGRh8fD47P
	 uX01UBvOrQm2If1hoRROCEmuqx+XfCDrKaT3xJqFQ4xdHNtM97jxmhUErCmH7hIMef
	 DRx+FpaeEW6dQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v4 8/8] tpm: In tpm_get_random() replace 'retries' with a zero check
Date: Wed, 10 Dec 2025 19:20:26 +0200
Message-Id: <20251210172027.109938-9-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251210172027.109938-1-jarkko@kernel.org>
References: <20251210172027.109938-1-jarkko@kernel.org>
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
index 5cc2bbabd57a..594ad095a90b 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -620,7 +620,6 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max, bool wait)
 {
 	u32 num_bytes = max;
 	u8 *out_ptr = out;
-	int retries = 5;
 	int total = 0;
 	int rc;
 
@@ -646,8 +645,12 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max, bool wait)
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
@@ -657,7 +660,7 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max, bool wait)
 		out_ptr += rc;
 		total += rc;
 		num_bytes -= rc;
-	} while (retries-- && total < max);
+	} while (total < max);
 
 	tpm_put_ops(chip);
 	return total ? total : -EIO;
-- 
2.39.5


