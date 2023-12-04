Return-Path: <linux-integrity+bounces-338-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D15C80358B
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 14:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4862A1F21025
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7825570;
	Mon,  4 Dec 2023 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="PFz0Z2+j";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="PFz0Z2+j"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFF390;
	Mon,  4 Dec 2023 05:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701698021;
	bh=FqjL2D3XMXJXXmk1AK7KpV8AG9NqnOBZzZcvFpY+xjM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=PFz0Z2+jwDOlKRi3ZI7tKKHnffiq9p/OVAkElr8/erYvvzczbXXivK4qIpOwQi//K
	 lqYkUxdtuPRwZ2HcGfLtMLqciZqHBd5ahejBZ4CGFlyNJ1WOqfhB3fNrWJqBwlz0Pm
	 EUcu48K6kWaMdENKwZVgcHgdoXRUKzRur3wLs9gE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B8D3E1281000;
	Mon,  4 Dec 2023 08:53:41 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Dt4zEI8L_liS; Mon,  4 Dec 2023 08:53:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701698021;
	bh=FqjL2D3XMXJXXmk1AK7KpV8AG9NqnOBZzZcvFpY+xjM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=PFz0Z2+jwDOlKRi3ZI7tKKHnffiq9p/OVAkElr8/erYvvzczbXXivK4qIpOwQi//K
	 lqYkUxdtuPRwZ2HcGfLtMLqciZqHBd5ahejBZ4CGFlyNJ1WOqfhB3fNrWJqBwlz0Pm
	 EUcu48K6kWaMdENKwZVgcHgdoXRUKzRur3wLs9gE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D74601280FB4;
	Mon,  4 Dec 2023 08:53:40 -0500 (EST)
Message-ID: <41fe65c907cbe5683cabe9e3782132391c20f726.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 08/13] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 04 Dec 2023 08:53:38 -0500
In-Reply-To: <7d5a1ff219c40efccabcb0336361a16b53796998.camel@linux.ibm.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
	 <20230403214003.32093-9-James.Bottomley@HansenPartnership.com>
	 <CX8FJA25TO6W.ET37QQIXFGQH@kernel.org>
	 <4e7fd5c07dede4ebe640dcc3b123adcb1e65f1f0.camel@HansenPartnership.com>
	 <CXF71WGDHXAW.28FXYY08L1DMR@suppilovahvero>
	 <987f9fc8e9e8df38e66e6d4a2fd1f8eb570899ff.camel@HansenPartnership.com>
	 <7d5a1ff219c40efccabcb0336361a16b53796998.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2023-12-04 at 08:43 -0500, Mimi Zohar wrote:
> On Mon, 2023-12-04 at 07:35 -0500, James Bottomley wrote:
> > On Mon, 2023-12-04 at 04:29 +0200, Jarkko Sakkinen wrote:
> > > On Sun Nov 26, 2023 at 5:05 PM EET, James Bottomley wrote:
> > > > On Sun, 2023-11-26 at 05:39 +0200, Jarkko Sakkinen wrote:
> > > > > One very obvious thing to fix there is the kconfig flag:
> > > > > 
> > > > > 1. Its meaning and purpose is not documented to the commit
> > > > > message. What is it and what is its meaning and purpose.
> > > > > 2. TPM_BUS_SECURITY does not follow the naming convention of
> > > > > other TPM kconfig flags, and to add, "security" is way way
> > > > > too abstract word. Something like TCG_TPM_HMAC
> > > > > 
> > > > >    It should be renamed as TCG_TPM_
> > > > 
> > > > One question is do we still need this?  Since my tree has moved
> > > > ahead, I also need the HMAC code for policy on keys and the
> > > > primary code for permanent parents.  The only real performance
> > > > concern is for PCR extension (no-one really cares about the
> > > > speed of unseal or random), so a different possible way of
> > > > doing this is simply to CONFIG that one operation.
> > > 
> > > I think so.
> > > 
> > > Major distributions have started to ship with TPM2 sealed
> > > hardware drive encryption, based on LVM/LUKS2 partitioning setup.
> > > It is convenient enough that at least I prefer it over encrypted
> > > passphrase.
> > > 
> > > Having this feature would add defence in depth to that. I could
> > > definitely see distributions adapting also to HMAC because now
> > > there is already too legit uses cases (ignoring the people who
> > > just enjoy configuring obscure things).
> > > 
> > > So motivation has rised by a factor now, i.e. it makes sense now
> > > more as a "product" and not just research topic, given the use in
> > > the workstation, in addition to the data center.
> > 
> > Sorry, miscommunication.  By "this" I meant the config option not
> > the entire HMAC code.  The proposal without it would be
> > unconditionally compile tpm2-sessions.c and do HMAC/encryption on
> > random and seal/unseal but gate the PCR HMAC via a compile or
> > runtime option so as not to degrade IMA performance if performance
> > were preferable to security.
> 
> Is there a way of not degrading IMA performance without disabling
> HMAC encryption/decryption?

Well, perhaps we should measure it.  My operating assumption, since
extend is a simple hash, is that most of the latency of extend is
actually in the LPC (or i2c or whatever) bus round trip.  To do HMAC,
you have to have a session, which adds an extra command and thus
doubles the round trip.

James


