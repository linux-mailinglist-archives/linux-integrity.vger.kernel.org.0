Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B0373603E
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jun 2023 01:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjFSXto (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jun 2023 19:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFSXtn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jun 2023 19:49:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0A2134;
        Mon, 19 Jun 2023 16:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFD7560D2C;
        Mon, 19 Jun 2023 23:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5BCC433C8;
        Mon, 19 Jun 2023 23:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687218581;
        bh=kCq6cxrUfNeUQh6dPgSUzHhzzothrrVE0B0Ii4lpQok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDQm53XdDgk1/USnW70cXL9c8yL6qjlwqG4SiRuT+WO8lKe2GtVzneucIMI5tAUpv
         PAxEN7DFWnYFzxigIc3H9F315n8+TdS4f67CL3B8gCf2oyQpHwsk83oqTycQSDnJjg
         x+2bDGieQ75gbdY0+amBzRwqVK+JpAj9Ggdmx8chk/8YDcvaZvLkBPJAdbhyBNoT/0
         388eMY2d9Y1puxAoLDB42iBU5Uqebv/ejbcjxyWBeCb9/OrVuWb8afMigrQVGPhx8l
         18d5dpx3kggVTTjwRaFznTPeo7A0dX+uygc2ZghSNZ8VeHBgVkHjPaSICRU4KuMa3W
         oJGBdXnAYUGqQ==
Date:   Mon, 19 Jun 2023 16:49:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     fsverity@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH v2] fsverity: improve documentation for builtin signature
 support
Message-ID: <20230619234939.GA2320@sol.localdomain>
References: <20230619221048.10335-1-ebiggers@kernel.org>
 <CAMw=ZnQCBJM71wi-yO99yi+KTy=WtR2+jJxU2snvWgJTzTeeFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnQCBJM71wi-yO99yi+KTy=WtR2+jJxU2snvWgJTzTeeFw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 20, 2023 at 12:04:39AM +0100, Luca Boccassi wrote:
> > diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
> > index ede672dedf110..c33f783e74953 100644
> > --- a/Documentation/filesystems/fsverity.rst
> > +++ b/Documentation/filesystems/fsverity.rst
> <...>
> > +- Trusted userspace code.  Often, the userspace code that accesses
> > +  files can be trusted to authenticate them.  Consider e.g. an
> > +  application that wants to authenticate data files before using them,
> > +  or an application loader that is part of the operating system (which
> > +  is already authenticated in a different way, such as by being loaded
> > +  from a read-only partition that uses dm-verity) and that wants to
> > +  authenticate applications before loading them.  In these cases, this
> > +  trusted userspace code can authenticate a file's contents by
> > +  retrieving its fs-verity digest using `FS_IOC_ENABLE_VERITY`_, then
> > +  verifying a signature of it using any userspace cryptographic
> > +  library that supports digital signatures.  Consider using `libsodium
> > +  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_
> > +  or `Tink <https://developers.google.com/tink/digitally-sign-data>`_.
> > +  Other options include OpenSSL, JCA, and libgcrypt.
> 
> Text looks good to me now, but please just drop the last sentence with
> the external projects links, as it seems best left as an exercise for
> the reader to find their preferred tooling that is appropriate to be
> used at the time of reading, as this will get out of date fast.
> 
> <...>

Well, a significant part of the motivation for this patch is that the "exercise
for the reader" approach has already been tried, for several years, but it is
not working well.  People don't know what to use and need a little more help.

I'm planning to add some example code to fsverity-utils, probably using
libsodium.  After that, I'll make this documentation link to there.  But for
now, I think the last two sentences of the above paragraph are helpful.

> 
> > +- fs-verity builtin signatures are in PKCS#7 format, and the public
> > +  keys are in X.509 format.  These data formats are unnecessarily
> > +  complex and prone to vulnerabilities.  (fs-verity builtin signatures
> > +  were made to use these formats because other kernel subsystems, such
> > +  as the module loader, unfortunately used these formats already.
> > +  Note, these formats should still be used when they are the only
> > +  option to have signatures at all.)  Userspace signature verification
> > +  avoids having to enable CONFIG_FS_VERITY_BUILTIN_SIGNATURES and the
> > +  associated kernel attack surface.  Userspace also has the
> > +  flexibility to choose simpler formats.  For example, consider using
> > +  straightforward Ed25519 keys and signatures with `libsodium
> > +  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_.
> > +
> > +  IMA appraisal, which supports fs-verity, does not use PKCS#7, so it
> > +  partially avoids this issue as well (though it does use X.509).
> > +
> > +  If you are considering making use of "advanced" features of X.509
> > +  and/or PKCS#7, please also keep in mind that these "advanced"
> > +  features do not always work as intended with the kernel.  For
> > +  example, the kernel does not check X.509 certificate validity times.
> 
> Sorry but this still reads as way too opinionated and generic, rather
> than being fsverity-specific.
>
> Please simplify to convey the same
> message in more concise way, perhaps something along these lines:
> 
> - fs-verity builtin signatures are in PKCS#7 format, and the public
> keys are in X.509 format. IMA appraisal, which supports fs-verity,
> uses a custom signature format rather than PKCS#7 and X.509 for public
> keys. Alternative formats for signatures and public keys are not
> supported for builtin signatures or IMA appraisal. For fully flexible
> and customized signature and public keys formats, while also avoiding
> to expose the kernel to untrusted input, signature verification can be
> implemented by a trusted userspace component as described at <pointer
> to appropriate section>

That is not the same message at all, as it omits the mention of the
disadvantages of PKCS#7 and X.509 compared to raw signatures, which was the main
point.  So no, I don't think your version would be better.

It seems that what is going on here is that you are invested heavily into
existing X.509 and PKCS#7 based systems, and as a result you do not want the
problems with these formats to be described anywhere in the kernel
documentation.  That is understandable, but that is a special interest that
should not be catered to here.  This documentation is trying to help users make
a decision of what type of signature to use in new systems.  And yes, it is
fsverity specific documentation, but there is no way for it to make the needed
point without dicussing the underlying data formats.

- Eric
