Return-Path: <linux-integrity+bounces-3131-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D05C932808
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 16:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2198E1F2300E
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533A119AD71;
	Tue, 16 Jul 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCD/672z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8D4D8A3;
	Tue, 16 Jul 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139152; cv=none; b=f5wby31T4DYL0/gVF0SEPZomEOQFLQhTywm2vn3ZdAE/QxgLWnSYdAjZK9vsCyUkeFgPE6e9lPLH1SpnjAMxf5kwNKhF4gdah5sB9nXFze9ubn9tzBd3z4Kbv5LHepJbszT8+vwx14t1vsQ60vwu/jjSnnZqNG1HFKcHoh2d8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139152; c=relaxed/simple;
	bh=JVm8U+sG/TsLjrRayyuXqEG/Fw+2Uf8ktDyVz0CtjwE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=V1p8rWzyibskP+7va1ZbDKZa7wB32bnG823BUh12bwaB8DdCo9ffr74fz/Kc7jR7riYFkzIaOUDtdcEyVzN3mmWh8D8+IuyPROVzskBUEVD6QukCwIUd5l9ftatACtFKZv/ySkukllc8frXJuZ/SroN8iVv04iCKoR40NNJbbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCD/672z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4F9C116B1;
	Tue, 16 Jul 2024 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139150;
	bh=JVm8U+sG/TsLjrRayyuXqEG/Fw+2Uf8ktDyVz0CtjwE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=SCD/672za+BMIiAL7n3xsDJL835vt2mktw+NWd6l1aEiw2SHaxz/swONg0KnhDOJP
	 BxtY4GlDuzQwbtsxjLDq53teXVdgg0t88Fmtoh38rwW+6vhXgum2N6X5HOmabl+eXL
	 fTBH9PTDFhAHL0f/9tA0zl3TWDgkJ8EyP2cATVAPB0oRToB9BmYq4g658rIq+g97Y2
	 /KIbZfNmK0ukD/ubwA3lGJEw7qzbjGWM8oFno0tfL4QtBXC2m0+rc5LyCBhaUVV2jT
	 +5zydXoaB2ygclNQirbBqncaXlKdeO3llRrugeK5bqmoV2Arv79J/7gjIaebuY7NVL
	 eXGkYcEdPSYKw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 17:12:28 +0300
Message-Id: <D2R0WP82K6MI.5B2XEV90M0VB@kernel.org>
Cc: <keyrings@vger.kernel.org>
Subject: Re: [PATCH 2/6] tpm: add policy sessions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
 <20240524130459.21510-3-James.Bottomley@HansenPartnership.com>
 <D2QXYCVI47RK.GFOY8SNQHWW2@kernel.org>
 <D2R0SSS449F2.1CSVCMJ39S3LB@kernel.org>
 <D2R0TZB6I6Z8.1R0YSFP46LXPF@kernel.org>
In-Reply-To: <D2R0TZB6I6Z8.1R0YSFP46LXPF@kernel.org>

On Tue Jul 16, 2024 at 5:08 PM EEST, Jarkko Sakkinen wrote:
> On Tue Jul 16, 2024 at 5:07 PM EEST, Jarkko Sakkinen wrote:
> > On Tue Jul 16, 2024 at 2:53 PM EEST, Jarkko Sakkinen wrote:
> > > > -	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
> > > > +	u8 name[AUTH_MAX_NAMES][2 + HASH_MAX_DIGESTSIZE];
> >
> > Ouch, we definitely do not want 2-dimensional arrays. I missed this in
> > the hmac review.
> >
> > Why this is based on count (AUTH_MAX_NAMES) rather than space? Is that
> > value from the specs?
> >
> > You could just as well replace name and name_h with a single tpm_buf
> > instance in "sized" mode and return -E2BIG from the functions that use
> > it. Right, those don't return anything but void, which should be also
> > fixed.
>
> tpm_buf_write_u32()
> tpm_buf_write()
> tpm_buf_write_u32()
> tpm_buf_write()
>
> Two buffers stored. The read functions are non-destructive. Let's not
> invent ad-hoc crap when we have already a tested and legit tool for
> this.

Other issues that I saw is that the patch set does not apply anymore but
it is been two months so no wonder.

For the next version you should also specify a test transcript that
allows to test the functionality similarly as I've done for asymmetric
keys:

https://lore.kernel.org/linux-integrity/20240528210823.28798-1-jarkko@kerne=
l.org/T/#mb07f85a8c3f4af388cbc08438e71ac8aea447d85

I don't want to invent the test case myself, and very few will do
I'd figure.

BR, Jarkko

