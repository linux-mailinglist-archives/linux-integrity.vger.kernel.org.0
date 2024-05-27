Return-Path: <linux-integrity+bounces-2650-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 423378CF837
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 05:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657B61C20EAB
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 03:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E51D50F;
	Mon, 27 May 2024 03:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b="qM+6sjrJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j93MeP8b"
X-Original-To: linux-integrity@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A71D2E6;
	Mon, 27 May 2024 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716781797; cv=none; b=FddPD39BlFsbrkJqKipaK1hIn2VQ8Pf5xhP71tEB7k0QkrOEgoWnD9qtpW3jo9+dyAbgm1ewi9YNEI8HZclpGJIdBKWv7bopB6S8QAZP45azegBahm8vi9LCCmV1peczY8JPZjZT70Hak/yqazfZj6c10Sx/mb0v72DgshC8ID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716781797; c=relaxed/simple;
	bh=J6AO67bEK+nzBT7Hze3F9tliQGeUpAZp6FtdsUq6rwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVBpSiSUOCBiBJEKJPX0YCNom9VIdz5JsFWnxaHQbN6qFYhB9Txf3RLEFvPcVzJHXDz4CAfzvs3acUfwQTk1toDmO/sp9AULV6ck8FKa6Fo1M1tjIwEaBaBZ5FdtP7cT0Ri+mt3xgCEvcHxW/iDNnN3E72YbLTwFiDaANFc6fNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net; spf=pass smtp.mailfrom=benboeckel.net; dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b=qM+6sjrJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j93MeP8b; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benboeckel.net
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9C5C911400D6;
	Sun, 26 May 2024 23:49:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 26 May 2024 23:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1716781794; x=
	1716868194; bh=nV3HSCAECVY02yDkc70k6BjqqboLqO/myAkpKc/GBMw=; b=q
	M+6sjrJQocFKoM8hKdejRVqZe8Sqya7XWVXYM4yX8RVsgg769Qe2CZcx/ivDTfhv
	QLxY/CoGcOc5OpFrXNNweQvTHMNKoNfI9B6ef5HFcFZD2dcxp6EgsKeLzNxDYxku
	HXkl3FbXAVSjaMkDNfzFPJZMOKw1WYaFXGGTdj9yziy1zRV7gpJCSNt7XLmeCAuP
	8PeNy6MtBJi11o/jd3Q152hFMN6RViTyZsyILZDwIy10F7Z4dGG4llt9No/Tdx3P
	H5i5txerMzuoA8YKyKzrOlza9YGlcxftI7txMW9/hpGElsYzpaWuKDiUhRZR0xol
	6RTAx8ZD7K+IMt5hcbH8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716781794; x=1716868194; bh=nV3HSCAECVY02yDkc70k6BjqqboL
	qO/myAkpKc/GBMw=; b=j93MeP8bx1fmEjPhfBroYB+V/HaQUdhEsk5eDthyOqsM
	17NWDeyL2E2OFkcERbfGZSCb99vUn7uFBSEZJPrivm5P2K1HZZjAy/dra8b6WO3F
	LauPklcPxKFe1Ra8P4KSUzjjg3Fs/cmH09UiI11lxLlYIpXVKU9jxq5vQ4JXZXX5
	8L/03Opjy1G1+1ObooUWp2pKQPM4tyMmwK/6H9zfhNJjBXdZXAYosRktPzbMHoyA
	vL4dIt6aVahEyq1EqNktnOGAziux7G8UAY/NZg0u3z+x/Jk9vxZZ6zZs+jvD1aIP
	MfRgGWUlfnofZzktykymCchCRkcW+dwTC5aHrJP+/Q==
X-ME-Sender: <xms:4gJUZoeWEBeRAqNZcHqdbJq4DuxZ9TfRkRB6l_i9IFibcGplj_XxJA>
    <xme:4gJUZqN9t9cc9QrFK3-j59RpYP_g0T8TaWvbfwK1hncjODhCh6CRx67D6_awPL04G
    H6nmhXy5brmiYlmfpI>
X-ME-Received: <xmr:4gJUZphIpdfmKF-q6UElmCMHGI1ZqyzqKxfHmHxOYPWFcKDYGsL_07YajdKEPMiGpKnMgDC3TaUn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujggfsehttdertddtreejnecuhfhrohhmpeeuvghn
    uceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrfgrth
    htvghrnhepffelgeffveelkeffkeehiefgtdeluedvtdfghfdtvdefgfejheffudeuveek
    vddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    gvsegsvghnsghovggtkhgvlhdrnhgvth
