Return-Path: <linux-integrity+bounces-6194-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566A8AB5DA3
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 22:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8B28604E2
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 20:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9AE1EB5CB;
	Tue, 13 May 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="O1V0x0e8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FC1F866A
	for <linux-integrity@vger.kernel.org>; Tue, 13 May 2025 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747167823; cv=none; b=TpvvH9qJCC+73HpaLpiYcRZ/+VV2lTGucaFkPiyowMQIE/14INDOz2K0XEjx2rnZutVgFXfkwoeM0xTHN0hHb7+SYzYDIj+p8egTguWkOnI56c9wdmA5sf1pQzkDcnUY40/5Ljy/j5rFik7HyRcZ2DR+2oRC0Lp9/FAm9WgsgtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747167823; c=relaxed/simple;
	bh=0DWhoiiGjt4cEmztHGaRcxM7LEQhF04hQ+Li3wBs71U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+9JRlkZvuQnyP0+F4PBVOosLuswJQT2Or7VNvzS7TYGIBLazkZQDcIoZsRHXlVcJB6l20Il45q5HpMKYHkiTGYeutc5OkZiCce9CtuRuwNS8WeLIpCLX1G8C2YfmncYfpdydHR80TaKdnW8D0/3LjVggK4zekX3lGDL//+M/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=O1V0x0e8; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so5990494276.3
        for <linux-integrity@vger.kernel.org>; Tue, 13 May 2025 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747167819; x=1747772619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIQU/NXe9ILd4+pIUnQ5aBv1djsj2ZIPCNccu5ShGRY=;
        b=O1V0x0e8pyWEW8mTNMKRsvM1P1F/o4pUP+CYoBUGVKlpI6GOvFxwgxciHWwcuynCx2
         VkK1kBHsoK0Bg6p2sVGA4PqPXyLwyJdnJu8+2fO1J7bLgq+5LlEBY6pIRs97vanBbpG+
         2iP6w0QeusWENB50BYxQGLa8f4245sxRVe1trXsT/GxtqDDZhQk0WgMaLERuYDqoffoi
         SMD5wdjNti9GiWLKe5F6wMsxFz7AHn3FFRZHfDfEslCdppav7qkDXmohblSXQRW7zFM2
         q3Ki189JRsQZABJQg0xAjhfvxVjeo4kfDqFy5Si0LiI0ERABOEZWDbtn6G9IFK307bPX
         XG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747167819; x=1747772619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIQU/NXe9ILd4+pIUnQ5aBv1djsj2ZIPCNccu5ShGRY=;
        b=G5FTVrwxye1XN2woe1O36QLa0gDiWqcwl+mjKxK/pvWXbEwhuEV5yo90+5TpBShu9u
         MBvk9zZH6QbPnN2Hra2XonXecWHNwGj6glvEspnI4uIBaI6uVMj1SGO69paDH9ru3xWm
         1eDDTrAYq5BdNMs+rAjnOMbdjn8gr+4TVBR1GFBQ3LHyvAV2wXQTU6MeeJw5XNBQVbfU
         rVbdNoBj1TMKuks6HQQuwsqFcypB2FM3lirnnOeOmFMiTq722Gu/+lwGoPx1P5MGKdSo
         L7nL4wIfMcpHIqGeBOpaDwKAxDQa4IBYEuzPQtiZ121K4l9ctuu4WwNaPIgkctqC54hf
         zskA==
X-Forwarded-Encrypted: i=1; AJvYcCXaDzBHSPCCL3uUQxviihDGqAjVSoaUydWrwkFD++RvMQZNnJGR6mU43htPe5c0ngsABdE4mtQ+Y9eF1cx/ghE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzNrSp+80XHsduinzWmynSzX8gr0kZYPifMqrN+d7MaLVOy+WU
	Fe93JEsemeEsCvPzTPz10xD6LdoWFyzcA84nQDSyI+vEHWSjQljVJuLplEZuz2WKi2xayEMyGCM
	HXThQvXqHpLrZVqx5tWdbsPUrQ0Bm1st6XhUN
