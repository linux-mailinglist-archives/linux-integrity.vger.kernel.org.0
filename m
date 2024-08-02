Return-Path: <linux-integrity+bounces-3250-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AC194645A
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 22:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7211B210A1
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 20:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241AF33DF;
	Fri,  2 Aug 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="BuMqCtQC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95101335C0
	for <linux-integrity@vger.kernel.org>; Fri,  2 Aug 2024 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630421; cv=none; b=BSsXfFwD0WqSFwkBCf8/8pvmqLzD2VAP7eoEiUnZ1FBk3DR3hWkh8VTyuj53i8tAOTZQrLc72uev/yWgXbp5YbK5AgMkNzGhAUXaM6WWYpcFcbb3BzHb/xoCXlCTpIzBZdg6mxKSCV49HF/p5h7iciouWkz13XccC4qYI6Cxbmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630421; c=relaxed/simple;
	bh=/6f5JDDLTwh/hyHKM8I5DBdiE7qBwzHBvU+Igzw9x+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V7AvXKv3tV8+LBujVxmLOQY9/RRzqrqqWmhjut9ibWjaOeIUj9NDT4wTwlabobvpvU+gbKgrn2uFyd2Z8rQSzCyf9gC+ru+jXScJDqrq6TtKBb0zPOOVbwEjrMKb9SKonmrq9b/ehW3R7InMe/5AQJ2ocaJMGN7oVXsI/CeBwJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=BuMqCtQC; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722630419;
	bh=/6f5JDDLTwh/hyHKM8I5DBdiE7qBwzHBvU+Igzw9x+c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=BuMqCtQCiOJCUKgt5nvXQgxYsMY98m4IiZ6Jx1QgYLZafKeWtp4gglhcDX+DM/+UO
	 UIi6C4GFtX64d/fVgbRbYxLmrKncP6dR71AT8nHAMTA/KcVlzq/vtE5SKYpI0BlFxN
	 4+/WdPg5QibW4GduI25jK0dQ9bP6v7CPw2QnHyAs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1C0501286A6B;
	Fri, 02 Aug 2024 16:26:59 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id BjV7tdSRJoc3; Fri,  2 Aug 2024 16:26:59 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9EE5B128690C;
	Fri, 02 Aug 2024 16:26:58 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: openssl-tpm2-engine@groups.io
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 4/8] libcommon: add primary creation from template
Date: Fri,  2 Aug 2024 16:26:02 -0400
Message-Id: <20240802202606.12767-5-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
References: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although for usual operation we only need the standard template to
create the keys, for EK operations we need to create the EK from the
exact EK template (of which there are a few), so add a new function to
allow the creation of a primary from any given template.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 src/include/tpm2-common.h   |  3 +++
 src/libcommon/tpm2-common.c | 54 +++++++++++++++++++++----------------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/src/include/tpm2-common.h b/src/include/tpm2-common.h
