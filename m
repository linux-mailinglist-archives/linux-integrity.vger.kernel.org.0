Return-Path: <linux-integrity+bounces-645-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F288F8247DC
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 18:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C311F228B1
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F2D28DAB;
	Thu,  4 Jan 2024 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD0ZDiWM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39FE28DA0;
	Thu,  4 Jan 2024 17:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734D8C433CA;
	Thu,  4 Jan 2024 17:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704391005;
	bh=pRDqTucUl85nz0YsAX/5/EHDm2UPcEWIRaJQHjFFQg4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PD0ZDiWMjBEH3GJ1eVqs4ND4zzLmLjnV/7hjEVE1xMeboqYkhZyqmoK6oezv1YZcv
	 3CG87kXnUJegZyxOKlEZNSKMv08iUHeN+I0/AChMAOYqsbEh450ku4n1Dur4uC8QyN
	 vFT+cT1TqkdZAoJ49+biWKgy/4Y0XeLd7PrLXTA/VsdmIxGkE+VWme/Pt55+GM8M8H
	 aeIstHyIrqSim2fDldB0hBZPQR6mLzoTyC3tAz6k33ANDGg/uM0DadQyOXScdHrOWN
	 Kk794ykoIeGCNNcvHwLTN1WF/LVOGDnW4OV1VMfIw+IfTz3BREKNhHhFu5XlbqRdBD
	 is2a2P3zhprgA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jan 2024 19:56:42 +0200
Message-Id: <CY646P7ZHPKG.2F87N3P2DFQQ2@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v6 12/20] tpm: Add NULL primary creation
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
 <20240102170408.21969-13-James.Bottomley@HansenPartnership.com>
 <CY561MZ9UH2Z.3PMLA57T4GKD2@suppilovahvero>
 <781fbe99d89ca573f9f6b77b29371bafa283d2b6.camel@HansenPartnership.com>
In-Reply-To: <781fbe99d89ca573f9f6b77b29371bafa283d2b6.camel@HansenPartnership.com>

On Wed Jan 3, 2024 at 5:25 PM EET, James Bottomley wrote:
> On Wed, 2024-01-03 at 17:11 +0200, Jarkko Sakkinen wrote:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 ec_point_x[EC_PT_SZ];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 ec_point_y[EC_PT_SZ];
> >=20
> > And also prefix these similarly with hmac.
>
> This isn't in itself an HMAC; it's the public point of the P-256 key
> derived from the null seed (effectively it's a public key).  It's used
> to exchange secret information with the TPM, like a salt for the HMAC
> sessions but it's a thing in its own right (and is bound to the null
> name).  I suppose null_key_x/y is better.
>
> James

Right, yea would add clarity (or perhaps null_ec_key_{x,y} for extra
clarity).

BR, Jarkko

