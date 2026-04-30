Return-Path: <linux-integrity+bounces-9387-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC+2FDOn8mlwtQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9387-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 02:49:55 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3949BD60
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 02:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3655E300B9CA
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 00:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFC21E834E;
	Thu, 30 Apr 2026 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G2yi90uS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506272628D
	for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2026 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509799; cv=pass; b=ZX7JS2JNoUk4LFqAcI5b01THZ4JFqZ7Q5M8p57DugUAv03mlPzSxCw62pkjI908XB3iexQtyCRRXdsht3Xh3h3N97jrdT7AM8MrhAOEUqpc4meJXr5T3z0wlDDs59z7U1NeampIhFlYIL4m23Jic05ykSssJCMcxt7N/3NQweo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509799; c=relaxed/simple;
	bh=ZdaMDMnsE2bNTMd0UOmXsnLLXqtDt1Cqm9/WufJEwTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALe2nnomm5xox0uhcuoUoMLiC4kedPE0nFsD+8H7qb1ZMarGnIKrzBjTKTkjpRJ5To/A0q/5YQnZENYz8tPFyEO4+QE0K8KRu7fDwqwntMIqOUIYeBFGoxZ6Xb04x2KNXPEd3OpxIPGLPr+LHQ7zEibDO5vaFdoxjBhcz2Ca1GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G2yi90uS; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d965648a2so325687a91.0
        for <linux-integrity@vger.kernel.org>; Wed, 29 Apr 2026 17:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777509798; cv=none;
        d=google.com; s=arc-20240605;
        b=SiqY3scOWIdpOXw9UbxZlhHGX0R2O0JeZyjbGTnd5t6utA0J2gLLh9U+SzgtzdvsuR
         uJON99y6udaKG8xKN5B5ENYgUiGXKUuvDU15inSitT5/U0yb/q+Q0tnGFLOZTSGzT061
         J8CobWlzOaKcI3jL4Tt4oT/eG6xw16z08othhzBzLxulIrnHfo4Coevv0MY2o7ZHwLI+
         8s3Lift/Xgmbly9sb3NClM3rqQmK9he+zS0f2uimNKeAo4WVPqs7Hk0GFf4++19DWGSA
         pzYp78b0FM39ro81JdJ0uOb85jHOGRpwRqr336OZmOryJziErFrLLycKKyAc/F0jEF9m
         3xVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+22Vew3O7NYuCAbB+MpAlEjTY5hterfUj3xJsaAyHE8=;
        fh=ANq4fL87Uf9grHljsN0AZtChQn/p0FUu+eSJDPKrVLk=;
        b=PwZzRJ5qrmDnhLNurT8UeMCKkf2I4CWtSxM5nxI2sJO2cUhsQqEPepwCI4youEBiTX
         4zkZi4dD9uD4xL1v7BI8Bu/4kSvXqNMxBB79gdFC0DOgKTnBqsZ/0fX3kGjBxqCzHqWt
         vcbbxzWnvqyjQ35QOkW8RUGdlJtEgjbE7vnIRREC2oV9rl5KX+41BxgB1zT6ad8OW/TR
         1M8cCzMv09SjwHUCtK7SrIJCich5aO8tqTR/f4NWmmf7Mdc1rTA3hG6Y6tJZEIYZ6Z0C
         U+r1/xDzFuAjuyJA90ObnUQzOIFMR0YJRN0YkMkC9d01IpYUXU5tRO0+jxoMSGjuXjvZ
         Ok1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777509798; x=1778114598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+22Vew3O7NYuCAbB+MpAlEjTY5hterfUj3xJsaAyHE8=;
        b=G2yi90uS0VYAefuD0q4YL5MvIf+jTDDyZMDzTJucknJJFV7BwKM+BAPQtWErB6rAKo
         PcT0gaj+LkO07kcO8Qqjd0k7OEgyADrViPpLXjbCiFH21CLt9rrey5+fhRCyuoZ67nr5
         Ft8qm7H4gbesCMBczBfzrrgbgyXEE+6FM+by2f8JesasyRJUcFDTuTJpIEmm9UELeLnR
         qQY+oLDkiklsy3fCC3u4PuqRiFZ6/wA1Jv5XBilacVJ5UscbLNY6T+lBXuYZMpF6QOXf
         g6+mg4XWWbcGLdzVhal8kV9oQdVS35EiMlw2xfiln8MIQjmw3EQE2F4ZCPzmKDhi1S3T
         Pbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777509798; x=1778114598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+22Vew3O7NYuCAbB+MpAlEjTY5hterfUj3xJsaAyHE8=;
        b=KmG6JJnrh1PN0REft3bjHALGq/R4HzZ0y2brzsIRoYxM6fUlGr8EG8w0rlMtxKtIk7
         B/T9STaWteNjXiUCw1OisK4Xkncn/jCR6wiSXhMBcDp+94cBjvqP9JZynw+tUTika38M
         brFHF/5AuE9Hnvr+T6A8p/iArtgeFG3B0Nv2dO5uxig19umqW6I4KIhc81sTB8EIgn46
         fsOsNKTOfNhbbesbGzDB9BT44XHcpoy4rSjSXkDuO5LhIuEIiSQV7mwiAhWHDRPOvo71
         S025kAK36PMk/y1kXu8+vxCNTgGL/nLmYmO0ectyVTz9YP+B6lRMq6N39O8freRrvqOD
         pQJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+KP3bVgG7Upszqe5ST1Hj1HItmUOLNjtl7tJOK35yhSKAMOR1VRseIOZdaFYwojgznZ0DPgmWJSn/EgPbtUG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8vsT0glGu+B0fhmrmJKSWQ2Mq7LLhRv1E+rmAoH8uIkUUXeB
	TqXUgnHfrMFrXdDXcl8Zmf3pPWlz1PcuR9WGYg8kd/XYxCo48258tcwPuPuI3crUOYOdJYUAJAa
	SPPxlVET4F9Vd5HDAyKfQZb1CzFCkOvr7MXPLykwH
