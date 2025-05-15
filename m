Return-Path: <linux-integrity+bounces-6240-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAF4AB9121
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 23:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B553BFA7D
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 21:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D5627E7D1;
	Thu, 15 May 2025 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XiL8FJUm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870E1A01B9
	for <linux-integrity@vger.kernel.org>; Thu, 15 May 2025 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342958; cv=none; b=M2xDK5NqUKCql1inNtoQlV7bvF4FD3x1i12dkuZFJEvF4FTxI5BP4pcZTUau6skR7WHdW2Tchksv2ST9KvtEOSaCrnG5459BnuLGutDtc4m7fS0MUcoNn287Wtf2Kzcob8POrgavk1KvidSojDhSgYLlm5fJectpd55Yav0jgrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342958; c=relaxed/simple;
	bh=26lORAklMyj3fACbwa3+V7HA6m0rRTkAPbAuDxglhgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKOaYtK1/VoLAmsCfs28Oz6aETztJB1O3zSrL0qqFc3dtoJJ77HaWyzKwtAUQW3BYn4Ue5QINnChwMaAQlVeK2wtkHGkek7/SL6iHF8j+YbeASB+q/Hn1zVlBq8ZiruohvRvhK8TKKS1gVsx8ntcX0bPE5bjVaWMv6ywrLfpHcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XiL8FJUm; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7b3178473eso1436268276.2
        for <linux-integrity@vger.kernel.org>; Thu, 15 May 2025 14:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747342955; x=1747947755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpA+fUmCWeSlCnAM5f9BQqcfVNSkTiIQtWWOa60sp2U=;
        b=XiL8FJUmFGRnUMqoKtA/ruHD3tcMj1OcxzQFBX7d8tMj4I6tokx/9piGuH8vHN/B14
         l4uqBVDanrbOs149W3cYP1j5HJCR7rKRyPzhT2ak16KOJPG2u2akDr9W6rIvgaVZp9Go
         gVRnulBQNJu3OrgtRkis/35NDz5cNnlN4NoEMulEleFsCoovV0/WXZ7sidL5qdltiofw
         Tl7aAe0BZCtJ6lH+Ww7s/ie7yMNmO1D8d9ouXq3QTXjClHuq+sHM2tGpKN6rza6kRjA+
         SyzWdrCTmMsFC5AvpT/JNy4ZTxSgvKuO8nCXdtBhIThGkEvYTafseZhIUa3DTYgHy+iD
         tb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342955; x=1747947755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpA+fUmCWeSlCnAM5f9BQqcfVNSkTiIQtWWOa60sp2U=;
        b=mgQyFPHL2dd4TeF5hgJxLuWUZiEsKT6xlPkzjWtQHDbA7s5bE5BnsnGUPo25Z33AW2
         x2VnfgXxeN2cIlt7f70Wn0rTosVmaIF99y+4L0GeWJ9fcYyfTimJRqy6VpCLEMPfuMmY
         2aEHWSEURNo3tqiNV3vu5QJd2KPPnJptIpM8GVHbdH3rukjxNPCC6zAlfVm4l724g/2G
         Tlnvx1+cjr/LLSIzHFBf1THoQCWOkf05O3B5NrEdhAgtXVEh9BI1K3pcQc+LlbUkEzBu
         2HSzmv6/rIvw8HRTPOdN8LjSZy7NTH6w4STY58Yt1Gp6jKhEXqPIT2XNPYIchtsAB6+i
         C03Q==
X-Forwarded-Encrypted: i=1; AJvYcCXf0g+0LMuHjoSMgoGgjRiJRSpDTVbkUPRnuCs0J/y16ZeRrCZOMgwGT/vw1rLXBKPkeQtzsezm2hzUGQdkqGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xhCrKi3Ni4bCFWxw8MnkC/9vdiaAQN44fJjdi2NGCME5QEax
	LqtPFHnPZ103XFKvGFU6CHVnmfcZs8b03hVXQc7DUXrWkovBc8SuAYgPdXPwhGsDzFka41o+FyR
	3Xy7eVzbeuqhgRzHKNSNyArkW0Vur/aVA/ivHTvwf
X-Gm-Gg: ASbGncshom5RZdlaa8zN2bHw5BDsT/uTV16z+kgQstdxR9+jvlQVoVDoHG8o99Kn6EH
	5Hfi9O/1WB30u3aMYweyY0CQN9M0mEhSRCEFa3TxPlPv5Iz4BP2/3FWKct9J1ajjyn1KV/8AmqS
	tOSBG72xNXqNHsl3LbjV19SbY7dFlPZNfF
X-Google-Smtp-Source: AGHT+IFG4xJfXunSgZQeenjERt+7u3aBw98sMz9/+SZ1qA5bJgp4wIFrzJokOJs37W4C7WHtZPHLnos8TQBVMXB5/Ck=
X-Received: by 2002:a05:6902:990:b0:e72:97bc:a1a1 with SMTP id
 3f1490d57ef6-e7b69d546cemr1735351276.7.1747342954909; Thu, 15 May 2025
 14:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-60-paul@paul-moore.com>
 <81106a29-90ce-4439-9b4c-60bb2962fe04@schaufler-ca.com> <CAHC9VhRUr+sXhLzDSjiG9bEVbzZd2u632dLMVpcCe6By_d_H4w@mail.gmail.com>
 <3d884912-6225-485b-a7dd-2aa4073265f2@schaufler-ca.com> <CAHC9VhR5OFDvJNJLy9jKMsB4ZVx=phm6k6iebT6VuXD96kNEEA@mail.gmail.com>
 <c5b81e66-7e73-41cb-a626-9f18f6074e53@schaufler-ca.com> <CAHC9VhSiGc16g36gtZvWKYdtdx-3WG7HbWWhNXvPSBRfA7uphQ@mail.gmail.com>
 <5df7b895-888e-4aa0-a21f-0a8264158bfa@schaufler-ca.com> <CAHC9VhScu-AsvOAJ+4VoQB_QTmhuFGwVXmQF2PpgH+D-qLi7=w@mail.gmail.com>
 <9351b5b9-ee06-464d-96d8-9fb5a9c94c82@schaufler-ca.com>
