Return-Path: <linux-integrity+bounces-2048-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F0C8A21EB
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Apr 2024 00:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AE8B220A7
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Apr 2024 22:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229DF2CCD7;
	Thu, 11 Apr 2024 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emom8fSM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D612E6C
	for <linux-integrity@vger.kernel.org>; Thu, 11 Apr 2024 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875816; cv=none; b=oSWZm1V21FLdz4R3hNH22t34+cZdDrD9wruF0R1dX9eOsoguWtPRhUw8fqby+IjgFrqBwzytv2pdE2FXR9NI9snIzyJbYG73XHQaR2he38PsaLylSPpVgp8SzIdvPBCwlmqtkdcL6BDbXyp+r5hrVNN4kLkYhqEg4eOXd2AH78k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875816; c=relaxed/simple;
	bh=gbOja/iFdN2dia+crdM7ykW+OKsh+Q8fPIPBWdcUTns=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=nVcyZ0Jzf8lizosVbWj0EMaUAxm2X/cqVaCbFZt5xlSBOFBxyqyBbWVnm4Pj2CLjaY3Lfj3dki65kdj2zmbjKN5Yt92qBh76QKK/mJsG+1oUDSEqzM/n96vM9PlE4+dr8lcKLiSeLzjY4xEx0ZNaAdm0YbBLpUQ6+/ldOi+IJHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emom8fSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45318C072AA;
	Thu, 11 Apr 2024 22:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712875815;
	bh=gbOja/iFdN2dia+crdM7ykW+OKsh+Q8fPIPBWdcUTns=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Emom8fSMwMfDe3Y6kWp4gg+j0vpgTbJr+Mu3CA5mLIWF3fz6UQ5pq33Bc0TO29pEr
	 7jeYldorfx3h75gY/a9n0gkSyly/M27whBvlHTpQ5fjRUnW+imO7ahuXsSYiH6BBfO
	 CQUCTlXaMtwjlsroCRb/xaQzwBo8FcSyBYXKJyYanG9Fhctx9FfSh5Fwo4uQ2YB9mk
	 HHL4XKi+NVpS/qe4QXFO/V7u8LcddllZeuEFucELjKswPYgVop5KN2MM3JpZSDdEoG
	 2SDoUUA5iQAgPeEHJYqENZqIaeBMpGdl5sTQ1aHTY80X6TgLncx0jpHx9VVVmn/Gc9
	 6mkWLnr6gES6w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Apr 2024 01:50:12 +0300
Message-Id: <D0HNST37O7G8.3A722951U878Z@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "William
 Brown" <wbrown@suse.de>, <linux-integrity@vger.kernel.org>
Cc: <peterhuewe@gmx.de>, <jgg@ziepe.ca>, "Takashi Iwai" <tiwai@suse.de>
Subject: Re: TPM error 0x0901, possibly related to TPM2_PT_CONTEXT_GAP_MAX
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <424B3F10-D91C-4F47-B33C-BB66FE4DB91A@suse.de>
 <D0BFJLQ0JKO4.20EW2ZA8GIS5Z@kernel.org>
 <D0BFMGM02V7A.1HEWQ05350K07@kernel.org>
 <6857f043301a100ee93b3ea120a2d1d60e83efdb.camel@HansenPartnership.com>
In-Reply-To: <6857f043301a100ee93b3ea120a2d1d60e83efdb.camel@HansenPartnership.com>

On Thu Apr 4, 2024 at 6:49 PM EEST, James Bottomley wrote:
> On Thu, 2024-04-04 at 18:09 +0300, Jarkko Sakkinen wrote:
> > [...]
> > Emphasis that I might have forgotten something but this is what I can
> > remember right now.
>
> What you forgot is that I did originally proposed session degapping in
> the kernel resource manager but it was rather complex, so you made me
> take it out for lack of a use case.  It dates back to when we used the
> old sourceforge tpmdd list which seems to have caused message loss, so
> I'm not sure how complete this thread is:

I might be forgetting some detail to contxt gap but since kernel flushes
every single object per transaction contextCounter should be updated all
the time and thus there should not be too large gap that would cause
emitting this error.

I quickly reviewed section 30.5 for architecture specificaton to check
if I got it right and it says that: "On receiving this error, the
management software either would explicitly flush old session contexts
or would load the old session contexts to update their associated
counter values.."

You could cause the error even with kernel RM if e,g. a process with
access to /dev/tpm0 purposely populates the chip with objects that it
does not flush so it is then inevitable over time...

I still think that kernel RM should not do any pro-active handling to
this albeit I have to admit I did not remember what I said about the
topic back then :-)

>
> https://lore.kernel.org/lkml/1484772489.2396.2.camel@HansenPartnership.co=
m/
>
> If I compare it to the fragment on sourceforge, you can see a bit more
> of it (but sourceforge has lost the patch):
>
> https://sourceforge.net/p/tpmdd/mailman/tpmdd-devel/thread/201702090906.v=
1996c6a015552%40wind.enjellic.com/#msg35656470
>
> The reality is that unless you context save a session, you don't need
> degapping and pretty much every TSS based use of sessions doesn't need
> to save them, so people who construct TPM based systems rarely run into
> this.  The exception is the tpm2-tools CLI project, which encourages
> the context saving of sessions and thus can cause this.  We kept
> tripping across this in the Keylime, but the eventual solution was to
> dump the tpm2-tools dependency and do a direct TSS connection in the
> Keylime agent.

If someone is interested to deal with this error in tpm2-tools (or what
ever that stacks name is), e.g. Android TPM stack does address the
error.

I agree with you tho that properly implemented application wisely you
should never encounter the error...

> James

BR, Jarkko

