Return-Path: <linux-integrity+bounces-3251-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827D2946458
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 22:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D91E282359
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 20:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67C24F615;
	Fri,  2 Aug 2024 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="P4atAKBq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E0A49658
	for <linux-integrity@vger.kernel.org>; Fri,  2 Aug 2024 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630427; cv=none; b=OVA1UbVcq+lCNu/1uHIALU1+vKq1mBihkeJRXpnXJg7layFpby5S+dvMiN2MUQ28bddb4unO5x5cKsuzgsV/HZLhvyaDLGaar9WKaHNkVg9M7vS3M/L7RpX9z9Oq+o1693CJiY58FLizULyBQiaslx8aeOWBS6DdjUgdgTiTZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630427; c=relaxed/simple;
	bh=0R2yr2EPWtj7mnglV5x3DOhrjqkXbxmxsU9gnoCJf4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCFddOnhy173bcg8Qq+8fcH2nkmfVDABPY7KliD5BANa1lKSOHPkohmwiODneP/2FumwNXEw3oiFaPYH/3Td8QLrJIwaUEqcH6GjKeqD0tq9teoSnghjTjSgiegKd/N8ia8Tx9c58rNfU52PieFp4l/AToVhPkSafVS75ft/U9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=P4atAKBq; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722630425;
	bh=0R2yr2EPWtj7mnglV5x3DOhrjqkXbxmxsU9gnoCJf4g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=P4atAKBqSvbLVv5UkqbRwHmMMMdFofGFO83iM/1NHQFIDf5hQu/xZsQ1XzA7TvrN1
	 mDllaUAiu7fcmylzaEP56C9GSBHlqMNKnrBkeTqmslQVOeQmdipFXk5dUc1cWx/Qoq
	 4E1lEPAnoyMNKgkdShTLBFAk7z+MJ/Ickye9a6zo=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CA99C1286A6B;
	Fri, 02 Aug 2024 16:27:05 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id xi1AjlFFYM3H; Fri,  2 Aug 2024 16:27:05 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4CD40128690C;
	Fri, 02 Aug 2024 16:27:05 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: openssl-tpm2-engine@groups.io
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 5/8] tss: add tpm2_Certify, tpm2_ActivateCredential and tpm2_PolicyOR
Date: Fri,  2 Aug 2024 16:26:03 -0400
Message-Id: <20240802202606.12767-6-James.Bottomley@HansenPartnership.com>
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

tpm2_Certify is used to verify that a given object is resident in the
TPM.  tpm2_ActivateCredential is used to decrypt a challenge from a
privacyCA and constructing the high template for the EK to use with
this requires PolicyOR.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 src/include/ibm-tss.h   | 84 +++++++++++++++++++++++++++++++++++++++++
 src/include/intel-tss.h | 77 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/src/include/ibm-tss.h b/src/include/ibm-tss.h
index 1b53319..b5da340 100644
--- a/src/include/ibm-tss.h
+++ b/src/include/ibm-tss.h
@@ -16,6 +16,7 @@
 #define VAL(X)			X.val
 #define VAL_2B(X, MEMBER)	X.b.MEMBER
 #define VAL_2B_P(X, MEMBER)	X->b.MEMBER
+#define VAL_T(X, MEMBER)	X.t.MEMBER
 
 static inline void
 tpm2_error(TPM_RC rc, const char *reason)
@@ -695,6 +696,26 @@ tpm2_PolicySecret(TSS_CONTEXT *tssContext, TPM_HANDLE authHandle,
 	return rc;
 }
 
+static inline TPM_RC
+tpm2_PolicyOR(TSS_CONTEXT *tssContext, TPM_HANDLE policySession,
+	      TPML_DIGEST *pHashList)
+{
+	PolicyOR_In in;
+	TPM_RC rc;
+
+	in.policySession = policySession;
+	in.pHashList = *pHashList;
+
+	rc = TSS_Execute(tssContext,
+			 NULL,
+			 (COMMAND_PARAMETERS *)&in,
+			 NULL,
+			 TPM_CC_PolicyOR,
+			 TPM_RH_NULL, NULL, 0);
+
+	return rc;
+}
+
 static inline TPM_RC
 tpm2_PolicyGetDigest(TSS_CONTEXT *tssContext, TPM_HANDLE policySession,
 		     DIGEST_2B *digest)
@@ -743,6 +764,69 @@ tpm2_PCR_Read(TSS_CONTEXT *tssContext, TPML_PCR_SELECTION *pcrSelectionIn,
 	return rc;
 }
 