index 0e0f28a..026a2ae 100644
--- a/src/include/tpm2-common.h
+++ b/src/include/tpm2-common.h
@@ -59,6 +59,9 @@ struct app_data {
 void tpm2_error(TPM_RC rc, const char *reason);
 TPM_RC tpm2_load_srk(TSS_CONTEXT *tssContext, TPM_HANDLE *h, const char *auth,
 		     TPM2B_PUBLIC *pub, TPM_HANDLE handle, enum tpm2_type type);
+TPM_RC tpm2_load_srk_tmpl(TSS_CONTEXT *tssContext, TPM_HANDLE *h,
+			  const char *auth, TPM2B_PUBLIC *tmpl,
+			  TPM2B_PUBLIC *pub, TPM_HANDLE hierarchy);
 void tpm2_flush_handle(TSS_CONTEXT *tssContext, TPM_HANDLE h);
 EVP_PKEY *tpm2_to_openssl_public(TPMT_PUBLIC *pub);
 void tpm2_flush_srk(TSS_CONTEXT *tssContext, TPM_HANDLE hSRK);
diff --git a/src/libcommon/tpm2-common.c b/src/libcommon/tpm2-common.c
index 3ffa773..be3fe50 100644
--- a/src/libcommon/tpm2-common.c
+++ b/src/libcommon/tpm2-common.c
@@ -717,13 +717,12 @@ TPM_RC tpm2_ObjectPublic_GetName(NAME_2B *name,
 	return rc;
 }
 
-TPM_RC tpm2_load_srk(TSS_CONTEXT *tssContext, TPM_HANDLE *h, const char *auth,
-		     TPM2B_PUBLIC *pub, TPM_HANDLE hierarchy,
-		     enum tpm2_type type)
+TPM_RC tpm2_load_srk_tmpl(TSS_CONTEXT *tssContext, TPM_HANDLE *h,
+			  const char *auth, TPM2B_PUBLIC *tmpl,
+			  TPM2B_PUBLIC *pub, TPM_HANDLE hierarchy)
 {
 	TPM_RC rc;
 	TPM2B_SENSITIVE_CREATE inSensitive;
-	TPM2B_PUBLIC inPublic;
 	TPM_HANDLE session = TPM_RS_PW;
 
 	if (auth) {
@@ -736,7 +735,33 @@ TPM_RC tpm2_load_srk(TSS_CONTEXT *tssContext, TPM_HANDLE *h, const char *auth,
 	/* no sensitive date for storage keys */
 	VAL_2B(inSensitive.sensitive.data, size) = 0;
 
-	/* public parameters for an RSA2048 key  */
+	/* use a bound session here because we have no known key objects
+	 * to encrypt a salt to */
+	if (auth) {
+		rc = tpm2_get_bound_handle(tssContext, &session, hierarchy, auth);
+		if (rc)
+			return rc;
+	}
+
+	rc = tpm2_CreatePrimary(tssContext, hierarchy, &inSensitive, tmpl,
+				h, pub, session, auth);
+
+	if (rc) {
+		tpm2_error(rc, "TSS_CreatePrimary");
+		if (session != TPM_RS_PW)
+			tpm2_flush_handle(tssContext, session);
+	}
+
+	return rc;
+}
+
+TPM_RC tpm2_load_srk(TSS_CONTEXT *tssContext, TPM_HANDLE *h, const char *auth,
+		     TPM2B_PUBLIC *pub, TPM_HANDLE hierarchy,
+		     enum tpm2_type type)
+{
+	TPM2B_PUBLIC inPublic;
+
+	/* public parameters for a P-256 key  */
 	inPublic.publicArea.type = TPM_ALG_ECC;
 	inPublic.publicArea.nameAlg = TPM_ALG_SHA256;
 	VAL(inPublic.publicArea.objectAttributes) =
@@ -774,24 +799,7 @@ TPM_RC tpm2_load_srk(TSS_CONTEXT *tssContext, TPM_HANDLE *h, const char *auth,
 	VAL_2B(inPublic.publicArea.unique.ecc.y, size) = 0;
 	VAL_2B(inPublic.publicArea.authPolicy, size) = 0;
 
-	/* use a bound session here because we have no known key objects
-	 * to encrypt a salt to */
-	if (auth) {
-		rc = tpm2_get_bound_handle(tssContext, &session, hierarchy, auth);
-		if (rc)
-			return rc;
-	}
-
-	rc = tpm2_CreatePrimary(tssContext, hierarchy, &inSensitive, &inPublic,
-				h, pub, session, auth);
-
-	if (rc) {
-		tpm2_error(rc, "TSS_CreatePrimary");
-		if (session != TPM_RS_PW)
-			tpm2_flush_handle(tssContext, session);
-	}
-
-	return rc;
+	return tpm2_load_srk_tmpl(tssContext, h, auth, &inPublic, pub, hierarchy);
 }
 
 void tpm2_flush_srk(TSS_CONTEXT *tssContext, TPM_HANDLE hSRK)
-- 
2.35.3


