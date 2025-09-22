Return-Path: <linux-integrity+bounces-7229-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D37B92654
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 19:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F2516B27D
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 17:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC51D31355B;
	Mon, 22 Sep 2025 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b="dspsx8At";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DkOyr9XC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CAE305E33;
	Mon, 22 Sep 2025 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561739; cv=none; b=R6e8Fhqgz1JYQ1glEZhl56Av1EFlbWCd0xkkqEldMivUHtfqzJUsXNGJG4xbkyvh9QKzwKdsBCOOqLf83gvE4itVv+/nUOOSmtC8OAD/SpsPk4XZa3bai0cpjcUNjpc4EzVZ83/n9peB/V905aPOyHpq50Z0H8zGPo4/MYB0N+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561739; c=relaxed/simple;
	bh=VN0yMScQ8pb/61s20XjaSKiW9Mzun4YWkxHCUCwd0Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOR4YY7YppoVDp0EWEfk4fPx9BafX04JjTS3HZkkhB66bx/Z/OGMrX5WD1lkaHRYeh+1KNgVmbmvIv+bcP80iithPyW2tELdAd10p+qAmYfpNZgESuWHA1DaBH34x7lIqho2M9kJZvxDDzj2S82SlykWKGEr1vyB4X2c5XcfWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net; spf=pass smtp.mailfrom=benboeckel.net; dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b=dspsx8At; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DkOyr9XC; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benboeckel.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BD0261D00232;
	Mon, 22 Sep 2025 13:22:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 22 Sep 2025 13:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1758561735;
	 x=1758648135; bh=K8LjtBRRLWLzn/Sx28Fp4ytkbkynjN1owR8vzMqVA6E=; b=
	dspsx8AtAyFXyefXTGJ4sjqIyY4LfhNOU+EEYgr+OmVPdxz+xaEfcoeBds6hURwo
	tnCCMDWmhkyuOhKHKq2kPpJlknzTVJdBSHDrSwAFLnzeXlpthVyDRYKMknHSdltm
	olRsCg++XOH6ocGn8NSJCTQNGY9Z0t+S5Uj22iYCyJp+X/IfGL/i7UfZisuR+g7L
	YRmVI4BgjaIip6oQAitSU8SPjNVBBUWGxZlTIlHu5lu3x7PgbRSVoq2UI8HJviXc
	6SQHx0t79b6R0xZ6ZSUD05/VRhLFFLz4woqymB+hqmbHOTyStEIvCFOl7aDKdKNn
	vq0tfkSUtNYNrPxSkISEIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1758561735; x=1758648135; bh=K8LjtBRRLWLzn/Sx28Fp4ytkbkyn
	jN1owR8vzMqVA6E=; b=DkOyr9XCnn2hEyg4t2q2lgLtX0SZl21VY3bNu2KxCLrm
	KX8cu3HobsPNkvexCMBTSNFKfkOsvTlHjMrsz3xl/csH86RIsTpvbpV/t1kGAnep
	pwTlOJSBM4iu+m6a158InW/B6LK9SA3HBdsXEKWmb3evSiW4lrma0dpdx+1gOCDC
	Y92kwzEqGzLf40sWoNFKw7GUqwIPDE5sw/o4g8MQ3zBMciA46hLCbtXDC2lHmBG+
	R3yHdhCk6ZU8yo1I8dwS5kVcs+2A+aBGFa1bF4PJSNsN/FJ4pfZ5mATcPCr2BgRP
	Lo5OsnjEAB5n9mxccvpP8siONFEbvxC/ac42zRmz+A==
X-ME-Sender: <xms:xoXRaFnmkVF92qNKvTBHQ9iPteMpTnxZWfSbOnPBLPHolxlo1f-fcQ>
    <xme:xoXRaLMeVN9iMefaWNPy6xGx5-_7I26c1V2FBMItnCQBLyX9hFxFj3bu_cHXXhPuN
    caik4I1l9kZZn0IVlCi8LN3EBWt6MJrnOmKR2z5qQLnzuIKDyd3tXM>
X-ME-Received: <xmr:xoXRaByEMN6cxitMggZyHrEPzfsLPyM3a6hprqzo-_Eb0e77rfwmruepwv4mcuJdR4JZksQAF87DG_CsepiNpb9tNxpP52KTbzk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhrfhggtggujggfsehttdertddtreejnecuhfhrohhmpeeuvghnuceu
    ohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepudethefgfeduffefleffhfehjefgvdffhfelvdeukeduueeigeeujeeiffdvieeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvse
    gsvghnsghovggtkhgvlhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrghrkhhkoheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqihhnthgvghhrihhthiesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrghrkhhkohdrshgrkhhkihhnvghnsehophhinhhshihsrdgtohhmpd
    hrtghpthhtohepphgvthgvrhhhuhgvfigvsehgmhigrdguvgdprhgtphhtthhopehjghhg
    seiiihgvphgvrdgtrgdprhgtphhtthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthho
    pehjmhhorhhrihhssehnrghmvghirdhorhhgpdhrtghpthhtohepshgvrhhgvgeshhgrlh
    hlhihnrdgtohhm
X-ME-Proxy: <xmx:xoXRaAuMkF7IXrFJh6e5fN5VJar92zm3cO6qvt01pTPDIKLxgBSsjw>
    <xmx:xoXRaMaHrFk2VhMb8C44mXdZS8_mZSagw0H7JvZ4UUOtiM6x5i6jRQ>
    <xmx:xoXRaH0mpEJa9wZFbSxS5SWNe1ETCw4dMBjbmsBdt1Kcq_rFHSZLLw>
    <xmx:xoXRaGshmBzBkuIQBM42-f5I5ldP693bfcP0jqmTKHrW9-4Us9vHHg>
    <xmx:x4XRaHS1-MM6ljfBrMOKe1CL1eAKp4rsLESzUtcuIrwLmtrr_9ug_Hp2>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 13:22:14 -0400 (EDT)
Date: Mon, 22 Sep 2025 13:22:13 -0400
From: Ben Boeckel <me@benboeckel.net>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] tpm2-sessions: Remove unnecessary wrapper
Message-ID: <aNGFv-nGZF5chGIb@rotor>
Reply-To: list.lkml.keyrings@me.benboeckel.net
References: <20250922164318.3540792-1-jarkko@kernel.org>
 <20250922164318.3540792-4-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922164318.3540792-4-jarkko@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Mon, Sep 22, 2025 at 19:43:16 +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Open code tpm_buf_append_hmac_session_opt() because it adds unnecessary
> disperancy to the call sites (and reduces the amount of code).
  ^^^^^^^^^^

"discrepancy" as in "difference"? But that doesn't feel like the right
usage either. Perhaps "unnecessary abstraction"? Also, open coding it
reduces the amount of code, so some clarification to not read as
something else that "it" (`tpm_buf_append_hmac_session_opt`) does would
be clearer.

Thanks,

--Ben

