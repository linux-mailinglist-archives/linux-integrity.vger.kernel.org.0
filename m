Return-Path: <linux-integrity+bounces-9326-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OapK3LP62nfRgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9326-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 22:15:46 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D18463246
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 22:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8304300611C
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 20:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F33F30E853;
	Fri, 24 Apr 2026 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Lrk3+Dyh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E0378815
	for <linux-integrity@vger.kernel.org>; Fri, 24 Apr 2026 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061744; cv=pass; b=AyguXta9zB1nPaLvEMSL2nq67DXeyQlZXCa+14d+yq3UVUVzuKc7uQeWgpc/860JovQogJWP6tRGrTnETUQafF1FPTthr+romkF4RRLJ5eO5GP7vN2o+PTqzK08W5Z8z/0PTy+1z8nC+ewa58EEXG5yUFnjDlVgjBht72bsl8eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061744; c=relaxed/simple;
	bh=Vbb/QbHuW7LGihD/Z5UNc4YCg0mP3LbwRcOYR2R1TWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKAYTmUmpDK+0UIc2xhdFeb4b6FMUZSln1oPMW/gLHHuJ3kQ6I9pHoksUePlERY6VIv0lr89sW4xgmF1hAUdq59S3eBIJm8i+D+BaJ4PTZA2snQKfZB1zALQiR3gBD6IUFyTpzvMbgfSXujLo9tMIbv+iU+25OE94+HVWEgS4yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Lrk3+Dyh; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad4d639db3so42046935ad.0
        for <linux-integrity@vger.kernel.org>; Fri, 24 Apr 2026 13:15:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777061742; cv=none;
        d=google.com; s=arc-20240605;
        b=Z71I/jtZc7LZPLbph90PJznHVhsES9UpWdTVmM7p1uInjnEVEAN5rhbAI9M/D0YwHI
         1W18n+mWH+Z7TDtx1VnmsMDBnpOOv+Mi3veDSfxpsXFH3cRduNkuXvfRJRsCKGjOKBfe
         2IdrVjjCBl2Ob1PDDMc5MNOcpSlSELcRitllmPTEqYWdHVnGt3eZyuIX6WbiXj7W8+Gw
         mesFEkDgDQO7AJmUGPuKkGI6yb/wYpCBO+z56aEAS07bTMNmBd6KyCeYLQrg/P7pLr3z
         kEhIp0J/cwZKRhtlYI/iGYi7V6xZSFcRdde55/QfCIUQURbXgh2gZ7IKB0XQB1iSwjty
         m5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sp92EwCFMmdCctd+G8p5NZ1F+m0+I8XgaVk8fcD+2Os=;
        fh=V2fE1/Icx2aOftNi4usmGtrdXnnzTlYOzXYAp4P5hKw=;
        b=QUiRpqudqrHJgSPuNd8B8Mm2OFWNNigYOwPdjiMXPEhLBhXKnpKp2F6Lw8DWewtIhd
         uD/HdBvFJJABA5Xlh/ND4AOgoyS0uQaSKCHEQvw5ceWfhvVE58kOYUxqJ/twvDal3p0Y
         +MlzTaoGThCV3zEyOVwOZOilO0iU393Ek9P9kZjGA8s6KCNCwWcv/dxhC+zjpQ457A3D
         hC4bD4nEPAEFC0zDllwmozze6Y3CQp9VwRJytCxDb4vHAS3978M7meBBRsdL7AJKbjGt
         pgLgRAI7CiHmOVHyMOWowOWz0lzzFJYfETvrn4d4gupt7hN8u0hrUMtVWuAf81glwwoy
         Umbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777061742; x=1777666542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp92EwCFMmdCctd+G8p5NZ1F+m0+I8XgaVk8fcD+2Os=;
        b=Lrk3+Dyh2N6zYAjXOqDaMBkh1DH1fZBTh1nBQ72Y3OP2cJmx95Q9G1T2ozsvaMbDIR
         czgEEnJYPmVyEEHEkDYAv+JOZ0qCim8IVfdOIb2e30B+9VO9j5Z/O09Ll1Fx2vDvicwO
         B74VIXYM+6kyBdIjnE10sv3TopUlU+LpG+Be/Y79LrgrWUfTlwCf2muQ/cWTL/ozGE/h
         9pHR/bhqwyKtlJD7fsEFClyMu52t3GbJQ41/9v88BtQ83JPPO5CbizduYWzrnYHxZlXO
         G0JrvAGhSxZVBCFcZWdUdKzvAKY0qYo8FS3sLaY94xlKHHnTwjd9nRf160WW/Pwp3sgC
         Bhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777061742; x=1777666542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sp92EwCFMmdCctd+G8p5NZ1F+m0+I8XgaVk8fcD+2Os=;
        b=fNEdeExFsVDCHzDa0E10zW9gIIVr3PTFTOJrHEbqtkIVcilgDGSy8Hkl9ZzHIDBNsb
         6IJWw9tyLtnUkRqbgzejUzZT3lFbIzyY/ZsH0gnh0uLYfRPtobGLKWBjsiBMKxGg1jAW
         693EgiUU4FT39I7y7TVPSLxSnbAsGnpXiOla8YFxIZJrjOXqvtmUbCGB7dwmEopbOyWH
         Ktc3n40RPeMmXwUX0uyr19tIEwlxtiEBwUm+YB/w97N2IJPk2KgwBDj5tABku9wKO6KE
         mOAYxfvXJMt/WuU9lYFXDMqtUk6H6YB+2fkGFFxwllrmZAqtBqKxo9Eer09Lc4tHWn5m
         pCUw==
