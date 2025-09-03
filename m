Return-Path: <linux-integrity+bounces-7006-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D25B42ADE
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 22:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965505E4CF5
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 20:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991432E7F1A;
	Wed,  3 Sep 2025 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZkE6CsCz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161A92E6CB6
	for <linux-integrity@vger.kernel.org>; Wed,  3 Sep 2025 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931201; cv=none; b=ZoG3WBe2/3/CjkQMzTlRoD6fGeUREcWjtP/SA5nG7IGsSdmO7wVu9dOMApXRDcUk18MpFVssIByxCoxaz45jCf/5Mg76JvUzYtiPWsAbMLMC/4NYXtvSGs+5Way/DHUEItYrtYvVVU1oeO8Py7dqygYwNI18TBlSSdRV7aEg5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931201; c=relaxed/simple;
	bh=0MaG39Q10+lRsjDKYez8QkznlAN7+rEuOEcO8KHI5a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTyEM6lzcEOyRy7X6yuZWBMZvjxT0cDqbkbdzcm94XqRT1i8dxE/yPCv9D57zo0vdPDPDmNSdMsWs00swlsVdIGWnMt1C5Z7pJZ/AW/cGRTclipaJRyDu4qq4FkClyCVDZVWluPQpaQhtdTPQwtfh2vEZRrL4uPX3dNeo/Q77bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZkE6CsCz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32b02d88d80so226785a91.0
        for <linux-integrity@vger.kernel.org>; Wed, 03 Sep 2025 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756931199; x=1757535999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXOKUhuO1qAsEEf2zdDA37wCLb2DEnMcoGNBMXWm0MY=;
        b=ZkE6CsCziq8zVGP9z73lM6U9o7/BXD4HzR9kNQfyCbvZOBSeAnbO4UohlU7z0woW6T
         srUizqZ6kBhlN553jVhSoQODEOUTYOb/dHnRCQ4lQnMd5TBphl9UvAFZTMZSPSIJUllM
         MBnl/mCRq6HdGpYI3B8+BCp8QVKqTM22vBgzTIFoKA7WgEyLf8perBKVUUg6bLbhinJi
         uM5lcV5XiZqKrv+YKj3Qzh3pJnXvbWWxzYr+Z/ibEEVt0ZMSYYl3cjM+HH3CJIe+a/Er
         f+x5KL607eya2h2G0sPICeCuVrNYv9JoJsqVqZ6ohrkzu6D5qEMBPFJT/N/6kgufysfb
         be7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756931199; x=1757535999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXOKUhuO1qAsEEf2zdDA37wCLb2DEnMcoGNBMXWm0MY=;
        b=jzW4oqXx2O7HNR0ukQk4ABPBKsHeri7+om8NBJ4VkVGyDqGHc5ZXEpiE6ynBLQTOeq
         +1mNhA4KzLIIacknSO7Er19iFxCfL1LQQEdJH24j1w8n9LUYwxvxul2WUROzs8WpHiyz
         tSchdZ3zqibz25jpbalmiJb0XYJU6GD0+NUhSVbWNq9bDkrLJ5rqldK47K3Gn/PuuhJX
         a+KXyFSm9AkBlN5yr2r6U9ZDslHLeIL4H//bTy7hWPEOCGdjd69HSs1D88hECFdnnQTs
         EOAYsAeC2TNfQbjRSRvgjr2LLa7iXzgkZASTDtml0XkeNzbiLxkTznZKSXaScmxKfy2u
         MOFg==
X-Forwarded-Encrypted: i=1; AJvYcCXYcs9GNwMYWhdvIq/Bl4VNkansSDJ8uUA24Xz81kQQHKucKZM0EAxRpy8W3s+E+O5MWrBWpVdrmV2M3jgg8gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbyoQ1bJASJ4+7ZRg4FPih5axOBU657RksMWWIpMPoc9aNvw55
	6shnsGgvR+0SAmoZdz+4WS67XHlpbvLzHoxeDSxpds9tP2sE0WaPvUuGp0J48Ye+TJD04B752Q3
	BVgMoMsOhxzXi/5Iwua4mZ/HfQuTMgmCP4lj1GA8w
