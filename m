Return-Path: <linux-integrity+bounces-3248-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63528946456
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 22:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D515282579
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 20:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC5653389;
	Fri,  2 Aug 2024 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="R789jnk4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92933DF
	for <linux-integrity@vger.kernel.org>; Fri,  2 Aug 2024 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630407; cv=none; b=Y+8ORahTKvq8BTqp6IHaBdiYI/9qoHsnp6sgbBaP8ZFyrx3CyxwbCM03S+6xPbgC3zVVQdAUQx2/rFc+FxLUdzr4Kzt7qzLXXJGj6QFhrPJ1dUB/kckJk4MOBnWlrBFTBWLgWOTpWSB4bconhefoSpPct3YY/coHkLy38enroVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630407; c=relaxed/simple;
	bh=XU+dvLQYWHnHVWOM2RRqf/WI1AWPHF27cSZcHp3fJRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwy8PTeiqjoXe24M+q/A6j1LNEKvyBY+HAh/k8mx1R7MEj4xwirPG4DSh2iu+M3axTab47KXzrQgGBtEmntiwBkqX9wq465h6KlYd1g/rg2yikdAPlRd0ZUMp5zhccql043Z8w7Eadlu0slWvJgDhTud05uWwnlel6A/wOHg9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=R789jnk4; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722630404;
	bh=XU+dvLQYWHnHVWOM2RRqf/WI1AWPHF27cSZcHp3fJRE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=R789jnk4xNug0NYkE18ZxHl1EuraccXkosrYLQbfWgG2l2mcgzNwmYd3oKZeItLp6
	 Kg/ehLnNGuKunZncpAu4aTXWBCeNbKcFvnliXbcP4MawMv9bJugCHL/nlxbisEUmD2
	 40azjqK1kMGPZ5Km/Vpwv0qGzTX7OOxjww/Xmz2Y=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D78A51286A6B;
	Fri, 02 Aug 2024 16:26:44 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id dExUoxIiLZ06; Fri,  2 Aug 2024 16:26:44 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5BFFC128690C;
	Fri, 02 Aug 2024 16:26:44 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: openssl-tpm2-engine@groups.io
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 2/8] libcommon: add ability to create a signing primary key
Date: Fri,  2 Aug 2024 16:26:00 -0400
Message-Id: <20240802202606.12767-3-James.Bottomley@HansenPartnership.com>
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

Having a primary key that can sign things is useful for conducting
certification and quoting operations without having to go through the
makecredential/activatecredential dance, which is unnecessary for a
local TPM where you don't need privacy separated attestation keys.
Add the ability to use the signing key template to tpm2_load_srk().

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 src/include/tpm2-common.h   |  1 +
 src/libcommon/tpm2-common.c | 23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/src/include/tpm2-common.h b/src/include/tpm2-common.h
index 4520f76..97b60f2 100644
--- a/src/include/tpm2-common.h
+++ b/src/include/tpm2-common.h
@@ -23,6 +23,7 @@ enum tpm2_type {
 	TPM2_LOADABLE = 1,
 	TPM2_IMPORTABLE = 2,
 	TPM2_SEALED = 3,
+	TPM2_SIGNING = 4,
 };
 
 struct policies {
diff --git a/src/libcommon/tpm2-common.c b/src/libcommon/tpm2-common.c
index 3b9f785..b70ac27 100644
--- a/src/libcommon/tpm2-common.c
+++ b/src/libcommon/tpm2-common.c
@@ -743,17 +743,30 @@ TPM_RC tpm2_load_srk(TSS_CONTEXT *tssContext, TPM_HANDLE *h, const char *auth,
 		TPMA_OBJECT_NODA |
 		TPMA_OBJECT_SENSITIVEDATAORIGIN |
 		TPMA_OBJECT_USERWITHAUTH |
-		TPMA_OBJECT_DECRYPT |
 		TPMA_OBJECT_RESTRICTED;
+	if (type == TPM2_SIGNING)
+		VAL(inPublic.publicArea.objectAttributes) |=
+			TPMA_OBJECT_SIGN;
+	else
+		VAL(inPublic.publicArea.objectAttributes) |=
+			TPMA_OBJECT_DECRYPT;
 	if (type != TPM2_LEGACY)
 		VAL(inPublic.publicArea.objectAttributes) |=
 			TPMA_OBJECT_FIXEDPARENT |
 			TPMA_OBJECT_FIXEDTPM;
 
-	inPublic.publicArea.parameters.eccDetail.symmetric.algorithm = TPM_ALG_AES;
-	inPublic.publicArea.parameters.eccDetail.symmetric.keyBits.aes = 128;
-	inPublic.publicArea.parameters.eccDetail.symmetric.mode.aes = TPM_ALG_CFB;
-	inPublic.publicArea.parameters.eccDetail.scheme.scheme = TPM_ALG_NULL;
+	if (type != TPM2_SIGNING) {
+		inPublic.publicArea.parameters.eccDetail.symmetric.algorithm = TPM_ALG_AES;
+		inPublic.publicArea.parameters.eccDetail.symmetric.keyBits.aes = 128;
+		inPublic.publicArea.parameters.eccDetail.symmetric.mode.aes = TPM_ALG_CFB;
+		inPublic.publicArea.parameters.eccDetail.scheme.scheme = TPM_ALG_NULL;
+	} else {
+		inPublic.publicArea.parameters.eccDetail.symmetric.algorithm = TPM_ALG_NULL;
+		inPublic.publicArea.parameters.eccDetail.symmetric.keyBits.aes = 0;
+		inPublic.publicArea.parameters.eccDetail.symmetric.mode.aes = TPM_ALG_NULL;
+		inPublic.publicArea.parameters.eccDetail.scheme.scheme = TPM_ALG_ECDSA;
+		inPublic.publicArea.parameters.eccDetail.scheme.details.ecdsa.hashAlg = TPM_ALG_SHA256;
+	}
 	inPublic.publicArea.parameters.eccDetail.curveID = TPM_ECC_NIST_P256;
 	inPublic.publicArea.parameters.eccDetail.kdf.scheme = TPM_ALG_NULL;
 
-- 
2.35.3


