Return-Path: <linux-integrity+bounces-6220-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 582F4AB7770
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 22:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A67A867593
	for <lists+linux-integrity@lfdr.de>; Wed, 14 May 2025 20:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABDE296709;
	Wed, 14 May 2025 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XcamvQgF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2A170A0B
	for <linux-integrity@vger.kernel.org>; Wed, 14 May 2025 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747256241; cv=none; b=q8rBVfKht/aXuL07uXmL8u8XNihR5GkOtOllCNziaDj4TuEhhWcxltBJZgKetAqaFKdsHLRC4YkkcvZACr9ImcaL4wNmcjJ4qL+AHaWBg17Aj+rGQIMHBNrLSDzOSDxsnF1qRJbdd/Nvq4TKcyusuZrdSpr5XHNUXETJhH2zOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747256241; c=relaxed/simple;
	bh=hvvQ2pUYnZJR61LFz/51B8Xyw9gpi8oWmkmoASpxPMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ro8f26JM7JTAtWdZX5WxKHdP3YBfbLL3wQhuIvZIbw43MCrncj/gIihaX/jTZBFOpHkt6IaBKIp44lzehYqn5vC4hD/y4oqvHK0JJAhKIHYyEga+9tgMUrP5JDbfEiPCVQfgFa1j+6BW/ulBhNzvG2+rumpw18hrepEA7YWnZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XcamvQgF; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e78e6396d36so202818276.3
        for <linux-integrity@vger.kernel.org>; Wed, 14 May 2025 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747256238; x=1747861038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlqmH4WT69hzfobPlD8etu8qibl5LWMx50hF3RsDw34=;
        b=XcamvQgFZuGH/wDntCfuVEzv9FG/Cs8FGp+bq+M/uf3XGE6buiBOtSWFO3NXvyF1jL
         kOKpCmGeiEwftY1jt0pjcNW0cgfM11U+bzm3kHBqpyt03/D7cUG0MFvEXKRiT3TAHRvk
         bxnOxhkgNEMfinBMSNMIuUiRZwbsuxo3c1Tbiwr94sjczvWeWjnGr0ggV1Px/PtV4WAT
         2v0il3Tq+H7CGh0RJLWiQqPHLwEUl4XN4LCPp3QzXp+yUob+ic8x1iubmfTUZzxufrgU
         boRB7/E6zgGqcETPp1oxC9Rwga0uZfuiBboU646r7TRxh/tRjyZnZdq5bJgoO4vVX5Di
         cM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747256238; x=1747861038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlqmH4WT69hzfobPlD8etu8qibl5LWMx50hF3RsDw34=;
        b=XnY3A2xTZjrVQ6pD1nqOhufmzjiIRGibwAtNleaA3H9/i+wxji2mawHnRJCWlp/Amq
         EPQxUdU9yDXQaiXsu+3FjbxR3uqJZT+jmVRnNOByA0y5I1unVWbPiA+kzXw0tQDMFhqf
         cuUenLjF0yh0bHzgnLrOMUfg8HbC88dOTnuiZbVFppF9fV4cFwCnUJZO4GoWlGShmiYA
         ZBoeW/Y4G8ONkYYiGY0X+fjsJ7xqBAJ+H4uHq2SC3dR5xLA2OSUK2ul3s8ERvDMcDqro
         zTbbDaWRppcnEH9gUAiCZvXEu/b8kPeeyWHv5498xruauam/wHiMF0XzOCeeLZnUs31m
         qUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxlfGySTY97bdApj3jlqpiB7WVzqzYludYEPTKkNj130RN9G9PDkoqNOgWDCoArgBLbGU9uGAp4sl4bU/2aKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeKYl1v8wU8dgx0SwSruUSGk+q0BPpvQKdUv1YaUXJDy+7rvV+
	A50nCu7kNnfsaquwjy42H/L52VDj2GKea4A7f3LBsHzguZtItMhLtYiQi0KWa3H5SzPDvVL/AQB
	dLww99PRjhm4ifmAMPYa17jZ6rjdHhIMjtyWM
X-Gm-Gg: ASbGnctouBJli3N5hdyPDNpJn35Z0hr7Jaq4leHxN4/9BacSrk73Znl3+8nhf2eYTeO
	Tp3LaHDknhyCRUVxuvPSydERieFCxNlWyCJjX2oa6N9OmWWRQvaHAvglElTQKEa+jZ1xPvwgVWX
	/h9CnSRLE+2UPTtusb7JxdGn8+q7kvBftI6MMhdHz2o4o=
