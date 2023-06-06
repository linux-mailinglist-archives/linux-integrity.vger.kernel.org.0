Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B566724064
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 13:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjFFLDu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 07:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbjFFLDH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 07:03:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2016319B3;
        Tue,  6 Jun 2023 04:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 882826280D;
        Tue,  6 Jun 2023 11:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D95C433A1;
        Tue,  6 Jun 2023 11:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686049219;
        bh=FJZBvU9mZ929InzbREOPQybjQtP4GSxypUKiLaiGPYY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f8YppWGM9pkCcQiw8BokRT2JY3X69vuGpmvJMhjP7v+Li0/uaE71ySscWjIpuV4RK
         AhoN9TUo3jQwzL677mAtiESDt/zi+B7hK8acfqOVU7toT0lPBZ6ZTbE8rAC7Qru+7w
         Wfffy+NLgnq8GzQJSBe8lBylVcGAbZdNjhFbKUdl1xQn9JD8FU9OQa0EZFg3/HeiJ5
         j6BqlGeR+vNLo2nINfnlZ3o9q5CeXDbQGNeBFcsnEjUBInrraE3iVbxBLIfbcN8qtH
         w0aeW0AUbZTwPHkcZEio7sxGoGumfZq9jkJi1Vc/KY9RusvNRYnDssU/50OOTXFz45
         jE4m/lBQ2hP5g==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b1c30a1653so32320511fa.2;
        Tue, 06 Jun 2023 04:00:18 -0700 (PDT)
X-Gm-Message-State: AC+VfDwf+WejIx8A98qzFziX1i7ixfFrpJ1tUJMMD0ZtxtncUwIvlGgg
        vVQ+Zp7RYCNatw36xwBVFIn9uGYLUEi30dG3MjQ=
X-Google-Smtp-Source: ACHHUZ563CmkIVh5K78BzyBEHDhqyYmtPZjw56PYzfIh3cc6Z/kEJrshyqqwF2nJo0HFFVkgYROpAOqSLHtjsHRwShg=
X-Received: by 2002:a2e:b16f:0:b0:2ad:99dd:de07 with SMTP id
 a15-20020a2eb16f000000b002ad99ddde07mr985836ljm.16.1686049216890; Tue, 06 Jun
 2023 04:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
 <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
 <CAHk-=wgCUzRNTg4fC8DF=UFnznK0M=mNUBDcsnLt7D4+HP2_1Q@mail.gmail.com> <ZH2hgrV6po9dkxi+@gondor.apana.org.au>
In-Reply-To: <ZH2hgrV6po9dkxi+@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 6 Jun 2023 13:00:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFvpcKVQ2askwh-ahDRyjtN8MerjDJJBBMiTBZ1CSfZ9w@mail.gmail.com>
Message-ID: <CAMj1kXFvpcKVQ2askwh-ahDRyjtN8MerjDJJBBMiTBZ1CSfZ9w@mail.gmail.com>
Subject: Re: [GIT PULL] Asymmetric keys fix for v6.4-rc5
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 5 Jun 2023 at 10:49, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Jun 02, 2023 at 08:02:23PM -0400, Linus Torvalds wrote:
> >
> > I absolutely abhor the crypto interfaces. They all seem designed for
> > that "external DMA engine" case that seems so horrendously pointless
> > and slow.  In practice so few of them are that, and we have all those
> > optimized routines for doing it all on the CPU - but have in the
> > meantime wasted all that time and effort into copying everything,
> > turning simple buffers into sg-bufs etc etc. The amount of indirection
> > and "set this state in the state machine" is just nasty, and this
> > seems to all be a prime example of it all. With some of it then
> > randomly going through some kthread too.
>
> You're right.  Originally SG lists were used as the majority of
> our input came from network packets, in the form of skb's.  They
> are easily translated into SG lists.  This is still somewhat the
> case for parts of the Crypto API (e.g., skcipher and ahash).
>
> However, for akcipher the only user of the underlying API is the
> file in question so I absolutely agree that forcing it to go through
> an SG list is just wrong.
>
> I'll change the underlying akcipher interface to take pointers
> instead and hide the SG list stuff (along with the copying) inside
> API.
>

Could we do the same for the compression API? This is a major pain as
well, and results (on my 128-core workstation) in 32 MiB permanently
tied up in scratch buffers in the scomp-to-acomp adaptation layer
because most of the underlying implementations are compression
libraries operating on plain virtual addresses, and so the
scatterlists needs to be copied into a buffer and back to perform the
actual transformation.

The only user user of the async compression interface is zswap, but it
blocks on the completion so it is actually synchronous as well.
