Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 709ED4A971
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfFRSHE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 14:07:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36680 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRSHE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 14:07:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id p15so16535085qtl.3;
        Tue, 18 Jun 2019 11:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tc5SveGAk5xUuqd8TE/eo44xuPz3szmJWnQMQ7ceihc=;
        b=fLOYIz2AWOld4qC6XnjvF+f+iyBqcLmCpjL8suMPryo8VrIp9031kkF2mnEjDreb4j
         afAXc0tYVyVTNdy1HOjYGwSz9UElYR+4gPnFTL1TD9ZuBf8RDRtE8OQvgXETXmxO+cw2
         3s76eZvGUyzS755evBhVr/T+y2uuZnW5fBcRimLtHRkGGGMd8IGn9E1pHQ6jdwL0yjSU
         UNFXNX2owQmF/b/i4rg9XPVEfPjFClbBNQ3ikPJpBT77K1hEX3N6R+DB3ofZTjIB3V1Z
         1qm4n9us1LeTxEJVcY3SXaDaHgn/NdOTjJl/zaAeg+U6nYB9LOyuDSELBE5fRz6w84x8
         dHiw==
X-Gm-Message-State: APjAAAWarKsSXaZDGOTUv5CyJqHenbz1mSog5WKegEkeE/8FxssxBsji
        2Jt6DHvRPS0UAbBMAu+fXz3DiWZ+YU/n4e3TUPk=
X-Google-Smtp-Source: APXvYqxZap79tJRc+geEbzJzShPPIrQc8XHYJtp7zMygG22X1MJgBEecbGk1pYegoT0Ow/kbm8aHMpqcn2Zo5zMZc2Y=
X-Received: by 2002:ac8:8dd:: with SMTP id y29mr35512555qth.304.1560881223019;
 Tue, 18 Jun 2019 11:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190617115838.2397872-1-arnd@arndb.de> <1560786951.4072.103.camel@linux.ibm.com>
 <1560794826.4072.169.camel@linux.ibm.com> <CAK8P3a1Q2JG3KBYNYgWg0_XtGUufNc6zuqcUBqiGSaBRp+au-w@mail.gmail.com>
 <1560861878.9530.17.camel@linux.ibm.com>
In-Reply-To: <1560861878.9530.17.camel@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Jun 2019 20:06:46 +0200
Message-ID: <CAK8P3a0_7ocqJZHA5Zbkd4yvhQnczKJxiSrBjOUDCmzO4gAb2Q@mail.gmail.com>
Subject: Re: [PATCH] ima: dynamically allocate shash_desc
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 18, 2019 at 3:55 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Mon, 2019-06-17 at 22:08 +0200, Arnd Bergmann wrote:
> > On Mon, Jun 17, 2019 at 8:08 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > On Mon, 2019-06-17 at 11:55 -0400, Mimi Zohar wrote:
> > > > On Mon, 2019-06-17 at 13:20 +0200, Arnd Bergmann wrote:
> > > > > On 32-bit ARM, we get a warning about excessive stack usage when
> > > > > building with clang.
> > > > >
> > > > > security/integrity/ima/ima_crypto.c:504:5: error: stack frame size
> > > > > of 1152 bytes in function 'ima_calc_field_array_hash' [-Werror,-
> > > > > Wframe-larger-than=]
> > > >
> > > > I'm definitely not seeing this.  Is this problem a result of non
> > > > upstreamed patches?  For sha1, currently the only possible hash
> > > > algorithm, I'm seeing 664.
> >
> > You won't see it with gcc, only with clang in some randconfig builds,
> > I suppose only when KASAN is enabled.
> >
> > > Every time a measurement is added to the measurement list, the memory
> > > would be allocated/freed.  The frequency of new measurements is policy
> > > dependent.  For performance reasons, I'd prefer if the allocation
> > > remains on the stack.
> >
> > Is there a way to preallocate the shash_desc instead? That would
> > avoid the overhead.
>
> There are 3 other SHASH_DESC_ON_STACK definitions in just
> ima_crypto.c, with a total of ~55 other places in the kernel.  Before
> fixing this particular function, I'd like to know if the "excessive
> stack usage" warning is limited to ima_calc_field_array_hash_tfm().
>  If so, what is so special about its usage of SHASH_DESC_ON_STACK?

SHASH_DESC_ON_STACK() uses at least 512 bytes of stack
everywhere, which is half of the warning limit for a function on
32 bit kernels.

With KASAN, a small redzone is put around it so we can detect out
of bounds access to a variable that is passed by reference.
clang makes that buffer larger than gcc, so we end up with something
like 768 bytes for each instance of SHASH_DESC_ON_STACK().

Most other users still stay below the 1024 byte warning level though,
because typical functions only use a few bytes of stack space.
In case of ima_calc_field_array_hash_tfm(), the is also the buffer[]
array of 255 bytes that gets another large redzone.

I fixed up all the (randconfig) warnings I get for arm32, arm64 and
x86 kernels, and I think there were four to five that were because of
SHASH_DESC_ON_STACK(). It might make sense to convert all
three instances in ima to preallocate the descriptor if we do it for
one of them, even when it's not actually needed.

     Arnd