In-Reply-To: <9351b5b9-ee06-464d-96d8-9fb5a9c94c82@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 May 2025 17:02:22 -0400
X-Gm-Features: AX0GCFtfuLfEqOgBjxD362RxeF-rLbRPhgbBA9x9mCqA2h8izdggIEODynqOF_o
Message-ID: <CAHC9VhTwQY1g8tUHLzaLVEJA9ib0Z-_H0m+dPBZfYhEabGYwVQ@mail.gmail.com>
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

On Thu, May 15, 2025 at 3:41=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 5/15/2025 11:13 AM, Paul Moore wrote:
> > On Thu, May 15, 2025 at 10:12=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 5/14/2025 3:11 PM, Paul Moore wrote:
> >>> On Wed, May 14, 2025 at 5:16=E2=80=AFPM Casey Schaufler <casey@schauf=
ler-ca.com> wrote:
> >>>> On 5/14/2025 1:57 PM, Paul Moore wrote:
> >>>>> On Wed, May 14, 2025 at 3:30=E2=80=AFPM Casey Schaufler <casey@scha=
ufler-ca.com> wrote:
> >>>>>> On 5/13/2025 1:23 PM, Paul Moore wrote:
> >>>>>>> On Tue, May 13, 2025 at 12:39=E2=80=AFPM Casey Schaufler <casey@s=
chaufler-ca.com> wrote:
> >>>>>>>> On 4/9/2025 11:50 AM, Paul Moore wrote:
> >>> ..
> >>>
> >>>>>> In my coming audit patch I changed where the counts of properties =
are
> >>>>>> maintained from the LSM infrastructure to the audit subsystem, whe=
re they are
> >>>>>> actually used. Instead of the LSM init code counting the property =
users, the
> >>>>>> individual LSM init functions call an audit function that keeps tr=
ack. BPF
> >>>>>> could call that audit function if it loads a program that uses con=
texts. That
> >>>>>> could happen after init, and the audit system would handle it prop=
erly.
> >>>>>> Unloading the bpf program would be problematic. I honestly don't k=
now whether
> >>>>>> that's permitted.
> >>>>> BPF programs can definitely go away, so that is something that woul=
d
> >>>>> need to be accounted for in any solution.  My understanding is that
> >>>>> once all references to a BPF program are gone, the BPF program is
> >>>>> unloaded from the kernel.
> >>>>>
> >>>>> Perhaps the answer is that whenever the BPF LSM is enabled at boot,
> >>>>> the audit subsystem always queries for subj/obj labels from the BPF
> >>>>> LSM and instead of using the normal audit placeholder for missing
> >>>>> values, "?", we simply don't log the BPF subj/obj fields.  I dislik=
e
> >>>>> the special case nature of the solution, but the reality is that th=
e
> >>>>> BPF is a bit "special" and we are going to need to have some specia=
l
> >>>>> code to deal with it.
> >>>> If BPF never calls audit_lsm_secctx() everything is fine, and the BP=
F
> >>>> context(s) never result in an aux record. If BPF does call audit_lsm=
_secctx()
> >>>> and there is another LSM that uses contexts you get the aux record, =
even
> >>>> if the BPF program goes away. You will get an aux record with only o=
ne context.
> >>>> This is not ideal, but provides the correct information. This all as=
sumes that
> >>>> BPF programs can call into the audit system, and that they deal with=
 multiple
> >>>> contexts within BPF. There could be a flag to audit_lsm_secctx() to =
delete the
> >>>> entry, but that seems potentially dangerous.
> >>> I think the answer to "can BPF programs call into the audit subsystem=
"
> >>> is dependent on if they have the proper BPF kfuncs for the audit API.
> >>> I don't recall seeing them post anything to the audit list about that=
,
> >>> but it's also possible they did it without telling anyone (ala move
> >>> fast, break things).  I don't think we would want to prevent BPF
> >>> programs from calling into the normal audit API that other subsystems
> >>> use, but we would need to look at that as it comes up.
> >> I suggest that until the "BPF auditing doesn't work!!!" crisis hits
> >> there's not a lot of point in going to heroic efforts to ensure all
> >> the bases are covered. I'll move forward assuming that an LSM could
> >> dynamically decide to call audit_lsm_secctx(), and that once it does
> >> it will always show up in the aux record, even if that means subj_bpf=
=3D?
> >> shows up every time.
> > My only concern is that I suspect most/all of the major distro enable
> > the BPF LSM by default which means that suddenly a lot of users/admins
> > are going to start seeing the multi-subj/obj labeling scheme only to
> > have an empty field logged.
>
> That will only occur if a BPF program says it want to provide contexts
> and then stops doing so, either by exiting or in error. As no BPF program=
s
> currently use audit, it seems that this is at worst a future problem.
> Should BPF programs develop the ability to use audit the behavior will ne=
ed
> to be documented. I don't see how we can anticipate what they'll end up
> trying.

Okay, I must have misunderstood your proposal; I'll take a look once
it is posted, that should help clear things up.

--=20
paul-moore.com

