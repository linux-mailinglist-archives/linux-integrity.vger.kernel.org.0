Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E1926400
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2019 14:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfEVMsJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 May 2019 08:48:09 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:46145 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfEVMsJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 May 2019 08:48:09 -0400
Received: by mail-lf1-f44.google.com with SMTP id l26so1570318lfh.13;
        Wed, 22 May 2019 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=so71oic5MNIX7UjYg22Fsgw/dMesIEcibwby9XO5GTI=;
        b=utCS5nYhGEkR2JR3EAZkNkrWLGoW27eJ/PBlcxtnG5HFzwfyGptkVIy3ACk38lw4c4
         a3H0QmzBRjeYQF3oxoN+8AN2139+lF1xtgncfhWoQ60DNRJpoRa7uQOtUuAhamNRJ1Mp
         OKJjIUJS+x3/JN8/IlzbuvUcAJR81yW+1YB84mVZbImfzB2APSQSjWwHALi/waWxEHEv
         tawij3+d8+WnZNPzjyH/Q2YW26xBqhb9xwUqvGVFMvSZ95vfbHXpbdkcFjOxkOpd4xRS
         G7Hu/2UvjByOQnXGHW+c5aNZFvsZECFn0zBRCa8b0m71iIAVqIXR6A75vvKMlt5EZr3m
         wrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=so71oic5MNIX7UjYg22Fsgw/dMesIEcibwby9XO5GTI=;
        b=hddc6MmTb5Yt6RB93bIw4T9hS7yYlhGR7OTDMj8m9OewYr5J05QWPNgllhrsq9Nqrs
         zhvVaq9HqTzS+A8ipzx1pANLXZrAwszokYMT1K4NoW3G1Qld7ieboT8UuBGVmpI461a0
         JNRGwMqUy2Bb6BIlJrk/FA5npZpfuPI79LHW9etivk0KRiKXzEfZuRCi1ojm9bIL+mNq
         s9GFfWbawiVEif6BoE4jtggku2PmLOwzLjrAYF8kkzmCrYBalLUNXCUA5Kb/gnIxj0UN
         clu6jTRe2jr053Ys27MkY0xedw+Jy7AynMEkZngNmcjwwQWEv82dRppuSO5H+62Q9UiG
         mSQQ==
X-Gm-Message-State: APjAAAXMzu0naY1Qg8vWAxtQMMus3EEIUxDhi9qUuy7N77L3b2jBYpTU
        yKSIcWIuw77MyBJ43PyQ6SC8nEgu1YcR0tHJ7v0kVPNC
X-Google-Smtp-Source: APXvYqwzDfk4kNjAfP29X+kRRtnaoRyTk6YdxZTTablGYCpU/aZycMdsVR2PokNKy8EsYn0X2l5mlmBTKkVS4DCxaMw=
X-Received: by 2002:ac2:5bc1:: with SMTP id u1mr41093255lfn.111.1558529287306;
 Wed, 22 May 2019 05:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
 <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov>
In-Reply-To: <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 22 May 2019 15:47:55 +0300
Message-ID: <CAE=NcraenhB3eFtvhhdxkySxRw5puOEFYZ9FXdaaFgNsjsvHUQ@mail.gmail.com>
Subject: Re: sleep in selinux_audit_rule_init
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, paul@paul-moore.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 22, 2019 at 3:20 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > I managed to hit a following BUG, looks like ima can call
> > selinux_audit_rule_init that can sleep in rcu critical section in
> > ima_match_policy():
> >
> > __might_sleep
> > kmem_cache_alloc_trace
> > selinux_audit_rule_init <<< kzalloc (.. GFP_KERNEL)
> > security_audit_rule_init
> > ima_match_policy <<< list_for_each_entry_rcu
> > ima_get_action
> > process_measurement
> > ima_file_check
> > path_openat
> > do_filp_open
> > ..
> >
> > I guess this is the ima_match_rules() calling ima_lsm_update_rules()
> > when it concludes that the selinux policy may have been reloaded.
> >
> > The easy way for me to fix my own butt in this regard is to change the
> > selinux allocation not to wait, but Paul would you be OK with such
> > change? The alternative looks like a pretty big change in the ima?
>
> This is perhaps a sign of a deeper bug in IMA; if they are in the middle
> of matching against their policy rules, then they shouldn't be
> updating/modifying those rules in the middle of match processing?  How
> is that safe under RCU?

Heh indeed...


> If you look at how the audit subsystem deals with the same problem, they
> have a callback (audit_update_lsm_rules) that is called upon an AVC
> reset (hence upon a policy reload) and can update all of their rules at
> that time, not lazily during matching.  Since that time, a more general
> notifier mechanism was added, register_lsm_notifier(), and is used by
> infiniband to update its state upon policy changes.

I guess the same approach could work here. I'll see how that would
look like exactly..


--
Janne
