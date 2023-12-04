Return-Path: <linux-integrity+bounces-342-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ECB80366D
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 15:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7720B20B3D
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BC028DB1;
	Mon,  4 Dec 2023 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="pQTTRfjR";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="pQTTRfjR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A772736;
	Mon,  4 Dec 2023 06:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701699801;
	bh=oUwo8TIPQl+ytC7nNNkZlNOi2nFoKbz3HIyHoTH7Ads=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=pQTTRfjRIxS53DI1vQoapDPfO+VrutskDRRQ0gImcbKQKV89Cdm4iNnh5ZsdlnjXp
	 JO90MixhwlQlrWNXoPuEcLqupn38Wf2sV1Dmc5Q17Dd8UHHpLAyN0j/F1Q69qRCUwL
	 l/Kd745i7yUZ0n/BG9lawVGPTW8npv4nn2zz5LV0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B786C12862E2;
	Mon,  4 Dec 2023 09:23:21 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id jq4zWcUTdkrz; Mon,  4 Dec 2023 09:23:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701699801;
	bh=oUwo8TIPQl+ytC7nNNkZlNOi2nFoKbz3HIyHoTH7Ads=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=pQTTRfjRIxS53DI1vQoapDPfO+VrutskDRRQ0gImcbKQKV89Cdm4iNnh5ZsdlnjXp
	 JO90MixhwlQlrWNXoPuEcLqupn38Wf2sV1Dmc5Q17Dd8UHHpLAyN0j/F1Q69qRCUwL
	 l/Kd745i7yUZ0n/BG9lawVGPTW8npv4nn2zz5LV0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 03C811280B78;
	Mon,  4 Dec 2023 09:23:20 -0500 (EST)
Message-ID: <bd814edddfeac7072ed4f29365ce6bac3d235562.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 08/13] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 04 Dec 2023 09:23:17 -0500
In-Reply-To: <1ff17f0fde30e7152a630da11480a980d515f1d7.camel@linux.ibm.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
	 <20230403214003.32093-9-James.Bottomley@HansenPartnership.com>
	 <CX8FJA25TO6W.ET37QQIXFGQH@kernel.org>
	 <4e7fd5c07dede4ebe640dcc3b123adcb1e65f1f0.camel@HansenPartnership.com>
	 <CXF71WGDHXAW.28FXYY08L1DMR@suppilovahvero>
	 <987f9fc8e9e8df38e66e6d4a2fd1f8eb570899ff.camel@HansenPartnership.com>
	 <7d5a1ff219c40efccabcb0336361a16b53796998.camel@linux.ibm.com>
	 <41fe65c907cbe5683cabe9e3782132391c20f726.camel@HansenPartnership.com>
	 <113aa55fcdd8167e6cd87b88f0beeef743bc740e.camel@linux.ibm.com>
	 <95222bc8dfe97bc85bcf0c022920bdce659d10fd.camel@HansenPartnership.com>
	 <1ff17f0fde30e7152a630da11480a980d515f1d7.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2023-12-04 at 09:10 -0500, Mimi Zohar wrote:
> On Mon, 2023-12-04 at 09:02 -0500, James Bottomley wrote:
> > On Mon, 2023-12-04 at 08:59 -0500, Mimi Zohar wrote:
> > > On Mon, 2023-12-04 at 08:53 -0500, James Bottomley wrote:
> > > > On Mon, 2023-12-04 at 08:43 -0500, Mimi Zohar wrote:
> > [...]
> > > > > Is there a way of not degrading IMA performance without
> > > > > disabling
> > > > > HMAC encryption/decryption?
> > > > 
> > > > Well, perhaps we should measure it.  My operating assumption,
> > > > since extend is a simple hash, is that most of the latency of
> > > > extend is actually in the LPC (or i2c or whatever) bus round
> > > > trip.  To do HMAC, you have to have a session, which adds an
> > > > extra command and thus doubles the round trip.
> > > 
> > > Agreed getting some statistics would be beneficial.  Instead of
> > > creating a session for each IMA extend, would it be possible to
> > > estable a session once and re-use it?
> > 
> > Not really.  Sessions are fairly cheap to establish, so there's not
> > much work the TPM has to do, so context save/restore would still
> > have the same doubling of the bus round trip.  Keeping a session
> > permanently in the TPM would avoid the second round trip but be
> > visible to all the users and highly undesirable (would impact the
> > number of sessions they could create).
> 
> Ignoring the "highly undersirable" aspsect, is there a way of
> limiting visibility (and of course usage) of the "session permanently
> in the TPM" to just IMA?

In theory, yes, but we'd have to filter the session area of every
command plus inspect commands which take sessions as parameters. 
That's a lot of work which would have to be done by an infrastructure
that doesn't fully exist (we already snoop the sessions in tpm space
handling, so we can filter the session areas there; we'd have to add
filtering on commands which take sessions).  But nothing can really get
around the problem that commands can take three sessions and on most
TPMs that's also the maximum size of the session volatile area, so we'd
break any user space application that uses more than two sessions.

James


