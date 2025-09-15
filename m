Return-Path: <linux-integrity+bounces-7082-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A8B57FA0
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 16:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C407B2307
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8668C33CEB1;
	Mon, 15 Sep 2025 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFU/u96O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD89338F4A;
	Mon, 15 Sep 2025 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947807; cv=none; b=rOuo5CUy39/89JMu656h1H5Hn4iZiDoyw2MuoJQPjwZzlikfL8rWXyzenqSG/ycUZlKQ5rog8Z1otuO2ohEZjr9ECyjqTCOjBxkSN5D9p/DuvoP2a2n6R9kTuqCLJXkd3VuPk0eMqPuqlgrvPWZ48Z2ghINDwkXF2wwUWaVOILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947807; c=relaxed/simple;
	bh=c9GFrC7DaPOd4zrDemUY+nLS3IzPHHt3WJOypqyVfMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sti++5qyujBfTgik9gE6Gck6CBVUn2ZW3jvLZOrdFfBesNL00JMzQb2hB5enqkVbb0q5nEbhIEXeHvwAhXrPnQVcM31SYWD8cxnOjKzR1lTBhwRuGlIFzGtAGb7M16+Nr75yFucuUqP5iPlaTM00Jg65BOiXn88g1EcYyMUX/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFU/u96O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8814AC4CEF1;
	Mon, 15 Sep 2025 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947806;
	bh=c9GFrC7DaPOd4zrDemUY+nLS3IzPHHt3WJOypqyVfMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFU/u96OfiQNU+zC4+WOpdrT/7zOpeRxpBSo7ReLRk0tVUbFs73Y+rBC5uyJMOJww
	 mp4NZqjSmMikJPdBt36Xu7WBcPnNDu0T79qN0Z4v7tyYqmzU3e4G9bAF1Dp5RQAlM9
	 HrK6bUJK8W9qELTpm0nFcfdryoJnS04v4UW8121jSjE0PZnNcd6y5KQjmr6r6HiIdX
	 xUSpc5NrHH4Nf7170MsSKBfoqKrGvH5PP13AT5wppGKvaZdZJllrjJgU7dJNVgc/G3
	 foawS8AnNNMULG9R6KTKU/SAxMDYH4VR87noWU1mIv9iCNTwToqPSVaKbtcLIYqLLJ
	 i6O8hJqfM0XqQ==
Date: Mon, 15 Sep 2025 17:50:03 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, tpm2@lists.linux.dev
Subject: Re: tpm2key.asn1 parent identification
Message-ID: <aMgnm1OkDj9XnStc@kernel.org>
References: <aMboFXNNX7WZaOaS@kernel.org>
 <6e1f2713288b48a1cc0311d01e281a98d8e7f45d.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e1f2713288b48a1cc0311d01e281a98d8e7f45d.camel@HansenPartnership.com>

On Sun, Sep 14, 2025 at 11:24:24PM -0400, James Bottomley wrote:
> On Sun, 2025-09-14 at 19:08 +0300, Jarkko Sakkinen wrote:
> > Hi,
> > 
> > In practice, while implementing tpm2sh and its self-contained TPM
> > emulator called "MockTPM", I've noticed that 'tpm2key.asn1.' has a
> > major bottleneck, but luckily it is easy to squash.
> > 
> > Parent handle should never be persisted, as it defies the existential
> > reason of having a file format in the first place.
> 
> Actually, if you read the spec:it describes how to handle non-
> persistent parents by defining the exact form of the P256 parent you
> derive from the permanent handle in section 3.1.8:
> 
> https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html
> 
> This is the way all the implementations (well except the kernel, but
> that's fixable) do it.

Even if you fix it to persistent handle, the problem does not go
magically go away. Read public attributes are ubiquitos and
cryptographically correct way to do the binding.

> 
> > To address this issue I just added couple of optional fields to
> > TPMKey:
> > 
> >   parentName   [6] EXPLICIT OCTET STRING OPTIONAL,
> >   parentPubkey [7] EXPLICIT OCTET STRING OPTIONAL
> 
> So that's a bit redundant, since if you know the key, you know its
> name.

What I know is irrelevant here :-)

> 
> > By persisting this information TPM2_GetCapability + TPM2_ReadPublic
> > can be used to acquire an appropriate handle.
> 
> It can, how?  If the parent is a primary, you can't insert it from a
> public key, you have to derive it and if it's non-primary, you need its
> parent to do the insertion.

Transient handle is like file handle and persistent handle is like inode
number. Neither unambigiuously (and this is dead obvious) does not 
identify any possible key.

Further by binding key correctly, the requirement of being persistent
key goes away, which is a limiting factor.

> 
> > I'd highly recommend to add this quirk to anything that processes
> > this ASN.1 format.
> 
> Well, patches to the standard are accepted:
> 
> https://groups.io/g/openssl-tpm2-engine/topics
> 
> But first verify you don't simply need to use the non-persistent
> format.
> 
> Regards,
> 
> James
> 
> 
> 

BR, Jarkko

