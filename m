Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D312B69A771
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Feb 2023 09:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBQIuk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Feb 2023 03:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBQIue (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Feb 2023 03:50:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A8604FC;
        Fri, 17 Feb 2023 00:50:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3D646176A;
        Fri, 17 Feb 2023 08:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517D9C433EF;
        Fri, 17 Feb 2023 08:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676623804;
        bh=4LLKhoxcJlDltJAv/aUjhTDMAlz2OOxq/4uIFWP6Xkg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P9YfqazyEcsOafiUzdWmCa3PDtMzykuQC509chiiL0+6t3fyvg/UNF/S8hiFCZMux
         VMOQpYV5xui6EFvj6xu2XKfh4TYp59dkQlUmPQ4bR14B03M/WqmKcQHo6sLIGVybRl
         djF04zxgzWs9duvIfTpfv38KchIy8epoW7Uun84/WYVKnMMcTzVsLj0bex2OFrF0bm
         0c89btN2+WXhA1RwEzJyLNbeL9Kru2DqbNANJi3sUE9rQyNhe6qJ0H+SOsSsRdqbjT
         JMEhx5Mqo7l86xT5dS+WHBfeIcxvaa680lq4N2f/TMNHRDXV60gmADTCY537+JbR8A
         pHwfQ0BDByqAg==
Received: by mail-lj1-f173.google.com with SMTP id z10so268510ljq.2;
        Fri, 17 Feb 2023 00:50:04 -0800 (PST)
X-Gm-Message-State: AO0yUKVCB22wA5grfEV9rltbip56Uqnjz+AVn+NyXjbjppb8VmmKan3V
        hIoqZjz1Q+k6BCdfaw8RaD+5o3lHoQsAylBJwtk=
X-Google-Smtp-Source: AK7set/X3/WQ12GzzI0XxhTKEmTgL9IOMfH2HBNlvWYuzyH0v5tdt9exFbLPic3w4g2L/UszRzPgI1s0tbF0vnqAlyE=
X-Received: by 2002:a2e:b530:0:b0:294:6092:d63c with SMTP id
 z16-20020a2eb530000000b002946092d63cmr1496319ljm.2.1676623802308; Fri, 17 Feb
 2023 00:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20230124175516.5984-7-James.Bottomley@HansenPartnership.com>
 <202301250706.deGvd0yq-lkp@intel.com> <a588a74bb930f38c9322dd51d21661398b5e2bb8.camel@HansenPartnership.com>
 <Y9ykeASyzhSKQCmx@yujie-X299> <Y+MNxmzlILarAlZA@kernel.org>
 <3109ff421139af6b0d9e66a06d8399135e546fa7.camel@HansenPartnership.com>
 <Y+nqpLm2YyYkcZ+H@kernel.org> <CAMj1kXECgmUMjKZk41oeXWWQpX5wB22YtBt2CSAQzEq8SqbY_g@mail.gmail.com>
 <a71b8b39505ce936c8bde0d61943c6cc0a9efb81.camel@HansenPartnership.com>
 <CAMj1kXHC+9urxeXCmHPj1Ecdb7aF+QDriGE1W4Azuw+_it6u2w@mail.gmail.com> <6caed4e0ae21528d3b6bb5bc5eefecf6df714d72.camel@HansenPartnership.com>
In-Reply-To: <6caed4e0ae21528d3b6bb5bc5eefecf6df714d72.camel@HansenPartnership.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 17 Feb 2023 09:49:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGoUx2Aev7b-tuzJ7cH51bN=5JjiYb3t+y6LFDk4t7yoA@mail.gmail.com>
Message-ID: <CAMj1kXGoUx2Aev7b-tuzJ7cH51bN=5JjiYb3t+y6LFDk4t7yoA@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Yujie Liu <yujie.liu@intel.com>,
        kernel test robot <lkp@intel.com>,
        linux-integrity@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 16 Feb 2023 at 15:52, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2023-02-14 at 15:36 +0100, Ard Biesheuvel wrote:
> > On Tue, 14 Feb 2023 at 15:28, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > On Tue, 2023-02-14 at 14:54 +0100, Ard Biesheuvel wrote:
> [...]
> > > >
> > > > Can we avoid shashes and sync skciphers at all? We have sha256
> > > > and AES library routines these days, and AES in CFB mode seems
> > > > like a good candidate for a library implementation as well - it
> > > > uses AES encryption only, and is quite straight forward to
> > > > implement. [0]
> > >
> > > Yes, sure.  I originally suggested something like this way back
> > > four years ago, but it got overruled on the grounds that if I
> > > didn't use shashes and skciphers some architectures would be unable
> > > to use crypto acceleration.  If that's no longer a consideration,
> > > I'm all for simplification of static cipher types.
> > >
>
> I now have this all implemented, and I looked over your code, so you
> can add my tested/reviewed-by to the aescfb implementation.  On the
> acceleration issue, I'm happy to ignore external accelerators because
> they're a huge pain for small fragments of encryption like the TPM, but
> it would be nice if we could integrate CPU instruction acceleration
> (like AES-NI on x86) into the library functions.
>

Agreed that async crypto makes no sense here, and it is rather
unfortunate that even use cases such as this one require the
scatterlist handling, which requires direct mapped memory etc etc

As for the accelerated algos: it wouldn't be too complicated to build
the CFB library interface around the 'AES' crypto cipher, which is
synchronous and operates on virtual addresses directly. But it should
only use ones that are constant time (like AES-NI) and not use generic
AES or the asm accelerated ones, and so this would require an
additional annotation (or an allowlist) which makes things a bit
clunky.

However, doing the math on the back of an envelope: taking arm64 as an
example, which manages ~1 cycle per byte for AES instructions and 25
cycles per byte for AES encryption using this library, processing 1k
of data takes an additional 24k cycles, which comes down to 10
microseconds on a 2.4 GHz CPU.

Given that this particular use case is about communicating with off
chip discrete components, I wonder whether spending 10 microseconds
more is going to have a noticeable impact.

> I also got a test rig to investigate arc.  It seems there is a huge
> problem with the SKCIPHER stack structure on that platform.  For
> reasons I still can't fathom, the compiler thinks it needs at least
> 0.5k of stack for this one structure.  I'm sure its something to do
> with an incorrect crypto alignment on arc, but I can't yet find the
> root cause.
>

Maybe SKCIPHER_ON_STACK() needs the same treatment as
660d2062190db131d2feaf19914e90f868fe285c?

The catch here is that if we reduce the alignment of the buffer, the
req pointer will not have the alignment of the typedef, and so we will
be lying to the compiler.

This is all a result of the way we abuse alignment to pad out data
fields that may be used for inbound non-coherent DMA, and this is
something that is being fixed at the moment.


> > I don't know if that is a consideration or not. The AES library code
> > is generic C code that was written to be constant-time, rather than
> > fast. The fact that CFB only uses the encryption side of it is
> > fortunate, because decryption is even slower.
>
> I think for the TPM, since the encryption isn't exactly bulk (it's
> really under 1k for command and response encryption) it doesn't matter
> ... in fact setting up the accelerator is likely a bigger overhead.
>
> > So the question is whether this will actually be a bottleneck in this
> > particular scenario. The synchronous accelerated AES implementations
> > are all SIMD based, which means there is some overhead, and some
> > degree of parallelism is also needed to take full advantage, and CFB
> > only allows this for decryption to begin with, as encryption uses
> > ciphertext block N-1 as AES input for encrypting block N.
> >
> > So maybe this is terrible advice, but the code will look so much
> > better for it, and we can always add back the performance later if it
> > is really an impediment.
>
> It's definitely smaller and neater, yes.  I'll post a v3 based on this,
> but when might it go upstream?  In my post I'll put your aescfb as
> patch 1 so the static checkers don't go haywire about missing function
> exports, and we can drop that patch when it is upstream.
>

I'll add some test cases and send it to the list.
