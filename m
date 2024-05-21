Return-Path: <linux-integrity+bounces-2488-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10A08CA567
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 02:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7DC1C20D22
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 00:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6191E6AA1;
	Tue, 21 May 2024 00:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3psbCZt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0E18D;
	Tue, 21 May 2024 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716251858; cv=none; b=X3pV+oC7BRfJABkXR+SnQeyC3XXbPO8SY/UjtyXVCbw15oNtJtrAZmC9yJyMVofuOSkX6Ao+vMSvw7Dd71mAT8wjBeBQuGNNjPUg8coA6c8qQiOTxT6MpljYxb/KlcPt8h0vXJNcDjNBuoH58Weiud0cpm/M2LldKVVnzRgpr/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716251858; c=relaxed/simple;
	bh=YKL2F8+ozNzszn7mHMTBzmBfeApG2Bl85xxp0H7yZag=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iIRRivNMgGx4WBofCmEgzLckrRQZthffFpWWTiVcpnuHnC1wG6tE3PkVCnWtOK2/GUpsPQuPUuGAwnQS/05feVFz67GcT86REIiIiDxs3Rpi4+PTYKD/LVgXXPR4W7FBsRPuLSadcpcwCt1ChqJqEeexDd5ownHd3PHX5MDYqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3psbCZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF4EC2BD10;
	Tue, 21 May 2024 00:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716251857;
	bh=YKL2F8+ozNzszn7mHMTBzmBfeApG2Bl85xxp0H7yZag=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=D3psbCZt+RDzO+HvjXkIur5oU6ys4A63JxpizQVqdwIb7B/JmnGFc2jc3ky2Kl+76
	 Uvtx3+Mn09J+ZxWxR7aX3Z/EUVsR9WBlt1PyNgS0cuSaxZCOX1H0cmciV+DXA2z2Tw
	 LHNXNm5+N2yuZd0KbkBMod+iUwVRGJ5UMfS+paeqnla2sxMxtzQG9gc5jAULB/mAye
	 tzmwKWRVILE42fgr3Ro2e49M4jfgE5C32RfGKpIU945DD0oYBsZzHUFf8rjeGrs12L
	 ckdNFOYLAZixfKoAiPoUxi7zK2kE8L/xFG2JDmhfC0URFgUeNGncBTrc3sng+HC+Xg
	 ZtqjxNwC+htbQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 03:37:33 +0300
Message-Id: <D1EWI92F6AIH.3CFED3IMI10ZA@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "David S. Miller"
 <davem@davemloft.net>, "open list:CRYPTO API"
 <linux-crypto@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>
Subject: Re: [PATCH 0/6] KEYS: asymmetric: tpm2_key_rsa
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240520184727.22038-1-jarkko@kernel.org>
 <D1ERDC16XLUO.578U4ZE7VXW@kernel.org>
In-Reply-To: <D1ERDC16XLUO.578U4ZE7VXW@kernel.org>

On Mon May 20, 2024 at 11:36 PM EEST, Jarkko Sakkinen wrote:
> On Mon May 20, 2024 at 9:47 PM EEST, Jarkko Sakkinen wrote:
> > ## Overview
> >
> > Introduce tpm2_key_rsa implementing asymmetric TPM RSA key. This key ty=
pe
> > can be enabled with CONFIG_ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE config optio=
n.
> > Carves groundwork for similar modules in future, such as tpm2_key_ecdsa=
.
>
> Cc to Eric (forgot).

Also my idea is to take the (working) model from tpm_tis. At this point
it is just tpm2_key_rsa but it would be easy to lay out tpm2_key later
on and make the different key types as submodules. That would be a kind
of model, which would support algorithmic agility side of TPM2.

So there might tpm2_key at some point with tpm2_key_rsa and tpm2_key_ecdsa=
=20
as its submodules.

BR, Jarkko

