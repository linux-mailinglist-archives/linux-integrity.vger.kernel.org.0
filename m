Return-Path: <linux-integrity+bounces-4008-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562439BB33B
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 12:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CF41F22A7F
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 11:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296D81C175C;
	Mon,  4 Nov 2024 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIP9E0Ra"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A11B394D;
	Mon,  4 Nov 2024 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719201; cv=none; b=aQPrR3o1flxZ+OH1X47Hp9tP22wPcbi8Vf50L1xvqox/+yll6oey5MsOXeXwPk6fbaji3DlNsF56Q8szLKhl/Sa+5Qnrocbxmv1zuTP9M22o2g647dVACdxAc/tpWlDJi63ZjpCyRzmXRdjzbA2zeBi1DNxM60WYZeXh/6Dgep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719201; c=relaxed/simple;
	bh=cY33B02f8szVFbWSo1IQ5weKa0vYy6o23iYaDlbeQMI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NdRM9r2FxHHs3IY8S3S76b5foSixz10xle7GL45eA8iqwKZSUE29vCTb85np1mLIt9YC08qkDSKddrbPtRP9kYfKXgKuGOQsUTeGRzVEWa1+6YXHa9plCzZUY3SKpOyG1e/Dhg2MieMMAEHLE/iMVfouQGaahs8hUp3SgywCYDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIP9E0Ra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAA7C4CECE;
	Mon,  4 Nov 2024 11:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730719200;
	bh=cY33B02f8szVFbWSo1IQ5weKa0vYy6o23iYaDlbeQMI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UIP9E0RaNUsBSCPMqdDp2sCJlCa/4ioeF0NaoJAr3tljrNmOYW4l/yvH/b1wkhCDi
	 DfJ05oU3fIqAUtM6YtWamKC4RYV4fWtszl/ctXAnvYCZETKobKd+1bpeFoSwcV7PXy
	 8M3Y+2r3alSCyylqTnRyDRXU7UfJL3vTYfgNq9iwrBung0NR8/PPR2O6wDaT7h7PUn
	 x1P0978VSxvUaM0YPDlO3TCJ6JP3D4Jax8eCe6vux6EJHI91i9dpRpHFhwSXAzf+z9
	 YxHjGWZxvuInZpC/fCJPJAIVcGoxQHvOqBJZprA3san23C9UGsKbRe1Df2t1ELeP7r
	 QPPIkf6JNa8cA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Nov 2024 13:19:55 +0200
Message-Id: <D5DCR279TZY5.1C7KRTFPGD3WU@kernel.org>
Cc: <x86@kernel.org>, "Ross Philipson" <ross.philipson@oracle.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "open
 list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>
X-Mailer: aerc 0.18.2
References: <20241102152226.2593598-1-jarkko@kernel.org>
 <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
 <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
In-Reply-To: <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>

On Mon Nov 4, 2024 at 1:18 PM EET, Jarkko Sakkinen wrote:
> On Mon Nov 4, 2024 at 12:57 PM EET, Daniel P. Smith wrote:
> > On 11/2/24 14:00, Jarkko Sakkinen wrote:
> > > On Sat Nov 2, 2024 at 5:22 PM EET, Jarkko Sakkinen wrote:
> > >> It is not really my problem but I'm also wondering how the
> > >> initialization order is managed. What if e.g. IMA happens to
> > >> initialize before slmodule?
> > >=20
> > > The first obvious observation from Trenchboot implementation is that =
it
> > > is 9/10 times worst idea ever to have splitted root of trust. Here it
> > > is realized by an LKM for slmodule.
> >
> > First, there is no conflict between IMA and slmodule. With your change=
=20
> > to make locality switching a one shot, the only issue would be if IMA=
=20
> > were to run first and issue a locality switch to Locality 0, thus=20
> > blocking slmodule from switching to Locality 2. As for PCR usage, IMA=
=20
> > uses the SRTM PCRs, which are completely accessible under Locality 2.
>
> Just pointing out a possible problem (e.g. with  TPM2_PolicyLocality).
>
> > Honestly, a better path forward would be to revisit the issue that is
> > driving most of that logic existing, which is the lack of a TPM
> > interface code in the setup kernel. As a reminder, this issue is due to
> > the TPM maintainers position that the only TPM code in the kernel can b=
e
> > the mainline driver. Which, unless something has changed, is impossible
> > to compile into the setup kernel due to its use of mainline kernel
> > constructs not present in the setup kernel.
>
> I don't categorically reject adding some code to early setup. We have
> some shared code EFI stub but you have to explain your changes
> proeprly. Getting rejection in some early version to some approach,
> and being still pissed about that years forward is not really way
> to go IMHO.

... and ignoring fixes that took me almost one day to fully get together
is neither.

These address the awful commit messages, tpm_tis-only filtering and not
allowing repetition in the calls.

BR, Jarkko

