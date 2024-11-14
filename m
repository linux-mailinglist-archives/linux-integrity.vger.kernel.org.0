Return-Path: <linux-integrity+bounces-4120-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 374F69C821A
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 05:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C8BB25532
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 04:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44491553AA;
	Thu, 14 Nov 2024 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1Ez9LLH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E223C38
	for <linux-integrity@vger.kernel.org>; Thu, 14 Nov 2024 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731559947; cv=none; b=rSwZLIperzTxw/laIHpnv1nGW7r51cGyT6JtyBt0cFk2XlPUdAcmac11FVH0UAZ0yrGEkbDeSyxSYyffVSO0VlKGlPyr0a0rkK/3L/SgabW/c914HV4qhfBR7L/7fUWYw4lPuPSCio2ELpwOIXkDQ1fklY2GOE7RbT4Misi3Ww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731559947; c=relaxed/simple;
	bh=gFS2+aN4/Nd9o+KNciOWgJEs7/iK7qsriYypjswK7vM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=T/amXdU4wPXkAF9dIxxCKfDjgMKW0xBNwkg/zUjWLudIIq6HFVHEcpzjf3U8s6SdDFjfdCC3dCZOCN+DZoCL25RjrlSLn/Fld9ptuwmvSLbxLzLrW1HlAGeUdEkjymoawaCbYJHjPJ8dD/eOPuv5VAM9Tg1eIbfJ1qjiL2Jm9Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1Ez9LLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFE4C4CED0;
	Thu, 14 Nov 2024 04:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731559947;
	bh=gFS2+aN4/Nd9o+KNciOWgJEs7/iK7qsriYypjswK7vM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=b1Ez9LLHQcH/eg5+Zb6piXqyVT4R4RYZbCejwdgoNLm2x184H7yDAzUNwXm58aOV/
	 4xgAvBgUHAcvZGAz+aQdQw1184PwyYUWBIo4REHypVDd3PdcKSJ599QvUAer/rEA6K
	 40971isBlk9dV53PWa0l6Nr1b151mRNrentLeVXOghUFIF+UQDaYS/o0xM1aOIPw8C
	 gP+0oBDaRdUdY0mjWGYsiVouEyLubbtBYrHSMDh2EP3O6UQOlUYA2gDCHd6MFW8OTw
	 L7a4b46p7Iq07IZkr103jnltdKQuyj/eoQnWC1LTSgIss5fVG358OVhDouDCbTphL1
	 1nVjU1oHxV/lw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Nov 2024 06:52:22 +0200
Message-Id: <D5LMRS83UP6W.22IBEK42G75GB@kernel.org>
Cc: "James Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Christoph Anton Mitterer" <calestyo@scientia.org>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
 <D5L9XVNXYQR1.2EBNEZRV0QVUI@kernel.org>
 <10783d8ac0d407f85feb8e0de8eb7ccece8c8e57.camel@scientia.org>
In-Reply-To: <10783d8ac0d407f85feb8e0de8eb7ccece8c8e57.camel@scientia.org>

On Thu Nov 14, 2024 at 2:04 AM EET, Christoph Anton Mitterer wrote:
> On Wed, 2024-11-13 at 20:49 +0200, Jarkko Sakkinen wrote:
> > The problem still persists related to TPM bus encryption not working
> > with hibernate in 6.11.5 but the message was shown only once in the
> > log (and thus you did not notice it).
>
> At least my grep from before wouldn't have shown it even once.
>
>
>
> > Please test my fix and I can take it to PR.
>
> I've seen your PR was anyway already applied, so testing still needed?
> I'd need to compile the whole Debian kernel which takes quite a while
> O:-)

It was too obvious and I wanted to bring that to 6.12 :-) It was
a mistake in my fix so was dead obvious.

>
>
> But other than that... and especially as I'm seeing these:
>   2024-11-01T15:41:22.428940+01:00 heisenberg kernel: tpm_tis NTC0702:00:=
 Ignoring error -5 while suspending
> errors...
>
> ... I wondered whether that rings any bells on your side with respect
> to: https://bugzilla.kernel.org/show_bug.cgi?id=3D216998

So here's my proposal:

1. I added myself to the CC list.
2. Please add any additional comments from your response that might be
   missing as comment.

I look that as soon as I have time. First time I'm seeing this.

For anything TPM you can go ahead and CC me also in future...=20

BR, Jarkko

