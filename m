Return-Path: <linux-integrity+bounces-6620-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B413AF89EB
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 09:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F604872EA
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 07:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8DA2857F1;
	Fri,  4 Jul 2025 07:47:14 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A9C282F5;
	Fri,  4 Jul 2025 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615234; cv=none; b=I2ykW4EfQUNT7CwnPHLEoBKZ2l52oRGAQv8hHPe+xqubn0F0TuOooIaMWq518ijBS929h0dedalJMP/+VbXB3n+iaLfjKEEFJUbY5b0+CuMtTJf31e/0ck82iQesXGIjkTnU9HhN8bFD43/Q9ElATLOxEqqiC8k0nWzqRla34iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615234; c=relaxed/simple;
	bh=f5bUyETWuLf21xHjox/tbacH4YnaGKFp9ktsm1YeJpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTZKQWBUid95ecls9Tt4BWQIcF00rIhhf3sljXyAe/iZKX/AYRotn3bXc6jws3NU9WZ7KjgALw/06f6WFJQHiRrR/vKXsbQZT6DAtfYzMinHnk7NsblTGgP+jRCGYVOK07in8VNz1BhOjUgPv2QU7Uu7r0Dj3/+AGBQzFbd+5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 103F1E81788;
	Fri,  4 Jul 2025 09:47:10 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 1F09416005E; Fri,  4 Jul 2025 09:47:09 +0200 (CEST)
Date: Fri, 4 Jul 2025 09:47:08 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: GONG Ruiqi <gongruiqi1@huawei.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>,
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
Message-ID: <aGeG_C2fcWqpgo1O@gardel-login>
References: <Z9wDxeRQPhTi1EIS@gardel-login>
 <1a6cf2097487816e4b93890ad760f18fe750bd70.camel@linux.ibm.com>
 <aGYurikYK1ManAp3@gardel-login>
 <8401c23009db3b8447b0b06710b37b1585a081ab.camel@linux.ibm.com>
 <aGZ_x8Ar6iwzt2zV@gardel-login>
 <c74b5581-b5a5-4f71-a4da-2cef73351715@huawei.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c74b5581-b5a5-4f71-a4da-2cef73351715@huawei.com>

On Fr, 04.07.25 09:30, GONG Ruiqi (gongruiqi1@huawei.com) wrote:

> > patch arbitrary keys into the ELF image of the kernel before starting
> > it, and everything will look perfect later on, because the image is
> > not authenticated after all via SB. So there *already* is a way into
> > the kernel keyring with this – it's just really messy to parse and
> > patch ELF at runtime like this from the bootloader. My hope with just
> > relaxing the rules on MOK keys when SB is off is to just make this
> > stuff cleaner and more elegant (and also to leave the ELF image intact
> > so that we get clean measurements, both of the kernel and of the keys
> > we add).
>
> Just curious: if an attacker takes control of the boot phase earlier
> than the kernel, then not just this check has no value, but any check in
> the kernel has no value, right? Anything that got loaded early enough
> could theoretically patch the kernel with anything on anywhere. So shall
> we just remove them all?

Measured boot protects you against that, as I explained: what we do in
our model is lock the full disk encryption to a key in the TPM that
enforces an local attestation policy: only if a all measurements match
that policy the FDE key is released to the OS. Hence yes, if SB is off
*any* code can run, but if it's not the right code then it cannot
unlock the disk. If it *is* able to unlock the FDE however, then this
is proof that the boot chain is in order, and hence the kernel can be
trusted, and it makes sense for it to defend itself from later steps.

> Certainly the answer is no, and they are still meaningful somehow and
> somewhere. IMHO I think the concern behind the check is reasonable, but
> the actual code could be an overkill. It would be better if it does:
>
>   if (arch_ima_get_secureboot() && ima_mok_verify()) // hypothetical
>
> , and in the future we could extend the ima policy for the boot phase
> chain of trust and perform the check here accordingly, i.e. let the
> users decide how things should go.
>
> While for the current situation, my personal advice would be to add a
> config to control whether or not the check is conducted. Let's call it
> CONFIG_LOAD_UEFI_KEYS_STRICT temporarily:
>
> #ifdef CONFIG_LOAD_UEFI_KEYS_STRICT
>   /* the MOK/MOKx can not be trusted when secure boot is disabled */
>   if (!arch_ima_get_secureboot())
>           return 0;
> #endif
>
> so that both sides are happy, and we can think of more fine-grained
> verification methods, like the one I said above, for the strict mode
> afterwards.

Having an option for this would be better than nothing of course, but
I seriously wonder what the value of the check is supposed to be at
all. SecureBoot=off tells the system: hey, please accept any boot-time
resource without validation, and firmware and boot loaders honour that,
but Linux then does the opposite, invents some artificial checks not
even done if SB is on!

I mean, a boot trust chain means: trust what comes before, and
authenticate/measure what comes next before you pass control to it.

But for some reason Linux makes up a different model, where if told to
not authenticate it suddenly doesn't trust half of what comes before
anymore, but the other half it does. And that's just bogus, and
illogical.

Lennart

--
Lennart Poettering, Berlin

