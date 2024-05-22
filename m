Return-Path: <linux-integrity+bounces-2552-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4B88CC23A
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 15:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3AC1C20E8D
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 13:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FFF140361;
	Wed, 22 May 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LY4KnZEt";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LY4KnZEt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D313D532;
	Wed, 22 May 2024 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384933; cv=none; b=PHd+5vgwArfFuXpNtiJCy7rIg2+WtQYtX8B4xlkshLQmB3dnM+/Ax1uwOgHRjwE8JQwVJLPJ//0ouNHl5s22/2wAJMsCMsvLsQUJ5ppAHdUuLvQO0I4TUXvFwZrqx3jjHExAaUP5+4een8gEIQ8IGqAoVGMVa4ESffYQmxZHsYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384933; c=relaxed/simple;
	bh=kdwS4J2re7NPgqyP8PRnuHF0BUonXqbA7hQP1gBF8XE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JGjj+I9tRqABeowZP8tk38FaUalfb+Xyd7iyBLy6Jgcx1Iuowhpiq0CPVwS/Pk4iVnKPHLUFgOI6rkeU6wA5GanMZCdjAjcYb3PasInx6vDjH/QaDGo0DCGscAocP+D6V7R3kSkVu/oA89XHtjeyctZpBOfLS7F6AY15mPD5wjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=LY4KnZEt; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=LY4KnZEt; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716384929;
	bh=kdwS4J2re7NPgqyP8PRnuHF0BUonXqbA7hQP1gBF8XE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=LY4KnZEtrqTVhymxyjmxAjbe5ZlSPq3aJ2wyoZRscMvYhC3ahsf6HNOWyadv0cZ5s
	 2QHFCDEwdLy3DXizEYe+wHyKEi6iEoDD9/zeVJWULvhrk01/qZhceAW0N5TBStPQkO
	 uxyvPDfPBlVfDtmjYSzxPSGdc6AgXEAFg1hCU16U=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CF9771287287;
	Wed, 22 May 2024 09:35:29 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id N1c-ZmMXw-pg; Wed, 22 May 2024 09:35:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716384929;
	bh=kdwS4J2re7NPgqyP8PRnuHF0BUonXqbA7hQP1gBF8XE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=LY4KnZEtrqTVhymxyjmxAjbe5ZlSPq3aJ2wyoZRscMvYhC3ahsf6HNOWyadv0cZ5s
	 2QHFCDEwdLy3DXizEYe+wHyKEi6iEoDD9/zeVJWULvhrk01/qZhceAW0N5TBStPQkO
	 uxyvPDfPBlVfDtmjYSzxPSGdc6AgXEAFg1hCU16U=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9F7BA1286673;
	Wed, 22 May 2024 09:35:28 -0400 (EDT)
Message-ID: <17a5dcd7aceb356587ef7c8f45b0f6359b2d2a91.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Vitor Soares <ivitro@gmail.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Wed, 22 May 2024 09:35:27 -0400
In-Reply-To: <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
References: <20240519235122.3380-1-jarkko@kernel.org>
	 <20240519235122.3380-2-jarkko@kernel.org>
	 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
	 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
	 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
	 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-05-22 at 09:18 +0100, Vitor Soares wrote:
> On Tue, 2024-05-21 at 08:33 -0400, James Bottomley wrote:
> > On Tue, 2024-05-21 at 10:10 +0300, Jarkko Sakkinen wrote:
> > > This benchmark could be done in user space using /dev/tpm0.
> > 
> > Let's actually try that.  If you have the ibmtss installed, the
> > command to time primary key generation from userspace on your tpm
> > is
> > 
> > time tsscreateprimary -hi n -ecc nistp256
> > 
> > 
> > And just for chuckles and grins, try it in the owner hierarchy as
> > well (sometimes slow TPMs cache this)
> > 
> > time tsscreateprimary -hi o -ecc nistp256
> > 
> > And if you have tpm2 tools, the above commands should be:
> > 
> > time tpm2_createprimary -C n -G ecc256
> > time tpm2_createprimary -C o -G ecc256
> > 
> > James
> > 
> > 
> 
> Testing on an arm64 platform I get the following results.
> 
> hmac disabled:
>   time modprobe tpm_tis_spi
>   real    0m2.776s
>   user    0m0.006s
>   sys     0m0.015s
> 
>   time tpm2_createprimary -C n -G ecc256
>   real    0m0.686s
>   user    0m0.044s
>   sys     0m0.025s
> 
>   time tpm2_createprimary -C o -G ecc256
>   real    0m0.638s
>   user    0m0.048s
>   sys     0m0.009s
> 
> 
> hmac enabled:
>   time modprobe tpm_tis_spi
>   real    8m5.840s
>   user    0m0.005s
>   sys     0m0.018s
> 
> 
>   time tpm2_createprimary -C n -G ecc256
>   real    5m27.678s
>   user    0m0.059s
>   sys     0m0.009s
> 
>   (after first command)
>   real    0m0.395s
>   user    0m0.040s
>   sys     0m0.015s
> 
>   time tpm2_createprimary -C o -G ecc256
>   real    0m0.418s
>   user    0m0.049s
>   sys     0m0.009s

That's interesting: it suggests the create primary is fast (as
expected) but that the TPM is blocked for some reason.  Is there
anything else in dmesg if you do

dmesg|grep -i tpm

?

Unfortunately we don't really do timeouts on our end (we have the TPM
do it instead), but we could instrument your kernel with command and
time sent and returned.  That may tell us where the problem lies.

Regards,

James


