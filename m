Return-Path: <linux-integrity+bounces-7694-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92336C8EA22
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 14:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43EBE352049
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 13:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129232E74B;
	Thu, 27 Nov 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1K7fa1U"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC632E749;
	Thu, 27 Nov 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251719; cv=none; b=HHkv4s3VciL1U8uRVtvdgNhaMfnam5GscWgUQJQd/Ci3RX6EgIVxs4jmPkekivbNUbPjQ8/b8ZGKZd/JjjphTHgCj+PBmObwKNkWIKxC14EWqtJQxfeKZM/iyJz7UDuE6DyjjS3EQ0BpQjodrwZc7XWQKMQqQwsoNbSWAcfcqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251719; c=relaxed/simple;
	bh=rU1D2RrYSE4OoU7aSIo1o0h6l5hzXHRKOJ/MUDPasdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r60eZ00VGVFV5cLKbF4ekIC6gWRO/f9lvkeKdjIV7HGsCIwSuJU3+JBMTZTGIpE+mdNIqOBR5kKI5m5psQz+7agnZdYPLNxNfHcGa+jCBRyGDCIeYjALhJwxHI9LROxIQO4zgGx7ZphRawv9j5HLvkXhAH15WwFO7muo/P1dZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1K7fa1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270C7C4CEF8;
	Thu, 27 Nov 2025 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764251718;
	bh=rU1D2RrYSE4OoU7aSIo1o0h6l5hzXHRKOJ/MUDPasdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1K7fa1U2lFRJU4mQPeIk6lu5Gf7Bq9ZFIdrNojSyH/T2Jz/0gilTvP+ogaLqfYfq
	 UFXzxg1vMMMXlKWyX+C7NlC+GXeZ8UngSLgG2Iy+QmYqwO4OcPQ2pvCuye2P34chud
	 jGrJPWGzR0XvwXZ4tyluXdrjKWqvMLNzge8j5RnVgjTWKmH2RNncyoH/zdvXDcG5VO
	 DRCvpB7jS93exR8J8IG+XkBJ1o0cYY2dcURFT0DzbPcfC+sgypoBQI0oNuhrHZzcN0
	 oa54G+KqfVtl2pVAnyhRKg5kKcI3d2SIvPkJ2CU3K3ORyeGuqEJ8t/syWvFPBhq50b
	 W4uaLj5bd0j6A==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/11] KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2
Date: Thu, 27 Nov 2025 15:54:37 +0200
Message-ID: <20251127135445.2141241-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127135445.2141241-1-jarkko@kernel.org>
References: <20251127135445.2141241-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Use tpm_ret_to_err() to transmute TPM return codes in trusted_tpm2.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
---
v6:
- No changes.
v5:
- No changes.
v4:
- No changes.
v3:
- No changes.
v2:
- New patch split out from the fix.
---
 security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++-----------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 00bc1afb32c8..c9973ac46041 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -331,25 +331,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
@@ -453,10 +447,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 out:
 	tpm_buf_destroy(&buf);
 
-	if (rc > 0)
-		rc = -EPERM;
-
-	return rc;
+	return tpm_ret_to_err(rc);
 }
 
 /**
@@ -519,8 +510,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	tpm_buf_fill_hmac_session(chip, &buf);
 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
-	if (rc > 0)
-		rc = -EPERM;
 
 	if (!rc) {
 		data_len = be16_to_cpup(
@@ -553,7 +542,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 
 out:
 	tpm_buf_destroy(&buf);
-	return rc;
+	return tpm_ret_to_err(rc);
 }
 
 /**
@@ -585,6 +574,5 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 
 out:
 	tpm_put_ops(chip);
-
-	return rc;
+	return tpm_ret_to_err(rc);
 }
-- 
2.52.0


