Return-Path: <linux-integrity+bounces-3249-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761C4946459
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 22:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1842CB2103C
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 20:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17094CE05;
	Fri,  2 Aug 2024 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="lVcUy6fV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F2335C0
	for <linux-integrity@vger.kernel.org>; Fri,  2 Aug 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630414; cv=none; b=rTu/F2ZKVgudZr/WtZ6yhpAfEccMfHUMsMurE8ej4TXmia/E+gk1bwrmWZc9W9zqMD/evRSBzaK6ugwh5CmgUZtnGbltMz4Rm0e00PKOmFGcB4RVr7EYmItApMbmemfaZn6BFu+LaLwgAXpsELbrXl5h7G0MXBNDilvcOvUzhAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630414; c=relaxed/simple;
	bh=/FecCDLZ1DR5BrQqvYyJHHGzKOTUyQKiy/cycGXV2i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ik3MoBwd/WYr3ZPGsiMGYxAoZ8cCO/MwDoKwyisW3Fg8LSnoR1hRDsVD+RZrbkqv5yv0cOuCdJA1L4pHKrLQLhMWxUV4S6EsztsN1egyMKb16SB01HwOqFfr3Unvn6YbAhsKF+YGu5SF4d0BnMD1pMNlJ6conetTQo0ZbVIg6uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=lVcUy6fV; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722630412;
	bh=/FecCDLZ1DR5BrQqvYyJHHGzKOTUyQKiy/cycGXV2i8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=lVcUy6fVSgFZcfN+jeAG16QI2tXFFv0j//653gzJR00gKNX00L9cPiqH5e5gnqJib
	 kZvZafvwIpkCUu4sRRLS3Rk6Ewa+WwJSV/vC8eZ0R5ErmXx9cYFo9UA0vV7Efu//Cp
	 fIJ+I9DrXzL9jMWqWKaHTtGIgecwVUacD2SzHZNw=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C404D1286A6B;
	Fri, 02 Aug 2024 16:26:52 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id NERE6xOfK9o6; Fri,  2 Aug 2024 16:26:52 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 30188128690C;
	Fri, 02 Aug 2024 16:26:52 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: openssl-tpm2-engine@groups.io
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 3/8] libcommon: add bin2hex and tmp2_get_hexname
Date: Fri,  2 Aug 2024 16:26:01 -0400
Message-Id: <20240802202606.12767-4-James.Bottomley@HansenPartnership.com>
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

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 src/include/tpm2-common.h   |  5 +++++
 src/libcommon/tpm2-common.c | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/src/include/tpm2-common.h b/src/include/tpm2-common.h
index 97b60f2..0e0f28a 100644
--- a/src/include/tpm2-common.h
+++ b/src/include/tpm2-common.h
@@ -9,6 +9,9 @@
  * not a TPM error, so don't process the rc as one */
 #define NOT_TPM_ERROR (0xffffffff)
 
+/* maximum space for a sha256 name in ascii */
+#define MAX_HEXNAME 132
+
 extern TPM_ALG_ID name_alg;
 
 struct policy_command {
@@ -141,4 +144,6 @@ int tpm2_rsa_decrypt(const struct app_data *ad, PUBLIC_KEY_RSA_2B *cipherText,
 		     char *srk_auth);
 int tpm2_rm_signed_policy(char *tpmkey, int rmnum);
 int tpm2_get_signed_policy(char *tpmkey, STACK_OF(TSSAUTHPOLICY) **sk);
+void bin2hex(char *dst, const unsigned char *src, size_t count);
+void tpm2_get_hexname(char hexname[MAX_HEXNAME], TPM2B_PUBLIC *pub);
 #endif
diff --git a/src/libcommon/tpm2-common.c b/src/libcommon/tpm2-common.c
index b70ac27..3ffa773 100644
--- a/src/libcommon/tpm2-common.c
+++ b/src/libcommon/tpm2-common.c
@@ -2320,6 +2320,14 @@ int hex2bin(unsigned char *dst, const char *src, size_t count)
 	return 0;
 }
 
+void bin2hex(char *dst, const unsigned char *src, size_t count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		sprintf(&dst[i<<1], "%02x", src[i]);
+}
+
 TPM_RC tpm2_parse_policy_file(const char *policy_file,
 			      STACK_OF(TSSOPTPOLICY) *sk,
 			      char *auth, TPMT_HA *digest)
@@ -3376,6 +3384,14 @@ openssl_print_errors()
 	ERR_print_errors_fp(stderr);
 }
 
+void tpm2_get_hexname(char hexname[MAX_HEXNAME], TPM2B_PUBLIC *pub)
+{
+	NAME_2B n;
+
+	tpm2_ObjectPublic_GetName(&n, &pub->publicArea);
+	bin2hex(hexname, (unsigned char *)n.name, n.size);
+}
+
 IMPLEMENT_ASN1_FUNCTIONS(TSSOPTPOLICY)
 IMPLEMENT_ASN1_FUNCTIONS(TSSAUTHPOLICY)
 IMPLEMENT_ASN1_FUNCTIONS(TSSLOADABLE)
-- 
2.35.3


