Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE70198509
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgC3UBY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 16:01:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55037 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgC3UBY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 16:01:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id c81so168395wmd.4
        for <linux-integrity@vger.kernel.org>; Mon, 30 Mar 2020 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ia9fKL83ifHc8USlzohyXpYnv9ydB1s0BUbwKqKInYQ=;
        b=i+QLwjSgK3NW9K9WLid2KKb0w1oPfzZi02m0I8YQ3iwby4hEKbAhRlvjxzzdIGjfgG
         5PW5T31/3j9mzyi45qNdy39DSSPZKgd+qQ2EY+yTqxtv/J/Iw1eEAk8neEP9ftZP95OS
         tynYK/8sI8A1wwYROKDB0BzAne6jRUedEeSEWngOF2ZmfC7aXm3nvVweDAHPyaMqt0Ri
         PelX9BQO4Rdzz84bW6xpS72nVx1MFC71lq7mT5KOJ5owjlsu+gzs2UHu9Xtda7LEbH1T
         ZJrR2/Ru6Ewa40EEL6lTwNRCXuBKnsHgwigbJKXcceIJeD7uk1lgWrcAPfzR2/7Uj1od
         gDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ia9fKL83ifHc8USlzohyXpYnv9ydB1s0BUbwKqKInYQ=;
        b=hGSSzqyfK2kiJOmk3Tb2R8nfhUD2/ntRlz0mi5iVcvwz97KGA5vyIPWnF4UeV2/lfB
         gmL7/Fd5PVcZFilH7U4s998kDwglNfk+HxNFq/rChguUqJhooBVNN5CaWo3nJ6nAko9A
         ZbObPHxp+skeiYUPhgh8jdsol0vL6TbMi+DYnWSeiVS+Sr43cSibpI37dxyBCbkrg+us
         80X9y17qi6EKMprMDItRCRIKTwas0jaZAwfeQLIVEb0gN6FSjoKsh2Yem+iQmH4lwb9j
         6AWvqF306DrzbXv3/TVSx3tYUWg85J2cmz2FQ6BNjfuR0ith5DRnw1pXrkbtxGl4FfCq
         wuBw==
X-Gm-Message-State: ANhLgQ2khoY/owFgRgcKftXgO1pFKCpuarchp0AePgra+vaVRgzd6b7N
        32VAcE+EsjOZo0Ck962/gBarQoAjQJ2C5ZMnEVc=
X-Google-Smtp-Source: ADFU+vsA5mrAadVm0cDMoi/8lkgDuhUV8VrECZDX/5Ldh9DuwvVfME8bLsFaZocJLqtZMXOQiVLjNMfr8vmv7hU2G/0=
X-Received: by 2002:a7b:c2a1:: with SMTP id c1mr914482wmk.138.1585598481818;
 Mon, 30 Mar 2020 13:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200330122434.GB28214@kl> <1244b6bcc384413581da33c9b92743b8@huawei.com>
 <CAP22eLGbwcXzBDpc2QbMOGtjrdYsufUf-8vq4uHt8jjPoQanKQ@mail.gmail.com> <1585591534.5188.435.camel@linux.ibm.com>
In-Reply-To: <1585591534.5188.435.camel@linux.ibm.com>
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Mon, 30 Mar 2020 23:01:10 +0300
Message-ID: <CAP22eLEx4-06iTC5kw-GHoD=YVmLdLpN_JCCGx8PRMy4honiQg@mail.gmail.com>
Subject: Re: [PATCH] integrity ima_policy : Select files by suffix
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@us.ibm.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 30, 2020 at 9:05 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> [The normal conventions for this mailing list is bottom post.]
>
> Lev,
>
> On Mon, 2020-03-30 at 20:21 +0300, Lev R. Oshvang . wrote:
> > I already answered to Mimi Zohar that applications expect file name in
> > open() syscall.
>
> And I disagreed with you.  Not only can filenames be renamed, as I
> mentioned, but they aren't protected, as Roberto said.
>
I politely remind you that the goal of IMA  is to provide the
application the guarantee that the file was not altered when it tries
to use it, whether it is open(), stat(), , execve , etc
BPRM_CHECK, MMAP_CHECK narrows the scope of checks to executable files/libs.

But there are a tons of files in file systems and we can not check them all.
My intention is to put under scrutiny just important configuration
files, systemd service files, some files in etc, ex /etc/shadow.

The result will be good for providing TCB, because we can be sure that
all systemd services passed attestation.
Right now we measure  sshd binary but we do not mesure sshd config.

An attacker may change the configuration file of iptables, sshd.
sudoers to make attack successful or leave a backdoor.
He can not achieve the attack goal if he changes a file name. The
application/service will just not start.
TOCTOU is not relevant. Attacker works from userspace but open()/IMA
happens in the kernel. So there is no way to avoid IMA check.

> > So there is no need to protect file name otherwise applications just
> > stop to work.
> > Even now when ima hash is not correct application stops to work.
> > Put aside scripts for a second. A lot of programs are configured in
> > .ini or .conf files.
> > The suffix is a very convenient way to provide these files would be measured.
> >
> > Now I returning to scripts.
> > It is very hard to enforce IMA checks in interpreters. And thinks
> > about perl scrips. awk. python scripts. etc
> > The proposed suffix rule is easy and lightweight.
> > I once had programmed BRM hook of LSM
> > I had a very hard time trying to figure out whether shell is opening a
> > script or data , how to get filename to check its signature.
> > Sometimes script file does not have shebang or does not have
> > executable permission.
>
> Only the interpreter knows how the file will be used.
>
Not true. It is a common practice to use file suffix to indicate how a
file is going to be used
Coding styles required from programmers to use suffixes.
So let's be on a common-sense side and agree that if some system as a
coding style use .sh for shell scripts name
we can use it in IMA policy rule.
> >
> > I hope I convinced you.
>
> There have been a number of attempts to define IMA policy rules based
> on pathname, which have not been upstreamed.  Feel free to use your
> solution, but it can't be upstreamed as is.
>
> Mimi
>
Hi Mimi,
I am completely newbie in such discussion so please forgive that I may
violate style again because I responded in the middle of your reply
Another argument that is responsible sysadmin may use the immutable
attribute to prevent name change,

Regards,
Lev
