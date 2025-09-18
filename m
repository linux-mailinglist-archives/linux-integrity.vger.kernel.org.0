Return-Path: <linux-integrity+bounces-7164-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ECEB85DA8
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 18:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A026E565260
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263B1312811;
	Thu, 18 Sep 2025 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WOJX4PrT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1C31065D
	for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210880; cv=none; b=BiKJmsWU/YUUmUkhT3GVn/dTuT09p+OgcLuNWm9QpLqgrVdCAsFOUaXM33+j7aSO5Pa/P/xm/y7VZ2u6zz8swYtLAgjXeGwGkPKCivIBumB0r6Nh1A0SrD9XSZc+aEt5wz+HZvwLw8+sx5fFlgD5mo4HfoXmlFdumX0+bWHsg1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210880; c=relaxed/simple;
	bh=X9pgNkF1ErnNwPDlEf3bxDqMrcFcZSmiU/nO0X68JGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGe0L57OWoj4tCs6YEsivkI8QtDjkyAsPh7HInejfg1JTKTM/zIzTwt4NWLeCRBrAa3heLSCuBAG0MshkpPdrgF0g2qo2pnxcV6g4417leIVUHUWNm6oCHncqyZQWkAJo8sehydK62PiJj/n8dz/S1zn2d922rAj5zn3cimSOFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WOJX4PrT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so751712a91.3
        for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758210877; x=1758815677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Am2P4TTs1rFQpRtzKDy6Sx6BlCb8FIoV2rTP67iVQI=;
        b=WOJX4PrTdHzrK2T4xWYMvUhx38Uk/h9powM1YrZFuBCRinQLTBymGIpcpZwnRRHySQ
         J9gO6CQZGy36eLwfHbpDJBcjPC57sUHESKHa0JeIy1Wjrzr807KQRkrS32qzMd478PK7
         hjD6sH41vmPQYfM5/WSukVEwMDymhv5DHEMOF9PjvSztXGpJeu1Ovh1JzqeQmACsNp4w
         4wGEWMXuODyq/sNbS/t+8OJvAFV3Rgxxin82Sw5Rtm5aXt7OZLxePwJ1D+eLQHuctEKT
         vpcOefSD2RM5bIwPtRLTNv5QfP/bJYEPjjR/AGVh83ga1+UaHXIUGOGGwqDuPI6kpE6A
         0DHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210877; x=1758815677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Am2P4TTs1rFQpRtzKDy6Sx6BlCb8FIoV2rTP67iVQI=;
        b=nPIoet4byly32vDQm7zsZEGdH3pME4AfcoDdUW0S/gaKgmiIHvBrj8WpA1fsUjmKyO
         aUuExKTO3GN94Uw4z9Ijmyok0DfYv+h4wKulW3xuOXEVDpgBAOJpNdjKQc0XOtDGF+S4
         u40emDmDB9eJuIJXEmj7pSPQrCgimObr+HdHWyg2bdYJzYcMpCbGqTHzUZkwyWUr2BW1
         vAMALU/VBBKJL7roMw9W0tL9bmXBsBsKWGLAM1wh0qu9NoXidl8XstznQXZ7+O1kLQ/F
         cEGG6C3wgxK4LXFjQBC2/22HhSGLa6k+CYlKmSxeemqeCDXz5ATbmaoFDi7DIcgt8oyw
         XjiA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ7IGhKQCBwEK5Cn3z25Ahel4ogC7wcCqDFc6bThxVEq7zQUr19aZdHlmDRoNmJ8psmagqzqXx3cRFVC1Z6Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjwUDJFNqDaJWGAGf7qSsbPLB4iPE9D2w+nYu3DDM2XGjTVhdx
	KuyRsYnj70ykLS+GrbvHH3F9dYonc3BsoVIXpF05hPGi5lHNhr5sAdDEaj85DasCHzGm8VNZhol
	u+T/onspc6SZcmyqLDaK6gHdLCgt1P1TPO9nLMiAc
