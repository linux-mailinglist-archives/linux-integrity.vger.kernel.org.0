Return-Path: <linux-integrity+bounces-2009-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C183A898AB4
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Apr 2024 17:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8F3289D6F
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Apr 2024 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2583D1D543;
	Thu,  4 Apr 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkvdcs/d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A381D537
	for <linux-integrity@vger.kernel.org>; Thu,  4 Apr 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243390; cv=none; b=bFnYdfZDfLDzaP0nbFhqlR6EwGM11LM7c6AHzWFm1yMcJ4pg5jNBBEzrUSS/xzkRGozKkmt5iWBQUXzpzoLbnGQ1dv1zc4CCqhoyawAgPfsS816Qyirgq47cZDQ1LxKqJNjf5wefKgr1+ERYEwnjeGaH6oOrJkijT+c2rrg71U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243390; c=relaxed/simple;
	bh=2AYrdOvpJ/Gw2RCctWDqn1jHJVqLwzck0oO6pz4p7Dw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=EB73RQhAGTrjxCHMYUcbYV7g3moYxSGdemCTWqN2m1ow/xnO2E6QX5MbTmpGtgo+nNl7ZoSAZelIn6RYpyY73XFKUt/TYGNuyGr96SibwVxLkJjfVgzP2ChTFnus48F1/pAS/TXqLe/3hxExMrODAF6nW2dqgSPMMThEOYJ0DZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkvdcs/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC73C433F1;
	Thu,  4 Apr 2024 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712243389;
	bh=2AYrdOvpJ/Gw2RCctWDqn1jHJVqLwzck0oO6pz4p7Dw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=pkvdcs/dOGbBgc/xcSttbN08paplEZbU41hEJxzZGjLYKuytYAwDO3++OuMVv3BWl
	 LFMteMOU0Rnw9XwAm5UZslTOGCJe9R4D0Eo1aBwlgcPoRzjrv7UagbokHzcrD3aHR7
	 QCbKNZjoFHFM7+Lemn55ds5SG9V0/NEw0qfN1fk+L9qmRJVAJDYxd17z6PxVhyzYfE
	 jFqJP9Ifxtqb2BNCVoB3k1a1+cJl0U2sSYrn5r08C2yAT1aFxnV1UvTgHmalJX2HMG
	 dmuZALTVOgWRTrmrYcpaC3+4u+vPnbDglR7iGLM4AGVVE0Yg2YLG6owvM4k/Iwt3BW
	 ITCOU0Za9bTIw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Apr 2024 18:09:46 +0300
Message-Id: <D0BFMGM02V7A.1HEWQ05350K07@kernel.org>
Subject: Re: TPM error 0x0901, possibly related to TPM2_PT_CONTEXT_GAP_MAX
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "William Brown" <wbrown@suse.de>,
 <linux-integrity@vger.kernel.org>
Cc: <peterhuewe@gmx.de>, <jgg@ziepe.ca>, "Takashi Iwai" <tiwai@suse.de>
X-Mailer: aerc 0.17.0
References: <424B3F10-D91C-4F47-B33C-BB66FE4DB91A@suse.de>
 <D0BFJLQ0JKO4.20EW2ZA8GIS5Z@kernel.org>
In-Reply-To: <D0BFJLQ0JKO4.20EW2ZA8GIS5Z@kernel.org>

On Thu Apr 4, 2024 at 6:06 PM EEST, Jarkko Sakkinen wrote:
> On Thu Apr 4, 2024 at 5:19 AM EEST, William Brown wrote:
> > Hi all,
> >
> > I've been recently working on enabling TPM support within a number of P=
AM modules. I'm certainly not a TPM expert, but I have noticed some issues =
when testing.
> >
> > We have a number of tests/examples in the rust-tss-esapi project, such =
as an example that shows how to hmac a value:
> >
> > ```
> > # TCTI=3Ddevice:/dev/tpmrm0 cargo run --example hmac --features generat=
e-bindings
> >     Finished dev [unoptimized + debuginfo] target(s) in 0.07s
> >      Running `target/debug/examples/hmac`
> > true: TpmProperties(TaggedTpmPropertyList { tagged_tpm_properties: [] }=
)
> > hmac1 =3D Digest(Zeroizing([54, 176, 122, 39, 222, 112, 105, 131, 3, 15=
8, 89, 12, 38, 14, 184, 176, 97, 38, 60, 37, 9, 49, 176, 80, 191, 161, 64, =
233, 163, 47, 254, 1]))
> > hmac2 =3D Digest(Zeroizing([54, 176, 122, 39, 222, 112, 105, 131, 3, 15=
8, 89, 12, 38, 14, 184, 176, 97, 38, 60, 37, 9, 49, 176, 80, 191, 161, 64, =
233, 163, 47, 254, 1]))
> > ```
> >
> > When this test program is run repeatedly, it begins to fail with:
> >
> > ERROR:tcti:src/tss2-tcti/tcti-device.c:197:tcti_device_receive() Failed=
 to get response size fd 3, got errno 14: Bad address
> > ERROR:esys:src/tss2-esys/api/Esys_FlushContext.c:238:Esys_FlushContext_=
Finish() Received a non-TPM Error
> > ERROR:esys:src/tss2-esys/api/Esys_FlushContext.c:89:Esys_FlushContext()=
 Esys Finish ErrorCode (0x000a000a)
> > thread 'main' panicked at tss-esapi/examples/hmac.rs:170:48:
> > called `Result::unwrap()` on an `Err` value: TssError(Tcti(TctiReturnCo=
de { base_error: IoError }))
> > stack backtrace:
> >
> > This is associated with dmesg erros such as:
> >
> > [83754.340909] tpm tpm0: tpm2_save_context: failed with a TPM error 0x0=
901
> > [83754.343680] tpm tpm0: A TPM error (459) occurred flushing context
> > [83754.345650] tpm tpm0: tpm2_commit_space: error -14
>
> 0x0901 is TPM_RC_CONTEXT_GAP, which means according to TCG spec that:
>
> "This response code can be returned for commands that manage session
> contexts. It indicates that the gap between the lowest numbered active se=
ssion
> and the highest numbered session is at the limits of the session tracking=
 logic.
> The remedy is to load the session context with the lowest number so that =
its
> tracking number can be updated."
>
> Since the code is accessing /dev/tpm0 and not /dev/tpmrm0 this issue
> should be mitigated by the user space resource manager.
>
> [1] Section 6.2 in https://trustedcomputinggroup.org/wp-content/uploads/T=
PM-2.0-1.83-Part-3-Commands.pdf

It's been a long while since I implemented the resource manager but out
of top of my head I'm not sure if we even expect to encounter the issue
in kernel RM as it fills and empties everything for a command
transaction.

Emphasis that I might have forgotten something but this is what I can
remember right now.

BR, Jarkko

