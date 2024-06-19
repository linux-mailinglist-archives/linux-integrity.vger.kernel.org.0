Return-Path: <linux-integrity+bounces-2871-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B3B90F364
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2024 18:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42AB1F25216
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2024 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4056315884F;
	Wed, 19 Jun 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Deuzf+T7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52231157E99
	for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812160; cv=none; b=Gxvwn75Pfi6A7sJDUqNEs3H7EPt2E4Z984mq9XT2OnXVVEAzm5RjdZHf1LytHAi1CWcVj0cbZ6DtRqgPmpT53fiQzLS1+W8sr3kBHbNl9x+H6MwWp9voX94LaNQdNR+Z5jubn27LB1X4AAuXz0H9UsDsDoexgUwYZeIWWoxSdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812160; c=relaxed/simple;
	bh=cSH93zHXkK5myzncS0R9U3Eonp7whM/bFDFKKdLoqKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b259tJLhzN3VbbMzrffVAvtylkd7VyQhP08dVRDV35ExKQJWDMQGMbgnyvrCLRz1UTI10frhfNuKj42X7cwNEW0kwS42BJSdtU1vFQfpVbsGqGZfzewdwsTm/Kz3Ll2auVnVhI+At+1Oe7KVhXlb9mSpb3tMGO65MT+MfxSmaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Deuzf+T7; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-632bcf111ffso52773537b3.3
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2024 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718812157; x=1719416957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A3V41ThbwHIAGZpAhL1w9y7K8p24jvNIlupY7BQNOY=;
        b=Deuzf+T7eIoBmSjD0usGJ8i1x1VH9BioooixvPYb5R5hoaZaXI0MekCU7r/i0D31Sa
         ZjAc8jE/T4Em5onVaGSWln4Ds5DiMatRYi7HpFN+oFqyDgbaISxht2YO8VtPfr85MeEB
         oTs8ew+/Sf5VZsFdGKZe8GLudEPvrxrOFEUG3IuaRK/zFpiMhoF44PMocckPFcbB/rBL
         t7dFYaoLU3Gt29BgTW0SLHOzBPgp1ga7J3wzPZiOO9KqhSRgpwvwD63KQ8k+L09P9UOY
         4bNKDTs0r2yZgP4g3XnOae5yXnHYjfMKGDpMpqUn8rooCPqPM1p2O31BENaO19Q8RNKt
         m4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812157; x=1719416957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3A3V41ThbwHIAGZpAhL1w9y7K8p24jvNIlupY7BQNOY=;
        b=D45FHxqLxqeos7vTAc96JOIaPKfN4VHMASsIY5RKtd8GM5XX4dSSKpeSftvLarugSQ
         LF3qFwpepswcqr3LD70uYkh2j8wpaOctYwN19o4jEMQspR+6kPJvphMrhMvfeX1eMggf
         BeTuMZsc61I0hhv9ypd/2oUmHzNAx/qj+qDxkeBFFdGQOzbT55XzLhV2O96dd50UnuJn
         Wu3Bj0sX9nG6aFMoiFhsuCerbix1tJ2WMPlfqv/eu1P2kYcA4XrsiZ8BL6F4dHMgmJ67
         5rixeuFGN+NEkiowiJDDa3c/YW4ODUNw/QMojmIkYLbhkne5y1sbAXmd6nEWUUgAxrQF
         awew==
X-Forwarded-Encrypted: i=1; AJvYcCUsADn+JXAOJq0wVcupbAuIIxgNYIpmVbK305zMGG+j7ABiYd1haVVkvealeF/acko11Y/5LK/+xrtRAvOpY59vF2E2mO9eaWvf9CeNZYry
X-Gm-Message-State: AOJu0Yy/pV/Yf/Lr4+ouzt5/0UhEDyzP+BwdfqyBC5yaLVP4EtQsHS62
	ebNOf3N4elzVx6gfYEY6jSHAqdoVH8jbdHJ+8qOtIMcRenHt0pvD4fDZopN4SC4zS6bxJ9a1blc
	c0u0gByQQwgHFF7hQf8fch3QnfZx4JS2XZuGUtC6X+K1os5IgDyq3
X-Google-Smtp-Source: AGHT+IEkDQP5qZ6Yrjj3uYAUPWx122jAV/ve6smoTK2csXSUiZ3XrnUftHl2q2TGjzjXyIgjKZD8k1vF8LzOBOY22t0=
X-Received: by 2002:a81:84c5:0:b0:62c:e6c0:e887 with SMTP id
 00721157ae682-63a8d72f60bmr34069987b3.9.1718812157336; Wed, 19 Jun 2024
 08:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com> <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
In-Reply-To: <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 19 Jun 2024 11:49:06 -0400
Message-ID: <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: corbet@lwn.net, jmorris@namei.org, serge@hallyn.com, 
	akpm@linux-foundation.org, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, mic@digikod.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	linux-integrity@vger.kernel.org, wufan@linux.microsoft.com, 
	pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org, 
	pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com, jikos@kernel.org, 
	mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de, 
	kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 3:59=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Tue, 2024-06-18 at 19:20 -0400, Paul Moore wrote:
> > On Mon, Apr 15, 2024 at 10:25=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Integrity detection and protection has long been a desirable feature,=
 to
> > > reach a large user base and mitigate the risk of flaws in the softwar=
e
> > > and attacks.
> > >
> > > However, while solutions exist, they struggle to reach the large user
> > > base, due to requiring higher than desired constraints on performance=
,
> > > flexibility and configurability, that only security conscious people =
are
> > > willing to accept.
> > >
> > > This is where the new digest_cache LSM comes into play, it offers
> > > additional support for new and existing integrity solutions, to make
> > > them faster and easier to deploy.
> > >
> > > The full documentation with the motivation and the solution details c=
an be
> > > found in patch 14.
> > >
> > > The IMA integration patch set will be introduced separately. Also a P=
oC
> > > based on the current version of IPE can be provided.
> >
> > I'm not sure we want to implement a cache as a LSM.  I'm sure it would
> > work, but historically LSMs have provided some form of access control,
> > measurement, or other traditional security service.  A digest cache,
> > while potentially useful for a variety of security related
> > applications, is not a security service by itself, it is simply a file
> > digest storage mechanism.
>
> Uhm, currently the digest_cache LSM is heavily based on the LSM
> infrastructure:

I understand that, but as I said previously, I don't believe that we
want to support a LSM which exists solely to provide a file digest
cache.  LSMs should be based around the idea of some type of access
control, security monitoring, etc.

Including a file digest cache in IMA, or implementing it as a
standalone piece of kernel functionality, are still options.  If you
want to pursue this, I would suggest that including the digest cache
as part of IMA would be the easier of the two options; if it proves to
be generally useful outside of IMA, it can always be abstracted out to
a general kernel module/subsystem.

--=20
paul-moore.com

