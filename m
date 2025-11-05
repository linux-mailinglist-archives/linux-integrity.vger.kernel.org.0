Return-Path: <linux-integrity+bounces-7577-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6947C38589
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 00:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33CE84F238C
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Nov 2025 23:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E672F5483;
	Wed,  5 Nov 2025 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfkuoZwz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA242F5A34
	for <linux-integrity@vger.kernel.org>; Wed,  5 Nov 2025 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385033; cv=none; b=Rn/80LBxItg0hQOQsPZ2cmQpnT5VUAM6NqevXC+Rqgndm+BcSAkj8nOTEWMcIey8LjdrfdtS7HoKCZ2aawGwSu7h548TgnAbsspLLZtW5Nav3CeRbc1HzPqx3GSM8V04f15+6th8mQdu/dvyaaiVmtTe0jisHk2ULRaz0o4USZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385033; c=relaxed/simple;
	bh=Al3oGioELwHK6+eex1SyHV0FyTUyYiQOvc+s/ABh5bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrXGOsKDKjaRaPbDbb5EoMulguwyMCQNMn8EatN9JkJAamlQaB92pQgaRhgfCoABqI81heftpSGe+RcLHSJrVJZLknMMqNE1niefHxH9s7s6JSmzRg8vyidSYv+pzqL05w2jzjmUb29ZHruTXUGQqCXgYuJAbRPsAnYxS+V0Fng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfkuoZwz; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3408c9a8147so353067a91.0
        for <linux-integrity@vger.kernel.org>; Wed, 05 Nov 2025 15:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762385030; x=1762989830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kubJeXUo3UmeVih2lAdYf2/Z0P2HnIw8/BtS+HNWHsg=;
        b=MfkuoZwzD0cXS5npPq828F5dLtwJ0Y+VmVm0uUVNnLUJddFsj8SxXIa4/T0/sgTqWG
         M3PyQvcI7Zq62Pt9JbN23MPp/+JTzxCH3SVmxv1kRmyJDJiQAiW6sA1FwmIhSMsI1w0g
         JzVbsbJCtPz7yZ7LVBdXUPq2RvYR4+cscPJyvR6kIn/PsKkE8HmJf8+HQJKx12tS65Qn
         aq71G5LzUm3+Fc3UkpNEWW0a+rn2dsujoVCaXdxU/uqu8tCpPecPKmOKxCxtbjh4pIRt
         OQXT/Dzvf9Hrfgs0utsHKMUfS6pTG9Y2yRAWcO7b4ip8yvseZDjTmHF3nuEwVJBTLVsq
         rfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385030; x=1762989830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kubJeXUo3UmeVih2lAdYf2/Z0P2HnIw8/BtS+HNWHsg=;
        b=swLk2TDT+4d+L0bmtd0bGb6t2yHtN1unoT3fTXEMdLMhlewj8toVHVeRiMduuQE94p
         F8hJraUtHnDnOOrjanoPFO6hWbqm43Bh3Y3e59XuI4EimcoV/GAh6ZLPohG0SfsLpZch
         QCQycZmHIB3jc+LNc7UVDyNHD8KN46BgW9Q6A73LOsg1BrO3+lEm0QlKBi7z2eaz1UED
         2cvaknJi3SqidlsE3GFyzOtIgylE0TdVX+L/iTCY9fpbkz9ir6pmonxiJ7AywVzQGDsJ
         46Ux1vx5lr59qKl4PPsvBjmBcFTIE9SavjPG31yaqlUOAZHbWVVmxOts0z0ugJa6rSbf
         PJxg==
X-Forwarded-Encrypted: i=1; AJvYcCWH5+u8v1ydsw+OckFeByM/e3XwaX3o/4yQXe0RCme/Rndak8tVhKDPH65AvevUldBH5g1rs2SGYndyYQOL6qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbskyVy5IBZ2V7Y8DKFEaqkycfv/2cUBqPUTkwGUDGF+1SWx7F
	gYSM4hu1SFbYaAb43oAs7ZfZQXnQ53Q3qTdwNJLd9UpiIIVwfkgrFE3i
