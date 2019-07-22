Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C3470A83
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2019 22:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfGVUT5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jul 2019 16:19:57 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:46352 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfGVUT5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jul 2019 16:19:57 -0400
Received: by mail-vk1-f193.google.com with SMTP id b64so8188270vke.13
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jul 2019 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fQQOqpuBL8hV+B+XPOqQvDfq/URV4+cGeVScowINNY=;
        b=qtTbc28DDACwZfMAeAkyaIw+wilv0M9Wtl4KW22DBIvFkkpXNPSPLrXaJcS1RA9vWJ
         Zk84SEO72NshM+DfLKdsnA6QSUmHsDBpJAPsxzKr0SjPSly4ItF9k62U94e2zd4uWGtH
         oqO8ijb04A0zrJ2f5eKT6Z+nJ9lPkIFpzo3fW0QOufFUwcQGX72Ye0Lgy82nI60b5H3K
         /ljMCQKR48kX2KkYn/Y586aXpnz1l78MW2TV4vJ1qSy+A3pnOacTZozTZxmoFhrjq8kd
         mR9TUNMhlf/UWFohFMRcw5zQ8DtHBPVyWqViSnONoa9FDUu341bP8eZFxJ+JqVFr/lQC
         Z/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fQQOqpuBL8hV+B+XPOqQvDfq/URV4+cGeVScowINNY=;
        b=t22+a8TUzmhYx6nrX5loxm7g57npdGh45jA/4Mbo6eTo7ScwENrSj7MRk93tSK6J8E
         JA544VtYbQsp+0YlvurgTlN8aMUYb+0bDHWOXPuIKu0PDCEu3uAvTsB0Tnc6oQUYQEGe
         faoQloxm/YVaRsaM+ORLy3b92Xx/Oagy+faHtNtqWNa8rClwfHCY0oWFcIaijIdrpSoN
         0TDCA17+FuUoAdy1cu+QEFr8KT8kv7LWxW30PexhjN74a9tCMJD0R//y7/ki8NiS9doV
         xr4uyoaQXFix2Z6HCkih09tALH35+tVyd1wVolMdBt3YQkeWVCGQn12m5T1y3NkDDwPP
         NK9Q==
X-Gm-Message-State: APjAAAUcMdEWnjDGHUzYT9pRwyn6Q6BaJGnn7uFzfS4BjWrg+wecuKMy
        ja2TXUvxPmStQt6gDP1HxbGPbv9A9A9xjpf4Si6wNEdJ
X-Google-Smtp-Source: APXvYqwbFPC+7p7O33GiVlnCp3cInm7M4Q70I6C2gdLaCMwiwAdYYwAdW8775R/CEjXtBXriRlldHDpZNFSmToC0X00=
X-Received: by 2002:a1f:5cd:: with SMTP id 196mr27231643vkf.62.1563826796297;
 Mon, 22 Jul 2019 13:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <CABatt_yn_yjw-MOUnrPDyg-ZQd1AjaHkcJKxNBo8STC9o2EGrw@mail.gmail.com>
 <165e3170-9b5a-7c75-9a9b-265ede62f55e@schaufler-ca.com>
In-Reply-To: <165e3170-9b5a-7c75-9a9b-265ede62f55e@schaufler-ca.com>
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Mon, 22 Jul 2019 21:19:45 +0100
Message-ID: <CABatt_yS9m0nkqSzh_LwSDfc8wuubkXgiOxd6kgVKWuNjbFKuA@mail.gmail.com>
Subject: Re: SMACK and keys
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Casey

Thank you for the swift reply.

On Mon, Jul 22, 2019 at 5:25 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 7/22/2019 1:03 AM, Martin Townsend wrote:
> > Hi,
> >
> > One of our developers has reported the following audit log entry when
> > trying to add a key to the kernel's keyring when SMACK is enabled:
> >
> > Jul  9 09:33:23 mach-cw-rnet-ppm-1840 user.notice kernel: audit:
> > type=1400 audit(1562664803.960:12): lsm=SMACK fn=smack_key_permission
> > action=denied subject="programmingapp" object="_" requested=w pid=905
> > comm="programmingapp" key_serial=98475196 key_desc="_ses"
>
> The Smack label on a key is set when the key is created,
> and is set to the label of the process that created it.

I'll have to check but I thought that the programmingapp process from
the audit message above was trying to create the key, the dev team
were reporting that the add_key syscall was failing the SMACK access
check.  This raises another question, we currently compile in several
root Certificates into the kernel, would these get a SMACK label? and
if so would this be '_'?

>
> > I had a quick look through the code in smack_lsm.c but can't see how
> > I'm supposed to set a SMACK label for keys or keyrings.  Is it
> > possible and if so how?
>
> There is currently no way to change the Smack label on a key.
>
> > We are running a 4.9 Kernel with not much
> > chance of upgrading as it's a vendor kernel (linux-imx).  As it's an
> > embedded system we are happy to hard code the SMACK labels into the
> > kernel if this is possible?
>
> In smack_key_alloc() change
>
>         key->security = skp;
>
> to
>         key->security = &smack_known_star;
>
> and all keys will have the star ("*") label, which
> grants everyone access to them. Not the best solution
> long term, but it should get you by.

They are currently adding a rule 'programmingapp _ rw' so I think this
would be an upgrade :)
Could I go one further and have something like?
#ifdef CONFIG_KEYS

+static struct smack_known smack_known_keymaster = {
+ .smk_known = "keymaster",
+ .smk_secid = 9,
+};
+
 /**
  * smack_key_alloc - Set the key security blob
  * @key: object
@@ -4327,9 +4332,7 @@ static void smack_inet_csk_clone(struct sock *sk,
 static int smack_key_alloc(struct key *key, const struct cred *cred,
     unsigned long flags)
 {
- struct smack_known *skp = smk_of_task(cred->security);
-
- key->security = skp;
+ key->security = &smack_known_keymaster;
  return 0;
 }

or is this just asking for trouble

>
> > or is it set to '_' by design and we
> > should add the key whilst the process is a privileged state before the
> > SMACK label for the process has been set?
>
> If you can run the program that creates the key with a label
> other than floor ("_"), perhaps "keymaster", the key would be
> labeled keymaster, and you could create access rules like

I will get some more information on how they are creating the keys as
I thought the process creating the keys was labelled "programmingapp"
so the key in theory should be labelled "programmingapp".  And looking
at the smack_key_alloc function mentioned previously it definitely
looks like it should have.  I'll see if I can get them to create some
test code and debug why this isn't happening.
Thanks again for your help.

>
>         programmingapp keymaster rw
>
>
> >
> > Many Thanks,
> > Martin.
>
