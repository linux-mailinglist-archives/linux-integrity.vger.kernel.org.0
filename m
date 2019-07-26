Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 022A275F76
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jul 2019 09:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGZHFW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jul 2019 03:05:22 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:65401 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfGZHFW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jul 2019 03:05:22 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x6Q752an012469;
        Fri, 26 Jul 2019 16:05:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x6Q752an012469
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564124703;
        bh=hf3V59I5cEBKminI065xbdxm3L9O5Fl0uGomw+56D08=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=rvVZeqt68sq4elNmUHxFKFkzb91btDIX43mcwq2hjNYQxd1TF6kT8UiCP1Jkvisca
         qBlbKboUt9XCxFhWcWvZak9fMsYLzBtNCL4TQYfsQjoMyTUTB+gTYodqQke8Ft4C/q
         cpuqt8cylEebo/fSDxr8l3VYIFZvAcXEujVcrr40NBPgWHmqKv6CD8xrikJCK2LcQT
         lEouJ8kpVN6Q/yYRb3++/X+Tv66azlAJkdRB5QZmYet2tzNq2E3ou959Qnc6fXAFxd
         I2tsqF+vC59UJH8MkvR34QqGm4UVK4byzhOFjFdYqFKZlliiUghorBAK5oXS6jB+iF
         LRuIDt29e1Kew==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id 190so35434283vsf.9;
        Fri, 26 Jul 2019 00:05:02 -0700 (PDT)
X-Gm-Message-State: APjAAAXAHjh1REvDsFlVTSJihdCBQSUapnbpTgES7FxhZC6a6La9ui26
        qYwerTGGTfu6Qzr6QjdZH8btYIPFkTxFv9v2cnw=
X-Google-Smtp-Source: APXvYqxICz+MjfLEujejITXMpQhAs6T5RoUN7yEeG79RQzzeORmsaKPiKHGvtyFlhUAyAGr6hXde53fpb62/UEcp97U=
X-Received: by 2002:a67:f495:: with SMTP id o21mr58544872vsn.54.1564124701676;
 Fri, 26 Jul 2019 00:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190726021058.4212-1-yamada.masahiro@socionext.com>
 <20190726021058.4212-5-yamada.masahiro@socionext.com> <20190726043719.GB643@sol.localdomain>
In-Reply-To: <20190726043719.GB643@sol.localdomain>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 26 Jul 2019 16:04:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfUkJTfRHHxkL-4nOq6wG+Y9sDbBHZE97UVOdSrA_1CQ@mail.gmail.com>
Message-ID: <CAK7LNARfUkJTfRHHxkL-4nOq6wG+Y9sDbBHZE97UVOdSrA_1CQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] IMA: use obj-y for non-modular objects
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 26, 2019 at 1:37 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Jul 26, 2019 at 11:10:57AM +0900, Masahiro Yamada wrote:
> > CONFIG_IMA is a boolean option, so none of these objects is linked
> > into a module.
> >
> > All the objects in this directory are compiled only when CONFIG_IMA=y
> > since this directory is guarded by the parent Makefile:
> >
> >   obj-$(CONFIG_IMA)                       += ima/
> >
> > So, there is no point in creating the composite object, ima.o
> >
> > Flatten the code into the obj-$(CONFIG_...) form.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  security/integrity/ima/Makefile | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> > index d921dc4f9eb0..5517486c9154 100644
> > --- a/security/integrity/ima/Makefile
> > +++ b/security/integrity/ima/Makefile
> > @@ -4,10 +4,8 @@
> >  # Measurement Architecture(IMA).
> >  #
> >
> > -obj-$(CONFIG_IMA) += ima.o
> > -
> > -ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
> > +obj-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
> >        ima_policy.o ima_template.o ima_template_lib.o
> > -ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
> > -ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
> > +obj-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
> > +obj-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
> >  obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
> > --
>
> This patch changes the kernel command line options
>
>         ima.ahash_minsize
>         ima.ahash_bufsize
>
> to
>         ima_crypto.ahash_minsize
>         ima_crypto.ahash_bufsize
>
> Intentional?

No.
I missed those kernel parameters.
So, please drop this patch.

I see no problem in 3/5, 5/5, but
if composite object is preferred for consistency,
please feel free to drop them as well.

Thanks.




> Note that these are documented in
> Documentation/admin-guide/kernel-parameters.txt.






-- 
Best Regards
Masahiro Yamada
