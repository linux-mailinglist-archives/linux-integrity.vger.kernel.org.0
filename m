Return-Path: <linux-integrity+bounces-9416-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBBcMZAH+Wnx4QIAu9opvQ
	(envelope-from <linux-integrity+bounces-9416-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 22:54:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 318844C3C83
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 22:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61BAE303A121
	for <lists+linux-integrity@lfdr.de>; Mon,  4 May 2026 20:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C677F3264FF;
	Mon,  4 May 2026 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Otqq3Ojv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A531DDBB
	for <linux-integrity@vger.kernel.org>; Mon,  4 May 2026 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927924; cv=pass; b=UGKvVKB0eQw4A0V3GAvrM74JRzHFN/xw7TpBi/ZJahjBsyAdxT/jC2GxA4nUSZOAMjD2ZgpllzLMNKWowdo/zUZ7QY/uBKX7QEYrk2skLfIv7cvZN6aeYypK2ZSl1fN9APIgBiqpcP1hWIqneM7/ZJdbqhRQlL4CqJGopkIWZ60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927924; c=relaxed/simple;
	bh=tJ66m+Ap+y9oidCE5FFl7LELM0PChA2R+pYpwfkimac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cra8CcEzkBM+2pTVcmf/PEC3nIwWGbxoJ1qXBJpmKGwejxK4Csn3ankKFQO0KfZjvfSnOdDdclH5btzW7x56gDJet4z8G6N2XkSVxeR9SXUmXa1Q8+puWVNWsaqaY47RZqaryB0/6mH3lxascBHv30pEQOnZYmqawhvk0VUyw+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Otqq3Ojv; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8296d553142so3406070b3a.3
        for <linux-integrity@vger.kernel.org>; Mon, 04 May 2026 13:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777927920; cv=none;
        d=google.com; s=arc-20240605;
        b=ME32IWxXMYjBBhBWY7bL+OZRCUGa9FvsKndFMdv2mXnqZq4axUjjYNUBYWaeRyUtYF
         NDM+L3fyHHZmwAM2GAOsvNJGsa5TGiv8b7SJ1SAgouSFubbjHWZF9P+1d5fZ9noitTg0
         ELcI5N/a0SxHPYaJlVG64SwMT4By9u3zzyAp1EmXrBY7zKljFQatAqF7XnjIIBA9q+dz
         j/3CBNnuN5Zw5/3nLtcRcN7TjD3enGLoNZO9z+6OWg0yJbBaI77q/IMyDgTViYWRL6ET
         d2WjOJ8lZn7YkfsxSmMT2ZyPJwChz46eVju+Bvzduf2XmILVLYQBYr+n6ooP9gfHKBlT
         SOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WJ2eAXPYNTEsOYZ4v8rz7h3jNo4Zy8g4wcsmv8Syleg=;
        fh=E4XeySrBvfqfKOnJ27w+EGiV6wKsJvxzI+IC+JXjiz8=;
        b=NI2WLhoIHlcSt4fciE2jjsA/fW9bthIiISZzmy6AzThc4yd5dyFd0J73mtLiIeQ1tg
         ihnn/y4b4/+7H/0+cVzWm1dvlq6uzhElOr2TSZXNYQK0R3naXPg0RnYvUiOSuE5EJHy0
         fM6f1PRT8NGdJo6gdzehks5jjnHewQO8OKx94oEz0HuBZXCQfjibVq5ry7tCJujyT+I4
         2+NcmtyJMZO55AJnclZ1F9zFtfPA6pRCud0bF9A0f1ufspQmYQ8NY2A74iOh48OhR2p6
         eFa80FUwWGP71Bse5jy63ebBgrN1Eg1XweQpHrzkFaA5WOvPwpRjHwItaDBuKDHuG1fc
         CBaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777927920; x=1778532720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJ2eAXPYNTEsOYZ4v8rz7h3jNo4Zy8g4wcsmv8Syleg=;
        b=Otqq3Ojvcxo+9zA+e3PF1kUEatfZzLGdq8AVTu9c+5mxLKNjyMPWUA0ayS13IjGn8q
         3Z0MU8AQM4yJ08YDclMRA0aKZXXHzq0Pc6x3K5fbzA3qB61pVCrilwpMr2mDHR8Ib2Lg
         QXKYiLrTI3avxcRSPOnP7b0wIhMdymrRlKy255GCA+VEOfq8qITc/6dCIeRrGiTWyDPh
         q0sCHQfWvRfD2XqsaJvWwPin1kqldAkinns5rOvr8liFiNCqC9z64hXdODfW66dxi2Cu
         l27dOM2LY2QmLNzximRynb4tnY/O1Wg1BurWQBY+wr7KGSnbVYHVQhn9sZF3OJYtjxxA
         abPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927920; x=1778532720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJ2eAXPYNTEsOYZ4v8rz7h3jNo4Zy8g4wcsmv8Syleg=;
        b=lW4OUS+G1C7cAUfqNvGZuLewUg8ZhXskQY2ao4jNEh+3i0X0IO9R/x6ufKHB+FEF09
         rJtTvNUn36PAqDIrRPajXI0kHd9FtFjpPMJqFl2pZkV6HKfWVzPuc/dEH4KQLcoECcne
         OUHgKc9bNXOH8SUVHNkF6cu8xhkF7P5XSosJMD/orWbuklpQudkcP0EmHhJCDbaOUYNF
         2WtnBY5XCwfZIvihS+m6U0Mtw4WFAH6fT0vmaoszDnqu14CW2FFCEDvzAtgXAHdcCanQ
         4zQ/uMa0ikb6SuE3KMT5AqWnjjh9+xl0VbpUlxe150m5A+eB4+oFh5NeSvN1Ds0GSxMC
         zLNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9N2z/Eh88AfViD08poIGahc42WKz7lXGq5nf3FSbC8vaOJXZNOhELYe/nacTkJzeAHyhIFz6J5B3i7MmxGryg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC8aTYs16/jRJfobocKym3jj3oSP52xr21QvtLg8tiGogE+n65
	vxfuJOs/gcK/TG7mjsLSeIqdS57lJgBPLi5mBlFogZ5UNMHNqab9HIUfTiy5ak0hQ1RgmeVBZhO
	arRmIhdtOgDHRiq2ICiLxeEJaPRnSvryRabXX/8Jr
X-Gm-Gg: AeBDievROJCrWLbkuJqoO2KCQZshkNRQa4g6JI5yPHFQf793DX1+zxEt3QL3/18zQ3+
	dpEoP8APAOBBtMFBWxng+/Bk60kgDD1YG+ckgAJMoSyVk8JoO/6gNNhkPw7udmNmXIQ4UtDfQqv
	C2hBaNnp+h0QUA8eQ8Z8/UbITx5d2g28XQ4XNBa4T0rl6TzTiurZ/ymMmMRJHrE4RTAWIn87sse
	hFy7n9y4a59VRrqmpzxFKBHLkHp8wEpPA0AZv1DbXJkGwJ1PhibbzSBMGN60Slw3PihvWim8M0d
	ZVsEqSBE5CfnKSvcfQ==
X-Received: by 2002:a05:6a00:430a:b0:81f:852b:a925 with SMTP id
 d2e1a72fcca58-8352d03bf06mr9580368b3a.1.1777927919687; Mon, 04 May 2026
 13:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777036497.git.noodles@meta.com> <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
 <afMlgstqahnZg68h@e129823.arm.com> <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
 <CAHC9VhRsnmPp2KmQAns5uq5qXX5EF2xQQzyfTgrPi4O9AXyPpg@mail.gmail.com>
 <ba4bf28314b679474a6a8da6298e548e54b3754c.camel@linux.ibm.com>
 <CAHC9VhRE2kRr1fdDf6xgQgpSrtvqtP8Vy9LVGJhDZFUbzLKGmQ@mail.gmail.com> <ff28c6dcb60c357c752724927addaa8c4fd3bf2c.camel@linux.ibm.com>
In-Reply-To: <ff28c6dcb60c357c752724927addaa8c4fd3bf2c.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 16:51:48 -0400
X-Gm-Features: AVHnY4Lr6yzqiFvtxlogRXd7Q0IQ_OqPkojIvu5hlaN_AhoE9caMVXM731mJvc8
Message-ID: <CAHC9VhQY2TMkTvQq9P8oZteQWQSr7qq2utOuH+pdVx+8jWLBCw@mail.gmail.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell <noodles@earth.li>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, jmorris@namei.org, serge@hallyn.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jarkko@kernel.org, jgg@ziepe.ca, sudeep.holla@kernel.org, maz@kernel.org, 
	oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	noodles@meta.com, sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 318844C3C83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9416-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[arm.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Mon, May 4, 2026 at 8:03=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Sun, 2026-05-03 at 12:46 -0400, Paul Moore wrote:
> > Regardless, assuming you always want IMA to leverage a TPMs when they
> > exist, your reply suggests that using an initcall based IMA init
> > scheme, even a late-sync initcall, may not be sufficient because
> > deferred TPM initialization could happen later, yes?
>
> Well yeah.  The TPM could be configured as a module, but that scenario is=
 not of
> interest.  That's way too late.  The case being addressed in this patch s=
et is
> when the TPM driver tries to initialize at device_initcall, returns
> EPROBE_DEFER, and is retried at deferred_probe_initcall (late_initcall). =
 Since
> ordering within an initcall is not supported, this patch attempts to init=
ialize
> IMA at late_initcall and similarly retries, in this case, at late_initcal=
l_sync.

Okay, so from a TPM initialization perspective you are satisfied with
a late-sync IMA initialization, yes?

--=20
paul-moore.com

