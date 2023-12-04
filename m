Return-Path: <linux-integrity+bounces-348-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 207BC8041D1
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 23:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A443AB20B7A
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 22:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F9E3BB50;
	Mon,  4 Dec 2023 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtVlhQyr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07D93BB38;
	Mon,  4 Dec 2023 22:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADE9C433C8;
	Mon,  4 Dec 2023 22:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701729992;
	bh=xtZUI5hMvKsNQ/xe3WgP6RpYMcg8xtDwJKZPA/xgbDE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PtVlhQyrhQdppnmNagQVsPrRAnFBmjk4ukJErnDpcy82b82X/IqGvw3CD0/QB+q4q
	 jBc70dMtdMScSuu95zmqcwBTsR1fvglVQjxwoYPPe3Bz2qIAcmoU7G919b7RMXie1G
	 OyburYfelwSbxlmAyRLSqhgxJykl2fvPNzdRmanQ3dE3m+SBnlrGGQLOSXT7ObVXWI
	 B1a7kICimd1XULTF+5B5x7uP+oxybMQ7vhi6olkAQ6lJWsKi7I66WuoLtrtWh/MW7S
	 72XXHyabPkuaRlwgmFmcbOG99z0Unc9lIuR8GH3VuVHmOwDB6RYOSmmWtcM+tih27S
	 Ah6IfCYSZfjnA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Dec 2023 00:46:28 +0200
Message-Id: <CXFWXOIEB49Q.L5BO3I3Y8R0S@suppilovahvero>
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
 <CXF71WGDHXAW.28FXYY08L1DMR@suppilovahvero>
 <987f9fc8e9e8df38e66e6d4a2fd1f8eb570899ff.camel@HansenPartnership.com>
In-Reply-To: <987f9fc8e9e8df38e66e6d4a2fd1f8eb570899ff.camel@HansenPartnership.com>

On Mon Dec 4, 2023 at 2:35 PM EET, James Bottomley wrote:
> On Mon, 2023-12-04 at 04:29 +0200, Jarkko Sakkinen wrote:
> > On Sun Nov 26, 2023 at 5:05 PM EET, James Bottomley wrote:
> > > On Sun, 2023-11-26 at 05:39 +0200, Jarkko Sakkinen wrote:
> > > > One very obvious thing to fix there is the kconfig flag:
> > > >=20
> > > > 1. Its meaning and purpose is not documented to the commit
> > > > message. What is it and what is its meaning and purpose.
> > > > 2. TPM_BUS_SECURITY does not follow the naming convention of
> > > > other TPM kconfig flags, and to add, "security" is way way too
> > > > abstract word. Something like TCG_TPM_HMAC
> > > >=20
> > > > =C2=A0=C2=A0 It should be renamed as TCG_TPM_
> > >=20
> > > One question is do we still need this?=C2=A0 Since my tree has moved
> > > ahead, I also need the HMAC code for policy on keys and the primary
> > > code for permanent parents.=C2=A0 The only real performance concern i=
s
> > > for PCR extension (no-one really cares about the speed of unseal or
> > > random), so a different possible way of doing this is simply to
> > > CONFIG that one operation.
> >=20
> > I think so.
> >=20
> > Major distributions have started to ship with TPM2 sealed hardware
> > drive encryption, based on LVM/LUKS2 partitioning setup. It is
> > convenient enough that at least I prefer it over encrypted
> > passphrase.
> >=20
> > Having this feature would add defence in depth to that. I could
> > definitely see distributions adapting also to HMAC because now there
> > is already too legit uses cases (ignoring the people who just enjoy
> > configuring obscure things).
> >=20
> > So motivation has rised by a factor now, i.e. it makes sense now more
> > as a "product" and not just research topic, given the use in the
> > workstation, in addition to the data center.
>
> Sorry, miscommunication.  By "this" I meant the config option not the
> entire HMAC code.  The proposal without it would be unconditionally
> compile tpm2-sessions.c and do HMAC/encryption on random and
> seal/unseal but gate the PCR HMAC via a compile or runtime option so as
> not to degrade IMA performance if performance were preferable to
> security.
>
> James

Ok, well, at this point I would default-n and distributions can make
their policy.

BR, Jarkko

