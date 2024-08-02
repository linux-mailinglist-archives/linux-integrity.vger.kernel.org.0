Return-Path: <linux-integrity+bounces-3247-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA697946454
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 22:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CFDBB21F6F
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 20:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754AC4D8D1;
	Fri,  2 Aug 2024 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ebCGbhrs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00F4D8A1
	for <linux-integrity@vger.kernel.org>; Fri,  2 Aug 2024 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630401; cv=none; b=VtADGZDrub8TcvoIvtC1CVzjpsNrQyyO9rRkZK0CnRvME+lqIbRJfUf2r9AhnaS53J4ZIv7Vbpu3dQdUbgO1HU9zMugZ/oWYlwN/UYODadtQBkj2uHdTSVnf2rAXyFVZcDPa4OBnqpRuev5crx/cvBUHLHzyEIZENcMA9GgwH78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630401; c=relaxed/simple;
	bh=tlYMTE9qUYrL1KkFicy/RFTs+B9cajYqQ8pFQYhQd+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eov5cpnH6YdRFvnJ9DK53fbMTjSCcXssimzK0to5iohlac9Xj4pysYUcDQ7n0qEKFzC1QFdpi5rj49FX5dJ67jNpDlHxeHu8C6XKptVcUI5MaaHJGFZRcSNWpRcBvLf/q9exZqJYHYXf5bcS5Uhee/iRqy0sP9Jmzwg38zMM5ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ebCGbhrs; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722630395;
	bh=tlYMTE9qUYrL1KkFicy/RFTs+B9cajYqQ8pFQYhQd+c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=ebCGbhrsDY+GLCrkOAVkaJ2ppK46cIrMdzvNmZ8syHW8AduMYlByfQ+OP/CUUdsRA
	 MoEh/OkxcgjXOOT/HGVouV3LlDRa3oMTEPdD8govlzUD9F3Zp5B67P1zc1bJQMNoYx
	 VbCV+UlN9B/lSpc9W0pKvfLc2jdlwMvR2lO8xxuI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3CA1E1286A6B;
	Fri, 02 Aug 2024 16:26:35 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id EmW6V8rWYiMo; Fri,  2 Aug 2024 16:26:35 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B60C4128690C;
	Fri, 02 Aug 2024 16:26:34 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: openssl-tpm2-engine@groups.io
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 1/8] tss: Fix handling of TPM_RH_NULL in intel-tss
Date: Fri,  2 Aug 2024 16:25:59 -0400
Message-Id: <20240802202606.12767-2-James.Bottomley@HansenPartnership.com>
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

Now that we're going to be using the NULL primary to salt sessions,
the Intel TSS shim needs fixing to cope with this.  In the Intel TSS,
there are two internal handles representing NULL: ESYS_TR_NONE and
ESYS_TR_RH_NULL.  We translate TPM_RH_NULL to ESYS_TR_NONE because
most of the time it does mean no value.  However, for the NULL primary
handle we must use ESYS_TR_RH_NULL, so check for that specific case
and fix it.  Additionally remove the intel_handle() code which was
supposed to do this: it's unused because 0 is never passed in as a
handle number.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 src/include/intel-tss.h | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/src/include/intel-tss.h b/src/include/intel-tss.h
index 1870b4e..5b8db20 100644
--- a/src/include/intel-tss.h
+++ b/src/include/intel-tss.h
@@ -251,14 +251,6 @@ intel_sess_helper(TSS_CONTEXT *tssContext, TPM_HANDLE auth, TPMA_SESSION flags)
 				  TPMA_SESSION_CONTINUESESSION | flags);
 }
 
-static inline TPM_HANDLE
-intel_handle(TPM_HANDLE h)
-{
-	if (h == 0)
-		return ESYS_TR_NONE;
-	return h;
-}
-
 static inline void
 TSS_Delete(TSS_CONTEXT *tssContext)
 {
@@ -937,8 +929,10 @@ tpm2_CreatePrimary(TSS_CONTEXT *tssContext, TPM_HANDLE primaryHandle,
 	TPM2B_PUBLIC *opub;
 	TPM_RC rc;
 
-	/* FIXME will generate wrong value for NULL hierarchy */
-	primaryHandle = intel_handle(primaryHandle);
+
+	/* TPM_RH_NULL is mapped to ESYS_TR_NONE, which won't work here */
+	if (primaryHandle == TPM_RH_NULL)
+		primaryHandle = INT_TPM_RH_NULL;
 
 	outsideInfo.size = 0;
 	creationPcr.count = 0;
@@ -993,9 +987,7 @@ tpm2_StartAuthSession(TSS_CONTEXT *tssContext, TPM_HANDLE tpmKey,
 		      TPM_HANDLE *sessionHandle,
 		      const char *bindPassword)
 {
-	bind = intel_handle(bind);
-	tpmKey = intel_handle(tpmKey);
-	if (bind != ESYS_TR_NONE)
+	if (bind != TPM_RH_NULL)
 		intel_auth_helper(tssContext, bind, bindPassword);
 
 	return Esys_StartAuthSession(tssContext, tpmKey, bind, ESYS_TR_NONE,
-- 
2.35.3