X-Gm-Gg: ASbGncv6hLH3jQ8EY7tv0OYBXwy2EgDXp9feId8Q910pSlODBUaOQ2IESb3d70TmDM9
	xkAZZYwhVgb2ekYna90kru6PamhMpHpjmPmMsb5CHfTeDVSbqE+bEQRAT+Y5gwOEuaSswlK+PQf
	YicaXygcPsGbBZlLMXf1OWQxJwwZSD+wQa+N6xWRm5OQvHfMLwMSTFhyTGsfyxPvlNGYGhLU2O8
	cqF5HLGcZZHSJaHr5JiTOsoPdOWqAhXrkE/+jHGsmGgNJe8CZgoPMDGMnG9gk0BIMItMU8OUT4E
	CGCEHmwkszdOkC6pPlUnkhp7jj18ZOJwb4R20dBQHnNseuvjDnsfEiDoNGwc1MCqTjaTYS7cuIx
	IUQ9PYCQqT8O+4J+Kmj5A8bF4Eh9iKsOftlyfKvTbLZOMWWVqDiq95IWarUEARDgRlCxgtaWi6A
	cUwMPR+d+RIY4UrxKlBNNIbA==
X-Google-Smtp-Source: AGHT+IEcGzkdAa/JmxgIi83wsydvd0gXDWv6Dhw6hmBafbUdgTVKt1GnX2x8UlV59wQ8wCiPzufLug==
X-Received: by 2002:a17:90b:180f:b0:32e:4716:d551 with SMTP id 98e67ed59e1d1-341cd0d3850mr1372807a91.6.1762385029921;
        Wed, 05 Nov 2025 15:23:49 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d048e1d9sm361918a91.6.2025.11.05.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:23:49 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 871BA420A685; Thu, 06 Nov 2025 06:23:46 +0700 (WIB)
Date: Thu, 6 Nov 2025 06:23:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Integrity <linux-integrity@vger.kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: tpm: tpm-security: Demote "Null Primary
 Key Certification in Userspace" section
Message-ID: <aQvcgoOU0AHxKf9W@archie.me>
References: <20251104131312.23791-1-bagasdotme@gmail.com>
 <50acd6bfbc8b9006bef5d7d0376b7ce4ab35f94c.camel@HansenPartnership.com>
 <aQqvEsdoj0El2Dq4@archie.me>
 <a8a5b95e06e2d5d1c04aab8933f25cd07903a3e8.camel@HansenPartnership.com>
 <aQtLerZYehQRWdqe@archie.me>
 <bbba0752a40859a114bac987d279a8b268e5e5eb.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JHfvFp1iNfVh4sFH"
Content-Disposition: inline
In-Reply-To: <bbba0752a40859a114bac987d279a8b268e5e5eb.camel@HansenPartnership.com>


--JHfvFp1iNfVh4sFH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 11:33:39AM -0500, James Bottomley wrote:
> On Wed, 2025-11-05 at 20:04 +0700, Bagas Sanjaya wrote:
> > > Why might it need moving?
> >=20
> > Just to tidy up toctree then...
>=20
> I'd really rather have the files in the doc tree grouped for ease (and
> reminder of) maintenance.  The two headings belong together in one file
> because if someone updates the doc for one, there's at least a chance
> they'll notice the other might need an update as well; whereas if we do
> separate files for every heading the tree becomes very fragmented and
> the chance of something being missed increases.
>=20

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--JHfvFp1iNfVh4sFH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQvcfQAKCRD2uYlJVVFO
o2ziAP9k9lD+4G6TWabjWQjhgcM0by7e5E3t2WQFaS34n6XU1QD/b+hf+htPHhCU
NSmPw4fnv0FZwoxw6cdfsOIYZV5dQA8=
=OkY8
-----END PGP SIGNATURE-----

--JHfvFp1iNfVh4sFH--

