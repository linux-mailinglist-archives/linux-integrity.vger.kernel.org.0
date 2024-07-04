Return-Path: <linux-integrity+bounces-3003-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFEA927BD6
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 19:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD811C22969
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 17:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C672E3F7;
	Thu,  4 Jul 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Fl/0hM+d";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="oolnUM2r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF523746;
	Thu,  4 Jul 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720113685; cv=none; b=i/nxVi+/0dE6WiuPGzrUVb+vHghfUiyPF8k2p9Irl2z76BQY4N64W6tUWdtcKCN8+UfxREbzY9MhqUgHEWyWx+nr6DfU1qkeQgBKbApt9pqNGulgQqZpi+Vowr108fsP9n6j2HFwUDb/BV0BRnK80Z0o01DlOwgZvGsxLHDBrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720113685; c=relaxed/simple;
	bh=vJQzy0Q8OJqhIkEv+KaZBm3Uu+AYIen7ID7ZraKwjrw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RU/Sb7NgHaQ+UDsxbJjKRb2/WOnjzjeu3FEbINIjTYRfAnpftIhfyLfqRkzIWfzRQuvhqJ711giAl3BsfNUwQ33bsZF9l4bmFU5R/LwVxnayA8WV2mrjzBBwwy6lhZ1EID85QfsyPv6ch+6C2KLZ6FUA+Is92Qm20OA4jF5cynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Fl/0hM+d; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=oolnUM2r; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1720113682;
	bh=vJQzy0Q8OJqhIkEv+KaZBm3Uu+AYIen7ID7ZraKwjrw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Fl/0hM+dyGxr2Yx8FXgJfkWl0SRN6cXS3oFKNuikyK98zMSF6ym+UWILzwqixD+6I
	 goE892ezUMpVuy7scQW7C+21UgoIlnb/4LIB/y7fC3bJuNbcUZLIUzz3UEbc0yYQLh
	 XuPKtfhYITQ2rWcfZTO2gZrYDHIrYbw9Q+OB5PZs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4E4581285E26;
	Thu, 04 Jul 2024 13:21:22 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id L7KcQKRYgeQI; Thu,  4 Jul 2024 13:21:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1720113681;
	bh=vJQzy0Q8OJqhIkEv+KaZBm3Uu+AYIen7ID7ZraKwjrw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=oolnUM2rI+9SFsFDREg7z10HYlvicWDoBXwbBZmtyyrOblh5z8GoLfD3JPxhH1eoN
	 YbtH0EezP7acAQ6kWzE8vy+D5f7UAi7fp4o0TGZqWiomfPggJsk3e5yoho3m5ktAJo
	 WuRsG6GMPF9VVf7iZx/y/IErMiRPQ+sso8YsULsU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 53BF51285E10;
	Thu, 04 Jul 2024 13:21:20 -0400 (EDT)
Message-ID: <91ccd10c3098782d540a3e9f5c70c5034f867928.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/3] tpm: Address !chip->auth in tpm_buf_append_name()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
 Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org,
 Stefan Berger <stefanb@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>,  David
 Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>, Ard
 Biesheuvel <ardb@kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Thu, 04 Jul 2024 13:21:18 -0400
In-Reply-To: <CAHk-=wiM=Cyw-07EkbAH66pE50VzJiT3bVHv9CS=kYR6zz5mTQ@mail.gmail.com>
References: <20240703182453.1580888-1-jarkko@kernel.org>
	 <20240703182453.1580888-3-jarkko@kernel.org>
	 <922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com>
	 <CAHk-=wiM=Cyw-07EkbAH66pE50VzJiT3bVHv9CS=kYR6zz5mTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-07-04 at 10:07 -0700, Linus Torvalds wrote:
> On Wed, 3 Jul 2024 at 13:11, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > if (__and(IS_ENABLED(CONFIG_TCG_TPM2_HMAC), chip->auth))
> 
> Augh. Please don't do this.
> 
> That "__and()" thing may work, but it's entirely accidental that it
> does.
> 
> It's designed for config options _only_, and the fact that it then
> happens to work for "first argument is config option, second argument
> is C conditional".
> 
> The comment says that it's implementing "&&" using preprocessor
> expansion only, but it's a *really* limited form of it. The arguments
> are *not* arbitrary.
> 
> So no. Don't do this.
> 
> Just create a helper inline like
> 
>     static inline struct tpm2_auth *chip_auth(struct tpm_chip *chip)
>     {
>     #ifdef CONFIG_TCG_TPM2_HMAC
>         return chip->auth;
>     #else
>         return NULL;
>     #endif
>     }
> 
> and if we really want to have some kind of automatic way of doing
> this, we will *NOT* be using __and(), we'd do something like
> 
>         /* Return zero or 'value' depending on whether OPTION is
> enabled or not */
>         #define IF_ENABLED(option, value) __and(IS_ENABLED(option),
> value)
> 
> that actually would be documented and meaningful.
> 
> Not this internal random __and() implementation that is purely a
> kconfig.h helper macro and SHOULD NOT be used anywhere else.

I actually like the latter version, but instinct tells me that if this
is the first time the kernel has ever needed something like this then
perhaps we should go with the former because that's how everyone must
have handled it in the past.

James


