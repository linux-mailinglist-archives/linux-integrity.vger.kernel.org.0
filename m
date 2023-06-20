Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DE673621D
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jun 2023 05:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjFTDSS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jun 2023 23:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjFTDSS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jun 2023 23:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5DA1B0;
        Mon, 19 Jun 2023 20:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 495C060E99;
        Tue, 20 Jun 2023 03:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4ECC433C0;
        Tue, 20 Jun 2023 03:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687231095;
        bh=5kX3k4XJ9Q5Hely0t1ghE0El8Wyy1Z6098NToPfXlEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MESw7CmzT0ggbKAhmbX2XebQDrYUo1Ww3FbyjHZ4UOAITSmk2FNd26sNGHamem3Gk
         bjRYEBVPq2n1l+h0ABhRi08/cGpRxwlwZFERZKcEX4TSXJoGGCzwT6brbN8gXWSOaJ
         NCqAWNq0AKvofWbavZfAQZn/B6jzOlIfB+KHMk23TiQy/5F8DqeCYqByt5xydFXKv+
         fTQZYKfLFWl/rJ2mnqHYUGdU5NeIrvLm1Izvc/LYrzsHlxj4yo7kXpZFMYc/UuEnJN
         +Wi6XRO+UEE9kavhE7mQid1ItKf6F9xdiqC1BzZVXzDe/Ick4WsZUMgkklRsn+gIl9
         eAOo0GXuCu6eQ==
Date:   Mon, 19 Jun 2023 20:18:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     fsverity@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH v2] fsverity: improve documentation for builtin signature
 support
Message-ID: <20230620031813.GA1590@sol.localdomain>
References: <20230619221048.10335-1-ebiggers@kernel.org>
 <CAMw=ZnQCBJM71wi-yO99yi+KTy=WtR2+jJxU2snvWgJTzTeeFw@mail.gmail.com>
 <20230619234939.GA2320@sol.localdomain>
 <CAMw=ZnRVKQz9tY=DH9eoAMeEd07tdXMENW0Lhbx2tApH==5D_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnRVKQz9tY=DH9eoAMeEd07tdXMENW0Lhbx2tApH==5D_Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 20, 2023 at 01:42:20AM +0100, Luca Boccassi wrote:
> On Tue, 20 Jun 2023 at 00:49, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Tue, Jun 20, 2023 at 12:04:39AM +0100, Luca Boccassi wrote:
> > > > diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
> > > > index ede672dedf110..c33f783e74953 100644
> > > > --- a/Documentation/filesystems/fsverity.rst
> > > > +++ b/Documentation/filesystems/fsverity.rst
> > > <...>
> > > > +- Trusted userspace code.  Often, the userspace code that accesses
> > > > +  files can be trusted to authenticate them.  Consider e.g. an
> > > > +  application that wants to authenticate data files before using them,
> > > > +  or an application loader that is part of the operating system (which
> > > > +  is already authenticated in a different way, such as by being loaded
> > > > +  from a read-only partition that uses dm-verity) and that wants to
> > > > +  authenticate applications before loading them.  In these cases, this
> > > > +  trusted userspace code can authenticate a file's contents by
> > > > +  retrieving its fs-verity digest using `FS_IOC_ENABLE_VERITY`_, then
> > > > +  verifying a signature of it using any userspace cryptographic
> > > > +  library that supports digital signatures.  Consider using `libsodium
> > > > +  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_
> > > > +  or `Tink <https://developers.google.com/tink/digitally-sign-data>`_.
> > > > +  Other options include OpenSSL, JCA, and libgcrypt.
> > >
> > > Text looks good to me now, but please just drop the last sentence with
> > > the external projects links, as it seems best left as an exercise for
> > > the reader to find their preferred tooling that is appropriate to be
> > > used at the time of reading, as this will get out of date fast.
> > >
> > > <...>
> >
> > Well, a significant part of the motivation for this patch is that the "exercise
> > for the reader" approach has already been tried, for several years, but it is
> > not working well.  People don't know what to use and need a little more help.
> >
> > I'm planning to add some example code to fsverity-utils, probably using
> > libsodium.  After that, I'll make this documentation link to there.  But for
> > now, I think the last two sentences of the above paragraph are helpful.
> 
> That list does not help, quite the opposite - libsodium seems all but
> abandoned (last release 5 years ago, an unmaintained project is not
> exactly what you want for your crypto primitives)

libsodium has an active maintainer.  Last commit was 3 months ago.

Also note that simple crypto libraries that focus on offering modern
cryptographic algorithms don't need to be updated often.  You actually *don't*
really want to have to constantly update your crypto library because they e.g.
messed up their ASN.1 parser.  If there is no ASN.1, that cannot happen.

> tink appears to
> be one of those google's sources-available-proprietary projects, which
> means that, as with everything else that google throws over the wall,
> it's at permanent risk of getting killed with little notice, among
> many other problems.

Tink is an open source project licensed under the Apache license.  Non-Google
contributions to Tink are being accepted on GitHub.  If Google stops maintaining
Tink, it can be forked, like any other open source project.

