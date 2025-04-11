Return-Path: <linux-integrity+bounces-5812-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BCDA85130
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 03:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E60465E00
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 01:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A643270EB9;
	Fri, 11 Apr 2025 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ShCFN5lc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C16226FD83
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 01:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334520; cv=none; b=F0pDBgZcyLVb80rIRxoI584lqkPz/jX+0XoH67EGPbG9KZNCyrwgzz38uabwQjSeObWqsmG1peXiYfDFfDj6EW9o8l8oOKV+sFJg016MX60BXxfndGClFAfPjpmN4X/CZIuu60UVZXD1N2AaWmJEBws13p8kBc5xxOWixKF1K5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334520; c=relaxed/simple;
	bh=0W34x8Ck2m4q/Qa+lzOYSRJAJBcw975BtQwXfNHZXj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xmwe/eZOmfVxfAhYXySKPapsAvpjy7qybxCVIABBb/Z0nfnGKocDUE/XdXNxSE4pN87r+CX42iaiWPT5m65iETIps1ALeetpHiMxK7Bv7UNnuvtmRkENM/oGWD4qFod9RvVr1QL2rShCi6YLVJxPVlgMvltXzNh5GcQe0T1PNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ShCFN5lc; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e6df1419f94so1158042276.0
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 18:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744334517; x=1744939317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDZj3yQ14A5xcIpe7c0DSs5qSG0Hnq5KDdt6cHHAOgY=;
        b=ShCFN5lcBIMD2qx87n80CsrOt1TElZUZ/3xNWFNSnMM5cqtnoJe077KRiCZb52IrlK
         zJi9mQToaJa6+MV1qUj9XtDfrv2wYtKWjgj3DPUmOalhR6t+On0UG9dL+rKLx5unhpLI
         6HPvtfdmARbLxfdux3fGN50TB2+w1T8TvggoVzcadtAkk1UvpqMQkKTeiHsW/vrbu9Pi
         IyKM165CYs2uku3Arc9FJSNJqLVeSHOPra+JgSmziW6UG7M2ZpgfIv37Pcgf04uMVbb0
         9qxHDz0/jaoZqz1fbxNH8TKC88iZwyBYCr4X8/q8uDmEZQm/HsnQXACGVIU+NOm3mG6d
         zufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744334517; x=1744939317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDZj3yQ14A5xcIpe7c0DSs5qSG0Hnq5KDdt6cHHAOgY=;
        b=ghpa13+DhcMLhzz85bTPVhouG59lEwK+88t+LkrCNNNWneFUfk+cs8P3cVkdNw4oYA
         RJ9tvRpv/LNBcqvaOmJyORVjNXUb8UOTZm8a1U1RBlAsvTBqeEhGZFwzZHbss8e8XLom
         acGGxO/ktXEWfIFChPSrHPg+lPCgllsHy5O6KO/fGCdyJtn5VkFJD9xEaY302CqTWUpm
         8bZrumvLV1fLGmUslM/6SaWaPt8V7NrBjV8CfdImHccRJ3vhjF+he6Z4szPrAzSmO5y2
         3kpIhEnmuplER6cZToHa3tsPA1omApp329VE1YW2m3lUURRx3CEvYbrCE85Bwy50P4Xa
         Q96A==
X-Forwarded-Encrypted: i=1; AJvYcCU30TTeim2hDMNhduOSBsGjXOw07TuxeesvVYZsykDIcrTcZCbeoDcMuFSAizuc7jlQORKc6a5DLA5RtrBs4HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRSPP+LloRJ7RR120ZxowECttXl0bDPqsnc+kyDgE+JnXqXZS9
	N54lOCBafQaQ4yN0sEgyLN8Y5ea5rmI8VgFn8neFiCltttQu70Y1wa+cckz9KQMbfyPnkzFzrzW
	F0979OAcSS5QLBbdQnbfZSfNzxhtCSTfQX0p8r+ZButpR71Y=
X-Gm-Gg: ASbGncspF3ZVnR0kC2ExdIIfRotCbXWWlFeXcqhcnNjU4ER8sIUDlt4ZNGSj/GgQnIT
	dfySA+wsj1pr1mH2e99lf//Pc/jZ/Ydq7WKxk71FL/PvFfBH4ZOTnqsm7+/rR4f+YLDRIzlX6ea
	b3nbmetGuxfKySsP8DavhLRw==
X-Google-Smtp-Source: AGHT+IG7WXGp7fnjjFYKUmfliUjJExX03/TYU/y9D8duxhk/OQGZU8sKLSMddfn2XvWf/re46nHpnP9HIJ7dpJxGopo=
X-Received: by 2002:a05:6902:91a:b0:e5a:b05e:4da8 with SMTP id
 3f1490d57ef6-e704e025162mr1839801276.42.1744334517198; Thu, 10 Apr 2025
 18:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-58-paul@paul-moore.com>
 <202504091649.E30A1670@keescook>
In-Reply-To: <202504091649.E30A1670@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 21:21:46 -0400
X-Gm-Features: ATxdqUFV6nml9Pgs1tXUY-RKXULr_XkSZF2rF4yd2I4HaYI1g1tN1bIqwvmlvGI
Message-ID: <CAHC9VhSFGfEJ1-f48hdBMgrXwCMcqxi22ze5WZz1N_yPuFdriQ@mail.gmail.com>
Subject: Re: [RFC PATCH 27/29] lsm: consolidate all of the LSM framework initcalls
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 7:52=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 02:50:12PM -0400, Paul Moore wrote:
> > The LSM framework itself registers a small number of initcalls, this
> > patch converts these initcalls into the new initcall mechanism.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/inode.c    |  3 +--
> >  security/lsm.h      |  4 ++++
> >  security/lsm_init.c | 14 ++++++++++++--
> >  security/min_addr.c |  5 +++--
> >  4 files changed, 20 insertions(+), 6 deletions(-)

...

> > @@ -503,7 +508,12 @@ early_initcall(security_initcall_early);
> >   */
> >  static int __init security_initcall_core(void)
> >  {
> > -     return lsm_initcall(core);
> > +     int rc_sfs, rc_lsm;
> > +
> > +     rc_sfs =3D securityfs_init();
> > +     rc_lsm =3D lsm_initcall(core);
> > +
> > +     return (rc_sfs ? rc_sfs : rc_lsm);
> >  }
> >  core_initcall(security_initcall_core);
>
> Hrm. Given these aren't really _lsm_ hooks, maybe just leave this out. I
> worry about confusing the lsm inits with the lsm subsystem's core inits.

I'm not too concerned about that, and I do prefer it this way.

> Or we need a new stacking type for "required"? But that seems ... heavy.

So I understand the motivation behind that, but that's a big hard "no"
from me at this point in time ;)

--=20
paul-moore.com

