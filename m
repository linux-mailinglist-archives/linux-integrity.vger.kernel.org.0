Return-Path: <linux-integrity+bounces-3287-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50939946F9C
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Aug 2024 17:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04127281605
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Aug 2024 15:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E0F58210;
	Sun,  4 Aug 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="oPlcqyiS";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="SFc2RLoO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC209461
	for <linux-integrity@vger.kernel.org>; Sun,  4 Aug 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722785852; cv=none; b=T9/JNbwyMDPyoo+5Hua8LMRlt096miJ8StiRh6LpN8TiOzMG4yj/7eQ8yVSPNz0z32Q1RYiqrzFO4GJB2pPdGesgvUUNNWKO2gPXnHFOHEvFACpKYWNPgX01eDzoKoovGDOmcZuruypNEpWYCMmjMnEi7v+gd37DZOR/wMFIRYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722785852; c=relaxed/simple;
	bh=eNrKQxqimFyak2njv7PbAxJ/wLALwG64KVcFLKvOEuM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W+kohqUVrlHYYb8pIdBUuYCNcsfWZHr1JyGYXRuy7Qvu8BjWBS01rwSEvfbo4fenueXCpA4MVPnIdhaa1ojaH+ETRfYuxU5e8odzO3+9IYOnsObniGehn3VzAjfTbV4Edvht/qMDJ7iqPaRFbo4q3nMAVASaCimCZZa8G3gwzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=oPlcqyiS; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=SFc2RLoO; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722785847;
	bh=eNrKQxqimFyak2njv7PbAxJ/wLALwG64KVcFLKvOEuM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=oPlcqyiSZRgPF42oRfCtWZ3c6rrZPmHggl7wNRcD1wA6L/iBOFSmXVJYL3vIOu3Qr
	 9mSdTqiDWeEt9qeYWULKMc0QCPNoOHpLMg7H5J1ycBoA/uLQWW8hiY2umkGwbJvzqv
	 miUqCnOt0GYekl6iucLiDuLNVeuftdbImddBHbcs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4684A1281F7B;
	Sun, 04 Aug 2024 11:37:27 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id hukPq2TAZwJv; Sun,  4 Aug 2024 11:37:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722785846;
	bh=eNrKQxqimFyak2njv7PbAxJ/wLALwG64KVcFLKvOEuM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=SFc2RLoOTjBmzrwyrQBzT4I7vcq9pORvKq2nhWI2RMYvlcdAg1KLJceBzoouAuPhy
	 p8lmYDMfwpaXbIURKmIjObvqmPhv+PEr+yBRpKI39D2/W3mRFUhZOBMqB/OvKRr1BZ
	 M99TZxEntF5y1jsK/ZJLY0MEMVbu++N2mhTpXNqc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7B9471281A34;
	Sun, 04 Aug 2024 11:37:26 -0400 (EDT)
Message-ID: <cb96399b5fdebf2f6fbaeba1a0b72a4f4b020c10.camel@HansenPartnership.com>
Subject: Re: [openssl-tpm2-engine] [PATCH v2 1/8] tss: Fix handling of
 TPM_RH_NULL in intel-tss
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: openssl-tpm2-engine@groups.io, jarkko@kernel.org, Jarkko Sakkinen
	 <jarkko.sakkinen@iki.fi>
Cc: linux-integrity@vger.kernel.org
Date: Sun, 04 Aug 2024 11:37:23 -0400
In-Reply-To: <940e5cbca2cf08f7275d5e09d552a8500e18742c.camel@HansenPartnership.com>
References: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
	 <20240802202606.12767-2-James.Bottomley@HansenPartnership.com>
	 <D36FX5RTUSEW.1LZMP91ZPPZZK@iki.fi>
	 <53a91b9ebbc500e928eadf2112d3ecb5631c56c1.camel@HansenPartnership.com>
	 <D36IYI5ZD4VK.2GC6CG6GIUWK9@kernel.org>
	 <237c1ed926d926bfddb92a959a27543479b5f0ae.camel@HansenPartnership.com>
	 <D36KI8TC0600.1OAIM33YQYMLX@kernel.org>
	 <940e5cbca2cf08f7275d5e09d552a8500e18742c.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2024-08-04 at 09:42 -0400, James Bottomley wrote:
> The design of the intel-tss shim is to hide the difference between
> the
> internal and the external handles by doing the internal to external
> transform on entry.  Unfortunately, the NULL handle (TPM_RH_NULL,
> 40000007) has two possible internal representations depending on
> whether it's used to indicate no session or the null hierarcy.
> 
> There is a bug in the intel-tss in that it uses the wrong internal
> NULL handle to try to create the NULL seed primary (and thus fails).
> Now that we're going to be using the NULL primary to salt sessions,
> the Intel TSS shim needs fixing to cope with thi correctly.
> 
> The fix is to do the correct transform to the internal hierarchy
> representation on NULL hierarchy creation and to do the session
> handle
> conversion everywhere else.  Additionally remove the intel_handle()
> code which was supposed to do this: it's unused because 0 is never
> passed in as a handle number.

Going over all the internal to external handle conversions, I found one
more use case that would produce a bug. This one isn't actually used in
the openssl_tpm2_engine code, so it's an unmanifested bug but
nevertheless it should be fixed to avoid problems later on.  I'll fold
the below fix into this patch.

Regards,

James

---

diff --git a/src/include/intel-tss.h b/src/include/intel-tss.h
index 3b8c18d..a2050ba 100644
--- a/src/include/intel-tss.h
+++ b/src/include/intel-tss.h
@@ -1271,6 +1271,19 @@ tpm2_handle_ext(TSS_CONTEXT *tssContext,
TPM_HANDLE esysh)
 {
 	TPM2_HANDLE realh = 0;
 
+	switch (esysh) {
+	case ESYS_TR_RH_OWNER:
+		return EXT_TPM_RH_OWNER;
+	case ESYS_TR_RH_PLATFORM:
+		return EXT_TPM_RH_PLATFORM;
+	case ESYS_TR_RH_ENDORSEMENT:
+		return EXT_TPM_RH_ENDORSEMENT;
+	case ESYS_TR_RH_NULL:
+		return EXT_TPM_RH_NULL;
+	case ESYS_TR_NONE:
+		return EXT_TPM_RH_NULL;
+	}
+
 	Esys_TR_GetTpmHandle(tssContext, esysh, &realh);
 
 	return realh;


