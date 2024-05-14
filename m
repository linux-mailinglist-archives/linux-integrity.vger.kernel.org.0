Return-Path: <linux-integrity+bounces-2411-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DCE8C5DE6
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 00:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550241F216B1
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 22:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE8C182C80;
	Tue, 14 May 2024 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ0oG5RI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E9181CFB;
	Tue, 14 May 2024 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727170; cv=none; b=AF11icv9EVrK0g6KNRNvy/53Ww9rZREyizScFJoZ5xYZxJ+ak0zXC+IdnHTheLzgf/aIYqlh523LJxsrVBBb68ndFhecisysyeBiXCRoN0Hk71ZZTB4tP481qADHbmZjDSE0P+yHATBy11zMs6Pc4scx58sueuB+iHBEP/GWOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727170; c=relaxed/simple;
	bh=OdT4KFAV9v7V5rkLDBZy5koQ2ZG/f6bqAbd2RkcWpE8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sGVvrAUr41TtvLsAcUGF6J8QWhyqxdABvm6PZIu6WpI3MyxLTdaSmLhtzSn5pNKp0QnOLfCDtOTF/Doge2yce/Ih380PkYuLmAue1kLEaZ2FfDCTXHX4KKJtrvAKUR3nB6/PubvwfQV6vazUjRDEpDaSskgcxKzx9iu6VtV5ctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ0oG5RI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9C5C2BD10;
	Tue, 14 May 2024 22:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715727170;
	bh=OdT4KFAV9v7V5rkLDBZy5koQ2ZG/f6bqAbd2RkcWpE8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=bZ0oG5RINe5rxgxiSLdO7FVul3/cEDvqoPKyN6ke/kLbC+t4VZId+rMpE7atp6a2K
	 Td6+TZANf+Yf1b9Yc+xJ0ffcA0jEAdzcdOW8dJF88IJZEEqxrFTutXF89dDjhG0Mw8
	 WOBNCHooSJOKe+oKMsInus7QYFE0PmWFbsc2D6lX30ZIlEx2hQONIJgahNZn9qXnL2
	 8UjHaDyC7aESw5vwZoxXRs9EaBWG1oW5jS8XsOnaFFaEVrodyxNPI2wwflVB/LJ7bc
	 WTeKx2Ie80L0VqeRGlyYTtGDmxOAFqBWBrd5ncoPW/I3MteZb34OTGeVIKINpHh2dP
	 11S5hUB+XQYGA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 May 2024 01:52:45 +0300
Message-Id: <D19QIQS6SU8W.27A70AXVLRD12@kernel.org>
Cc: <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 1/2] tpm: add some algorithm and constant
 definitions from the TPM spec
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ignat Korchagin"
 <ignat@cloudflare.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <20240503221634.44274-2-ignat@cloudflare.com>
 <D19QI1MDD734.3FA17QYMV3TD3@kernel.org>
In-Reply-To: <D19QI1MDD734.3FA17QYMV3TD3@kernel.org>

On Wed May 15, 2024 at 1:51 AM EEST, Jarkko Sakkinen wrote:
> > @@ -227,6 +229,7 @@ enum tpm2_command_codes {
> >  	TPM2_CC_CREATE		        =3D 0x0153,
> >  	TPM2_CC_LOAD		        =3D 0x0157,
> >  	TPM2_CC_SEQUENCE_UPDATE         =3D 0x015C,
> > +	TPM2_CC_SIGN		        =3D 0x015D,
> >  	TPM2_CC_UNSEAL		        =3D 0x015E,
> >  	TPM2_CC_CONTEXT_LOAD	        =3D 0x0161,
> >  	TPM2_CC_CONTEXT_SAVE	        =3D 0x0162,
>
> Ditto.
>
> > @@ -234,6 +237,7 @@ enum tpm2_command_codes {
> >  	TPM2_CC_VERIFY_SIGNATURE        =3D 0x0177,
> >  	TPM2_CC_GET_CAPABILITY	        =3D 0x017A,
> >  	TPM2_CC_GET_RANDOM	        =3D 0x017B,
> > +	TPM2_CC_HASH	        	=3D 0x017D,
> >  	TPM2_CC_PCR_READ	        =3D 0x017E,
> >  	TPM2_CC_PCR_EXTEND	        =3D 0x0182,
> >  	TPM2_CC_EVENT_SEQUENCE_COMPLETE =3D 0x0185,
>
>
> Ditto.

These can be in the same patch but both need a rationale.

BR, Jarkko

