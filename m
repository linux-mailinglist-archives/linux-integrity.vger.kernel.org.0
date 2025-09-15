Return-Path: <linux-integrity+bounces-7085-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE214B5843D
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 20:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B65C1A26213
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 18:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A43285CB3;
	Mon, 15 Sep 2025 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXfSdqnr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236A8287E;
	Mon, 15 Sep 2025 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959716; cv=none; b=uDMx5AZdGrvSysLACWrlAuTmj+2zHV+mOP4CFXcJH8VtB1/rb0+iBE4T0WpT/jOwZae6XqWv6PfX+VxM1OwKTGe/FfJiWT6zM6zbjD6jQfiiK1+llV47c55i6aQ2LaLIzODU1wyBZGbHmM5C9yTfJNyIcDtMYhAwN5oyp76FiEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959716; c=relaxed/simple;
	bh=/mE8vbwF1iMcu+eJkqFf6dVcAvM+kXI0//yR7+m2kOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvYLNJhCa5UyPZcRZ8RqAuXmtFIRQKXtTVaLRSKV45R4iF/CxcFiw5s1S7anmV62iMJzV+pVNfhQjngn35Wg5J8vE1z4gJFeMN3BXSfFOznCibafzwIV0wiI+AIhEypHJdlktuNLq499IznioOF5+TVfV2vzhrZawuIe/iaWVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXfSdqnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDC8C4CEF1;
	Mon, 15 Sep 2025 18:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757959715;
	bh=/mE8vbwF1iMcu+eJkqFf6dVcAvM+kXI0//yR7+m2kOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXfSdqnrwH696J6Vqaqr5tANKEMd2/bCq02iRSYDtpZ67dC1LoW7SyKDevDTIPwhb
	 jda+XX1PEhVRA+K7geUnI2hDZGIcjI0OCl13mttaGkevtAeSgh8opgrs6MOeweJ8rP
	 Qt4RcK3YC92ztL5NE3f9hrqdnWKZIt0nQx1DCyh6IYTFQAwYQpKFUhTN4ufaKQNqEy
	 1B1DaFb79FH1wfA68zcFzSflybBw0eRYktQfycJwqwOCBCTC5dpVFUnZSi1gTql31u
	 7YYhF9WWURk4f02Rbusayx9HO/PfdjEyuVnlO4cLxfOfUQfYHRu37Hgsv9tiVele3o
	 z9u0bfjLjClmw==
Date: Mon, 15 Sep 2025 21:08:31 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, tpm2@lists.linux.dev
Subject: Re: tpm2key.asn1 parent identification
Message-ID: <aMhWHy1LQVqpyW5E@kernel.org>
References: <aMboFXNNX7WZaOaS@kernel.org>
 <6e1f2713288b48a1cc0311d01e281a98d8e7f45d.camel@HansenPartnership.com>
 <aMgnm1OkDj9XnStc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMgnm1OkDj9XnStc@kernel.org>

On Mon, Sep 15, 2025 at 05:50:07PM +0300, Jarkko Sakkinen wrote:
> On Sun, Sep 14, 2025 at 11:24:24PM -0400, James Bottomley wrote:
> > On Sun, 2025-09-14 at 19:08 +0300, Jarkko Sakkinen wrote:
> > > Hi,
> > > 
> > > In practice, while implementing tpm2sh and its self-contained TPM
> > > emulator called "MockTPM", I've noticed that 'tpm2key.asn1.' has a
> > > major bottleneck, but luckily it is easy to squash.
> > > 
> > > Parent handle should never be persisted, as it defies the existential
> > > reason of having a file format in the first place.
> > 
> > Actually, if you read the spec:it describes how to handle non-
> > persistent parents by defining the exact form of the P256 parent you
> > derive from the permanent handle in section 3.1.8:
> > 
> > https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html
> > 
> > This is the way all the implementations (well except the kernel, but
> > that's fixable) do it.
> 
> Even if you fix it to persistent handle, the problem does not go
> magically go away. Read public attributes are ubiquitos and
> cryptographically correct way to do the binding.
> 
> > 
> > > To address this issue I just added couple of optional fields to
> > > TPMKey:
> > > 
> > >   parentName   [6] EXPLICIT OCTET STRING OPTIONAL,
> > >   parentPubkey [7] EXPLICIT OCTET STRING OPTIONAL
> > 
> > So that's a bit redundant, since if you know the key, you know its
> > name.
> 
> What I know is irrelevant here :-)
> 
> > 
> > > By persisting this information TPM2_GetCapability + TPM2_ReadPublic
> > > can be used to acquire an appropriate handle.
> > 
> > It can, how?  If the parent is a primary, you can't insert it from a
> > public key, you have to derive it and if it's non-primary, you need its
> > parent to do the insertion.
> 
> Transient handle is like file handle and persistent handle is like inode
> number. Neither unambigiuously (and this is dead obvious) does not 
> identify any possible key.
> 
> Further by binding key correctly, the requirement of being persistent
> key goes away, which is a limiting factor.
> 
> > 
> > > I'd highly recommend to add this quirk to anything that processes
> > > this ASN.1 format.
> > 
> > Well, patches to the standard are accepted:
> > 
> > https://groups.io/g/openssl-tpm2-engine/topics

Further there is two options:

1. Either remove TPM2 key ASN.1 support from kernel entirely.
2. Fix the 0day bug.

It is unacceptable to make strong binding to a random open source
project. I zero care what OpenSSL TPM2 engine does with the file
format.

> > 
> > But first verify you don't simply need to use the non-persistent
> > format.
> > 
> > Regards,
> > 
> > James
> > 
> > 
> > 
> 
> BR, Jarkko

BR, Jarkko