X-Gm-Gg: ASbGncvToaIJToLXzDWn/10gokOSQd24AKEbO/WBg/Q3ttqrQu1BoSDKQfHmc2FHVtU
	3r1ebXwTbAqHRD+hiM9VBb4KQ0rBkAPyJEhfWUo/KSmkE7ry0wnMxGmKpUkpt3H+Ilss5kjxqk+
	aqtJZKi/oTcrrhYf5dJosScogm7RWn4PbxSm4v1B+mUkg=
X-Google-Smtp-Source: AGHT+IGu7ZC+8RLKMNHM8plULPDrisp0DJLXbvTpcBWmGjCYCIjahQPMq5yl9BfPO3JpLi7liq4enj3+g8NvQjd+7u0=
X-Received: by 2002:a25:d016:0:b0:e7b:33d1:3bf6 with SMTP id
 3f1490d57ef6-e7b3d5d570emr740981276.34.1747167819570; Tue, 13 May 2025
 13:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-60-paul@paul-moore.com>
 <81106a29-90ce-4439-9b4c-60bb2962fe04@schaufler-ca.com>
In-Reply-To: <81106a29-90ce-4439-9b4c-60bb2962fe04@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 May 2025 16:23:28 -0400
X-Gm-Features: AX0GCFvRVrYvZ-PQXUB54yV2bYzKcz9N97bT_M-AxzEvX8EdbeG8EddltVHS7O4
Message-ID: <CAHC9VhRUr+sXhLzDSjiG9bEVbzZd2u632dLMVpcCe6By_d_H4w@mail.gmail.com>
Subject: Re: [RFC PATCH 29/29] lsm: add support for counting lsm_prop support
 among LSMs
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 12:39=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 4/9/2025 11:50 AM, Paul Moore wrote:
> > Add two new variables, lsm_count_prop_subj and lsm_count_prop_obj, to
> > count the number of lsm_prop entries for subjects and objects across al=
l
> > of the enabled LSMs.  Future patches will use this to continue the
> > conversion towards the lsm_prop struct.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  include/linux/lsm_hooks.h         | 6 ++++++
> >  security/apparmor/lsm.c           | 1 +
> >  security/bpf/hooks.c              | 1 +
> >  security/commoncap.c              | 1 +
> >  security/integrity/evm/evm_main.c | 1 +
> >  security/integrity/ima/ima_main.c | 1 +
> >  security/ipe/ipe.c                | 1 +
> >  security/landlock/setup.c         | 1 +
> >  security/loadpin/loadpin.c        | 1 +
> >  security/lockdown/lockdown.c      | 1 +
> >  security/lsm.h                    | 4 ++++
> >  security/lsm_init.c               | 6 ++++++
> >  security/safesetid/lsm.c          | 1 +
> >  security/security.c               | 3 +++
> >  security/selinux/hooks.c          | 1 +
> >  security/smack/smack_lsm.c        | 1 +
> >  security/tomoyo/tomoyo.c          | 1 +
> >  security/yama/yama_lsm.c          | 1 +
> >  18 files changed, 33 insertions(+)

...

> > diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> > index 40efde233f3a..c72df6ff69f7 100644
> > --- a/security/bpf/hooks.c
> > +++ b/security/bpf/hooks.c
> > @@ -18,6 +18,7 @@ static struct security_hook_list bpf_lsm_hooks[] __ro=
_after_init =3D {
> >  static const struct lsm_id bpf_lsmid =3D {
> >       .name =3D "bpf",
> >       .id =3D LSM_ID_BPF,
> > +     .flags =3D LSM_ID_FLG_PROP_SUBJ | LSM_ID_FLG_PROP_OBJ,
>
> There's a problem here. BPF can have properties, but usually does not.
> Unless there's a bpf program loaded that provides them it is incorrect
> to use these flags. You can't know that at initialization.
>
> I have an alternative that will address this that I will propose
> shortly.

Okay, thanks.

--=20
paul-moore.com

