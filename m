Return-Path: <linux-integrity+bounces-328-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB984802A47
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 03:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F2C1F20F32
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 02:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CEC17F0;
	Mon,  4 Dec 2023 02:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSuNBR2i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA24115A4;
	Mon,  4 Dec 2023 02:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE1AC433C8;
	Mon,  4 Dec 2023 02:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701656974;
	bh=3BY6e2e10iglZcJnbDmX6v8gwrnNjURtjXXjYnjN2Uw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=hSuNBR2ilGbpL58IqvDKyJYScVpvPrbDuxscrpdpODBGRJuLN6bKKpEFz54WcAGfq
	 uU0sihsmR67BMTCCyjnJtiUja2BSQfdYHE6QkPyGFvlu95WELViVwJXo5TGBRfstXO
	 gnFkzd4LZYA335isPPfBdM4Dypz3x92BqUoYU4C+D1HR+vt39d7KNyTvObYOUxgxrk
	 thQty43WvYiSQlPijkjHvAb/OQ6PApBvhUVDvlXNQ/GSiG9bsFzk6WLoa/P4eEiLZ5
	 cCN2U/TAzQa4eozwV8RDzurVwUwTgdUgBuQGLpBor1sqBdV2xrQzy4OTpDc+2RmfNe
	 OFiGGdSCuPoPQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Dec 2023 04:29:30 +0200
Message-Id: <CXF71WGDHXAW.28FXYY08L1DMR@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>
Subject: Re: [PATCH v4 08/13] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-9-James.Bottomley@HansenPartnership.com>
 <CX8FJA25TO6W.ET37QQIXFGQH@kernel.org>
 <4e7fd5c07dede4ebe640dcc3b123adcb1e65f1f0.camel@HansenPartnership.com>
In-Reply-To: <4e7fd5c07dede4ebe640dcc3b123adcb1e65f1f0.camel@HansenPartnership.com>

On Sun Nov 26, 2023 at 5:05 PM EET, James Bottomley wrote:
> On Sun, 2023-11-26 at 05:39 +0200, Jarkko Sakkinen wrote:
> > One very obvious thing to fix there is the kconfig flag:
> >
> > 1. Its meaning and purpose is not documented to the commit message.
> > What
> > =C2=A0=C2=A0 is it and what is its meaning and purpose.
> > 2. TPM_BUS_SECURITY does not follow the naming convention of other
> > =C2=A0=C2=A0 TPM kconfig flags, and to add, "security" is way way too a=
bstract
> > =C2=A0=C2=A0 word. Something like TCG_TPM_HMAC
> >
> > =C2=A0=C2=A0 It should be renamed as TCG_TPM_
>
> One question is do we still need this?  Since my tree has moved ahead,
> I also need the HMAC code for policy on keys and the primary code for
> permanent parents.  The only real performance concern is for PCR
> extension (no-one really cares about the speed of unseal or random), so
> a different possible way of doing this is simply to CONFIG that one
> operation.

I think so.

Major distributions have started to ship with TPM2 sealed hardware drive
encryption, based on LVM/LUKS2 partitioning setup. It is convenient enough
that at least I prefer it over encrypted passphrase.

Having this feature would add defence in depth to that. I could definitely
see distributions adapting also to HMAC because now there is already too
legit uses cases (ignoring the people who just enjoy configuring obscure
things).

So motivation has rised by a factor now, i.e. it makes sense now more as
a "product" and not just research topic, given the use in the workstation,
in addition to the data center.

BR, Jarkko