X-Gm-Gg: AeBDietYWXfNtyXPnzlNl45jsWkZXjUuQ/FMIoI/fDUsho/uYsu02y0iuzAPg+OA+X4
	lJNHQiIopmvtRPZMIzC502b9bjVJ4wpBLrtjte7ghmix0v4wx90U0M7q29rMQ9qIoVLr7dbJHyp
	Bg/gG6TlnGupaU4VwF8sS40uZn7VAI7IP+iR6brqwENGgY7eGNs4MW4Zz4M8uEMk/olNCKyCW7L
	cwcLFjZipqh/Osp8cldoGHRE+2egGL67/byLGosMA65oTft9DkS7iB0ZFw9HooKWLV3uDeHPRSh
	FzW6C+bVJwJ1Tqdw2A==
X-Received: by 2002:a17:90b:3b8c:b0:35f:b5df:450 with SMTP id
 98e67ed59e1d1-364c309b046mr561429a91.19.1777509797729; Wed, 29 Apr 2026
 17:43:17 -0700 (PDT)
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
 <aesGU8a3mbVzvteH@e129823.arm.com> <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
 <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
 <CAHC9VhTW3=RJ8L91RWXYYA9tFjfSXGN-DMEEwdiD6big9H57Ew@mail.gmail.com>
 <1f78fc75b2e95239973612a4b6c4cc782960b7ac.camel@linux.ibm.com>
 <CAHC9VhS4JmPmCJrYTdbjxb3TO-uK6cB3Zij-ef=wswGce2BGzg@mail.gmail.com>
 <1e51c2fd090e5ceb07b1d09e50650c70fd3ccdb1.camel@linux.ibm.com>
 <CAHC9VhS_WgwhW_NDO91LoTeSzdieGqbwqnwPq8KpavH1_Lwi7g@mail.gmail.com> <e325b7a8041b7122e8415de9193f4fe1be04bb02.camel@huaweicloud.com>
In-Reply-To: <e325b7a8041b7122e8415de9193f4fe1be04bb02.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Apr 2026 20:43:05 -0400
X-Gm-Features: AVHnY4LHifXVy7YvtGHgR9F7kahKzv5vW_Z8KfHyWJ-dvateuzzdMLdc0MOzfBY
Message-ID: <CAHC9VhTqYgc6fE2v+ZY4QXuCDkvNMKZcM4Wi+7Vkxspff08K0A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Yeoreum Yun <yeoreum.yun@arm.com>, roberto.sassu@huawei.com, 
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
X-Rspamd-Queue-Id: 4CC3949BD60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9387-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[paul-moore.com:s=google];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,arm.com,huawei.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[paul-moore.com,none];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.926];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:dkim,paul-moore.com:url,huaweicloud.com:email,mail.gmail.com:mid]

On Wed, Apr 29, 2026 at 9:33=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Mon, 2026-04-27 at 21:31 -0400, Paul Moore wrote:
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
> Yes, I agree with you, or transition or not.
>
> However, all of this looks very fragile and easy to be broken. If we
> want to be on the safe side, we can use any notification mechanism that
> is suitable, but at the same time from IMA side we need to deny any
> file access that would require a measurement until the TPM comes up.
>
> If you accept this, I don't have any problem to move to late_sync.

To be perfectly honest, I don't care what the solution to the IMA/TPM
dependency issue looks like as long as it doesn't involve simply
trying to initialize IMA multiple times hoping that at one of those
times all of the dependencies have been satisfied and it isn't too
late.

If the notifier helps you solve this, great.  If the notifier isn't
helpful, that's fine too.

If you need to decompose IMA initialization into a multi-step process
spread across multiple initcall levels, that's okay; we do that with
other LSMs.  However, calling into the same init code across multiple
initcall levels is not okay; you need to figure out what is needed
when, and establish some synchronization mechanisms to provide some
assurance that the system will boot up correctly.

--=20
paul-moore.com