Anyway, my intent was simply to list some modern crypto libraries.  One of them
just happens to be from Google.  I'm sorry if it may have appeared like I listed
a Google project because of it being from Google.  That was not my intent.

> If you really want to suggest something, OpenSSL
> seems like an appropriate choice of a widely available, supported and
> well-known solution that is the most likely to still be around and
> maintained in 5/10 years.

Sure.  Which is why I included OpenSSL in the list.

Anyway, I'll go ahead and take your suggestion to omit the mentions of any
specific crypto libraries.  I do agree that it could use some more thought, and
the main place for this information will be in fsverity-utils which will have
the example code.

> > > > +- fs-verity builtin signatures are in PKCS#7 format, and the public
> > > > +  keys are in X.509 format.  These data formats are unnecessarily
> > > > +  complex and prone to vulnerabilities.  (fs-verity builtin signatures
> > > > +  were made to use these formats because other kernel subsystems, such
> > > > +  as the module loader, unfortunately used these formats already.
> > > > +  Note, these formats should still be used when they are the only
> > > > +  option to have signatures at all.)  Userspace signature verification
> > > > +  avoids having to enable CONFIG_FS_VERITY_BUILTIN_SIGNATURES and the
> > > > +  associated kernel attack surface.  Userspace also has the
> > > > +  flexibility to choose simpler formats.  For example, consider using
> > > > +  straightforward Ed25519 keys and signatures with `libsodium
> > > > +  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_.
> > > > +
> > > > +  IMA appraisal, which supports fs-verity, does not use PKCS#7, so it
> > > > +  partially avoids this issue as well (though it does use X.509).
> > > > +
> > > > +  If you are considering making use of "advanced" features of X.509
> > > > +  and/or PKCS#7, please also keep in mind that these "advanced"
> > > > +  features do not always work as intended with the kernel.  For
> > > > +  example, the kernel does not check X.509 certificate validity times.
> > >
> > > Sorry but this still reads as way too opinionated and generic, rather
> > > than being fsverity-specific.
> > >
> > > Please simplify to convey the same
> > > message in more concise way, perhaps something along these lines:
> > >
> > > - fs-verity builtin signatures are in PKCS#7 format, and the public
> > > keys are in X.509 format. IMA appraisal, which supports fs-verity,
> > > uses a custom signature format rather than PKCS#7 and X.509 for public
> > > keys. Alternative formats for signatures and public keys are not
> > > supported for builtin signatures or IMA appraisal. For fully flexible
> > > and customized signature and public keys formats, while also avoiding
> > > to expose the kernel to untrusted input, signature verification can be
> > > implemented by a trusted userspace component as described at <pointer
> > > to appropriate section>
> >
> > That is not the same message at all, as it omits the mention of the
> > disadvantages of PKCS#7 and X.509 compared to raw signatures, which was the main
> > point.  So no, I don't think your version would be better.
> 
> The 'disadvantages' are your personal opinions. It's fine to have
> opinions, it's less fine to present them as if they were industry
> consensus in public project-wide documentation.

I think it is a bit more objective than a "personal opinion".  I've given many
examples of vulnerability fixes in the kernel's ASN.1, X.509, and PKCS#7 code,
which were not inherent to the actual crypto that users want but rather just
caused by the complexities of these formats.  I've also mentioned how signatures
can be created and verified using an industry-standard signature algorithm
without using any of these formats.  I think you're also being a bit
disrespectful to people like me who have actually taken time to find and fix
vulnerabilities in the kernel's implementation of these formats.  As well as the
developers of major crypto libraries who will tell you the exact same thing.

> > It seems that what is going on here is that you are invested heavily into
> > existing X.509 and PKCS#7 based systems, and as a result you do not want the
> > problems with these formats to be described anywhere in the kernel
> > documentation.  That is understandable, but that is a special interest that
> > should not be catered to here.  This documentation is trying to help users make
> > a decision of what type of signature to use in new systems.  And yes, it is
> > fsverity specific documentation, but there is no way for it to make the needed
> > point without dicussing the underlying data formats.
> 
> Industry standards are by very definition the opposite of 'special
> interests'. Look, I tried my best to provide constructive and
> actionable feedback in previous replies, but given you seem only
> interested in casting aspersions and hijacking kernel documentation to
> promote the latest proprietary google-toy-of-the-month:
> 
> Nacked-by: Luca Boccassi <bluca@debian.org>

It's quite strange that you consider Ed25519 to be a "Google proprietary-toy-of-
the-month".  Are you sure you really know what you're talking about?

You've also claimed that my proposed documentation contradicts other kernel
documentation.  I don't see where that's the case.  There are other features
that use PKCS#7, but none of them seems to be extolling the virtues of PKCS#7.
It's just the signature format they happened to choose, probably because it was
the first one that came to mind (which is what happened to fs-verity too).  I
just would like to help fs-verity users avoid that mistake, when possible.

Anyway, I'll send out v3 of this patch with the mentions of the specific crypto
libraries removed.  I'll also update the wording of the PKCS#7 paragraph a bit.
I expect you still won't be happy with it.  But I do believe it is important to
give good security advice, which includes avoiding unnecessary complexity.

- Eric
