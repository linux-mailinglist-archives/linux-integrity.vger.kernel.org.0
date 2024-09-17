Return-Path: <linux-integrity+bounces-3622-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0153697B24A
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 17:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B788C28741C
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C7F19341B;
	Tue, 17 Sep 2024 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhTUFMyY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2411925BE;
	Tue, 17 Sep 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587900; cv=none; b=WyDd8TPEFKoHWnblY7uiwJGxVWEnFETYL1NxJs6DYarIXAsCetK01Q3yRLNprjy+Q42cNamxOPa928rFAzPZ2/bZ41FDkEPgQhwFzmKjGbp4yGmvCnReNlrG0eNGw/oor1zIXIFKDYosJTFIadiO4PT9xfYz99XxfTt0LUDLf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587900; c=relaxed/simple;
	bh=G8RsCScdbp+9ybMzUp8FLT1Lh6rs3SGvyd2dSpLYS0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiTQiZSKHH1iJi5yKJ2P8yFdm9r8zFeCfmU7/xcugBi9QOKgpPWmID4eJlMP/QYKoCNlDW2s32XeqSqoS8rCOaFBLYk422k1pBJKBdyeU8HdSUt3nSPTeG/K9LZQK3INjgyjai7hVFqRXT6a7v6hznV6WZ/ji58cNr0Y2q77UAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhTUFMyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA4DC4CEC5;
	Tue, 17 Sep 2024 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726587899;
	bh=G8RsCScdbp+9ybMzUp8FLT1Lh6rs3SGvyd2dSpLYS0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhTUFMyYGb2/U/xuczJFja6O8Mukl/o3hOpUo+BnD059eAi+hq3G8NJ0kpQYvqY2S
	 ORKQGqSeEBiaPQFWy7qzhV+L8umivyFSD6w7DBPHFiEYdGosJt9sGyV/yg6P+gzuNC
	 HxCh/BzCTkCIMMRgP3gOAKyfXuCGFc1SmqDhmBA/oxCSVCMAf7vVl9jb7cHB+9soMQ
	 ie13Cqo0jln69QgzzZT69bRDXBSGti39mXnCOJAVpMQED18AeUJVzzp/oRf8TV+r1C
	 CscqCGhW2h9M+iNK8aSqyHAGsUCBCmeZ5yx1nVjphV9Z3NAbnl1v7xkkWLBB7XMSz0
	 jzuc1L2CdjEBQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] tpm: Return on tpm2_create_null_primary() failure
Date: Tue, 17 Sep 2024 18:44:31 +0300
Message-ID: <20240917154444.702370-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917154444.702370-1-jarkko@kernel.org>
References: <20240917154444.702370-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_sessions_init() does not ignores the result of saving the null key.
Address this by printing either TPM or POSIX error code, and returning
-ENODEV back to the caller.

Cc: stable@vger.kernel.org # v6.11+
Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
- Handle TPM and POSIX error separately and return -ENODEV always back
  to the caller.
v2:
- Refined the commit message.
---
 drivers/char/tpm/tpm2-sessions.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 6cc1ea81c57c..0993d18ee886 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1273,7 +1273,13 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
 		tpm2_flush_context(chip, null_key);
 	}
 
-	return rc;
+	if (rc < 0)
+		dev_err(&chip->dev, "saving the null key failed with error %d\n", rc);
+	else if (rc > 0)
+		dev_err(&chip->dev, "saving the null key failed with TPM error 0x%04X\n", rc);
+
+	/* Map all errors to -ENODEV: */
+	return rc ? -ENODEV : rc;
 }
 
 /**
@@ -1289,7 +1295,7 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 
 	rc = tpm2_create_null_primary(chip);
 	if (rc)
-		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
+		return rc;
 
 	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
 	if (!chip->auth)
-- 
2.46.0


