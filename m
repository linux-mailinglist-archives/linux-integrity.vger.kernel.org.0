Return-Path: <linux-integrity+bounces-7215-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E4B8F47A
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 09:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C90317ED82
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 07:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BB02F3C19;
	Mon, 22 Sep 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy0LR9mD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA92F2908;
	Mon, 22 Sep 2025 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525824; cv=none; b=K2sDXXsgHixfyjthJYl5AS6pvsCtKjIiQAixNbdrjzN3yBJ/5eJzcW7n4gBqYXHjVplEx/okr3HhMtY6HzbPQpDHi/JcTsEBfhEPXOP+f768nmrYHdiVqHETzhm/WuMxDQV04fQRTY56Hktrrw03QEq5xCDBCgBpt2KUvNKkYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525824; c=relaxed/simple;
	bh=ZV7aj9Kf9IQrMj6PE5MKPkZnwo28z3HICV1pbhZwGJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LD6sGO6k1QebQS5JkUKLPflcpfRdahrKa2BpHDtO0eA7UJiTBFbNtOfe+/5/gX6B4CCF16e0ke+cq85hP6qEapdXI6o7l34LBGlS4CauzZNqWbihDQaXvzUGCipZzm6t9o4TeECjkX5oELJXWL36vBWxYX80m35HfXI8YEzptRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy0LR9mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1C5C4CEF0;
	Mon, 22 Sep 2025 07:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758525824;
	bh=ZV7aj9Kf9IQrMj6PE5MKPkZnwo28z3HICV1pbhZwGJg=;
	h=From:To:Cc:Subject:Date:From;
	b=qy0LR9mD5FuTYFS2OEEJV0ZztHALjbF577zATXWDiMUWjUHPZvD0/XqnOoP72QWXU
	 nUKth23FKJFWfYC+C3InmIeMopxNUDqKbtp+Hs+AlMo0vFQnFEhHP1jOUv/OWGC0Yl
	 pSDB1pegHFPWq93holMjx+rfjUylWVmtA/ZjxIpNQFYFAyi/dtqcXWOkfOpu5OHFJW
	 4wnQNgpeUNMdTR2XllaByQLomBdAWJ97OhoJcF2WktRGQX0eE8Oz7c9YTtde1F2jH5
	 fqEug/+UTai+Htj7z5FXrSoAdGMW7Z7oplqqMDYAQNadNwoZvSvED2KWa+J8P83QiA
	 YvWpwtxbeEB9Q==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org,
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
Subject: [PATCH] tpm: Use -EPERM as fallback error code in tpm_ret_to_err
Date: Mon, 22 Sep 2025 10:23:32 +0300
Message-Id: <20250922072332.2649135-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
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

Cc: stable@vger.kernel.org # v6.15+
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


