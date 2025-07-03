Return-Path: <linux-integrity+bounces-6603-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7CBAF6B78
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 09:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F0E3B1AD6
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 07:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EA72989B5;
	Thu,  3 Jul 2025 07:26:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4843A298992;
	Thu,  3 Jul 2025 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751527563; cv=none; b=jJ7hKwbxv02rk1ofssC18L77GhYj5wNmr1VaZDIy/ex0g7k/5uhHWFFdUXDBsAEZICn63uIey6fcEmpcSQknBcQhhhEFXSPdBj2kiNQYFxuE2NKPToZTNoizfGfDZ6BDBSvRhbACkqdl46sYuZ+uzhUyeK8U4qvWOvBf+xI1Vag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751527563; c=relaxed/simple;
	bh=qZiG4zQGXTT5x6dO83hm7UVqBecQ6/V8PRACW6DLJIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7CrGCSJvHmTFUETaGYKn5UA12mAge7+FtXcapIEMmmavYlysV+WRMKBMwzWoGVxgs0CiEGuJx14Kzs4Q9GQLNj3p7JCzomly/zaXBsDsm+pRICgvKJYEOQASPLQEdH1QOJe1rGqaTLdky/i+Gx8xGdFx+zOPdTKvbL/pi/WUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 5374FE81788;
	Thu,  3 Jul 2025 09:18:08 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 287DD16005E; Thu,  3 Jul 2025 09:18:06 +0200 (CEST)
Date: Thu, 3 Jul 2025 09:18:06 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: Re: [PATCH] Revert "integrity: Do not load MOK and MOKx when secure
 boot be disabled"
Message-ID: <aGYurikYK1ManAp3@gardel-login>
References: <Z9wDxeRQPhTi1EIS@gardel-login>
 <1a6cf2097487816e4b93890ad760f18fe750bd70.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a6cf2097487816e4b93890ad760f18fe750bd70.camel@linux.ibm.com>

On Mi, 02.07.25 21:40, Mimi Zohar (zohar@linux.ibm.com) wrote:

> On Thu, 2025-03-20 at 13:02 +0100, Lennart Poettering wrote:
> > This reverts commit 92ad19559ea9a8ec6f158480934ae26ebfe2c14f.
> >
> > This original commit this reverts creates a strange situation: it
> > ensures more restrictive behaviour if SecureBoot is off then when it
> > is on, which is the opposite of what one would expect.
> >
> > Typically, one would expect that if SB is off the validation of
> > resources during the pre-kernel and kernel initialization is less
> > restrictive, not more restrictive. But this check turned the world on
> > its head.
>
> Hi Lennart,
>
> I'm really sorry for the long delay ...
>
> >From an IMA perspective, the default is to only trust keys built into the kernel
> or certificates signed by the builtin keys and loaded onto the
> .secondary_trusted_keys keyring.
>
> The ability of loading MOK keys onto the .machine keyring and linked to the
> .secondary_trusted_keys keyring is an exception based on the assumption that
> that there is a secure boot chain of trust.  Allowing untrusted keys onto or
> linked to the .secondary_trusted_keys keyring, would potentially allow loading
> code signing keys onto the IMA keyring signed by untrusted MOK keys.
>
> I was really hesitant to allow this exception of loading MOK keys onto the
> .machine keyring in the first place.  I'm now even more concerned.
>
> This is not just an issue of being more or less restrictive, but of adding a new
> integrity gap when one didn't exist previously.

But we are talking of the case here where SecureBoot is *off*,
i.e. there is a concious decision in place that there is no trust
chain, and that the firmware *happily* *already* accepts unsigned boot
loaders/kernels and just runs with them. If SecureBoot is already off,
then an attacker can patch around in the kernel invoked at boot
completely freely anyway, there is *no* authentication done. Hence
it's really weird to then insist that the path into the kernel keyring
via mok keys is off in *only* this case, because an attacker can get
into that anyway in this case, it's just a lot more cumbersome.

It's really strange that currently when people ask for tight security
(i.e. SB on) the linux kernel is super relaxed and allows any keys to
be inserted, but if people ask for security checks to be off (i.e. SB
off) the kernel starts being super strict and doesn't allow any keys
to propagate into mok. That's really confusing and contradictory, no?

Lennart

--
Lennart Poettering, Berlin

