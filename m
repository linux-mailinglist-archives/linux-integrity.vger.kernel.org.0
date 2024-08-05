Return-Path: <linux-integrity+bounces-3289-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901CD947371
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2024 04:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35E91C20BF6
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2024 02:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7852A1C6;
	Mon,  5 Aug 2024 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="CknIr2J+";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="CknIr2J+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38918A21
	for <linux-integrity@vger.kernel.org>; Mon,  5 Aug 2024 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826112; cv=none; b=WzCrlSRyACWNe9Xq/6QzvZf/dGSnwErxwHlzfFSnruHPQMjk8+FDvdzXc9ysi3ww+vfbNmDkHlqUG8a/xnE39kFyaKVV4pEMw6qDiPXU+wZrsq8kXOUlVlwTOGhYY8riyHwXbbLLum4HQBDUpY6WD1kz4UtwQsDEZUPaDZoRsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826112; c=relaxed/simple;
	bh=TI6HnGClycd7Wn0NEsi363o/i5UEWV869bIojV3ENuM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZsXUsZ8RLYrZXcb5AOgwPixkyvK1Guu5sa18RbiL9zJ6+4rlFUE8jWU6ytQ1JuZZgVwQE1NWzBcZkU6y8mC5vjkf0axOyQ1NrSAz2D1njGHhAEGETnbA9RAiKEFFKk/tur9pyIJeoUUxEX1Ui/sScJBB3ZitjltfANJHIPK9GMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=CknIr2J+; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=CknIr2J+; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722826108;
	bh=TI6HnGClycd7Wn0NEsi363o/i5UEWV869bIojV3ENuM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=CknIr2J+1Hzxswi2jk53o+5Vq+aPIHiTceN/o4AMkKXfgs+FsvDRRgzZ21Q2mNXWO
	 HYnMWWm3+wuPuz5wmZzfFSAUwJNV6cizL9bolNkpz54Nw0vX56NExOzcMzg2jZ1a8B
	 9VW5FAZ2akrDLYKGg0yUWrzzhxrdyHWICKOSUZeo=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D601312813BC;
	Sun, 04 Aug 2024 22:48:28 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id tecFJ_tPKuoR; Sun,  4 Aug 2024 22:48:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722826108;
	bh=TI6HnGClycd7Wn0NEsi363o/i5UEWV869bIojV3ENuM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=CknIr2J+1Hzxswi2jk53o+5Vq+aPIHiTceN/o4AMkKXfgs+FsvDRRgzZ21Q2mNXWO
	 HYnMWWm3+wuPuz5wmZzfFSAUwJNV6cizL9bolNkpz54Nw0vX56NExOzcMzg2jZ1a8B
	 9VW5FAZ2akrDLYKGg0yUWrzzhxrdyHWICKOSUZeo=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3B241128120F;
	Sun, 04 Aug 2024 22:48:28 -0400 (EDT)
Message-ID: <d0d83a418720467551faa718fd150c379a933652.camel@HansenPartnership.com>
Subject: Re: [openssl-tpm2-engine] [PATCH v2 1/8] tss: Fix handling of
 TPM_RH_NULL in intel-tss
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: openssl-tpm2-engine@groups.io, jarkko@kernel.org, Jarkko Sakkinen
	 <jarkko.sakkinen@iki.fi>
Cc: linux-integrity@vger.kernel.org
Date: Sun, 04 Aug 2024 22:48:26 -0400
In-Reply-To: <D37G310H9GA0.34YJCKUIISRVS@kernel.org>
References: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
	 <20240802202606.12767-2-James.Bottomley@HansenPartnership.com>
	 <D36FX5RTUSEW.1LZMP91ZPPZZK@iki.fi>
	 <53a91b9ebbc500e928eadf2112d3ecb5631c56c1.camel@HansenPartnership.com>
	 <D36IYI5ZD4VK.2GC6CG6GIUWK9@kernel.org>
	 <237c1ed926d926bfddb92a959a27543479b5f0ae.camel@HansenPartnership.com>
	 <D36KI8TC0600.1OAIM33YQYMLX@kernel.org>
	 <940e5cbca2cf08f7275d5e09d552a8500e18742c.camel@HansenPartnership.com>
	 <D37G310H9GA0.34YJCKUIISRVS@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-08-05 at 00:28 +0300, Jarkko Sakkinen wrote:
[...]
> > --- a/src/include/intel-tss.h
> > +++ b/src/include/intel-tss.h
> > @@ -251,14 +251,6 @@ intel_sess_helper(TSS_CONTEXT *tssContext,
> > TPM_HANDLE auth, TPMA_SESSION flags)
> >                                   TPMA_SESSION_CONTINUESESSION |
> > flags);
> >  }
> >  
> > -static inline TPM_HANDLE
> > -intel_handle(TPM_HANDLE h)
> > -{
> > -       if (h == 0)
> > -               return ESYS_TR_NONE;
> > -       return h;
> > -}
> > -
> >  static inline void
> >  TSS_Delete(TSS_CONTEXT *tssContext)
> >  {
> > @@ -937,8 +929,10 @@ tpm2_CreatePrimary(TSS_CONTEXT *tssContext,
> > TPM_HANDLE primaryHandle,
> >         TPM2B_PUBLIC *opub;
> >         TPM_RC rc;
> >  
> > -       /* FIXME will generate wrong value for NULL hierarchy */
> > -       primaryHandle = intel_handle(primaryHandle);
> > +
> > +       /* TPM_RH_NULL is mapped to ESYS_TR_NONE, which won't work
> > here */
> > +       if (primaryHandle == TPM_RH_NULL)
> > +               primaryHandle = INT_TPM_RH_NULL;
> >  
> >         outsideInfo.size = 0;
> >         creationPcr.count = 0;
> > @@ -993,9 +987,7 @@ tpm2_StartAuthSession(TSS_CONTEXT *tssContext,
> > TPM_HANDLE tpmKey,
> >                       TPM_HANDLE *sessionHandle,
> >                       const char *bindPassword)
> >  {
> > -       bind = intel_handle(bind);
> > -       tpmKey = intel_handle(tpmKey);
> > -       if (bind != ESYS_TR_NONE)
> > +       if (bind != TPM_RH_NULL)
> >                 intel_auth_helper(tssContext, bind, bindPassword);
> 
> Not blaming the patch but just have hard time coping this.
> 
> The most basic question is probably this: what is the application for
> INT_TPM_RH_NULL?

Ah, well, it turns out that the Intel TSS also isn't very performant
and part of the performance loss is using a memory database for
translating external TPM objects into internal ones.  Some of the
performance can be recovered by not doing this.

It turns out that the engine code never uses volatile external handles,
so the switch from volatile internal -> external and vice versa (which
occurs on load followed by key operation) was eliminated and the code
uses internal representation for volatile handles and external
representation for all other handles.  This scheme worked fine until
non-volatile key indexes were introduced and then it broke down a bit.
It would be logically very nice to redo the internal representation to
be entirely contained within the intel tss shim, but then that would
reintroduce the performance problem (although on the other hand, the
Intel TSS is still twice as slow as the IBM TSS so perhaps this
wouldn't be such a huge addition).

Regards,

James