+static inline TPM_RC
+tpm2_Certify(TSS_CONTEXT *tssContext, TPM_HANDLE objectHandle,
+	     TPM_HANDLE signHandle, DATA_2B *qualifyingData,
+	     ATTEST_2B *certifyInfo, TPMT_SIGNATURE *signature)
+{
+	Certify_In in;
+	Certify_Out out;
+	TPM_RC rc;
+
+	in.objectHandle = objectHandle;
+	in.signHandle = signHandle;
+	in.qualifyingData.t = *qualifyingData;
+	in.inScheme.scheme = TPM_ALG_NULL;
+
+	rc = TSS_Execute(tssContext,
+			 (RESPONSE_PARAMETERS *)&out,
+			 (COMMAND_PARAMETERS *)&in,
+			 NULL,
+			 TPM_CC_Certify,
+			 TPM_RS_PW, NULL, 0,
+			 TPM_RS_PW, NULL, 0,
+			 TPM_RH_NULL, NULL, 0);
+
+	if (rc)
+		return rc;
+
+	*certifyInfo = out.certifyInfo.t;
+	*signature = out.signature;
+
+	return rc;
+}
+
+static inline TPM_RC
+tpm2_ActivateCredential(TSS_CONTEXT *tssContext, TPM_HANDLE activateHandle,
+			TPM_HANDLE keyHandle, ID_OBJECT_2B *credentialBlob,
+			ENCRYPTED_SECRET_2B *secret, DIGEST_2B *certinfo,
+			TPM_HANDLE auth)
+{
+	ActivateCredential_In in;
+	ActivateCredential_Out out;
+	TPM_RC rc;
+
+	in.activateHandle = activateHandle;
+	in.keyHandle = keyHandle;
+	in.credentialBlob.t = *credentialBlob;
+	in.secret.t = *secret;
+
+	rc = TSS_Execute(tssContext,
+			 (RESPONSE_PARAMETERS *)&out,
+			 (COMMAND_PARAMETERS *)&in,
+			 NULL,
+			 TPM_CC_ActivateCredential,
+			 TPM_RS_PW, NULL, 0,
+			 auth, NULL, TPMA_SESSION_ENCRYPT,
+			 TPM_RH_NULL, NULL, 0);
+	if (rc)
+		return rc;
+
+	*certinfo = out.certInfo.t;
+
+	return rc;
+}
+
 static inline TPM_HANDLE
 tpm2_handle_int(TSS_CONTEXT *tssContext, TPM_HANDLE h)
 {
diff --git a/src/include/intel-tss.h b/src/include/intel-tss.h
index 5b8db20..3b8c18d 100644
--- a/src/include/intel-tss.h
+++ b/src/include/intel-tss.h
@@ -74,6 +74,7 @@
 #define TPM_CC_PolicySecret	TPM2_CC_PolicySecret
 
 #define TPM_ST_HASHCHECK	TPM2_ST_HASHCHECK
+#define TPM_ST_ATTEST_CERTIFY	TPM2_ST_ATTEST_CERTIFY
 
 #define TPM_RH_OWNER		ESYS_TR_RH_OWNER
 #define TPM_RH_PLATFORM		ESYS_TR_RH_PLATFORM
@@ -131,6 +132,7 @@
 
 /* Intel and IBM have slightly different names for all the 2B structures */
 
+#define ATTEST_2B		TPM2B_ATTEST
 #define NAME_2B			TPM2B_NAME
 #define DATA_2B			TPM2B_DATA
 #define PRIVATE_2B		TPM2B_PRIVATE
@@ -138,6 +140,7 @@
 #define KEY_2B			TPM2B_KEY
 #define TPM2B_KEY		TPM2B_DATA
 #define DIGEST_2B		TPM2B_DIGEST
+#define ID_OBJECT_2B		TPM2B_ID_OBJECT
 #define ECC_PARAMETER_2B	TPM2B_ECC_PARAMETER
 #define SENSITIVE_DATA_2B	TPM2B_SENSITIVE_DATA
 #define PUBLIC_KEY_RSA_2B	TPM2B_PUBLIC_KEY_RSA
@@ -196,8 +199,11 @@ TSS_CONVERT_MARSHAL(TPM2B_PRIVATE, )
 TSS_CONVERT_MARSHAL(TPML_PCR_SELECTION, )
 TSS_CONVERT_MARSHAL(TPMT_SIGNATURE, )
 TSS_CONVERT_MARSHAL(UINT32, *)
+#define Tss2_MU_TPM_HANDLE_Marshal Tss2_MU_TPM2_HANDLE_Marshal
+TSS_CONVERT_MARSHAL(TPM_HANDLE, *)
 #define TSS_TPM_CC_Marshal TSS_UINT32_Marshal
 
+TSS_CONVERT_UNMARSHAL(TPMS_ATTEST, )
 TSS_CONVERT_UNMARSHAL(TPML_PCR_SELECTION, )
 TSS_CONVERT_UNMARSHAL(TPM2B_PRIVATE, )
 TSS_CONVERT_UNMARSHAL(TPM2B_PUBLIC, X)
@@ -218,6 +224,7 @@ TSS_CONVERT_UNMARSHAL(TPMT_SIGNATURE, X)
 #define VAL(X) X
 #define VAL_2B(X, MEMBER) X.MEMBER
 #define VAL_2B_P(X, MEMBER) X->MEMBER
+#define VAL_T(X, MEMBER) X.MEMBER
 
 static const struct {
 	TPM_ALG_ID alg;
@@ -409,7 +416,6 @@ TSS_HMAC_Generate(TPMT_HA *digest, const TPM2B_KEY *hmacKey, ...)
 		OSSL_PARAM_construct_utf8_string("digest", TSS_GetDigestName(digest->hashAlg), 0),
 		OSSL_PARAM_construct_end()
 	};
-	fprintf(stderr, "HMAC\n");
 #endif
 	int length;
 	uint8_t *buffer;
@@ -1124,6 +1130,15 @@ tpm2_PolicySecret(TSS_CONTEXT *tssContext, TPM_HANDLE authHandle,
 	return rc;
 }
 
+static inline TPM_RC
+tpm2_PolicyOR(TSS_CONTEXT *tssContext, TPM_HANDLE policySession,
+	      TPML_DIGEST *pHashList)
+{
+	return Esys_PolicyOR(tssContext, policySession,
+			     ESYS_TR_NONE, ESYS_TR_NONE, ESYS_TR_NONE,
+			     pHashList);
+}
+
 static inline TPM_RC
 tpm2_PolicyGetDigest(TSS_CONTEXT *tssContext, TPM_HANDLE policySession,
 		     DIGEST_2B *digest)
@@ -1191,6 +1206,66 @@ tpm2_PCR_Read(TSS_CONTEXT *tssContext, TPML_PCR_SELECTION *pcrSelectionIn,
 	return rc;
 }
 
+static inline TPM_RC
+tpm2_Certify(TSS_CONTEXT *tssContext, TPM_HANDLE objectHandle,
+	     TPM_HANDLE signHandle, DATA_2B *qualifyingData,
+	     ATTEST_2B *certifyInfo, TPMT_SIGNATURE *signature)
+{
+	TPM_RC rc;
+	TPMT_SIG_SCHEME inScheme;
+	ATTEST_2B *a;
+	TPMT_SIGNATURE *s;
+	TPM2B_AUTH auth;
+
+	inScheme.scheme = TPM_ALG_NULL;
+
+	auth.size = 0;
+	Esys_TR_SetAuth(tssContext, objectHandle, &auth);
+	Esys_TR_SetAuth(tssContext, signHandle, &auth);
+
+	rc = Esys_Certify(tssContext, objectHandle, signHandle,
+			  ESYS_TR_PASSWORD, ESYS_TR_PASSWORD,
+			  ESYS_TR_NONE, qualifyingData, &inScheme,
+			  &a, &s);
+	if (rc)
+		return rc;
+
+	*certifyInfo = *a;
+	*signature = *s;
+
+	free(a);
+	free(s);
+
+	return rc;
+}
+
+static inline TPM_RC
+tpm2_ActivateCredential(TSS_CONTEXT *tssContext, TPM_HANDLE activateHandle,
+			TPM_HANDLE keyHandle,
+			const ID_OBJECT_2B *credentialBlob,
+			const ENCRYPTED_SECRET_2B *secret, DIGEST_2B *certinfo,
+			TPM_HANDLE authHandle)
+{
+	TPM_RC rc;
+	DIGEST_2B *cinfo;
+	TPM2B_AUTH auth;
+
+	auth.size = 0;
+	Esys_TR_SetAuth(tssContext, activateHandle, &auth);
+	Esys_TR_SetAuth(tssContext, keyHandle, &auth);
+	intel_sess_helper(tssContext, authHandle, TPMA_SESSION_ENCRYPT);
+	rc = Esys_ActivateCredential(tssContext, activateHandle, keyHandle,
+				     ESYS_TR_PASSWORD, authHandle, ESYS_TR_NONE,
+				     credentialBlob, secret, &cinfo);
+	if (rc)
+		return rc;
+
+	*certinfo = *cinfo;
+	free(cinfo);
+
+	return rc;
+}
+
 static inline TPM_HANDLE
 tpm2_handle_ext(TSS_CONTEXT *tssContext, TPM_HANDLE esysh)
 {
-- 
2.35.3


