Return-Path: <linux-integrity+bounces-9386-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHc+ITuk8mm3tAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9386-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 02:37:15 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6F849BC7D
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 02:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0676C3007531
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 00:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BCC1DA0E1;
	Thu, 30 Apr 2026 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eS/db0qW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AC81ABED9
	for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2026 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509431; cv=pass; b=pTtOyZp5/QIVSQEjwcnrw0/IfW8gZdZlPaMoUvzCE3KgPZZMXRvXe65bjmDjdNfTLA8zGI2kRPv5RyX6OGME3q3rFkh8ZSLzS1tuFdiyALtx0+G6k8NAIh+EvF/+aB+dvHQfQYDW+tByAj/38o4Vnu5L7+0v/9D00I9dqNA4nXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509431; c=relaxed/simple;
	bh=jxwagxkzPi78qwqEQPmxVQVl+/Y1Vrryfq7+F8b392M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qC1pwVtsZBQEZU5rVvwUr1mAtsnd3Qoa51bmQqUig2W0WC+y0fvJKJDTXCm1q05v6y2zDQeQv0Rw1LKgjFncbPs60XeFNxkca2HT2SHuIYsqUWVI746U/G4WmjcKXyC44LIT9f3sSkKfV0stJYBZrpX2Md+Giyen/eQKXoJQ5ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eS/db0qW; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d90833cacso213085a91.2
        for <linux-integrity@vger.kernel.org>; Wed, 29 Apr 2026 17:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777509429; cv=none;
        d=google.com; s=arc-20240605;
        b=Z1BkXME4L3kpAkLm/5UgQEQIQGDwcSyXmL56EaxvOX3i9P/IkICv+esvOluure2qh9
         vb/hj9AQccwStPSJEePnMLYXgbm2dl8c6KFQLomFEKQ74i+FnAlVDMT3FThTy6t/ogDT
         h551JaMI8b0tTpIVhRgEXh0ZP3NTY3qUoVtzzLrVtonFOrrESTPRqd5KplJCRE18LUSr
         J8qKNEq8/vJO4C34VnBduIhlwWo2znIKlORdaY25F6z56fvUFz8G9iJBbvaf2iaCLhDK
         QjeYaqns6JE2+gd0gjYF/TeA5lGo0a5vY3TD8A8QmekLQlDDc4h+vfG2vNhfYwP9gF+G
         v62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XxIaGXcpSE5LxIReZcGgBcZB3ReO4RJbfPvanWg+Ksw=;
        fh=kJImvqXfOz2MUpNt/iO3L/C7wIwe7O1GA2dKYu+TuQU=;
        b=AtKKI3q1aSUjd1cnfbZe/LRIbcxhZ7cxMnA0mY5jym2zF0ufZsctXn3W1j+985O8Gr
         itsrgkvo9IoquEBTTNuEAEN0RVJsNi/hCkhOjqdkhGD05Gvui/KyTFQY1w5WlSwAsWXB
         WRn2L3F9zhxMRyqbhMODW1zcHMkD74Ehbu/E2LfJmVUkXYnBmotJ9FpVzeeZGGI32MhH
         DARnAXt993JKqBs9Ydz31gK1zFSeLxudq4GERNKJ8sJF03GkcieB1SiI1SIDyc79KnfJ
         JsGeWCA8vSN6XRDTmYodnpZ+8SWcJkRJimw8yrjqdJGZDLdAtGN0+0pUt9ZtcUeBNYm1
         /U8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777509429; x=1778114229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxIaGXcpSE5LxIReZcGgBcZB3ReO4RJbfPvanWg+Ksw=;
        b=eS/db0qW6OCfyvEl1tGX/aAPfKh+98ODtSsABKaEG3/UKblugEP7KMa8bHupkzvAOu
         SzAj8yIWyxKw6LStzCvSMYwpWihSuXetB1fONwuIlrT4faYy4WrEWvzyhDM/89PFev6/
         vXkL1vxrIoICucEKwE6Uzr/TZEzQKhzn8JZ2+AA8Kc4i2dK7HKxzqPj4+ansFuLu9uol
         ad1PeIEIvAVuSSH/amy6Uemdlm6eopaS98KIz2IDMAdNRugx+EXEvbk7Clrqaj7b2xQy
         EhA2pG9/V7rS0wt30efh6ZvmKlOgWx3HVH3ikBepIBKB3pK12NJYYirtKMBRIzyJ8jz6
         N05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777509429; x=1778114229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XxIaGXcpSE5LxIReZcGgBcZB3ReO4RJbfPvanWg+Ksw=;
        b=sesWeaW8PrT0fMfEt41sBkSjj306vPhkhuTwGJgF5+MxQ2J3UmHtMJlWgJL+6fDBYL
         pbjGmZ9B292NyiwXm153I6LjCigLDYZeLpy3z1oDpX7ySNLt99OkwaTaR6alaFFbTw12
         wUGH5bMymXpS0+3ljJAAPYkk8OszZuwi2yxm0fAczIaXESSmAd/dlR4biV646ARF6RX2
         HE/zdrL3SO6LC++35T2uLDwyXuVuXA9m2e7mNnYpHCDFVXw4voHof2R7Z3cZ7o+SfwOz
         +ESw91tVUCg1h90akhQ0+Sr6DsfhUZZRg+SMva0F8UZ2jxhlJYG44kRwP6YODaVRl+pp
         Nuwg==
