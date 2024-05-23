Return-Path: <linux-integrity+bounces-2577-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6328CD4F2
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 15:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917B71C223CC
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7391E13C80E;
	Thu, 23 May 2024 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b="MRTMLC6Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CH7HJe7u"
X-Original-To: linux-integrity@vger.kernel.org
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A0013B7B3;
	Thu, 23 May 2024 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471670; cv=none; b=hSWNeBDAlsbOmWQT7xdCgqCWObRuI+PaqL3aL6BeKDfnsDJedxN/9hnWndeyFkcrhfIv4Iw63zrbRT10gXLBwEpGB8R+oDxFfm72dKLG9MOhglfprNZ1bfpr1K2krw48qxkPA3K2DtEC91OoZ9cvgwZDVoNZ1ZcmKc81TBfoIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471670; c=relaxed/simple;
	bh=+5mIF7Xs1S52MlyNiTrZXhoj1RZF0L6UZJv60N3/q4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J11l5hNGA5cretvdFOsWeO66BNxxcFWSakqPMbfHQNYrO97CldokrIVvmhzZnie4J1ttumbiLJ3DUfX7Pgr3g/NQzYZgyA7B05oaetmIbtg+8Zi+195+m1V3oaxuSNU7pAMKd/PuGgGMcRmk8tcZKjq3+DLLpnJNc5slzy1jOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net; spf=pass smtp.mailfrom=benboeckel.net; dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b=MRTMLC6Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CH7HJe7u; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benboeckel.net
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id BC10E1800167;
	Thu, 23 May 2024 09:41:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 23 May 2024 09:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1716471665; x=
	1716558065; bh=mRnx5COVI0LWUi/LFa3Yn+dBzWKQMQVX8mCS5YjrH3Y=; b=M
	RTMLC6QwvUKwunisoJo+GmL7cqhgOOOX9TbQJUbw23vOaSQR4NjbvcN6mhdJYb7e
	aV6BU9SdvJIC8nXPLzHi4g/dJ4RGfqituK8yQaBZw/qbPLGPDbGxPuOA9KtOJvuP
	lq3Fk65V5t52FHhRUTw8n6eknT3Etra10p34ohOolKapDKotmcvKjACufp6LzdB7
	sKdS3kVPHvLcNFMt8LtaLX3dWoPXVBRwNDk4zPpCa0A84uz2LjTwON6PfE+6NldH
	2sGem4VLAPfAlN+AZvvdG0dIT2qmiOyXPPk2eAqUN9nWGr1hLKhN11iqcJ04uPBz
	e0BpmQP2aZ1wUTGB8OUqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716471665; x=1716558065; bh=mRnx5COVI0LWUi/LFa3Yn+dBzWKQ
	MQVX8mCS5YjrH3Y=; b=CH7HJe7uCQ27n7ovFF8rTNAADbDEJ0Y0m7OpDPikdres
	8qIW8ChFuw//gZuLKdmYF/lSwyocDHeB2sW7z3cD0T7yRp96YOWuDPtJpUARsmOb
	6iWvlEo4oy9FCIeKOXyhFbPV7y84tAx4jsqQ3pCSJoleQdCVwUp/uPEs74R5BdUT
	JNhCOP+bMBQNc9mtJECwoAyBMV5jjnO0qQ+t7KR9xJhhOa4Lr3/Zhi8TiJH4Bjfo
	lK46u8Ve0SnfGk5p+bf0CrnEiz9OmefZVChL/F6rP6G81Oh8789SYpD6HyX1y1Bo
	Km7AeJxC11Im8eD7TBI/2nFpIwj10vgVqi654ia4WA==
X-ME-Sender: <xms:cEdPZr0G2-vDAUhwlqttJTVdmRS8tukTPsyBKsdKjenxdu6MGKD0Kw>
    <xme:cEdPZqHIgZjl_M6SyvLVy_uAvYsvpGB3Hxogiqh-5tqDhD5EctmetVpQcPKcdwcDf
    k9SCveMb6Jc7e3DulI>
X-ME-Received: <xmr:cEdPZr5qTxNwYgBlgRiX4lAOkUYPNOsSeg5fClMUmPlQxCh-krrgDEtIR5TJqHQuEladWHoH-us_vdYfVGWrAkCtSPLZytMER6Y8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujggfsehttdertddtreejnecuhfhrohhmpeeuvghn
    uceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrfgrth
    htvghrnhepffelgeffveelkeffkeehiefgtdeluedvtdfghfdtvdefgfejheffudeuveek
    vddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    gvsegsvghnsghovggtkhgvlhdrnhgvth
X-ME-Proxy: <xmx:cEdPZg2TwgL5V_AKigCEAN7o-HzIck0gpUuDZ3lT5bJkCkoG9-VG8g>
    <xmx:cEdPZuEONg9wHiWDOrOqB-1XsbgiBNMZE9cKOihScKqSZgIQDpe0oA>
    <xmx:cEdPZh8YtWEwIGQ8QRbqCfY4-0vBTm8APrLBCNVWb1drWKXFDF5Tfg>
    <xmx:cEdPZrmw-N6TzMAlqgsOifD8q9KR-1XAM-q1NNGWHoXO0Z99NMI-nA>
    <xmx:cUdPZrL-019cYYIiO92VFNikyawDUB19bWDiRz4-wFtCIKgvg0p-86-E>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 May 2024 09:41:03 -0400 (EDT)
Date: Thu, 23 May 2024 09:41:03 -0400
From: Ben Boeckel <me@benboeckel.net>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Use ASN.1 encoded OID
Message-ID: <Zk9Hb-whVYvJrfLY@farprobe>
References: <20240523132341.32092-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523132341.32092-1-jarkko@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Thu, May 23, 2024 at 16:23:37 +0300, Jarkko Sakkinen wrote:
> There's no reason to encode OID_TPMSealedData at run-time, as it never
> changes.
> 
> Replace it with the encoded version, which has exactly the same size:
> 
> 	67 81 05 0A 01 05

Is it the same size? It looks considerably smaller to me (6*4 bytes
versus 8 bytes).

> Include OBJECT IDENTIFIER (0x06) tag and length as the epilogue so that
> the OID can be simply copied to the blob.

An "epilogue" occurs at the end, but it seems to be at the beginning
here (that would be a "prologue").

> -static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
> +/* Encoded OID_TPMSealedData. */
> +static u8 OID_TPMSealedData_ASN1[] = {0x06, 0x06, 0x67, 0x81, 0x05, 0x0a, 0x01, 0x05};

I'd say that a comment of what it encodes would be good to have for
context, but the source tree has `OID_TPMSealedData` in a header with
the value in a comment there, so that seems good enough to me.

> as it never changes.

Should it, perhaps be `const` too?

--Ben

