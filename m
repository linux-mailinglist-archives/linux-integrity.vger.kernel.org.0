Return-Path: <linux-integrity+bounces-6238-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B2DAB8E9F
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 20:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F8B1BC766B
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB9325B67B;
	Thu, 15 May 2025 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ACl7Wdk0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8AEC120
	for <linux-integrity@vger.kernel.org>; Thu, 15 May 2025 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332847; cv=none; b=KbWPKLBjYbsuZivvPVlofWoonXp5XZ7YWcYbK4ijXIVEirTvqQ49fe7DgJ3WxIGJuiZ1fedmV9RFPkW8yfy2oZiYXb6/5hVfujrwqFbIcVKKLIKV7axNq2GfJvc/miAtFYi1Om24RpgOcw6op9iy6ORIAE6wnNZzAUaP1Q92OUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332847; c=relaxed/simple;
	bh=clcjMFwjzq1K/HoDraAXYcNw0jxFnXWgfH8D6iM8jDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ab53EH6zaY7bTNdJhelvOileOXnpjjRsIKJAgwV9loSjvvghjCioDxaXdF1ar8Pf1uZnsqck9Fe3PlyjYskQneL870sEvKOj6tV6452yarCmDSU3I/mB5NVa4UN8ORxLBTuPd7VwcPkIPw74v1zwokZWKN7lLkd18WiB8kViUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ACl7Wdk0; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7b3410e122so1292818276.2
        for <linux-integrity@vger.kernel.org>; Thu, 15 May 2025 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747332844; x=1747937644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmhE0ZyXFIMq1ejroEpNwIAE09HwUrQ/oEQO4pBE8KQ=;
        b=ACl7Wdk0W5e2KTIuqHvYvU0CYvoNsGWGS2YMhVzQnqtcIQeoRpf8+reVgvdeYZokai
         qMuTFFQSocgOpVo1pQVQMr6/fBJqDEW2XnSHnMwJpqsH+LaDclsPSBUFYRmZWzI/SfeZ
         c8z5HxNGuIWNx3nfxTSX7b32HqTEvB/4/B4fpICUd4Tj77jAehuX48RMGhCE7LT0+n2S
         W6Z8PRhAruZ+fFgfOsPWU5iXKa0zmrsk+OwbpWww5G8DyHmxpx10J2cqzQc1Iqu/aZx9
         qqWReAqNItf2TlbU1hUn1aYwFK0VNEM8NFBQwXnODIWj2yaRNG79MnwuB9RJ1OnB4nXR
         eVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747332844; x=1747937644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmhE0ZyXFIMq1ejroEpNwIAE09HwUrQ/oEQO4pBE8KQ=;
        b=YbqQrhCwzeuC8eSDESJ8j2yaqDpyIFhzR7JNj43x8iCoBUs9h7KyFpV9NS4rsL/QFM
         WxpM2H0tLX8Jcf11HXBL3hjiAPGpvDMXqLHInLFH6ZSrZR3lgklSwitHFP8+EWctXQzd
         MDk24PpEKr5dZs3vsyOq5FIulVlVyxbspwUtHJIe7LLJRU2ZdTSzqGaml+FYk0QYY5TE
         FmTKbJSI8rOSEKc/FU6d6YObtWpyi+YNd35CVwlFz+z+ZN3XiPwRTbfL0fOr3FS1TvVM
         o8SnN4SnS3mZpWP4sv3SKTKRNdrpNDd6f6/LO2ttf4NmJq0Mu8Vol+1WHv5bLoC4iK8C
         aXAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnr3Xx/8Q7vxMmIAG/HdKY0eNFblQ/ukCm6UNMjdpCVy2tO8sUGe/j0lhRpF+6YdrVLjAioVXxGzGUnGlRBI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dyy8RLw+Svoh6WCXxxGne0bs7TYmrQB8tAvFDExKYRv0Wf3a
	5Q6z4LX9BvNM51qazewvVLNU2Np9YOYtFEtAJN4PfNUAxV1E8M/QphIBxAEb6T4JvN2KqxTTWpP
	mBrUxBspgMZJ00yIf7l679Fq9SfwYszkkPryVecz4
X-Gm-Gg: ASbGnctzq3HLSH/CwhAb4hMOFcRBelkf9Ttkz0243UxvWZDZ0GBI7HGKpbRxnRCk/m8
	icVSplQBSWrJcUmQ730mCCwNPd23TJcv7PYtsj9VGShjV4Jp+D/gdn3UeqxhqZkvpD05cKfdVJA
	GcNLrJaKpiNOSrZWwut2ryEb14ZH4CDg0fGxv31wyL/fE=