X-Forwarded-Encrypted: i=1; AFNElJ+XtQ5+zr175x/BOF/FfuHsbUfsVn89HnOWvCbaLC2iIre/ILtU2oT7nAgEDV6nUxMlvglokRsWK4z9vXJ1WRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1wlxwBbNesTbgwLSQZbwlyVgVGcWhxVaENiCnkpS4lOWH0oj
	gXbLkJIvEZnvoeNRmluH8KaHGE5dr1cLVs7DT5chbF62OCpA2eN2Is75z3U1+rtTKBX08nksL0q
	z22CI0g2sO9OSv+MC0FEv/zLDajSqYESeAAs9CvvR
X-Gm-Gg: AeBDievFEP/cO/FNdoqmUc6CzBdVKpmvAeq9Gr0p1qfexWv+O9sVm88uryHb02cQdap
	pgojDP2nQqG9DiPNk5UaZxnNwqGN1KcPSjN9yp+yWBnncgCrtMwQA2+xEJooZKyPgjNaAV1IXtg
	Oh+TVT4k2R6UPwxVX2Oe+DRulllZcU31SeQnvChC9n8p42vK24qKaacD9+FnYCScs5Bn/TyZY+5
	ActDcfsacm9dVt+GJxnHZuzJkFMoN1m2ZFJBfRL2JYWuGfELmTifyulGJUjnwoWgLy9zUGDUnDQ
	mUbmNMXtl5YxZudekA==
X-Received: by 2002:a17:903:3644:b0:2b2:5314:e96a with SMTP id
 d9443c01a7336-2b9a2523582mr3745025ad.34.1777509429231; Wed, 29 Apr 2026
 17:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aephL3MzYoqFGaT5@e129823.arm.com> <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
 <aesGU8a3mbVzvteH@e129823.arm.com> <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
 <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
 <CAHC9VhTW3=RJ8L91RWXYYA9tFjfSXGN-DMEEwdiD6big9H57Ew@mail.gmail.com>
 <1f78fc75b2e95239973612a4b6c4cc782960b7ac.camel@linux.ibm.com>
 <CAHC9VhS4JmPmCJrYTdbjxb3TO-uK6cB3Zij-ef=wswGce2BGzg@mail.gmail.com>
 <1e51c2fd090e5ceb07b1d09e50650c70fd3ccdb1.camel@linux.ibm.com>
 <CAHC9VhS_WgwhW_NDO91LoTeSzdieGqbwqnwPq8KpavH1_Lwi7g@mail.gmail.com> <afC0UPfGhNTsXnyi@e129823.arm.com>
In-Reply-To: <afC0UPfGhNTsXnyi@e129823.arm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Apr 2026 20:36:57 -0400
X-Gm-Features: AVHnY4L0F5CYsArVv0_Aux1I2flm7srRsxc7thS9QtQpbPKd3nDtBwoWwNOL0u8
Message-ID: <CAHC9VhR8Qc42xnoNHW+CEKGEAeupET-BFdYuHLuM3ZGzfDmEYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com, 
	Jonathan McDowell <noodles@earth.li>, linux-security-module@vger.kernel.org, 
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
X-Rspamd-Queue-Id: 2B6F849BC7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9386-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email,paul-moore.com:dkim,paul-moore.com:url]

On Tue, Apr 28, 2026 at 9:21=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
> > On Fri, Apr 24, 2026 at 6:49=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Fri, 2026-04-24 at 18:10 -0400, Paul Moore wrote:
> > > > (I'm assuming you meant initcall and not syscall above, but if you'=
re
> > > > talking about something else, please let me know.)
> > > >
> > > > Saying that you aren't comfortable moving IMA initialization to
> > > > late-sync is inconsistent with allowing IMA initialization to be
> > > > deferred to late-sync.  Either it is okay to initialize IMA in
> > > > late-sync or it isn't.  You must pick one.
> > >
> > > Yes, we're discussing late_initcall and late_initcall_sync.
> > >
> > > I prefer to look at it as being pragmatic. I'd rather err on the side=
 of caution
> > > and not move the syscall to late_initcall_sync, than move it.
> >
> > If you were truly erring on the side of caution you wouldn't allow
> > late-sync initialization without knowing if it was safe or not.
> > Determine whether IMA initialization is safe at late-sync.  If it is
> > safe, move the init to late-sync; if not, keep it at late and figure
> > out another mechanism to sync with the TPM availability.  If needed,
> > you could probably use the LSM notifier to enable the TPM driver to
> > signal when it is up and running.
>
> I don't think LSM notifier wouldn't be good since it a one time
> notification for initailisation and it wouldn't tell properly
> whehter TPM isn't present in system or present unless functions
> ima_init() are rewritten to discern the "TPM deferred" and
> "TPM doesn't exist" in the system (e.x) boot-aggregate log creation.

Yes, some work would needed to differentiate between TPM present and
TPM absent, the notifier would simply be a mechanism for the TPM
driver layer to signal to IMA (and potentially other LSMs if needed?)
that the TPM device was initialized and ready.

> One question, though.
> In the end, for systems where the TPM has already been probed by late_ini=
tcall(),
> init_ima() continues to be called at late_initcall(), while the above app=
roach
> is introduced for systems where the TPM is not properly initialized by th=
at point.
>
> If init_ima(), which used to be called at late_initcall(),
> were instead called at late_initcall_sync(), could this break system inte=
gration?
> In my view, both late_initcall and late_initcall_sync run during the do_b=
asic_setup() phase,
> so it doesn=E2=80=99t seem like this would cause tampering or affect thin=
gs like the creation of the boot-aggregate log.
>
> Is there any particular reason why init_ima() must be called specifically=
 at late_initcall()?

That is something that you, and the IMA devs need to answer.

--=20
paul-moore.com

