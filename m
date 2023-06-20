Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5A57374F1
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jun 2023 21:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjFTTPq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jun 2023 15:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjFTTPq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jun 2023 15:15:46 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB32122;
        Tue, 20 Jun 2023 12:15:40 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-38ede2e0e69so3265260b6e.2;
        Tue, 20 Jun 2023 12:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687288540; x=1689880540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5n/u8d/inDe24N1IpBkJh8btI238OScc6PefkBA8i8=;
        b=aK0etY9lj41CsygxQSeJhULRMtIc9t7rZi/MJ2tU8wA2ezPZEgzmS1RlTSr2GFWZio
         fSIZ5bGQPE7BvRcnA3P8VKRmWEtdlf/bzDZTHOAnaewJFO2J/F5QBRIGR6ridoent7e5
         /kCfnNU/fcEZo4WAEAKgsD98nmD3TbD7mBZrJnVp2q8L6+utwmeqSpzuF0Bm5jb7AtLF
         OdRfoMuTMnBsasDK5uDHgIdXwoMLu80k+Dr/2nPyKaGacHubsVuDg9uNRN3hAjb4T2/X
         4vTPpfvEWUsZT8hc1g+mgPv4gQbHurJb6ScuOl912RDa7yR7H2OmHw1Dr4egYRaEW6XW
         WQdg==
X-Gm-Message-State: AC+VfDytBtguT9J/lDq8xFa8oZ2of2ppIPmCLvxRML6pfI0v9bqE6xKI
        ZER4KXPAWTiwfzcMgCpNSodh7wdcKeCdgQ==
X-Google-Smtp-Source: ACHHUZ4lPx/lcIlPT1HENGyrHp/PSEc3Jhm8WO1pv6nHppxrvcdxhfrlNI92BtFAQiBrtj0TNimQOg==
X-Received: by 2002:a05:6808:1481:b0:3a0:373c:2960 with SMTP id e1-20020a056808148100b003a0373c2960mr3719320oiw.36.1687288539658;
        Tue, 20 Jun 2023 12:15:39 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id a5-20020aca1a05000000b0039c76ff8c2bsm1374117oia.47.2023.06.20.12.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 12:15:39 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6b46f27f562so2175561a34.0;
        Tue, 20 Jun 2023 12:15:39 -0700 (PDT)
X-Received: by 2002:a05:6358:e820:b0:129:c3a3:5efd with SMTP id
 gi32-20020a056358e82000b00129c3a35efdmr5151361rwb.24.1687288538894; Tue, 20
 Jun 2023 12:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230619221048.10335-1-ebiggers@kernel.org> <CAMw=ZnQCBJM71wi-yO99yi+KTy=WtR2+jJxU2snvWgJTzTeeFw@mail.gmail.com>
 <20230619234939.GA2320@sol.localdomain> <CAMw=ZnRVKQz9tY=DH9eoAMeEd07tdXMENW0Lhbx2tApH==5D_Q@mail.gmail.com>
 <20230620031813.GA1590@sol.localdomain>
In-Reply-To: <20230620031813.GA1590@sol.localdomain>
From:   Luca Boccassi <bluca@debian.org>
Date:   Tue, 20 Jun 2023 20:15:27 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnQ0vyZTQ2f_9JdDbefTaJb42LRM++Fsg7jW8yH82n-5sw@mail.gmail.com>
Message-ID: <CAMw=ZnQ0vyZTQ2f_9JdDbefTaJb42LRM++Fsg7jW8yH82n-5sw@mail.gmail.com>
Subject: Re: [PATCH v2] fsverity: improve documentation for builtin signature support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fsverity@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
        Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 20 Jun 2023 at 04:18, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jun 20, 2023 at 01:42:20AM +0100, Luca Boccassi wrote:
