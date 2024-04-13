Return-Path: <linux-integrity+bounces-2097-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5798A3E8A
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 22:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D557C281DE2
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 20:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1BF3FB1B;
	Sat, 13 Apr 2024 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekrf7wRh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274703D552
	for <linux-integrity@vger.kernel.org>; Sat, 13 Apr 2024 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713041451; cv=none; b=HO7p/PHQ2jSh+1DvmSo5Dc3vqlr+Rc/BqjDY2dgGrtXoAMm09TxdJMFLjLiNNBWnFM3nrG4riPZtPwOtK9DGkVE68weWKBciUARVtGbnmWnawcNu8BMqMj5JCPw16YEjtcCoocJkIL+UCzbND4AnTrqt1fWzrJQaSqnglrFv5Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713041451; c=relaxed/simple;
	bh=TVkeCE+aPWJLye3Qmq7o+acv9JooA7b4+3KqWkawCDo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=k+WzpopJ420xB81kK4do8z1TK2f7mbo0cYwhGbi3/MFi76PmMJ+QV3CETyAghiyeZBo5MHDK3STW6M+pPjYD1AWKKvPZK6lxGWQhcokd2EXHHcvQ/LWpeXwWwhY1SYZbXcxUAGQab3WhVRsRYd4inV1ypsOK2UK8ofTN11GFMlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekrf7wRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B95C113CD;
	Sat, 13 Apr 2024 20:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713041450;
	bh=TVkeCE+aPWJLye3Qmq7o+acv9JooA7b4+3KqWkawCDo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Ekrf7wRhHEG2wYJi3F+fMX7MuyZmPIWf1ucw+cAj+GV4KtzHOcBotIxxrFlHZcaJg
	 KBWZBpWcSbC3LoM7akE6WlhEfh0WbfM4PwLHNy3I3C1f7NZ4zXJ13eH2xCJVPEqkzS
	 NyJ4ZxtqLshTVGam39DmRo+RrqYg+t7J936w+d0D5y6IcTr+SpNwj6Qui7E7L2sbUq
	 2GRxDF3QCMVSlmSW0+IBjv0ZGDQAyuOBSZLCIDhd2DILVAxNEUSXVEJ6MdxVWZbIzX
	 bMcR/FmHxDFRRNmGBzDMz517xsDkTNcPYK3JTb2/f4qPmAp3+kzZjXW3tgBTo4FOW6
	 XBMY4ZCBM/AyA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Apr 2024 23:50:47 +0300
Message-Id: <D0JAIGVZLE9Q.2D0LVWXOE13H0@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
 "Takashi Iwai" <tiwai@suse.de>
Subject: Re: TPM error 0x0901, possibly related to TPM2_PT_CONTEXT_GAP_MAX
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "William Brown" <wbrown@suse.de>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>
X-Mailer: aerc 0.17.0
References: <424B3F10-D91C-4F47-B33C-BB66FE4DB91A@suse.de>
 <D0BFJLQ0JKO4.20EW2ZA8GIS5Z@kernel.org>
 <D0BFMGM02V7A.1HEWQ05350K07@kernel.org>
 <6857f043301a100ee93b3ea120a2d1d60e83efdb.camel@HansenPartnership.com>
 <4A174330-E1BB-4160-BD90-EAE6150706B5@suse.de>
In-Reply-To: <4A174330-E1BB-4160-BD90-EAE6150706B5@suse.de>

On Fri Apr 5, 2024 at 3:24 AM EEST, William Brown wrote:
>
>
> > On 5 Apr 2024, at 01:49, James Bottomley <James.Bottomley@HansenPartner=
ship.com> wrote:
> >=20
> > The reality is that unless you context save a session, you don't need
> > degapping and pretty much every TSS based use of sessions doesn't need
> > to save them, so people who construct TPM based systems rarely run into
> > this.=20
>
> This is the odd part - I'm *not* context saving sessions here.
>
>      Running `target/debug/examples/hmac`
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: HrLoaded, value: 0 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: HrLoadedAvail, value: 3 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: HrActive, value: 1 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: HrActiveAvail, value: 63 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: ActiveSessionsMax, value: 64 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: ContextGapMax, value: 255 }] })
>
>      Running `target/debug/examples/hmac`
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: HrLoaded, value: 0 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: HrLoadedAvail, value: 3 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: HrActive, value: 1 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: HrActiveAvail, value: 63 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: ActiveSessionsMax, value: 64 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: ContextGapMax, value: 255 }] })
>
>      Running `target/debug/examples/hmac`
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: HrLoaded, value: 0 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: HrLoadedAvail, value: 3 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: HrActive, value: 1 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: HrActiveAvail, value: 63 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: ActiveSessionsMax, value: 64 }] })
> true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [Tagge=
dProperty { property: ContextGapMax, value: 255 }] })
>
>
> I could be completely wrong, but my reading of the specification is that =
HrActive/HrLoaded are the values of interest here, and we can see they rema=
in at 0/1 for each test as the sessions and loaded objects are removed at t=
he end of each test.=20
>
> And yet, I'm running into the error 0x0901. So something else is going on=
 that I'm not 100% sure about.

We should catch all TPM2_StartAuthSession commands written to /dev/tpm0.

In practice this means checking the 32-bit value in buf[6] of the second
parameter of tpm_transmit().

This could be e.g. checked with bpftrace by hooking kprobe into the
function and comparing that to 0x00000176. It is in big-endian order.

I can try to bake a script for this if you need help...

That way we can catch all session creations.

>
>
> --
> Sincerely,
>
> William Brown
>
> Senior Software Engineer,
> Identity and Access Management
> SUSE Labs, Australia


BR, Jarkko