X-Google-Smtp-Source: AGHT+IFy670LlAegjCytZhdLu7KK8GCvgi4jANvaDLaVu1jBwnv38qWvqDWmYrWEdt4vIjmJKbKAIG64bXyYibiNH+M=
X-Received: by 2002:a05:6902:e0a:b0:e7b:6499:c9a9 with SMTP id
 3f1490d57ef6-e7b6a0a9ccbmr843090276.26.1747332844169; Thu, 15 May 2025
 11:14:04 -0700 (PDT)
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
 <5df7b895-888e-4aa0-a21f-0a8264158bfa@schaufler-ca.com>
In-Reply-To: <5df7b895-888e-4aa0-a21f-0a8264158bfa@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 May 2025 14:13:53 -0400
X-Gm-Features: AX0GCFv1XixYnJIYpriKgewGWoFqrzG1K0YAkWW4-n7gSHnWYpH7UfxE82NSNaE
Message-ID: <CAHC9VhScu-AsvOAJ+4VoQB_QTmhuFGwVXmQF2PpgH+D-qLi7=w@mail.gmail.com>
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

On Thu, May 15, 2025 at 10:12=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> On 5/14/2025 3:11 PM, Paul Moore wrote:
> > On Wed, May 14, 2025 at 5:16=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 5/14/2025 1:57 PM, Paul Moore wrote:
> >>> On Wed, May 14, 2025 at 3:30=E2=80=AFPM Casey Schaufler <casey@schauf=
ler-ca.com> wrote:
> >>>> On 5/13/2025 1:23 PM, Paul Moore wrote:
> >>>>> On Tue, May 13, 2025 at 12:39=E2=80=AFPM Casey Schaufler <casey@sch=
aufler-ca.com> wrote:
> >>>>>> On 4/9/2025 11:50 AM, Paul Moore wrote:
> > ..
> >
> >>>> In my coming audit patch I changed where the counts of properties ar=
e
> >>>> maintained from the LSM infrastructure to the audit subsystem, where=
 they are
> >>>> actually used. Instead of the LSM init code counting the property us=
ers, the
> >>>> individual LSM init functions call an audit function that keeps trac=
k. BPF
> >>>> could call that audit function if it loads a program that uses conte=
xts. That
> >>>> could happen after init, and the audit system would handle it proper=
ly.
> >>>> Unloading the bpf program would be problematic. I honestly don't kno=
w whether
> >>>> that's permitted.
> >>> BPF programs can definitely go away, so that is something that would
> >>> need to be accounted for in any solution.  My understanding is that
> >>> once all references to a BPF program are gone, the BPF program is
> >>> unloaded from the kernel.
> >>>
> >>> Perhaps the answer is that whenever the BPF LSM is enabled at boot,
> >>> the audit subsystem always queries for subj/obj labels from the BPF
> >>> LSM and instead of using the normal audit placeholder for missing
> >>> values, "?", we simply don't log the BPF subj/obj fields.  I dislike
> >>> the special case nature of the solution, but the reality is that the
> >>> BPF is a bit "special" and we are going to need to have some special
> >>> code to deal with it.
> >> If BPF never calls audit_lsm_secctx() everything is fine, and the BPF
> >> context(s) never result in an aux record. If BPF does call audit_lsm_s=
ecctx()
> >> and there is another LSM that uses contexts you get the aux record, ev=
en
> >> if the BPF program goes away. You will get an aux record with only one=
 context.
> >> This is not ideal, but provides the correct information. This all assu=
mes that
> >> BPF programs can call into the audit system, and that they deal with m=
ultiple
> >> contexts within BPF. There could be a flag to audit_lsm_secctx() to de=
lete the
> >> entry, but that seems potentially dangerous.
> > I think the answer to "can BPF programs call into the audit subsystem"
> > is dependent on if they have the proper BPF kfuncs for the audit API.
> > I don't recall seeing them post anything to the audit list about that,
> > but it's also possible they did it without telling anyone (ala move
> > fast, break things).  I don't think we would want to prevent BPF
> > programs from calling into the normal audit API that other subsystems
> > use, but we would need to look at that as it comes up.
>
> I suggest that until the "BPF auditing doesn't work!!!" crisis hits
> there's not a lot of point in going to heroic efforts to ensure all
> the bases are covered. I'll move forward assuming that an LSM could
> dynamically decide to call audit_lsm_secctx(), and that once it does
> it will always show up in the aux record, even if that means subj_bpf=3D?
> shows up every time.

My only concern is that I suspect most/all of the major distro enable
the BPF LSM by default which means that suddenly a lot of users/admins
are going to start seeing the multi-subj/obj labeling scheme only to
have an empty field logged.

--=20
paul-moore.com