> > On Tue, 20 Jun 2023 at 00:49, Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Tue, Jun 20, 2023 at 12:04:39AM +0100, Luca Boccassi wrote:
> > > > > diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
> > > > > index ede672dedf110..c33f783e74953 100644
> > > > > --- a/Documentation/filesystems/fsverity.rst
> > > > > +++ b/Documentation/filesystems/fsverity.rst
> > > > <...>
> > > > > +- Trusted userspace code.  Often, the userspace code that accesses
> > > > > +  files can be trusted to authenticate them.  Consider e.g. an
> > > > > +  application that wants to authenticate data files before using them,
> > > > > +  or an application loader that is part of the operating system (which
> > > > > +  is already authenticated in a different way, such as by being loaded
> > > > > +  from a read-only partition that uses dm-verity) and that wants to
> > > > > +  authenticate applications before loading them.  In these cases, this
> > > > > +  trusted userspace code can authenticate a file's contents by
> > > > > +  retrieving its fs-verity digest using `FS_IOC_ENABLE_VERITY`_, then
> > > > > +  verifying a signature of it using any userspace cryptographic
> > > > > +  library that supports digital signatures.  Consider using `libsodium
> > > > > +  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_
> > > > > +  or `Tink <https://developers.google.com/tink/digitally-sign-data>`_.
> > > > > +  Other options include OpenSSL, JCA, and libgcrypt.
> > > >
> > > > Text looks good to me now, but please just drop the last sentence with
> > > > the external projects links, as it seems best left as an exercise for
> > > > the reader to find their preferred tooling that is appropriate to be
> > > > used at the time of reading, as this will get out of date fast.
> > > >
> > > > <...>
> > >
> > > Well, a significant part of the motivation for this patch is that the "exercise
> > > for the reader" approach has already been tried, for several years, but it is
> > > not working well.  People don't know what to use and need a little more help.
> > >
> > > I'm planning to add some example code to fsverity-utils, probably using
> > > libsodium.  After that, I'll make this documentation link to there.  But for
> > > now, I think the last two sentences of the above paragraph are helpful.
> >
> > That list does not help, quite the opposite - libsodium seems all but
> > abandoned (last release 5 years ago, an unmaintained project is not
> > exactly what you want for your crypto primitives)
>
> libsodium has an active maintainer.  Last commit was 3 months ago.
>
> Also note that simple crypto libraries that focus on offering modern
> cryptographic algorithms don't need to be updated often.  You actually *don't*
> really want to have to constantly update your crypto library because they e.g.
> messed up their ASN.1 parser.  If there is no ASN.1, that cannot happen.

Maintenance is not only CVE-driven, no release for almost 5 years in a
security-critical component to me looks like a red flag. And I
maintain projects using libsodium (zeromq), so it's not like I've
never seen it before. But when a package is shipped bit-by-bit
identical across two different Debian releases it's usually not a sign
of good health for the project.

> > tink appears to
> > be one of those google's sources-available-proprietary projects, which
> > means that, as with everything else that google throws over the wall,
> > it's at permanent risk of getting killed with little notice, among
> > many other problems.
>
> Tink is an open source project licensed under the Apache license.  Non-Google
> contributions to Tink are being accepted on GitHub.  If Google stops maintaining
> Tink, it can be forked, like any other open source project.

The website that was linked said a CLA was required. On top of that, I
can't speak for this one in particular, but my experience with other
google projects that were allegedly open source has been atrocious -
the 'real' source tree being proprietary and private, with code
occasionally synced to Github, and external contributors requiring an
internal corporate 'sponsor' to get their changes merged internally
first, passing invisible, private CI and getting reverted without much
consideration when some more important, internal change conflicted,
and with no way to find out till the internal real tree was thrown
over the wall again at some point in the future. All of this while
claiming it was just a normal open source project on Github. That's
not open source, that's proprietary with sources-available.

> Anyway, my intent was simply to list some modern crypto libraries.  One of them
> just happens to be from Google.  I'm sorry if it may have appeared like I listed
> a Google project because of it being from Google.  That was not my intent.
>
> > If you really want to suggest something, OpenSSL
> > seems like an appropriate choice of a widely available, supported and
> > well-known solution that is the most likely to still be around and
> > maintained in 5/10 years.
>
> Sure.  Which is why I included OpenSSL in the list.
>
> Anyway, I'll go ahead and take your suggestion to omit the mentions of any
> specific crypto libraries.  I do agree that it could use some more thought, and
> the main place for this information will be in fsverity-utils which will have
> the example code.

Thank you. It seems best to keep such recommendations, if any,
together with the example code, yes.
