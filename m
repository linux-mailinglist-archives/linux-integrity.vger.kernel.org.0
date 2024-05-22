Return-Path: <linux-integrity+bounces-2546-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6D8CBCC9
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 10:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CEB1C20EF3
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 08:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588087E58F;
	Wed, 22 May 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC7/V79j"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A8C138;
	Wed, 22 May 2024 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365941; cv=none; b=eKRJXtzspCTrLAomU0rwAgqJCIzfiijMuE48ruPhjHwYC7/a4IMf6HWsa9smJvyp6i3comjj4HXFomdvEHmJfTznw9WwygMWTT5IXF6GNG3GUSX85dgzoIonjY2sI26BmubWpZhes7KnqJd2XtGok1MQYn360pvap4GiA5raOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365941; c=relaxed/simple;
	bh=bSHpF7FSeuBzxNcacKanUepxY0i4i7iOjdWUu/P8znY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V9VID4COpMUhMAOH7jRx3KTM6zfslFdjOVA7ByO8ntJRABgiIXofZughuStiDJCFJct1UaVsFNGwKeSe2gWEB0LBwnUZIBW4cVbrPovIYCk1YbbMselA7fj7ZKIdtMrN32kEVnuQGANSW2hOWj+kvVqxygMQq1VFjZRPruCpwlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VC7/V79j; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42016c8daa7so37961185e9.2;
        Wed, 22 May 2024 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716365938; x=1716970738; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lBg4uyn78t0bKiR5npVACUo4W3upFksgzJ+CETLwn1o=;
        b=VC7/V79jnvh8oNiXGIyENtx5r/GZNADafdUxhSm9tKx7KVTTCWWYaABKNPRgAHEW5G
         poO7VYW9LfvydgVSl7tIEL0WP+oJsb29rdS9ikKSeyeIqX0esOSSDfY6LJhztPjwPC0G
         wQenGVTkesDbc7WrzOjoeRIXLOb25iSyrQmEVblJxkuQQR/q4gsnGW+5xlZHcGCfuEwy
         vBhYnc8az5VkWB0gsvoGtR4uOK+vhOKzK1ca+pfA6qHnxc1Q4A+R4ftxe3jgYzs0zqsF
         pqURDC++m4hfrS7+Awx0YoPNwP0NKFVZTfsFB+18FCFHRDSa+sDOW0fLD+GSwmEaLshI
         qcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716365938; x=1716970738;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBg4uyn78t0bKiR5npVACUo4W3upFksgzJ+CETLwn1o=;
        b=A+9CRnJq2afFqnb191DvUBh8wkVxFXm/FaioDKNOVmtbYBRbyR2WK37tLiqDxtDDA4
         WU3Ebpr2WQk9Qjb5XycHsR3U1GJtAny+IwBRg3IZgj3eZvSYeydEfKZtjt/tl4Ugc/Yv
         JeKmH9qNWaqHmCJCjgk4pbOCOdroLopqjfhXal/HC0nRNDGxV24NJZYyHBybgN/QtG5W
         hPwzw6AR/ANRgo5bFsLxJhHNDjSAO/Y7Ohs3mE2QGt4YWA9UGm1k8J34rUNyf9OnPZYy
         u+7CQ//jSA2VcKXwT5WAZP2GG9RhnQJ+VurLxyKivt95T4Lk+Mw10nkXiR3R/9foiMIB
         TIgw==
X-Forwarded-Encrypted: i=1; AJvYcCULgoU+cVKdIi7Rh5To19YgdW6aiCUk4TDiH4luZyg4qbxZ4Y1K69IcndRTJ5WhRVN3bCTrpcDiTgjxZHR4sUAnD1GNq4NcOjxGjxK0eXSxjTXAchpZ9Ll76gC0lzowW/y6o6pUuhTIIaqVvNwkrXDlMvnJE1S60860xydeGGFj68aqNgsox6Bu2Kx8VW/AfGuDe5v7
X-Gm-Message-State: AOJu0YzviqUTLZx752qOPTPD2TbY6DWcpgK3zN63RO75r6NqyGYh+x+0
	R6XIij+iMEKrLriKwrd25gh4JJStyblzIktIxmRNY6QDz4j+fJ0Dz8kkcA==
X-Google-Smtp-Source: AGHT+IHLXZgSDJmsis6up0QpZBrArcJ+z5AUWwf3Q497OyVDz9iO2MWp1O0/FUUykhM9+MyKYg62oA==
X-Received: by 2002:a05:600c:2101:b0:41b:f30a:41f1 with SMTP id 5b1f17b1804b1-420fd2db85amr9177325e9.7.1716365937832;
        Wed, 22 May 2024 01:18:57 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:6a60:8259:5f0c:8e1? ([2001:8a0:e622:f700:6a60:8259:5f0c:8e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42017166c64sm363200215e9.8.2024.05.22.01.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:18:57 -0700 (PDT)
Message-ID: <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: Vitor Soares <ivitro@gmail.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Jarkko Sakkinen
	 <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Wed, 22 May 2024 09:18:56 +0100
In-Reply-To: <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
References: <20240519235122.3380-1-jarkko@kernel.org>
	 <20240519235122.3380-2-jarkko@kernel.org>
	 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
	 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
	 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 08:33 -0400, James Bottomley wrote:
> On Tue, 2024-05-21 at 10:10 +0300, Jarkko Sakkinen wrote:
> > This benchmark could be done in user space using /dev/tpm0.
>=20
> Let's actually try that.=C2=A0 If you have the ibmtss installed, the comm=
and
> to time primary key generation from userspace on your tpm is
>=20
> time tsscreateprimary -hi n -ecc nistp256
>=20
>=20
> And just for chuckles and grins, try it in the owner hierarchy as well
> (sometimes slow TPMs cache this)
>=20
> time tsscreateprimary -hi o -ecc nistp256
>=20
> And if you have tpm2 tools, the above commands should be:
>=20
> time tpm2_createprimary -C n -G ecc256
> time tpm2_createprimary -C o -G ecc256
>=20
> James
>=20
>=20

Testing on an arm64 platform I get the following results.

hmac disabled:
  time modprobe tpm_tis_spi
  real    0m2.776s
  user    0m0.006s
  sys     0m0.015s

  time tpm2_createprimary -C n -G ecc256
  real    0m0.686s
  user    0m0.044s
  sys     0m0.025s

  time tpm2_createprimary -C o -G ecc256
  real    0m0.638s
  user    0m0.048s
  sys     0m0.009s


hmac enabled:
  time modprobe tpm_tis_spi
  real    8m5.840s
  user    0m0.005s
  sys     0m0.018s


  time tpm2_createprimary -C n -G ecc256
  real    5m27.678s
  user    0m0.059s
  sys     0m0.009s

  (after first command)
  real    0m0.395s
  user    0m0.040s
  sys     0m0.015s

  time tpm2_createprimary -C o -G ecc256
  real    0m0.418s
  user    0m0.049s
  sys     0m0.009s

hmac enabled + patches applied
  time modprobe tpm_tis_spi
  real    8m6.663s
  user    0m0.000s
  sys     0m0.021s


  time tpm2_createprimary -C n -G ecc256
  real    7m24.662s
  user    0m0.048s
  sys     0m0.022s

  (after first command)
  real    0m0.395s
  user    0m0.047s
  sys     0m0.009s

  time tpm2_createprimary -C o -G ecc256
  real    0m0.404s
  user    0m0.046s
  sys     0m0.012s


Regards,
Vitor Soares

