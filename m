Return-Path: <linux-integrity+bounces-2575-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2898CD4E5
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 15:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4304DB2293C
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 13:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6C514A4D9;
	Thu, 23 May 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="PlRblVbw";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="koDbLc6B"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778341E495;
	Thu, 23 May 2024 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471502; cv=none; b=iXzcrdiJ11z7aETz2JsL/KDjOsVaEYFj46yBzQjAz+hpfOk6zIm8Qz1TTu6wvxXEluvS+WZQgS2w/fVr97ngdD2xK6VzmYJz/KIFUK3+7i+ynLkZ8QTQGLDmaQV77P7kv3b9GYaxqVwzmwyEa872B5PJa6WQ/+mr76O4s0Bdc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471502; c=relaxed/simple;
	bh=yxeerQdioJk9V45wxxQErrDchwYU+2o4GL3bADlnbvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QGmuevmS5j8Tp5VHueq9LHS42jBbTKsItKEO76eMbv5ZcE220I0rg0AGXlSn6m3SI3t65sVHsIT1A6jXXd/EkPfJ260k211nxl6PCD7oN3cX9MycJxhGx0lvn3eAl5svKwlmxPxETbVKUa8HNW3ZxQhxu7kTe8alSKTKcvrPSWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=PlRblVbw; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=koDbLc6B; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716471497;
	bh=yxeerQdioJk9V45wxxQErrDchwYU+2o4GL3bADlnbvY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=PlRblVbwvzEcJ2HxYGVj3/x80J/ZhHjLfCQkomzbGgkzlUX6SAAp4aOEUvveSpvuK
	 9YzeeoYKDg4l+w3W2alRAzoxdeulCwBvTEZtnacooAbjn/XwBSD2BUASvF48gADibt
	 oI84yLePkWDKbenhtjUqmDfadt4456n2YLqcS4p0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 308AC12872E9;
	Thu, 23 May 2024 09:38:17 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 5gC9RbkyaTpL; Thu, 23 May 2024 09:38:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716471496;
	bh=yxeerQdioJk9V45wxxQErrDchwYU+2o4GL3bADlnbvY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=koDbLc6BQBs4n/SOxXAS9PnErUds63F3s/2AZ42YlfFP1eWxrDmO4kn1Gyr+v5MYJ
	 UlFBL6AMru9SxfaeBXokp077sHiOePvg5xOeaaiFWl0JolRrwEhiebHS0pivFwaxXq
	 +/gNtR/TOwY+lQCWKbGRkRu/lSOYK/vrbeLLc+74=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A5FEB1280300;
	Thu, 23 May 2024 09:38:15 -0400 (EDT)
Message-ID: <9c96f39ed2161dd7f0c3a7964cba2de3169fae3b.camel@HansenPartnership.com>
Subject: Re: [PATCH RESEND] KEYS: trusted: Use ASN.1 encoded OID
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Eric
 Biggers <ebiggers@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Andrew Morton
 <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, David
 Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "open
 list:CRYPTO API" <linux-crypto@vger.kernel.org>,  open list
 <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Date: Thu, 23 May 2024 09:38:13 -0400
In-Reply-To: <20240523131931.22350-1-jarkko@kernel.org>
References: <20240523131931.22350-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-05-23 at 16:19 +0300, Jarkko Sakkinen wrote:
> There's no reason to encode OID_TPMSealedData at run-time, as it
> never changes.
> 
> Replace it with the encoded version, which has exactly the same size:
> 
>         67 81 05 0A 01 05
> 
> Include OBJECT IDENTIFIER (0x06) tag and length as the epilogue so
> that the OID can be simply copied to the blob.

This is true, but if we're going to do this, we should expand the OID
registry functions (in lib/oid_registry.c) to do something like
encode_OID.  The registry already contains the hex above minus the two
prefixes (which are easy to add).

I also note:

> @ -51,8 +52,8 @@ static int tpm2_key_encode(struct
> trusted_key_payload *payload,
>         if (!scratch)
>                 return -ENOMEM;
>  
> -       work = asn1_encode_oid(work, end_work, tpm2key_oid,
> -                              asn1_oid_len(tpm2key_oid));
> +       work = memcpy(work, OID_TPMSealedData_ASN1,
> sizeof(OID_TPMSealedData_ASN1));
> +       work += sizeof(OID_TPMSealedData_ASN1);

You lost the actually fits check.  This is somewhat irrelevant for TPM
keys because the OID is first in the structure and thus will never
overflow, but it might matter for other uses.

James


