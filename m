Return-Path: <linux-integrity+bounces-7487-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66CBECE31
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 13:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEF45E3163
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 11:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3FE2D879C;
	Sat, 18 Oct 2025 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0656Ahw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B010A2459D9;
	Sat, 18 Oct 2025 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760786272; cv=none; b=HNKncVQBuTnV/h3l2bcx4edqah1z4DEXHgcslQCBiy+vUHbBTY6eskuFe7LzEJ6WJ+ysEjxbPHpbyo5Edicw3ShDzc5JzdzSsWhE3Ifdubs2vhKF2qvyAt2L6Vw+fpEO3eIwYQAAq+QqEwQ11MZyVMPyYV/w8XSWaHk2Kx2YYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760786272; c=relaxed/simple;
	bh=Ecnq8rzxl6k5vrx8b5stw4hzFr1y6CAfG26b1YS3nnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rYbqMLIyzHc5+arx4HycvsixMk5CwLqU4Q5eXSKFoxTS+ziveeZF6S1NIJc9JImylQ+9SQ+W+vcMQpHV+tOk7x/ss+YZPM47m0EJcgZASyl7bNQsrQxkG+TYCz/Ek/qa4Xe8SDEkI3yvIqPOW8onnUOHovZfQlDUU808S57HPP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0656Ahw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47C0C4CEF8;
	Sat, 18 Oct 2025 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760786272;
	bh=Ecnq8rzxl6k5vrx8b5stw4hzFr1y6CAfG26b1YS3nnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0656AhwyQjSvpI0wS3nDkxP+DN55hJlrFSuv5yfeDACfCDPv8aFeXRbWkJmnvkFo
	 f6z1sIooaQCVB6lzeDCHnfv4TyMRbWZD16j60Velk4DoZkXQgE+RZ+w7rMcCtQF3bX
	 9t091dLRfTFXDMPwoWVhlWJvIqopk0BV4SMPc/SCmYL4u+EdTZ7kMlRnTyEt1MKavO
	 DtnTKzz29GRj59Vx/7cP9gaNfdq075UBDXCWrXhLtBLOy/gkKI1DXAlD9GQnJzDGvX
	 LLCJJfc42n2vXPQVP6a3Nr8B8xrhD/3rWuNKCManRv4BdOCcZ9EE3KosyX2OdOCd/L
	 QXXl2iswnHMuw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyring@vger.kernel.org,
	dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Roberto Sassu <roberto.sassu@huawei.com>,
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
Subject: [PATCH v6 04/10] KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2
Date: Sat, 18 Oct 2025 14:17:19 +0300
Message-Id: <20251018111725.3116386-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251018111725.3116386-1-jarkko@kernel.org>
References: <20251018111725.3116386-1-jarkko@kernel.org>
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
index 468a4a339541..1cd00aad033a 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -346,25 +346,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
@@ -465,10 +459,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 out:
 	tpm_buf_destroy(&buf);
 
-	if (rc > 0)
-		rc = -EPERM;
-
-	return rc;
+	return tpm_ret_to_err(rc);
 }
 
 /**
@@ -531,8 +522,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	tpm_buf_fill_hmac_session(chip, &buf);
 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
-	if (rc > 0)
-		rc = -EPERM;
 
 	if (!rc) {
 		data_len = be16_to_cpup(
@@ -565,7 +554,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 
 out:
 	tpm_buf_destroy(&buf);
-	return rc;
+	return tpm_ret_to_err(rc);
 }
 
 /**
@@ -597,6 +586,5 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 
 out:
 	tpm_put_ops(chip);
-
-	return rc;
+	return tpm_ret_to_err(rc);
 }
-- 
2.39.5


