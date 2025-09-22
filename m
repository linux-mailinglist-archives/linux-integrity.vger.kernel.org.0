Return-Path: <linux-integrity+bounces-7224-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2108B92447
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89871169312
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 16:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF2B3126B9;
	Mon, 22 Sep 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb1iWQFa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DA3054E6;
	Mon, 22 Sep 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559413; cv=none; b=i647fPV/sy4ZKS1LMS5vU9ifwGkXhncsH3tGbLFQ73XoqBRaehyBFBk8K5h4JeKnfaINW9dOjICVrkge/1Y9nLvZEH4XeVR0K3m1jySURtaJto4Al/B3q0mqvmnpV4Zs07Zb5FLYH3FBu/jekkCzhv6y7ZUtfx7zsMNJrs8Njw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559413; c=relaxed/simple;
	bh=Je6cj0fei63iymWrQv/qB2Jg+xsIJTJYbMZ3IJkxnR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/RQj6lij7Dw4+HtOERlv5g8FwqEFxDBwdK+CP4ZgFyN9dMXRcoYDEn7pWcFdm0BdaRmGS0/rqXxxHcqDwwkSOANiBYPaf+NbFUS17iccTnaArLDFD70aCL/tJcUyru2uzxSmL+OnDyLTXsEZZQe4s8tRqgCJB1GqCBULLNQqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb1iWQFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7B6C4CEF0;
	Mon, 22 Sep 2025 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758559413;
	bh=Je6cj0fei63iymWrQv/qB2Jg+xsIJTJYbMZ3IJkxnR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hb1iWQFa8vgzyoaoR3NTb+ZQFTRbS0KDhtJhVlHCJxfSFETHu3v1pr2291GGaMd1M
	 n5S0V+EhOTjYv/yLA7ZA9wJGRPC3VnPRkGhEegVzONvxxyMo5w3uzm2jMRHRtcOPFL
	 txwRkMvUF3gxL7PR/1T6YH5QvUbKvFkCKrKy3JjyVEhSIIWjzeEmlY1xkiyoMiRvun
	 OLH9EBc28+hG0qJjooAiKexMVE0hsThLBwt2PuOdahxNV4nTMJLJ4dEOgHtQ53vOer
	 gy5rOs5iudxwc+OuEeD1qkMviTklSMLC5aNePksMZAEMNU4oWhMHNpHvEdEsd+2egj
	 p4D/YdWutjXMQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH 1/4] tpm: Use -EPERM as fallback error code in tpm_ret_to_err
Date: Mon, 22 Sep 2025 19:43:14 +0300
Message-Id: <20250922164318.3540792-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922164318.3540792-1-jarkko@kernel.org>
References: <20250922164318.3540792-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Using -EFAULT here was not the best idea for tpm_ret_to_err as the fallback
error code as it is no concise with trusted keys.

Change the fallback as -EPERM, process TPM_RC_HASH also in tpm_ret_to_err,
and by these changes make the helper applicable for trusted keys.

Fixes: 539fbab37881 ("tpm: Mask TPM RC in tpm2_start_auth_session()")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
 include/linux/tpm.h                       |  9 +++++---
 security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++-----------------
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index dc0338a783f3..667d290789ca 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -449,13 +449,16 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
 	if (ret < 0)
 		return ret;
 
-	switch (tpm2_rc_value(ret)) {
-	case TPM2_RC_SUCCESS:
+	if (!ret)
 		return 0;
+
+	switch (tpm2_rc_value(ret)) {
 	case TPM2_RC_SESSION_MEMORY:
 		return -ENOMEM;
+	case TPM2_RC_HASH:
+		return -EINVAL;
 	default:
-		return -EFAULT;
+		return -EPERM;
 	}
 }
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 024be262702f..e165b117bbca 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -348,25 +348,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	}
 
 	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
+	if (blob_len < 0)
+		rc = blob_len;
 
 out:
 	tpm_buf_destroy(&sized);
 	tpm_buf_destroy(&buf);
 
-	if (rc > 0) {
-		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
-			rc = -EINVAL;
-		else
-			rc = -EPERM;
-	}
-	if (blob_len < 0)
-		rc = blob_len;
-	else
+	if (!rc)
 		payload->blob_len = blob_len;
 
 out_put:
 	tpm_put_ops(chip);
-	return rc;
+	return tpm_ret_to_err(rc);
 }
 
 /**
@@ -468,10 +462,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		kfree(blob);
 	tpm_buf_destroy(&buf);
 
-	if (rc > 0)
-		rc = -EPERM;
-
-	return rc;
+	return tpm_ret_to_err(rc);
 }
 
 /**
@@ -534,8 +525,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	tpm_buf_fill_hmac_session(chip, &buf);
 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
-	if (rc > 0)
-		rc = -EPERM;
 
 	if (!rc) {
 		data_len = be16_to_cpup(
@@ -568,7 +557,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 
 out:
 	tpm_buf_destroy(&buf);
-	return rc;
+	return tpm_ret_to_err(rc);
 }
 
 /**
@@ -600,6 +589,5 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 
 out:
 	tpm_put_ops(chip);
-
-	return rc;
+	return tpm_ret_to_err(rc);
 }
-- 
2.39.5


