Return-Path: <linux-integrity+bounces-7333-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B96ACBAEAD0
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 00:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4DF4A7224
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 22:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794BF2C3254;
	Tue, 30 Sep 2025 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNlaM1Rc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0FC2C237F;
	Tue, 30 Sep 2025 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759270649; cv=none; b=eOTFg6UkxD8vmfUtTkPwXWsDKZLH0R30tFGwzpMr4A3cmAUoyA9ycg2Dd5Tkty0h9cjjztzGz2qk3Vc1EL/XBYiomjCPcDZxW4jkVH7xdpUaLtSzx+NpcpZXR6QWM7nekKgomtwRJVUJEgnG1DDD7wTzGRzXGnFpgjDVl3ovcXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759270649; c=relaxed/simple;
	bh=J7dYilX7+fwruSZCr5jW3fpm0gVg9dKX3I7gHKTRx3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEr2cEdkTaCLNJ6iG3zCbnfBqF4Ayfuhff1YCjukT2bPbkVsx+VNjVxin+dzrcYM8JXRVrfT1xV73hdeFc49VHaX4RMA3s71bhzR6SmspYQ+Ew6ALK8jhbUMzAweCu+4Qlf2zMGO8x8pouOk2qXUQaMmNp1ZrX3wG60wo4i8GNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNlaM1Rc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D52C4CEF0;
	Tue, 30 Sep 2025 22:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759270648;
	bh=J7dYilX7+fwruSZCr5jW3fpm0gVg9dKX3I7gHKTRx3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNlaM1RctN9iKCK1TFbrDfa/17YAX7nwWg5LWZ15rb1dWH2ABMhO0n0Yylff5TnMJ
	 0+PgwxoCnQf5XK3RGhzgzOWvXajJ6gVfTRO3o4RRPlUP+UnyPyhK8qF8m29Xe2W7kY
	 sI5tPsADp1UpfudsyDQ7OUV7ZPsTObLpjkqLXF2wFx7wLjRVIvF5qkyJGp0lCEYSZq
	 9aJOA62rUbaOdXoOEXDEvZjDpR5UxXqQd5KNVKSjaChr3CDEef/AhWL83w9zWOXVur
	 Gj72tG/VGUrGuETMZ3Lxtk82XdY5nHhXxVwRsp+YFH8clVktPtkzpojJImfCm06n+x
	 QexY3S+sCXiFg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/9] KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2
Date: Wed,  1 Oct 2025 01:17:01 +0300
Message-Id: <20250930221707.1373912-4-jarkko@kernel.org>
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

Use tpm_ret_to_err() to transmute TPM return codes in trusted_tpm2.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
---
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