X-Forwarded-Encrypted: i=1; AFNElJ8fZ0+s0MhkmQAg4ND89moqilAUY4q8FWB2rtTwzz1lsaYmlMjRs+C7LsQSyNOxowCAbYByUMm8YWtvysBP3GI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+Cdg/qhzJGVfRqmnAi4hI7zZGMtSVj3YhClczIwTBGXMCXiw
	8AXEhODE+06yPMuGpkakis/to0XtRjElZg6s8SwtoafM9bf4rDJRm8YY973V49ldM4KORF4tlAk
	4Z/M8QdmJUVFab0kXAlQWeC99BS5IOMztcCmVpyad
X-Gm-Gg: AeBDievZQB6+IXw/MRk/iSc4PV7XHptegkEHv39t5qGR9o0n6MvR9tJHyfv2nlkfYvP
	jCfdZeJcfqkkYlcugTOu0vBQHRx1S7u13o4I1z6VpBdzkDXv8NL1o/6mFo0dgnwB93uTvCuAlfO
	uxE8xxWuW30lDu0n3Qf0alHb3Q/mm6/XxfQwiwSd9gfvMBzpTmLPRu/bxWU/hlZ2xOBUKlvqX+d
	LGgvGli0zeBsIOUklDzf9ma/4PFKsNTtBRnlufz53weoYjFFmG8aUAiGdWagpc4QbMpTatN48QS
	Scv7eZ1I4SS0zWUEVA==
X-Received: by 2002:a17:903:883:b0:2b2:9f45:2266 with SMTP id
 d9443c01a7336-2b5f9f8302dmr254143155ad.21.1777061741644; Fri, 24 Apr 2026
 13:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeoAlVEwzRUPrlVe@e129823.arm.com> <aeoRxWPyOHGJd+Jh@e129823.arm.com>
 <aeoWO2Cwo04YYu2l@earth.li> <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
 <aeokwrC86WI7uT+K@e129823.arm.com> <aeomlp3I0eVE5mce@earth.li>
 <aeotq8nPVu4wvEx5@e129823.arm.com> <e4e242ae5533d5762a3647186a178764881bf9ff.camel@linux.ibm.com>
 <aephL3MzYoqFGaT5@e129823.arm.com> <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
 <aesGU8a3mbVzvteH@e129823.arm.com>
In-Reply-To: <aesGU8a3mbVzvteH@e129823.arm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 24 Apr 2026 16:15:29 -0400
X-Gm-Features: AQROBzD85SjPMTZ-_HyOS5lMf1XvZbjXC0wu_RfpvlwIboP78qicPJqw2hn2ACs
Message-ID: <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
To: Yeoreum Yun <yeoreum.yun@arm.com>, Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com
Cc: Jonathan McDowell <noodles@earth.li>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca, 
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com, 
	sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 58D18463246
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9326-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,huawei.com,meta.com,google.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]

On Fri, Apr 24, 2026 at 1:57=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
> > On Thu, Apr 23, 2026 at 2:13=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.co=
m> wrote:
> > >
> > > Sounds good. Once the patch is posted, I=E2=80=99ll review it as well=
.
> > > Sorry again for the noise, and thanks for your patience ;)
> >
> > My apologies for not getting a chance to look at this patchset sooner.
> >
> > This seems like an obvious, perhaps even stupid, question, but I have
> > to ask: if IMA can be properly initialized via late_initcall_sync(),
> > why not simply do the initialization in late_initcall_sync() and drop
> > the late_initcall() initialization?
> >
> > Does any IMA functionality suffer if initialization waits until
> > late_initcall_sync()?  If so, it seems non-critical if waiting until
> > _sync() is acceptable, as it appears in these patches/comments.
>
> This is the way first patch did, and here is some discussion for this
> (Might you have seen, but in case of you missed):
>   - https://lore.kernel.org/all/a6a0e15286c983d720de227c6827adbe976c5b9b.=
camel@linux.ibm.com/

Thanks for the pointer.

Unfortunately, my concern remains the same: it's either "safe" to
initialize IMA at late_initcall_sync() or it isn't.  Attempting to
initialize IMA twice seems both odd and wrong.

I understand the need to ensure that the TPM is available, but if it
isn't safe to wait to initialize IMA at late_initcall_sync() then it
would seem like this is a bad option and we need another mechanism to
synchronize IMA with TPM devices.  If it is safe to initalize IMA in
late_initcall_sync(), just do that and be done with it.

I'm also guessing a two stage init process, e.g. some in
late_initcall() and some in late_initcall_sync(), doesn't make much
sense here, but that could be one other thing to consider if some IMA
tasks must be done in late_initcall().

--=20
paul-moore.com

