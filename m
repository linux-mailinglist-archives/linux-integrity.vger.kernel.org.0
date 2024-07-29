Return-Path: <linux-integrity+bounces-3240-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA5940041
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jul 2024 23:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09210B21888
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jul 2024 21:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F718C347;
	Mon, 29 Jul 2024 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HDy+iDNw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B76B189F2B
	for <linux-integrity@vger.kernel.org>; Mon, 29 Jul 2024 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287976; cv=none; b=CuT/JhgBsB+GDepAfj0ZyDxhXYbnJ6yoCf7ZZb+8EZgwTHzAycOQj1YJdSdsk/DXHPJBfPM2A1iUno1pVGW4JMOcfewdmHsWnAJWgHeTR4rWpoi3Gi2j8LMT4udsPiQgb71s8iPl0TKbmrhoICM+GB8MOajz+xqX18WFd9xNyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287976; c=relaxed/simple;
	bh=4l+Bvtu4kvAUQXF6bJmvFTVCWVJV5gtAA53iOAelmP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGOiSbuKEig5AOUzA4kijVKkYCi4TJymB/Xxs05I8ffnCxBoG0qDNzGtDPrgXOPpJ5OwNYiYvmp/VTg/CCDIzJ8XexfWWEfYTOIR4hOTucUIEmaWJJM7g1vqX1ZEtBqa/sP2LMAXRK34Goy8C+uBb3csyPwJZ+XrJyhbaGAo0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HDy+iDNw; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e04196b7603so2315526276.0
        for <linux-integrity@vger.kernel.org>; Mon, 29 Jul 2024 14:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722287972; x=1722892772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57KneJBJmxhIzkyiS8eBkpjOJsC+T980EDeLPEhnb1M=;
        b=HDy+iDNwXnKWRnm2oi89ppaqq1WBU/W8NHRB3MecEBB++3S8XLWeCVRRBXJu6ZymFc
         kraHJU858TtSyMNSZhdFmG+v8zEVSnehbeLdg1yjYmXYMMZk6ZeM3+zdZ60Gmp0TBgTA
         lPEzeqidGX1tX55itKEd1UK0o+FmDCXzEBsmBJLFqcvd7FxhMVi+OHc/TVp/L1Uq9GgJ
         qj1pGjQB4QshvPH2JIvxyh+a1ksMB6z39bgQcfPicqD+xseYkrUICxvpQNX95+nefWFm
         HOT/KaLG6FaC87gHxwlgOedQdxhcedGAte4BRO5/ljldPH6+QisohmVmErWS8vY6dmzT
         e05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287972; x=1722892772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57KneJBJmxhIzkyiS8eBkpjOJsC+T980EDeLPEhnb1M=;
        b=Z4fyn1cBGInmMXyJWjBwRCvP9MixIugnzmEJKrpqHaYXQr8TD8STtGTOijvgUabG4v
         Q2wcKSoPBhycRy+HsFVwOy3/eqmK0k6Mfb6DJCIwzdHVFk+yOL8dgJbf4Mrqb088u4mF
         baIcntYPRzCVCDKQVK6CDTNdKL9BO7gEEbLW8AK2FR8WgE+8bJzPf6o3DE4cwFYCHIG0
         tjpxOhpOo5gYLidGySDMJ9c1b6CF+5m4pp06BEQyrG1eZLwpUkcvrO1T0x+vNko6/5Yp
         a50G3+D5EjZ6spjHdBegLs5F/sbD2/vb8UUMqoNI9CfSD43Hauj8+QWzeUwQ4gwpOLLP
         goEA==
X-Forwarded-Encrypted: i=1; AJvYcCULSdZuBLHRAviEiCKS1HASr8EhcL/gBzXluwLKb6FUkt43bCLAYToMEKaYLX0yzevu9CnWVsTDFstmRo/6fk39WAlIldiNOoNgV8aKhwyh
X-Gm-Message-State: AOJu0YxkXusc1h8fbgDMUf2Y1K38nj5f8/zgHJTK7zQxr/JW+Jx4DFcu
	hHfEvCH8vS+PX/dsvDPN7kPIlESm3HHEBOBRsYYOEV32Gv2edk0TINPuSEpc87UeBqf/9iLiCP8
	aLBWSCCKwmXvnzdCP2cLy9whxbXJdnkQ5UKbG
X-Google-Smtp-Source: AGHT+IEMYEefrecGsvRSsfMyzdAwa3txRnjT2iryrdAee4DsCtHHJC+M0YAgZrPzcXwWtUyTuUJITsqdBLLjWYrTI3Y=
X-Received: by 2002:a05:6902:1b05:b0:e03:4607:10ff with SMTP id
 3f1490d57ef6-e0b5459dd6cmr8373357276.42.1722287972381; Mon, 29 Jul 2024
 14:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724020659.120353-1-xukuohai@huaweicloud.com>
 <26bb0c7b-e241-4239-8933-349115f3afdb@schaufler-ca.com> <CAHC9VhTfqhWe9g5Tfzqn2e2S8U3JrCJ2zjjgKKJF0La+ehwAaQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTfqhWe9g5Tfzqn2e2S8U3JrCJ2zjjgKKJF0La+ehwAaQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jul 2024 17:19:21 -0400
Message-ID: <CAHC9VhSF97=CaZw1YHMgP+Vqu_C21KgqSu=zXRnX-3kkvEFJzA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Refactor return value of two lsm hooks
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-integrity@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, James Morris <jmorris@namei.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Jul 24, 2024 at 4:36=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> > On 7/23/2024 7:06 PM, Xu Kuohai wrote:
> > > From: Xu Kuohai <xukuohai@huawei.com>
> > >
> > > The BPF LSM program may cause a kernel panic if it returns an
> > > unexpected value, such as a positive value on the hook
> > > file_alloc_security.
> > >
> > > To fix it, series [1] refactored the LSM hook return values and
> > > added BPF return value checks.
> > >
> > > [1] used two methods to refactor hook return values:
> > >
> > > - converting positive return value to negative error code
> > >
> > > - adding additional output parameter to store odd return values
> > >
> > > Based on discussion in [1], only two hooks refactored with the
> > > second method may be acceptable. Since the second method requires
> > > extra work on BPF side to ensure that the output parameter is
> > > set properly, the extra work does not seem worthwhile for just
> > > two hooks. So this series includes only the two patches refactored
> > > with the first method.
> > >
> > > Changes to [1]:
> > > - Drop unnecessary patches
> > > - Rebase
> > > - Remove redundant comments in the inode_copy_up_xattr patch
> > >
> > > [1] https://lore.kernel.org/bpf/20240711111908.3817636-1-xukuohai@hua=
weicloud.com
> > >     https://lore.kernel.org/bpf/20240711113828.3818398-1-xukuohai@hua=
weicloud.com
> > >
> > > Xu Kuohai (2):
> > >   lsm: Refactor return value of LSM hook vm_enough_memory
> > >   lsm: Refactor return value of LSM hook inode_copy_up_xattr
> >
> > For the series:
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>
> Looks good to me too.  I'm going to merge this into lsm/dev-staging
> for testing with the expectation that I'll move them over to lsm/dev
> once the merge window closes.

These patches are now lsm/dev, thanks again for your help on this patchset.

--=20
paul-moore.com

