Return-Path: <linux-integrity+bounces-38-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8667E95E0
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Nov 2023 05:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B8BB20A8B
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Nov 2023 04:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CD4BE7F;
	Mon, 13 Nov 2023 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rs9HkzrE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA7BE7E
	for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2023 04:06:18 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A24C1729
	for <linux-integrity@vger.kernel.org>; Sun, 12 Nov 2023 20:06:17 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7c08b7744so46197337b3.3
        for <linux-integrity@vger.kernel.org>; Sun, 12 Nov 2023 20:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699848376; x=1700453176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdulfEzSfHGU40Qe7T9MI/Dcb3TiqFwbhF9mJITGshA=;
        b=Rs9HkzrE1T4yo2QGbYc/4pXVHXDWmZDRA81eYugBeS/+46GBU6A1etnOI0XFICVgJj
         cQVPLcbntuWQjCdDUMm020jQbS54y4kfvM4uAFrIUijL13fL0xGinBYIPQ/N/yaVwZgS
         jkzs6k5tZm84mXjjhjKwg0bJHXSFSBDV++ICurpIrdfMvtWcBWSY7X+o7Xvp3bahMLie
         lJAkqqh9idYkZNBUMGxMpxGraKiGUv1KHBW45lvvCfEfpwkgje+fffQHm+2COPxePc19
         e0Fsz5vpjfLFXdoRQuyAcnuPqgmTclt0p0yHGdZ2z4XA7fhgj6iNa3mbgcpVWZ2wjeo2
         d8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848376; x=1700453176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdulfEzSfHGU40Qe7T9MI/Dcb3TiqFwbhF9mJITGshA=;
        b=NA52KUED1d2fb6VY58lR3elV5gE7YNQS1OsISpzr0z41ZzzrhPfAQon8OnLvrfGAlq
         d5ZCGSfg0ERr1EGsr358TX9DDYAslf8rtK2gG+JGI6S7D3zFXHvpLGtuj2my64eDfKvL
         I/5WHdDD+9u6jWoWwDpzBPHZCHQKKUodUEn0ZKDAx0zZLcxeQ6ecsxF5pvW7ImQv/rGy
         c6PSnl3oD+ritG5blNjLWppCOpyRoO3KdZpz1jhirFo8lE3FnBMRAQUuYPUh6m8fK/40
         gKu12MqXYHBYOQ+Sfg/nNlwblUZm685Fe0kmAHw9v38saVRgoQbu4w+bqq8tiskxog8A
         r+Dg==
X-Gm-Message-State: AOJu0YwIJl+hz+6lF6xAvtihf3P9E3AjvphL/KOz+mrDSIbzqJM7ZWHt
	IH07XlOtmdZlayfdYRtWsxmJQlE2Naxh2YjUCFoC
X-Google-Smtp-Source: AGHT+IEI/peI91Cg3UawMcuS9Yk9mFblaeeU97N3bZNmx6UjEdef/ZKk/ovoWf1eG3YjVOz6NHCes6ELqTMs8g5M1d8=
X-Received: by 2002:a25:dd8:0:b0:d9c:a485:332b with SMTP id
 207-20020a250dd8000000b00d9ca485332bmr4377065ybn.4.1699848376543; Sun, 12 Nov
 2023 20:06:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026090259.362945-1-roberto.sassu@huaweicloud.com>
 <dd0f6611c7b46f3cecee2b84681c45b1.paul@paul-moore.com> <447298d65b497fb1a7f8d47c4f1a3137eba24511.camel@huaweicloud.com>
 <CAHC9VhSMVpEvLwWvBCgz0EMEb=DG_AZ7fenVUk5vPM=v5c6kYQ@mail.gmail.com> <CAHC9VhQW1mi5Z72cia7sqC7jERcCxO93xZJnvER=e7U6RqNFxQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQW1mi5Z72cia7sqC7jERcCxO93xZJnvER=e7U6RqNFxQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Nov 2023 23:06:05 -0500
Message-ID: <CAHC9VhSwPb71C1Z4DULv_8VyXO-wdjuvf2QqcbUCPvJgdg+H4g@mail.gmail.com>
Subject: Re: [PATCH] security: Don't yet account for IMA in LSM_CONFIG_COUNT calculation
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 12:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Thu, Oct 26, 2023 at 11:59=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Thu, Oct 26, 2023 at 11:12=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Thu, 2023-10-26 at 10:48 -0400, Paul Moore wrote:
> > > > On Oct 26, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote=
:
> > > > >
> > > > > Since IMA is not yet an LSM, don't account for it in the LSM_CONF=
IG_COUNT
> > > > > calculation, used to limit how many LSMs can invoke security_add_=
hooks().
> > > > >
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > ---
> > > > >  security/security.c | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > >
> > > > Merged into lsm/dev-staging, thanks!
> > >
> > > Welcome!
> > >
> > > Could you please also rebase lsm/dev-staging, to move ab3888c7198d
> > > ("LSM: wireup Linux Security Module syscalls") after f7875966dc0c
> > > ("tools headers UAPI: Sync files changed by new fchmodat2 and
> > > map_shadow_stack syscalls with the kernel sources")?
> >
> > Let me look into that, as long as it doesn't blow up the stuff in
> > lsm/dev (I don't think it would), I'll go ahead and rebase to v6.6-rc4
> > which should resolve the syscall numbering conflict.
> >
> > FWIW, I also hit the same problem with my kernel-secnext builds, if
> > you're using those RPMs you'll find it's already resolved there.
>
> That wasn't very messy so I've rebased lsm/dev-staging to v6.6-rc4 and
> regenerated lsm/next.  If you notice any problems please let me know.

Now merged into lsm/dev, thanks Roberto!

--=20
paul-moore.com