X-Gm-Gg: ASbGncuX1QgBs2UYGC/bT0SQy8b/Xox5cwS253q1o3sba0TrVgqdz4u74MWHhGLf0Qt
	e+e6qs2hnQjiTNkWsKLiSBn76sCVHBv8LCTyKYMqAy8asxif9574KSSzFyZy7yswpf/GtSFZbli
	tDn/f/JQbGX3s7Zeqhc7vxqj9oWDAuLWB10du4YFYLLo+r0+dBmJRPMePvR7iiD4fBxITI/ZDxu
	EXpAxACJ/C+I/KuVRIb/KvKtyCB8b4GtHGh
X-Google-Smtp-Source: AGHT+IHDV1rc+1k30ZIFBg2iWzO6Aqcj2aw00dNs3kyTA7LZS3R9ReLSJW13d5vnaVdQX5/G4eDt5Yy+2KuXklmaLCI=
X-Received: by 2002:a17:90b:2783:b0:32b:cb15:5fdc with SMTP id
 98e67ed59e1d1-32ee3f7b5ccmr8386857a91.30.1758210877023; Thu, 18 Sep 2025
 08:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916220355.252592-36-paul@paul-moore.com> <20250916220355.252592-56-paul@paul-moore.com>
 <4db3bb94c42f11240a880a439c7a678599d7053f.camel@linux.ibm.com>
In-Reply-To: <4db3bb94c42f11240a880a439c7a678599d7053f.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 Sep 2025 11:54:23 -0400
X-Gm-Features: AS18NWC1b94QOog6RbdqvrXeya74B2L8hD95Wq1ffHwpCbiapFQUtV65oPOBgnw
Message-ID: <CAHC9VhQNc5U7Oyny3NQX0zwEJSs6bHD2Orokgqt8Cu5s1-cRiQ@mail.gmail.com>
Subject: Re: [PATCH v4 20/34] lsm: cleanup the debug and console output in lsm_init.c
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 11:51=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> > Move away from an init specific init_debug() macro to a more general
> > lsm_pr()/lsm_pr_cont()/lsm_pr_dbg() set of macros that are available
> > both before and after init.  In the process we do a number of minor
> > changes to improve the LSM initialization output and cleanup the code
> > somewhat.
> >
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > Reviewed-by: John Johansen <john.johhansen@canonical.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/lsm.h      |  11 ++++
> >  security/lsm_init.c | 123 +++++++++++++++++++-------------------------
> >  security/security.c |   2 +
> >  3 files changed, 66 insertions(+), 70 deletions(-)
> >
> > diff --git a/security/lsm.h b/security/lsm.h
> > index dbe755c45e57..8dc267977ae0 100644
> > --- a/security/lsm.h
> > +++ b/security/lsm.h
> > @@ -6,9 +6,20 @@
> >  #ifndef _LSM_H_
> >  #define _LSM_H_
> >
> > +#include <linux/printk.h>
> >  #include <linux/lsm_hooks.h>
> >  #include <linux/lsm_count.h>
> >
> > +/* LSM debugging */
> > +extern bool lsm_debug;
> > +#define lsm_pr(...)          pr_info(__VA_ARGS__)
> > +#define lsm_pr_cont(...)     pr_cont(__VA_ARGS__)
> > +#define lsm_pr_dbg(...)
> >
> >                               \
> > +     do {                                                            \
> > +             if (lsm_debug)                                          \
> > +                     pr_info(__VA_ARGS__);                           \
> > +     } while (0)
>
> The existing pr_info and pr_cont themselves are #defines.  Is there a rea=
son for
> these new "#define"?  If there is a valid reason for having these new def=
ines,
> why aren't they simply prefixed with "lsm"?

With the creation of the lsm_pr_dbg() macro which gates the output on
the "lsm.debug" flag, I felt it was more consistent to name things
this way, even if lsm_pr() and lsm_pr_cont() are just effectively
renames of the existing pr_info() and pr_cont() symbols.

--=20
paul-moore.com

