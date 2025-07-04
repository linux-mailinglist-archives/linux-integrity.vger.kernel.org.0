Return-Path: <linux-integrity+bounces-6616-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B47AF8995
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 09:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B043A63A5
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 07:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D82A27D77B;
	Fri,  4 Jul 2025 07:34:54 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B83D76;
	Fri,  4 Jul 2025 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614494; cv=none; b=G2PcufFNhNuEBvs3C8KJFY0z3AyvIuxWL/V5aerovnPbK2ctpWzUZsP0qAo0ubqPhffZ0BgMgcbLALHt3wAXND6gT7Wrbcu3VGkWC3eFIvYkc6m6wI+D2r3RDkSgWqztbYK/REiZg0vGa9jwdcDBi/Zoybyk2XiVlQvx9Cm1rPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614494; c=relaxed/simple;
	bh=/hl9HDUls7N81viQPs/KKr2is9V1xf9Nb8v1sBRpp+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEU9XIp0GMnLg2Zfz8DFPf2/GB3bBQmev/bISQg6AJXd2advXk2fcxNzTUP9CaBWjBIoQ1JiORrJJmpQ6T4+64fFQsVm4f5vv6F2KVTTUva1gQ/NKRr1GXN6HjLYvKL6d11N9dqYAUl7plDAT1ED/7W4CzhqLQUJPWNEdeKc204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 074B6E81788;
	Fri,  4 Jul 2025 09:34:42 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 3F58E16005E; Fri,  4 Jul 2025 09:34:35 +0200 (CEST)
Date: Fri, 4 Jul 2025 09:34:35 +0200
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
Message-ID: <aGeECyNqSQoIP7d2@gardel-login>
References: <Z9wDxeRQPhTi1EIS@gardel-login>
 <1a6cf2097487816e4b93890ad760f18fe750bd70.camel@linux.ibm.com>
 <aGYurikYK1ManAp3@gardel-login>
 <8401c23009db3b8447b0b06710b37b1585a081ab.camel@linux.ibm.com>
 <aGZ_x8Ar6iwzt2zV@gardel-login>
 <45b30f515efc3e364e1d248ab0ed7f12f8312f5d.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45b30f515efc3e364e1d248ab0ed7f12f8312f5d.camel@linux.ibm.com>

On Do, 03.07.25 19:56, Mimi Zohar (zohar@linux.ibm.com) wrote:

> > Yes, we have that in systemd: there's local attestation in place
> > already in systemd via the "systemd-pcrlock" feature. i.e. the idea is
> > that the disk encryption keys are only released to the OS if the
> > measurements of the boot phase match some golden measurements. This is
> > in a way a reasonable alternative (or addition) to SecureBoot: instead of
> > prohibiting code to run if it doesn't carry a signature of some
> > trusted key, you let it all run, but then later on you refuse to give
> > it the disk encryptions keys – the keys to the kingdom – unless the
> > measurements all along the way match what you expect them to be. This
> > protects the OS quite nicely, and makes SB to some level optional, as
> > we basically enforce security "a-posteriori" rather than "a-priori" – by
> > means of the TPM's key policies.
> >
> > Now you might wonder: if we have such local attestation policies, why
> > do we *also* want to get keys into the kernel keyring? That's because
> > the attestation policies are checked (primarily) when FDE is unlocked,
> > so that's our security boundary, our milestone where eveything
> > *before* is protected via attestation, but which cannot protect
> > anything *after*. In my model we then want to protect
> > any further resources via the kernel keyring then. hence it matters to
> > us to have a clean, elegant way, to insert keys *before* that
> > milestone that then can protect resources comeing *after* it.
> >
> > Why do I want to avoid SB at all for these setups? Mostly, because
> > it's a bureacractic effort to get your keys intot he Microsoft
> > keyring, and if you do get them there, then their security value is
> > kinda weak anyway, because the allowlist that the keyring is is such
> > an extremely wide net, it's at best a denylist of bad stuff rather
> > than an allowlist of good stuff at this point. It's kinda undemocratic
> > too. But anyway, the pros and cons of SB are another discussion. I am
> > primarily interested in making it optional, so that you can get
> > security with SB and without SB, because you always have someting to
> > protect the boot, and always something that protects the rest.
>
> You're basically relying on trusted/verified boot and, in TPM 1.2 terminology,
> sealing a key to a TPM PCR value.  Only if the PCR matches an expected value is
> the key released.  Instead of relying on MOK, the keys could be stored in the
> TPM NVRAM and loaded onto the existing .machine keyring or define a new keyring
> linked to the .secondary_trusted_keys keyring[1].  Then you could really claim
> the TPM as a new root of trust for both trusted and secure boot without any
> dependency on MOK.

Hmm, why involve the TPM in kernel keyring population though, if all
keys in question are vendor keys used to sign OS resources, i.e. not
local keys? It's entirely fine to ship these keys along with UKIs or
boot loaders, and in the model where SB is off they are protected by
the measurements that are done of both boot loaders and UKIs.

And what would even install the keys into the TPM in the first place?

Also note, that while a TPM can store keys, the way it is designed is
that you actually store keys outside of it, but wrap them with the
SRK that is the one you do store on the TPM. This in particular
matters as people might want to boot kernels of multiple vendors at
different times on the same system, and hence the keys for that should
not be sticky in the TPM.

Sorry, but storing keys in the TPM for this is just wrong for my
usecase.

> That would be preferable to changing the existing expectations to loading the
> MOK keys when secure boot is not enabled.

Sorry, but I vehemently disagree, that's a really broken security
model. SecureBoot on should mean strict rules and, SB off should mean
relaxed rules, and you are doing it in the opposite way.

> [1] A prior attempt to load keys from TPM NVRAM.
> https://lore.kernel.org/linux-integrity/20210225203229.363302-1-patrick@puiterwijk.org/

This seems really strange to me, as no policy is enforced on the
nvindex? The TPM is not a magic device that sprinkles "trust" magic
dust on things: you have to define your objects with a policy that
locks down access based on attestation, pins or other stuff, and it's
just not obvious what that should be here for such a kernel keyring.

Sorry, but this all seems backwards to me: what you propose weakens
the current model afaics, and you insist to be strict in the case where
an explicit request has been made to relax things by turning off SB.

Lennart

--
Lennart Poettering, Berlin

