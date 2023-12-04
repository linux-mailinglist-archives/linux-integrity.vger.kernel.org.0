Return-Path: <linux-integrity+bounces-334-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C7F8032ED
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 13:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 659A9B20A84
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 12:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C91B241FF;
	Mon,  4 Dec 2023 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MwXmJEq5";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MwXmJEq5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D659F114;
	Mon,  4 Dec 2023 04:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701693358;
	bh=mb9I/HGo60jh1P8Tj9QvTmqaNztezR0Fs+nFDjRR5Y8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=MwXmJEq5uEv2nx5nBqCc9LaWPTDPffoJ9kSLYbdWCg03NXEGe6ejpG3+zs+wZ4q6p
	 W0HDrWwB0OEP1l9p2odo4x7oYzD3T3wC5YQk3YYH29TeCW18XUnvCGc59etEu2Mcmv
	 Yqy+kdSnER4+N22YxFnMUt/7CAlhHA4dkV+ZZkAM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7037012865C1;
	Mon,  4 Dec 2023 07:35:58 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id PW69U1OwmqlD; Mon,  4 Dec 2023 07:35:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701693358;
	bh=mb9I/HGo60jh1P8Tj9QvTmqaNztezR0Fs+nFDjRR5Y8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=MwXmJEq5uEv2nx5nBqCc9LaWPTDPffoJ9kSLYbdWCg03NXEGe6ejpG3+zs+wZ4q6p
	 W0HDrWwB0OEP1l9p2odo4x7oYzD3T3wC5YQk3YYH29TeCW18XUnvCGc59etEu2Mcmv
	 Yqy+kdSnER4+N22YxFnMUt/7CAlhHA4dkV+ZZkAM=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9ECEA1286499;
	Mon,  4 Dec 2023 07:35:57 -0500 (EST)
Message-ID: <987f9fc8e9e8df38e66e6d4a2fd1f8eb570899ff.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 08/13] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Mimi Zohar
	 <zohar@linux.ibm.com>
Date: Mon, 04 Dec 2023 07:35:54 -0500
In-Reply-To: <CXF71WGDHXAW.28FXYY08L1DMR@suppilovahvero>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
	 <20230403214003.32093-9-James.Bottomley@HansenPartnership.com>
	 <CX8FJA25TO6W.ET37QQIXFGQH@kernel.org>
	 <4e7fd5c07dede4ebe640dcc3b123adcb1e65f1f0.camel@HansenPartnership.com>
	 <CXF71WGDHXAW.28FXYY08L1DMR@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2023-12-04 at 04:29 +0200, Jarkko Sakkinen wrote:
> On Sun Nov 26, 2023 at 5:05 PM EET, James Bottomley wrote:
> > On Sun, 2023-11-26 at 05:39 +0200, Jarkko Sakkinen wrote:
> > > One very obvious thing to fix there is the kconfig flag:
> > > 
> > > 1. Its meaning and purpose is not documented to the commit
> > > message. What is it and what is its meaning and purpose.
> > > 2. TPM_BUS_SECURITY does not follow the naming convention of
> > > other TPM kconfig flags, and to add, "security" is way way too
> > > abstract word. Something like TCG_TPM_HMAC
> > > 
> > >    It should be renamed as TCG_TPM_
> > 
> > One question is do we still need this?  Since my tree has moved
> > ahead, I also need the HMAC code for policy on keys and the primary
> > code for permanent parents.  The only real performance concern is
> > for PCR extension (no-one really cares about the speed of unseal or
> > random), so a different possible way of doing this is simply to
> > CONFIG that one operation.
> 
> I think so.
> 
> Major distributions have started to ship with TPM2 sealed hardware
> drive encryption, based on LVM/LUKS2 partitioning setup. It is
> convenient enough that at least I prefer it over encrypted
> passphrase.
> 
> Having this feature would add defence in depth to that. I could
> definitely see distributions adapting also to HMAC because now there
> is already too legit uses cases (ignoring the people who just enjoy
> configuring obscure things).
> 
> So motivation has rised by a factor now, i.e. it makes sense now more
> as a "product" and not just research topic, given the use in the
> workstation, in addition to the data center.

Sorry, miscommunication.  By "this" I meant the config option not the
entire HMAC code.  The proposal without it would be unconditionally
compile tpm2-sessions.c and do HMAC/encryption on random and
seal/unseal but gate the PCR HMAC via a compile or runtime option so as
not to degrade IMA performance if performance were preferable to
security.

James


