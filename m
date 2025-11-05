Return-Path: <linux-integrity+bounces-7566-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFB3C33B77
	for <lists+linux-integrity@lfdr.de>; Wed, 05 Nov 2025 02:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2945A464A4D
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Nov 2025 01:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BD61DC997;
	Wed,  5 Nov 2025 01:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM5hKU8q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290191F099C
	for <linux-integrity@vger.kernel.org>; Wed,  5 Nov 2025 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307865; cv=none; b=Axr/VJ/LwhGqQoYDmVuzeRwSaqSR8LT2QIR8RAXrsLJVmEIYJ03KFlPgv9XeieODu1u6awgx1ifgZe+ApGFVZ1yw1w2Kl8sS/T3a2ZtpnysqgEP0BU/ST0JH6ak6c3v5DPqdNTXibyXa1NXTSs1bYwH3fr0+61T/wPTk4L/q7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307865; c=relaxed/simple;
	bh=kIBkaG4fXIkzxYJM4+SHpSYNPKawIJMW91gnWOQCLVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZaMbmBxbb7cR/PXukWLO9LIe1m5bKRQj6KhRAUUtFcaeAYjrwBvWI+ek38EQqCs5reMRCKskF/bGg3bUBeKxNcAF+Rh3kyMIumQen334iMwDMqJ8dSVjsEiH+6gWfWu+JvPhTyl6ptGGkAX9IZ6dniR6EunqRv7ByFknMxTgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM5hKU8q; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b550eff972eso4278076a12.3
        for <linux-integrity@vger.kernel.org>; Tue, 04 Nov 2025 17:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762307863; x=1762912663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7QXdXPqYVzaqknJiF4d2FHnRogGGdgrOuALsEYlJt4=;
        b=RM5hKU8q5wGqp44Ozx2wgH4ob6c1Nl6e4CrhKaoNh7M5eRJSF+0+ey7ELWMx4dEDba
         XYEW7xJ8n8virjMCqsjvgh4SGRuN9qtjQIe23nNxHCoqPWbt5VtTXsoeupjv4GNzeDj0
         QAQ+YEp0SeYRGo4K3bIx+P7LvcUYMrk/6FvvEbnuCM3U7w7mD2DuyPO+V6J6KxFtycxp
         5U2QEMHPSBRApBBB9hZX6SjWLIouAaigHoRtAYKD3D8Q93cGM2RJIVdlGTgHULSqWaWo
         SNSt/DR+0ROGBCXA9z2JP6NiGJiUVJGCT4GNT+Z/JJOISFKTwniUsUFDJ0ExTKeOoG/1
         2aVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762307863; x=1762912663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7QXdXPqYVzaqknJiF4d2FHnRogGGdgrOuALsEYlJt4=;
        b=H9BdTRVh3tBDwLOEkC29Y7Brk5e3Awceu8Ih1scpetMky61j6UicmE07FDwaou+Hs8
         vQMjmQFeQxn/0FIyRPu8bhRjWT7HCeDCevYmZs8N3SZuV/NQRjGQuE2usacA/CnO4TQ9
         zfLlQWCjvktQ8+0xBBvwoXi992h31m3OIr3AD584WMG6P2kJ8JXOxBBvF/V+6fRJk5hz
         3RCWx93PkK0jqZbCeo+/BporanyiA/OAty3+NS149MFOKI4Odsimh2RgVDH4Ti64ILxE
         qaIv8KCM3P9h6R0nQZp6ZKLHs+E8wQrIi7cJPuHs4Pma5hjTPIc5se66DW/jAl1URvqV
         U+rw==
X-Forwarded-Encrypted: i=1; AJvYcCU4d/uYcOEg+nOLOL7z389B6nb4cgcxpLSwF+g2/DfxAllREoeurKgMOO2v4vyHmFEY1iQXAHS76xzcmQ5MZMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIalqWzJvNSDadDFDLWjWBqsfMtLp7+s97U4Pw0SOXGkZ078hj
	fvDmhw65cCiJ2Skyit60BoBpRZgODMJEHNYk68U93mxRSusZXYNiRJWC
X-Gm-Gg: ASbGncu0GCGiOjlfl1OyOFPdC/i9uPrP7im+em8d2UrhsXXXzC/6CTAv7ipnNkPGZkE
	6m/udOxcQyTx8J8cLj9hUzOvbg0YKZiSVGXG6KPT3ZORGzmxTNEWYaf5ewz7rB8AM2HNpwZxtl8
	lXNMG5F1E47bdwHBeyyCdqTSpY9NjWfIyqwbRl8pgvZ7zsYbVDrjQigkJmZhCkkyZ+6NihISd99
	Iihu9L+8CnKRGSuWbh7EKhAfB4I3WmjpZh6S2QGa5dOVmIR/JiMAv+HPMK6fGMiAca6Xg6VZ/qA
	ZZ6/fg2IFvDu3YSXDAgYnuLl3HSE1urAY0zTxGUwNb+SgJuueriOiVeUIMNduxjqTzrr/zMFT1h
	hPffypAKROM7+n1TmNSLskVp8hObqj8kWEkyd/INE80LNprERSJnX+1n4qLxDljak2bWkYHOvMP
	pk
X-Google-Smtp-Source: AGHT+IFltqwlLw/qoAh/Ic6xf0NjzjzpJGPbTkKnz8JOnOsH+5MlmsP9Q/aB13ieURxS0a35dg2/8A==
X-Received: by 2002:a05:6a20:9183:b0:33e:eb7a:4483 with SMTP id adf61e73a8af0-34f83f113f3mr1764667637.19.1762307863306;
        Tue, 04 Nov 2025 17:57:43 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f7569611sm3804562a12.22.2025.11.04.17.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:57:41 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6C941420A6A0; Wed, 05 Nov 2025 08:57:38 +0700 (WIB)
Date: Wed, 5 Nov 2025 08:57:38 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Integrity <linux-integrity@vger.kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: tpm: tpm-security: Demote "Null Primary
 Key Certification in Userspace" section
Message-ID: <aQqvEsdoj0El2Dq4@archie.me>
References: <20251104131312.23791-1-bagasdotme@gmail.com>
 <50acd6bfbc8b9006bef5d7d0376b7ce4ab35f94c.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xcdopG/xTaOcl4jy"
Content-Disposition: inline
In-Reply-To: <50acd6bfbc8b9006bef5d7d0376b7ce4ab35f94c.camel@HansenPartnership.com>


--xcdopG/xTaOcl4jy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 09:55:08AM -0500, James Bottomley wrote:
> On Tue, 2025-11-04 at 20:13 +0700, Bagas Sanjaya wrote:
> > The last section heading in TPM security docs is formatted as title
> > heading instead. As such, it shows up as TPM toctree entry. Demote it
> > to section heading as appropriate.
>=20
> It's supposed to be a separate heading.  It's explaining how to certify
> your booted kernel rather than describing TPM security within the
> kernel.

Should I keep the whole section as-is or should I move it to separate docs?

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--xcdopG/xTaOcl4jy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQqvCwAKCRD2uYlJVVFO
o8AoAQCExGLWsqsoM1i8GHUP+Fgv9X24rbgRfat4KNR1jYRIkgEAv1C61BYGUewY
KxDdWXOniy2ku0+gYvy3bqqF17wYjQ0=
=iC0f
-----END PGP SIGNATURE-----

--xcdopG/xTaOcl4jy--