X-Gm-Gg: ASbGncvbda1vgSFgGCUEOW8eaxKqz5HvLhroPo5itkxW/tV2j5Qj62sSJC0D3n7iR7O
	E7wr8EygGsjYHOrk5qWakUTQsn4HK1NY9UuBlS9jtZSRjyfgRxQgCMbxIdLW4aCNVQFTWu82lT7
	rASxrjgr4uocLh6TKcbbHOIl+r4/ByJMtfoKQIy5iSItMkDh7V1tdDLiB3i+vIebeGg3HlahZqp
	EAvJug=
X-Google-Smtp-Source: AGHT+IGlvup2xpjVL7Dhtel9vzzWcSj+zF8XRGa4iEdhrLRU5CzfIiVjQSX5z0wuO723g1nSxHsZHaxDuStGWwe0zYc=
X-Received: by 2002:a17:90b:2550:b0:32b:92ac:cfb6 with SMTP id
 98e67ed59e1d1-32b92acd0a2mr453692a91.12.1756931199212; Wed, 03 Sep 2025
 13:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-47-paul@paul-moore.com>
 <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com>
In-Reply-To: <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 16:26:26 -0400
X-Gm-Features: Ac12FXx8har4tdX6rI0dDPC0HOg1CPyZ1wT-CCBQj6hwAZvlOnWX7etUk1-2YCQ
Message-ID: <CAHC9VhQnFJLXrhcbQ2b7rWDNYjRRKoevqiKYchE_39ShcjgLEw@mail.gmail.com>
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some cleanup
To: John Johansen <john.johansen@canonical.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:20=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 8/14/25 15:50, Paul Moore wrote:
> > The LSM currently has a lot of code to maintain a list of the currently
> > active LSMs in a human readable string, with the only user being the
> > "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> > generate the string on first use and then cache it for subsequent use.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >   include/linux/lsm_hooks.h |  1 -
> >   security/inode.c          | 59 +++++++++++++++++++++++++++++++++++++-=
-
> >   security/lsm_init.c       | 49 --------------------------------
> >   3 files changed, 57 insertions(+), 52 deletions(-)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 7343dd60b1d5..65a8227bece7 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -172,7 +172,6 @@ struct lsm_info {
> >
> >
> >   /* DO NOT tamper with these variables outside of the LSM framework */
> > -extern char *lsm_names;
> >   extern struct lsm_static_calls_table static_calls_table __ro_after_in=
it;
> >
> >   /**
> > diff --git a/security/inode.c b/security/inode.c
> > index 43382ef8896e..a5e7a073e672 100644
> > --- a/security/inode.c
> > +++ b/security/inode.c
> > @@ -22,6 +22,8 @@
> >   #include <linux/lsm_hooks.h>
> >   #include <linux/magic.h>
> >
> > +#include "lsm.h"
> > +
> >   static struct vfsmount *mount;
> >   static int mount_count;
> >
> > @@ -315,12 +317,65 @@ void securityfs_remove(struct dentry *dentry)
> >   EXPORT_SYMBOL_GPL(securityfs_remove);
> >
> >   #ifdef CONFIG_SECURITY
> > +#include <linux/spinlock.h>
> > +
> >   static struct dentry *lsm_dentry;
> > +
> > +/* NOTE: we never free the string below once it is set. */
> > +static DEFINE_SPINLOCK(lsm_read_lock);
>
> nit, this is only used on the write side, so not the best name

Fair point, I'll rename it to lsm_read_str_lock, it still has "read"
in the name, but it should be a bit more clear that it references the
lsm_read_str variable.

> > +static char *lsm_read_str =3D NULL;
> > +static ssize_t lsm_read_len =3D 0;

Similarly, I'm renaming lsm_read_len to lsm_read_str_len.

> >   static ssize_t lsm_read(struct file *filp, char __user *buf, size_t c=
ount,
> >                       loff_t *ppos)
> >   {
> > -     return simple_read_from_buffer(buf, count, ppos, lsm_names,
> > -             strlen(lsm_names));
> > +     int i;
> > +     char *str;
> > +     ssize_t len;
> > +
> > +restart:
> > +
> > +     rcu_read_lock();
> > +     if (!lsm_read_str) {
>
> should probably be
> if (!rcu_access_pointer(lsm_read_str)) {

The description for rcu_access_pointer() contains the following sentence:

  "Within an RCU read-side critical section, there is little reason to
   use rcu_access_pointer()."
  https://elixir.bootlin.com/linux/v6.17-rc4/source/include/linux/rcupdate.=
h#L628

Perhaps I'm reading it wrong, but it looks like the RCU folks would
prefer we not use rcu_access_pointer() here?

--=20
paul-moore.com