X-Google-Smtp-Source: AGHT+IEl50Xu/vI+QbWzypfULTtnm70M/ccebQQobN7gDukIhD1K+vOzlCjYteIGVbw+npGcz0d50Mf5SbPrco5Va6c=
X-Received: by 2002:a05:6902:2e0f:b0:e79:1281:c4e7 with SMTP id
 3f1490d57ef6-e7b3d613ac2mr5927962276.48.1747256237829; Wed, 14 May 2025
 13:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-60-paul@paul-moore.com>
 <81106a29-90ce-4439-9b4c-60bb2962fe04@schaufler-ca.com> <CAHC9VhRUr+sXhLzDSjiG9bEVbzZd2u632dLMVpcCe6By_d_H4w@mail.gmail.com>
 <3d884912-6225-485b-a7dd-2aa4073265f2@schaufler-ca.com>
In-Reply-To: <3d884912-6225-485b-a7dd-2aa4073265f2@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 May 2025 16:57:06 -0400
X-Gm-Features: AX0GCFteL-GzhrL1nK-8Taj6ebOVTPAFysXn6CklaGbrkDpk3gpjTNx_RqmsztA
Message-ID: <CAHC9VhR5OFDvJNJLy9jKMsB4ZVx=phm6k6iebT6VuXD96kNEEA@mail.gmail.com>
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

On Wed, May 14, 2025 at 3:30=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 5/13/2025 1:23 PM, Paul Moore wrote:
> > On Tue, May 13, 2025 at 12:39=E2=80=AFPM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 4/9/2025 11:50 AM, Paul Moore wrote:
> >>> Add two new variables, lsm_count_prop_subj and lsm_count_prop_obj, to
> >>> count the number of lsm_prop entries for subjects and objects across =
all
> >>> of the enabled LSMs.  Future patches will use this to continue the
> >>> conversion towards the lsm_prop struct.
> >>>
> >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>> ---
> >>>  include/linux/lsm_hooks.h         | 6 ++++++
> >>>  security/apparmor/lsm.c           | 1 +
> >>>  security/bpf/hooks.c              | 1 +
> >>>  security/commoncap.c              | 1 +
> >>>  security/integrity/evm/evm_main.c | 1 +
> >>>  security/integrity/ima/ima_main.c | 1 +
> >>>  security/ipe/ipe.c                | 1 +
> >>>  security/landlock/setup.c         | 1 +
> >>>  security/loadpin/loadpin.c        | 1 +
> >>>  security/lockdown/lockdown.c      | 1 +
> >>>  security/lsm.h                    | 4 ++++
> >>>  security/lsm_init.c               | 6 ++++++
> >>>  security/safesetid/lsm.c          | 1 +
> >>>  security/security.c               | 3 +++
> >>>  security/selinux/hooks.c          | 1 +
> >>>  security/smack/smack_lsm.c        | 1 +
> >>>  security/tomoyo/tomoyo.c          | 1 +
> >>>  security/yama/yama_lsm.c          | 1 +
> >>>  18 files changed, 33 insertions(+)
> > ..
> >
> >>> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> >>> index 40efde233f3a..c72df6ff69f7 100644
> >>> --- a/security/bpf/hooks.c
> >>> +++ b/security/bpf/hooks.c
> >>> @@ -18,6 +18,7 @@ static struct security_hook_list bpf_lsm_hooks[] __=
ro_after_init =3D {
> >>>  static const struct lsm_id bpf_lsmid =3D {
> >>>       .name =3D "bpf",
> >>>       .id =3D LSM_ID_BPF,
> >>> +     .flags =3D LSM_ID_FLG_PROP_SUBJ | LSM_ID_FLG_PROP_OBJ,
> >> There's a problem here. BPF can have properties, but usually does not.
> >> Unless there's a bpf program loaded that provides them it is incorrect
> >> to use these flags. You can't know that at initialization.
> >>
> >> I have an alternative that will address this that I will propose
> >> shortly.
> > Okay, thanks.
>
> In my coming audit patch I changed where the counts of properties are
> maintained from the LSM infrastructure to the audit subsystem, where they=
 are
> actually used. Instead of the LSM init code counting the property users, =
the
> individual LSM init functions call an audit function that keeps track. BP=
F
> could call that audit function if it loads a program that uses contexts. =
That
> could happen after init, and the audit system would handle it properly.
> Unloading the bpf program would be problematic. I honestly don't know whe=
ther
> that's permitted.

BPF programs can definitely go away, so that is something that would
need to be accounted for in any solution.  My understanding is that
once all references to a BPF program are gone, the BPF program is
unloaded from the kernel.

Perhaps the answer is that whenever the BPF LSM is enabled at boot,
the audit subsystem always queries for subj/obj labels from the BPF
LSM and instead of using the normal audit placeholder for missing
values, "?", we simply don't log the BPF subj/obj fields.  I dislike
the special case nature of the solution, but the reality is that the
BPF is a bit "special" and we are going to need to have some special
code to deal with it.

Of course I'm open to other ideas too ...

--=20
paul-moore.com

