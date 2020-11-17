Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BBF2B7285
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Nov 2020 00:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgKQXgz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Nov 2020 18:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKQXgw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Nov 2020 18:36:52 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13A7C061A04
        for <linux-integrity@vger.kernel.org>; Tue, 17 Nov 2020 15:36:51 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o24so276916ljj.6
        for <linux-integrity@vger.kernel.org>; Tue, 17 Nov 2020 15:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0kv/TGZCBjgkfEmVlmQGbddq7Vuqk22W0hkuqKhgPg=;
        b=ZfCK9fE5KEx2c6LJVDvCKbk18EHOGfANhut79KLdPiY11VCpPSw0vPYJaLCzYbWfN7
         rxR97+wOKkrhlTSFjVmx0Ens33MZNx+ydmyDkcSx3o5aSc4rS+WnAeqjoTEjOy+8p4IX
         mcTfZ1lbMzrFtnx5GPNlU5oqnxJmpNU4bc8o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0kv/TGZCBjgkfEmVlmQGbddq7Vuqk22W0hkuqKhgPg=;
        b=T0xChyRhj5EbYeKkklVnqMf5hlK7+qnz3CmSckAtbAtopwmm/H/NwGQINxptyiilYi
         w4glQ5jgISD/RvIUxxdljtr0yA9Dtp/M0RNiRVhAaTKaf6aQQEdNJGR7DzG+qVRH+qg8
         8Kwm0BstLfs6OND67mY7HF4rRlcOxEaDOdEKDi+yto1HMkM6USQGv8r4FXYUp/myqxv7
         GpaTDSUpr5AcZ9nyDVImp2epZ1GPAsA+/Xs9R45beE3gtVn6j0SOljczg8fYCYE+URRp
         zsQ3CACeSl4n/9QwAJXvg5+okvWBzj1JedqikexFwFe1jydYuIm8sqQNP5FFNfxhTidR
         tjAg==
X-Gm-Message-State: AOAM531DX6Yogv1gRhuz6oj+u/8aXh+b0y+Rgu+5Vxpf+95q43a7WUjp
        34aWR06JMuqHH+Ry2GYMJlnpUqz3CWd+ng==
X-Google-Smtp-Source: ABdhPJxTv8xQ2X84fman4qMoXHn9CM/GGnjU3F6IlvEFOPaz/LeuWhhea9Zufid5kKxdccvzu26lhw==
X-Received: by 2002:a2e:8350:: with SMTP id l16mr2891394ljh.47.1605656209943;
        Tue, 17 Nov 2020 15:36:49 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id h6sm941494lfp.78.2020.11.17.15.36.47
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 15:36:47 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id x9so271413ljc.7
        for <linux-integrity@vger.kernel.org>; Tue, 17 Nov 2020 15:36:47 -0800 (PST)
X-Received: by 2002:a2e:80c7:: with SMTP id r7mr1059615ljg.285.1605656206837;
 Tue, 17 Nov 2020 15:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
 <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
 <20201116174127.GA4578@infradead.org> <CAHk-=wjd0RNthZQTLVsnK_d9SFYH0rug2tkezLLB0J-YZzVC+Q@mail.gmail.com>
 <3f8cc7c9462353ac2eef58e39beee079bdd9c7b4.camel@linux.ibm.com>
 <CAHk-=wih-ibNUxeiKpuKrw3Rd2=QEAZ8zgRWt_CORAjbZykRWQ@mail.gmail.com>
 <5d8fa26d376999f703aac9103166a572fc0df437.camel@linux.ibm.com> <CAHk-=wiPfWZYsAqhQry=mhAbKei8bHZDyVPJS0XHZz_FH9Jymw@mail.gmail.com>
In-Reply-To: <CAHk-=wiPfWZYsAqhQry=mhAbKei8bHZDyVPJS0XHZz_FH9Jymw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Nov 2020 15:36:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjinHpYRk_F1qiaXbXcMtn-ZHKkPkBvZpDJHjoN_2o4ag@mail.gmail.com>
Message-ID: <CAHk-=wjinHpYRk_F1qiaXbXcMtn-ZHKkPkBvZpDJHjoN_2o4ag@mail.gmail.com>
Subject: Re: [RESEND][PATCH] ima: Set and clear FMODE_CAN_READ in ima_calc_file_hash()
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 17, 2020 at 3:29 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Nov 17, 2020 at 3:24 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > I really wish it wasn't needed.
>
> Seriously, I get the feeling that IMA is completely mis-designed, and
> is doing actively bad things.
>
> Who uses this "feature", and who cares? Because I would suggest you
> just change the policy and be done with it.

Another alternative is to change the policy and say "any write-only
open gets turned into a read-write open".

But it needs to be done at *OPEN* time, not randomly afterwards by
just lying to the 'struct file'.

Why? Because the open has told the filesystem that it's only for
writing, and a filesystem could validly do things that make reading
invalid. The simplest example of this is a network filesystem, where
the server might simply not *allow* reads, because the open was for
writing only.

See? IMA really does something fundamentally quite wrong when it tries
to read from a non-readable file. It might "work" by accident, but I
really do think that commit a1f9b1c0439db didn't "break" IMA - it
showed that IMA was doing something fundamentally wrong.

           Linus
