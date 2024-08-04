Return-Path: <linux-integrity+bounces-3286-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5069946F0E
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Aug 2024 15:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15A51C209EB
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Aug 2024 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED53381B8;
	Sun,  4 Aug 2024 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FdNtDpx9";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FdNtDpx9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8881CAB1
	for <linux-integrity@vger.kernel.org>; Sun,  4 Aug 2024 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722778966; cv=none; b=DNmbnCr2k0XaHxhcKfjEZsFlqF5gwnUZmuRoQmBooLG+tm1TSP+mr3UHkHEH0IDKw6FkFnb84G8o7yoOdfHF/q3JLTq3AoTgyLRFY7C71VEEJX2VONMDcxUMlRo9Zib77XpzrocwBPu5L1djV/wcEkYkXDVl2AGItsAqA+ubUns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722778966; c=relaxed/simple;
	bh=e0N28LR56+eU7Rmh/AquoCvkT4VBsRFvTZrwiZoLeyM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ucw7Dv/QqO9ZEYK0657m9pUgQLpPvVTE2xP9/mPQsm1QgUzHPVKxVPYw9C7AR0MwBDYCFHnJ2Abzg8H5wRrpH/j19onEYNm1Uxm4LEAKPsz21EZDr3sUzc8YTwhjKuE+A/JU8mm411iztxdGzfy8SblAitReAgc94rHVCZSvyKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=FdNtDpx9; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=FdNtDpx9; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722778962;
	bh=e0N28LR56+eU7Rmh/AquoCvkT4VBsRFvTZrwiZoLeyM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=FdNtDpx9QONy7Ao8sSr6YzpFgumG8ALRGJa19kDzsCB4xVRZ23P1+c+cXkV1QlTcm
	 RYHUMCY3GpOkLiscfsfvKmPvu76AzEKQE0fXCyeQiAzSIL2Rqc2+tdhI0s4k8vQDRi
	 H2KdU8gPQiBY8j4zBPJbQemYkIWI28tEdOieccqY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id BA5ED1281A34;
	Sun, 04 Aug 2024 09:42:42 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 5wjyxZfVuzUx; Sun,  4 Aug 2024 09:42:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722778962;
	bh=e0N28LR56+eU7Rmh/AquoCvkT4VBsRFvTZrwiZoLeyM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=FdNtDpx9QONy7Ao8sSr6YzpFgumG8ALRGJa19kDzsCB4xVRZ23P1+c+cXkV1QlTcm
	 RYHUMCY3GpOkLiscfsfvKmPvu76AzEKQE0fXCyeQiAzSIL2Rqc2+tdhI0s4k8vQDRi
	 H2KdU8gPQiBY8j4zBPJbQemYkIWI28tEdOieccqY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DF36012819B1;
	Sun, 04 Aug 2024 09:42:41 -0400 (EDT)
Message-ID: <940e5cbca2cf08f7275d5e09d552a8500e18742c.camel@HansenPartnership.com>
Subject: [PATCH v2 1/8] tss: Fix handling of TPM_RH_NULL in intel-tss
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: openssl-tpm2-engine@groups.io, jarkko@kernel.org, Jarkko Sakkinen
	 <jarkko.sakkinen@iki.fi>
Cc: linux-integrity@vger.kernel.org
Date: Sun, 04 Aug 2024 09:42:39 -0400
In-Reply-To: <D36KI8TC0600.1OAIM33YQYMLX@kernel.org>
References: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
	 <20240802202606.12767-2-James.Bottomley@HansenPartnership.com>
	 <D36FX5RTUSEW.1LZMP91ZPPZZK@iki.fi>
	 <53a91b9ebbc500e928eadf2112d3ecb5631c56c1.camel@HansenPartnership.com>
	 <D36IYI5ZD4VK.2GC6CG6GIUWK9@kernel.org>
	 <237c1ed926d926bfddb92a959a27543479b5f0ae.camel@HansenPartnership.com>
	 <D36KI8TC0600.1OAIM33YQYMLX@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The design of the intel-tss shim is to hide the difference between the
internal and the external handles by doing the internal to external
transform on entry.  Unfortunately, the NULL handle (TPM_RH_NULL,
40000007) has two possible internal representations depending on
whether it's used to indicate no session or the null hierarcy.

There is a bug in the intel-tss in that it uses the wrong internal
NULL handle to try to create the NULL seed primary (and thus fails).
Now that we're going to be using the NULL primary to salt sessions,
the Intel TSS shim needs fixing to cope with thi correctly.

The fix is to do the correct transform to the internal hierarchy
representation on NULL hierarchy creation and to do the session handle
conversion everywhere else.  Additionally remove the intel_handle()
code which was supposed to do this: it's unused because 0 is never
passed in as a handle number.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
v2: reword commit message

---
 src/include/intel-tss.h | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/src/include/intel-tss.h b/src/include/intel-tss.h
index 1870b4e..5b8db20 100644
--- a/src/include/intel-tss.h
+++ b/src/include/intel-tss.h
@@ -251,14 +251,6 @@ intel_sess_helper(TSS_CONTEXT *tssContext,
TPM_HANDLE auth, TPMA_SESSION flags)
 				  TPMA_SESSION_CONTINUESESSION |
flags);
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
@@ -937,8 +929,10 @@ tpm2_CreatePrimary(TSS_CONTEXT *tssContext,
TPM_HANDLE primaryHandle,
 	TPM2B_PUBLIC *opub;
 	TPM_RC rc;
 
-	/* FIXME will generate wrong value for NULL hierarchy */
-	primaryHandle = intel_handle(primaryHandle);
+
+	/* TPM_RH_NULL is mapped to ESYS_TR_NONE, which won't work
here */
+	if (primaryHandle == TPM_RH_NULL)
+		primaryHandle = INT_TPM_RH_NULL;
 
 	outsideInfo.size = 0;
 	creationPcr.count = 0;
@@ -993,9 +987,7 @@ tpm2_StartAuthSession(TSS_CONTEXT *tssContext,
TPM_HANDLE tpmKey,
 		      TPM_HANDLE *sessionHandle,
 		      const char *bindPassword)
 {
-	bind = intel_handle(bind);
-	tpmKey = intel_handle(tpmKey);
-	if (bind != ESYS_TR_NONE)
+	if (bind != TPM_RH_NULL)
 		intel_auth_helper(tssContext, bind, bindPassword);
 
 	return Esys_StartAuthSession(tssContext, tpmKey, bind,
ESYS_TR_NONE,
-- 
2.35.3



