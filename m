Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30D6997E6
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 15:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBPOww (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Feb 2023 09:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjBPOwv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Feb 2023 09:52:51 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D734D616;
        Thu, 16 Feb 2023 06:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1676559160;
        bh=MaekqW8Y2lVTvmHenF8QlHyCe47i2wgNLvs0U8LNOZE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=vNtOLBVTEWi5kcjQSMxinCmqkNyPJFrNV1KjuMy8SCQcVHIUQTjCDoEFCqulNkyy3
         8r7tHiUHSbfExTmIelCG44dr70vU1NMhzHV4IgAGyvlZ++QHkknS/cVbDFImn0V3UG
         MzTdOhHVdMApySQoReXiXDf/c2BAQm7Pfp6ESULA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 678A9128121D;
        Thu, 16 Feb 2023 09:52:40 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SaJfseYx8dAH; Thu, 16 Feb 2023 09:52:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1676559160;
        bh=MaekqW8Y2lVTvmHenF8QlHyCe47i2wgNLvs0U8LNOZE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=vNtOLBVTEWi5kcjQSMxinCmqkNyPJFrNV1KjuMy8SCQcVHIUQTjCDoEFCqulNkyy3
         8r7tHiUHSbfExTmIelCG44dr70vU1NMhzHV4IgAGyvlZ++QHkknS/cVbDFImn0V3UG
         MzTdOhHVdMApySQoReXiXDf/c2BAQm7Pfp6ESULA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 745201280E69;
        Thu, 16 Feb 2023 09:52:39 -0500 (EST)
Message-ID: <6caed4e0ae21528d3b6bb5bc5eefecf6df714d72.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Yujie Liu <yujie.liu@intel.com>,
        kernel test robot <lkp@intel.com>,
        linux-integrity@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        keyrings@vger.kernel.org
Date:   Thu, 16 Feb 2023 09:52:36 -0500
In-Reply-To: <CAMj1kXHC+9urxeXCmHPj1Ecdb7aF+QDriGE1W4Azuw+_it6u2w@mail.gmail.com>
References: <20230124175516.5984-7-James.Bottomley@HansenPartnership.com>
         <202301250706.deGvd0yq-lkp@intel.com>
         <a588a74bb930f38c9322dd51d21661398b5e2bb8.camel@HansenPartnership.com>
         <Y9ykeASyzhSKQCmx@yujie-X299> <Y+MNxmzlILarAlZA@kernel.org>
         <3109ff421139af6b0d9e66a06d8399135e546fa7.camel@HansenPartnership.com>
         <Y+nqpLm2YyYkcZ+H@kernel.org>
         <CAMj1kXECgmUMjKZk41oeXWWQpX5wB22YtBt2CSAQzEq8SqbY_g@mail.gmail.com>
         <a71b8b39505ce936c8bde0d61943c6cc0a9efb81.camel@HansenPartnership.com>
         <CAMj1kXHC+9urxeXCmHPj1Ecdb7aF+QDriGE1W4Azuw+_it6u2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-02-14 at 15:36 +0100, Ard Biesheuvel wrote:
> On Tue, 14 Feb 2023 at 15:28, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Tue, 2023-02-14 at 14:54 +0100, Ard Biesheuvel wrote:
[...]
> > > 
> > > Can we avoid shashes and sync skciphers at all? We have sha256
> > > and AES library routines these days, and AES in CFB mode seems
> > > like a good candidate for a library implementation as well - it
> > > uses AES encryption only, and is quite straight forward to
> > > implement. [0]
> > 
> > Yes, sure.  I originally suggested something like this way back
> > four years ago, but it got overruled on the grounds that if I
> > didn't use shashes and skciphers some architectures would be unable
> > to use crypto acceleration.  If that's no longer a consideration,
> > I'm all for simplification of static cipher types.
> > 

I now have this all implemented, and I looked over your code, so you
can add my tested/reviewed-by to the aescfb implementation.  On the
acceleration issue, I'm happy to ignore external accelerators because
they're a huge pain for small fragments of encryption like the TPM, but
it would be nice if we could integrate CPU instruction acceleration
(like AES-NI on x86) into the library functions. 

I also got a test rig to investigate arc.  It seems there is a huge
problem with the SKCIPHER stack structure on that platform.  For
reasons I still can't fathom, the compiler thinks it needs at least
0.5k of stack for this one structure.  I'm sure its something to do
with an incorrect crypto alignment on arc, but I can't yet find the
root cause.

> I don't know if that is a consideration or not. The AES library code
> is generic C code that was written to be constant-time, rather than
> fast. The fact that CFB only uses the encryption side of it is
> fortunate, because decryption is even slower.

I think for the TPM, since the encryption isn't exactly bulk (it's
really under 1k for command and response encryption) it doesn't matter
... in fact setting up the accelerator is likely a bigger overhead.

> So the question is whether this will actually be a bottleneck in this
> particular scenario. The synchronous accelerated AES implementations
> are all SIMD based, which means there is some overhead, and some
> degree of parallelism is also needed to take full advantage, and CFB
> only allows this for decryption to begin with, as encryption uses
> ciphertext block N-1 as AES input for encrypting block N.
> 
> So maybe this is terrible advice, but the code will look so much
> better for it, and we can always add back the performance later if it
> is really an impediment.

It's definitely smaller and neater, yes.  I'll post a v3 based on this,
but when might it go upstream?  In my post I'll put your aescfb as
patch 1 so the static checkers don't go haywire about missing function
exports, and we can drop that patch when it is upstream.

James

> 
> 
> > > The crypto API is far too clunky for synchronous operations of
> > > algorithms that are known at compile time, and the requirement to
> > > use scatterlists for skciphers is especially horrid.
> > > 
> > > [0]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=crypto-aes-cfb-library
> > 
> > OK, let me have a go at respinning based on this.


