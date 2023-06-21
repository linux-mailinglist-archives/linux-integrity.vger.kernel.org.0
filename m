Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2289737ADE
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jun 2023 07:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFUFwZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Jun 2023 01:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjFUFvd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Jun 2023 01:51:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473D61BE7;
        Tue, 20 Jun 2023 22:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEA3761483;
        Wed, 21 Jun 2023 05:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F74C433CA;
        Wed, 21 Jun 2023 05:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687326643;
        bh=EsfoOoKV23FafCQLTWkJQXnXTdobu6E9LLFtgs9zj2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aopycqUUl2VG11V8rsW7lnOHxT4HLbSsT8NW2RRGNAeVw3R4Pi6YBnmsaJMamuJLc
         ve7LjvaMB1O1ZBJOmSqkCV8u7qxB6hjZhqo+2BXzjpwkMX8L/mKhYD1R2fu8BgWX5y
         QhTB9RVmAKIvwTRNJOTLtGUcz/H4dXwOF57JCJsIJD0HgPZ3bzoSfs8gWFOW4ZlhvC
         v4Yl2ZgaJSOYOGGK53inW1bwaDp1ufi55K0W2lztxetBGif9IPLTQrU/2FtBdYt94L
         06219G6eZ42EHFeREAvze/aTU/CpKrZnIUaa0bvY0C0hb89TqbDMuS2PNxVxxzevRV
         EhYSjVEX891MQ==
Date:   Tue, 20 Jun 2023 22:50:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     fsverity@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH v3] fsverity: improve documentation for builtin signature
 support
Message-ID: <20230621055041.GA1699@sol.localdomain>
References: <20230620041937.5809-1-ebiggers@kernel.org>
 <CAMw=ZnQg2dvdivEPdScMcgQQtj00T=EigpGn0ZRYHLMU=AKLMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnQg2dvdivEPdScMcgQQtj00T=EigpGn0ZRYHLMU=AKLMA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 20, 2023 at 08:15:42PM +0100, Luca Boccassi wrote:
> On Tue, 20 Jun 2023 at 05:23, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > From: Eric Biggers <ebiggers@google.com>
> >
> > fsverity builtin signatures (CONFIG_FS_VERITY_BUILTIN_SIGNATURES) aren't
> > the only way to do signatures with fsverity, and they have some major
> > limitations.  Yet, more users have tried to use them, e.g. recently by
> > https://github.com/ostreedev/ostree/pull/2640.  In most cases this seems
> > to be because users aren't sufficiently familiar with the limitations of
> > this feature and what the alternatives are.
> >
> > Therefore, make some updates to the documentation to try to clarify the
> > properties of this feature and nudge users in the right direction.
> >
> > Note that the Integrity Policy Enforcement (IPE) LSM, which is not yet
> > upstream, is planned to use the builtin signatures.  (This differs from
> > IMA, which uses its own signature mechanism.)  For that reason, my
> > earlier patch "fsverity: mark builtin signatures as deprecated"
> > (https://lore.kernel.org/r/20221208033548.122704-1-ebiggers@kernel.org),
> > which marked builtin signatures as "deprecated", was controversial.
> >
> > This patch therefore stops short of marking the feature as deprecated.
> > I've also revised the language to focus on better explaining the feature
> > and what its alternatives are.
> >
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >
> > v3: fixed ioctl name, and more updates to address Luca's comments
> > v2: updated two paragraphs of fsverity.rst to address Luca's comments
> >
> >  Documentation/filesystems/fsverity.rst | 192 ++++++++++++++++---------
> >  fs/verity/Kconfig                      |  16 +--
> >  fs/verity/enable.c                     |   2 +-
> >  fs/verity/open.c                       |   8 +-
> >  fs/verity/read_metadata.c              |   4 +-
> >  fs/verity/signature.c                  |   8 ++
> >  6 files changed, 149 insertions(+), 81 deletions(-)
> <...>
> > +- fs-verity builtin signatures are in PKCS#7 format, and the public
> > +  keys are in X.509 format.  These formats are commonly used,
> > +  including by some other kernel features (which is why the fs-verity
> > +  builtin signatures use them), and are very feature rich.
> > +  Unfortunately, history has shown that code that parses and handles
> > +  these formats (which are from the 1990s and are based on ASN.1)
> > +  often has vulnerabilities as a result of their complexity.  This
> > +  complexity is not inherent to the cryptography itself.
> > +
> > +  fs-verity users who do not need advanced features of X.509 and
> > +  PKCS#7 should strongly consider using simpler formats, such as plain
> > +  Ed25519 keys and signatures, and verifying signatures in userspace.
> > +
> > +  fs-verity users who choose to use X.509 and PKCS#7 anyway should
> > +  still consider that verifying those signatures in userspace is more
> > +  flexible (for other reasons mentioned earlier in this document) and
> > +  eliminates the need to enable CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> > +  and its associated increase in kernel attack surface.  In some cases
> > +  it can even be necessary, since advanced X.509 and PKCS#7 features
> > +  do not always work as intended with the kernel.  For example, the
> > +  kernel does not check X.509 certificate validity times.
> > +
> > +  Note: IMA appraisal, which supports fs-verity, does not use PKCS#7
> > +  for its signatures, so it partially avoids the issues discussed
> > +  here.  IMA appraisal does use X.509.
> 
> Thank you for the update, I find this new version much better as it is
> clearly scoped for the specific case of fs-verity, hence:
> 
> Reviewed-by: Luca Boccassi <bluca@debian.org>

Great, I'm glad we were finally able to arrive at a version that you're okay
with.

- Eric
