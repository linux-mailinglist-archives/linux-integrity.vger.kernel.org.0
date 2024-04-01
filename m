Return-Path: <linux-integrity+bounces-1955-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F5889465C
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Apr 2024 23:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EAD0B21437
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Apr 2024 21:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9075F54780;
	Mon,  1 Apr 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq8hvnS2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F8537F7;
	Mon,  1 Apr 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005196; cv=none; b=j95oigWnF6zTTjBYZpqoZRl4NWZ+XLmW6giX2n40iD5tWR/bP6qW5L/WJ+AeHnjzzVDqrHKYaGKi4/iyeM66uDfPt6qgjRV4txrDlXDeBJ1QiPpR5op6jsGm95qeC10EL4lpe3bVRghW3aa0D/N6qMAPpQKJ7Xm/xhjXFszPwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005196; c=relaxed/simple;
	bh=YRY64A6rKA9DfDT62fDPRWdJ1EBdYlzRg5MxrAyMg4c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZcTL5EqMB4WcScZCJ2gdkL7w75F16SsSA2GYGlaPVSTKBOKW0FvP2UJ4QDHREmiZPH2tSjJY+IDYgteATDlqWZ3lK1pbDPD00UgxUxqzd1ZZw/BHvzhinRnjJ8gCIdl8Kor3oPg0MGbsfYoY9LRddWb0lvLo3LEQnUHM+8Ywx5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq8hvnS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABECC433F1;
	Mon,  1 Apr 2024 20:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712005195;
	bh=YRY64A6rKA9DfDT62fDPRWdJ1EBdYlzRg5MxrAyMg4c=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Pq8hvnS2rz/lMa2+Cd7RmvvghSv6Ls/wABEWkm8hDERAnS3LASbOk5G3alT1m0S3w
	 Wj2U8Zy8VSayiWkIkvoMLyhazjjtGCHBPMIxPviSUTIktv725KkZzWCmhD9b4xskGi
	 wAnJcRNwOTU3NK+fCTx4f1ulzU1/OgDuti9t/dqa8sfFjjJDhWwLFKpfBydCe6DoTM
	 KA3OJn4IMuXQ+uT9RPZcLGhKVrdNah/rfL5jdcXTjeQYVMZIc6oLVirAt3WQX7gyiX
	 A69da/qvJLQRWk4qlaqVCxeDgrGnryD99hagDisc7sTD2Aew6NEsQhZZbjoETagoNJ
	 wRIltkz4z9URw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Apr 2024 23:59:52 +0300
Message-Id: <D0936VZCIT54.ALWDWWEF33OI@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>,
 =?utf-8?q?Gabr=C3=ADel_Arth=C3=BAr_P=C3=A9tursson?= <gabriel@system.is>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
 <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>
 <ad409aa8834c37d7bfe2666e03520dd777afd288.camel@HansenPartnership.com>
 <b60d9761e6afdb483c35949eb4184330f42b9dcc.camel@HansenPartnership.com>
 <D0932R78GETC.BN1J006Y9WAD@kernel.org>
In-Reply-To: <D0932R78GETC.BN1J006Y9WAD@kernel.org>

On Mon Apr 1, 2024 at 11:54 PM EEST, Jarkko Sakkinen wrote:
> On Mon Apr 1, 2024 at 7:55 PM EEST, James Bottomley wrote:
> > On Mon, 2024-04-01 at 10:19 -0400, James Bottomley wrote:
> > > So I'm not really sure how to solve this.=C2=A0 At the moment the ker=
nel
> > > doesn't use permanent handles for keys, but it should and it should
> > > follow what all of the industry is doing for interoperability (i.e.
> > > zero size points), which means the NULL primary should also follow
> > > it.
> >
> > Actually, it turns out this is already solved by the TCG.  The template
> > we're using is the correct one (zero size points).  Apparently they
> > regretted their earlier decision to zero fill and issued this guidance:
> >
> >    2.2.1.2.2 EK Template
> >   =20
> >    An EK Template is stored in an NV Index as a TPMT_PUBLIC structure
> >    marshaled as described in the TPM 2.0 Library Specification [1]. The
> >    default EK Templates are defined in annex B. The EK Template NV Inde=
x
> >    MUST be Populated if non-default values are used. It SHOULD be Absen=
t
> >    if default values are used.
> >   =20
> >    The EK Template unique field buffer size(s) SHOULD be zero.
> >   =20
> > But since they can't revoke the previous guidance, we now have two
> > templates defined: the L one which has the old n bytes of zeros and the
> > new (and recommended) H one which has zero size unique field.
> >
> > https://trustedcomputinggroup.org/resource/http-trustedcomputinggroup-o=
rg-wp-content-uploads-tcg-ek-credential-profile-v-2-5-r2_published-pdf/
> >
> > So in other words, we're doing the later correct thing and there's no
> > problem.  I'll update the ASN.1 draft
> >
> > https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html
>
> First time I'm seeing this document or URL.

Anyway, only thing that we align with is the latest in kernel
documentation, outside URL's are ignored. I.e. the legit ref
is trusted-encrypted.rst.

BR, Jarkko