X-ME-Proxy: <xmx:4gJUZt_km1HcPnF0X0nYgzShlefHrqqxJX4-ofhvW91oh4Y8NOYViA>
    <xmx:4gJUZkuR2GrTyTgdkBGT5sx8Oq3lOJrZrNt2VeljB6hYFA_7SOjmeA>
    <xmx:4gJUZkHbyYxn_y3cPQxMVGAgiDa9GhOEQxO1OK_Rk2kP7vFIdXgusQ>
    <xmx:4gJUZjNSeD1PthK3l9A4hRsTt983oTsBKtV5xiiMbQw_efOX0O5shw>
    <xmx:4gJUZuVvKxupe6lUYTLfMXgSHZUAHeJLQrfJs1D6Fb6gd_pHQavQCF7l>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 May 2024 23:49:54 -0400 (EDT)
Date: Sun, 26 May 2024 23:49:53 -0400
From: Ben Boeckel <me@benboeckel.net>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] lib/oid_registry: add ability to ASN.1 encode OIDs
Message-ID: <ZlQC4XJbymy5hvVP@farprobe>
References: <20240524125955.20739-1-James.Bottomley@HansenPartnership.com>
 <20240524125955.20739-2-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240524125955.20739-2-James.Bottomley@HansenPartnership.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Fri, May 24, 2024 at 08:59:53 -0400, James Bottomley wrote:
> Consumers of the ASN.1 encoder occasionally need to insert OIDs into
> the ASN.1 stream.  The existing interface in lib/asn1_encoder.c is
> clunky in that it directly encodes the u32 array form of the OID.
> Instead introduce a function, encode_OID() which takes the OID enum
> and returns the ASN.1 encoding.  This is easy because the OID registry
> table already has the binary encoded form for comparison.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  include/linux/oid_registry.h |  1 +
>  lib/oid_registry.c           | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
> index 51421fdbb0ba..87a6bcb2f5c0 100644
> --- a/include/linux/oid_registry.h
> +++ b/include/linux/oid_registry.h
> @@ -151,5 +151,6 @@ extern enum OID look_up_OID(const void *data, size_t datasize);
>  extern int parse_OID(const void *data, size_t datasize, enum OID *oid);
>  extern int sprint_oid(const void *, size_t, char *, size_t);
>  extern int sprint_OID(enum OID, char *, size_t);
> +extern ssize_t encode_OID(enum OID, u8 *, size_t);
>  
>  #endif /* _LINUX_OID_REGISTRY_H */
> diff --git a/lib/oid_registry.c b/lib/oid_registry.c
> index fe6705cfd780..adbc287875c1 100644
> --- a/lib/oid_registry.c
> +++ b/lib/oid_registry.c
> @@ -12,6 +12,7 @@
>  #include <linux/errno.h>
>  #include <linux/bug.h>
>  #include <linux/asn1.h>
> +#include <linux/asn1_ber_bytecode.h>
>  #include "oid_registry_data.c"
>  
>  MODULE_DESCRIPTION("OID Registry");
> @@ -196,3 +197,31 @@ int sprint_OID(enum OID oid, char *buffer, size_t bufsize)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(sprint_OID);
> +
> +/**
> + * encode_OID - embed an ASN.1 encoded OID in the provide buffer

"provided"

--Ben

> + * @oid: The OID to encode
> + * @buffer: The buffer to encode to
> + * @bufsize: the maximum size of the buffer
> + *
> + * Returns: negative error or encoded size in the buffer.
> + */
> +ssize_t encode_OID(enum OID oid, u8 *buffer, size_t bufsize)
> +{
> +	int oid_size;
> +
> +	BUG_ON(oid >= OID__NR);
> +
> +	oid_size = oid_index[oid + 1] - oid_index[oid];
> +
> +	if (bufsize < oid_size + 2)
> +		return -EINVAL;
> +
> +	buffer[0] = _tag(UNIV, PRIM, OID);
> +	buffer[1] = oid_size;
> +
> +	memcpy(&buffer[2], &oid_data[oid_index[oid]], oid_size);
> +
> +	return oid_size + 2;
> +}
> +EXPORT_SYMBOL_GPL(encode_OID);
> -- 
> 2.35.3
> 
> 

