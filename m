Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BA37360A0
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jun 2023 02:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjFTAmh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jun 2023 20:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFTAmf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jun 2023 20:42:35 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99A8E7F;
        Mon, 19 Jun 2023 17:42:33 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-bc9782291f5so4293755276.1;
        Mon, 19 Jun 2023 17:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687221753; x=1689813753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zijk9x5XKpNSurhQhmXEGI55QA031RY4qBEZvg6bX80=;
        b=VpVAaoJYCsN2GoTshTIuH1XL6tfvxhC5jKaQ6tL22b+k0jydG/oQF5kxAR6CFwiMGo
         Gqlz+jGawcLMTXgFNU3aWpxFHi6rVoB8Nez0Byb7Pm1YzgA9HA/wmY5dIZB92dvp0ZSQ
         IJM362MfAChhgZ4MrAds0tVCJhzqGzCOFgbgLinbxts+iCBTd2Lw/e44WGKf/C+To5ID
         WGyrbZW8A9/JEdMRXMjAc8EjL8spiJE6hpW/N10K4eirnZQeDPqym4J68yYOFbWnf/gP
         k/UnSZwg43kUPDNb5cCu9KFepqzkmiNt9yWcvTfI+tYE7lLsaEW8Fhcz0yC+8mhnYSDP
         LOgg==
X-Gm-Message-State: AC+VfDwY3BubDzM256QrkzV7AGe0zF05QHDyH+y4WCFhONwHJVSLl0ws
        CTEJlsvV3870h8DXtV4BYpgsQb/KxvKciA==
X-Google-Smtp-Source: ACHHUZ7pQL/b7dMn5xSJlU0WzFg6vbjpW/+cdiMsTXHtsXcAcYdP13v6sr8H9oUIp3z4Zg630FF+zQ==
X-Received: by 2002:a25:8402:0:b0:be5:d4d0:df61 with SMTP id u2-20020a258402000000b00be5d4d0df61mr8765551ybk.41.1687221752755;
        Mon, 19 Jun 2023 17:42:32 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm124498ybr.42.2023.06.19.17.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 17:42:31 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5700401acbeso45655707b3.0;
        Mon, 19 Jun 2023 17:42:31 -0700 (PDT)
X-Received: by 2002:a0d:e447:0:b0:565:99c0:a690 with SMTP id
 n68-20020a0de447000000b0056599c0a690mr10810305ywe.36.1687221751419; Mon, 19
 Jun 2023 17:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230619221048.10335-1-ebiggers@kernel.org> <CAMw=ZnQCBJM71wi-yO99yi+KTy=WtR2+jJxU2snvWgJTzTeeFw@mail.gmail.com>
 <20230619234939.GA2320@sol.localdomain>
In-Reply-To: <20230619234939.GA2320@sol.localdomain>
From:   Luca Boccassi <bluca@debian.org>
Date:   Tue, 20 Jun 2023 01:42:20 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnRVKQz9tY=DH9eoAMeEd07tdXMENW0Lhbx2tApH==5D_Q@mail.gmail.com>
Message-ID: <CAMw=ZnRVKQz9tY=DH9eoAMeEd07tdXMENW0Lhbx2tApH==5D_Q@mail.gmail.com>
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

On Tue, 20 Jun 2023 at 00:49, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jun 20, 2023 at 12:04:39AM +0100, Luca Boccassi wrote:
> > > diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
> > > index ede672dedf110..c33f783e74953 100644
> > > --- a/Documentation/filesystems/fsverity.rst
> > > +++ b/Documentation/filesystems/fsverity.rst
> > <...>
> > > +- Trusted userspace code.  Often, the userspace code that accesses
> > > +  files can be trusted to authenticate them.  Consider e.g. an
> > > +  application that wants to authenticate data files before using them,
> > > +  or an application loader that is part of the operating system (which
> > > +  is already authenticated in a different way, such as by being loaded
> > > +  from a read-only partition that uses dm-verity) and that wants to
> > > +  authenticate applications before loading them.  In these cases, this
> > > +  trusted userspace code can authenticate a file's contents by
> > > +  retrieving its fs-verity digest using `FS_IOC_ENABLE_VERITY`_, then
> > > +  verifying a signature of it using any userspace cryptographic
> > > +  library that supports digital signatures.  Consider using `libsodium
> > > +  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_
> > > +  or `Tink <https://developers.google.com/tink/digitally-sign-data>`_.
> > > +  Other options include OpenSSL, JCA, and libgcrypt.
> >
> > Text looks good to me now, but please just drop the last sentence with
> > the external projects links, as it seems best left as an exercise for
> > the reader to find their preferred tooling that is appropriate to be
> > used at the time of reading, as this will get out of date fast.
> >
> > <...>
>
> Well, a significant part of the motivation for this patch is that the "exercise
> for the reader" approach has already been tried, for several years, but it is
> not working well.  People don't know what to use and need a little more help.
>
> I'm planning to add some example code to fsverity-utils, probably using
> libsodium.  After that, I'll make this documentation link to there.  But for
> now, I think the last two sentences of the above paragraph are helpful.

That list does not help, quite the opposite - libsodium seems all but
abandoned (last release 5 years ago, an unmaintained project is not
exactly what you want for your crypto primitives) and tink appears to
be one of those google's sources-available-proprietary projects, which
means that, as with everything else that google throws over the wall,
it's at permanent risk of getting killed with little notice, among
many other problems. If you really want to suggest something, OpenSSL
seems like an appropriate choice of a widely available, supported and
well-known solution that is the most likely to still be around and
maintained in 5/10 years.

> > > +- fs-verity builtin signatures are in PKCS#7 format, and the public
> > > +  keys are in X.509 format.  These data formats are unnecessarily
> > > +  complex and prone to vulnerabilities.  (fs-verity builtin signatures
> > > +  were made to use these formats because other kernel subsystems, such
> > > +  as the module loader, unfortunately used these formats already.
> > > +  Note, these formats should still be used when they are the only
> > > +  option to have signatures at all.)  Userspace signature verification
> > > +  avoids having to enable CONFIG_FS_VERITY_BUILTIN_SIGNATURES and the
> > > +  associated kernel attack surface.  Userspace also has the
> > > +  flexibility to choose simpler formats.  For example, consider using
> > > +  straightforward Ed25519 keys and signatures with `libsodium
> > > +  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_.
> > > +
> > > +  IMA appraisal, which supports fs-verity, does not use PKCS#7, so it
> > > +  partially avoids this issue as well (though it does use X.509).
> > > +
> > > +  If you are considering making use of "advanced" features of X.509
> > > +  and/or PKCS#7, please also keep in mind that these "advanced"
> > > +  features do not always work as intended with the kernel.  For
> > > +  example, the kernel does not check X.509 certificate validity times.
> >
> > Sorry but this still reads as way too opinionated and generic, rather
> > than being fsverity-specific.
> >
> > Please simplify to convey the same
> > message in more concise way, perhaps something along these lines:
> >
> > - fs-verity builtin signatures are in PKCS#7 format, and the public
> > keys are in X.509 format. IMA appraisal, which supports fs-verity,
> > uses a custom signature format rather than PKCS#7 and X.509 for public
> > keys. Alternative formats for signatures and public keys are not
> > supported for builtin signatures or IMA appraisal. For fully flexible
> > and customized signature and public keys formats, while also avoiding
> > to expose the kernel to untrusted input, signature verification can be
> > implemented by a trusted userspace component as described at <pointer
> > to appropriate section>
>
> That is not the same message at all, as it omits the mention of the
> disadvantages of PKCS#7 and X.509 compared to raw signatures, which was the main
> point.  So no, I don't think your version would be better.

The 'disadvantages' are your personal opinions. It's fine to have
opinions, it's less fine to present them as if they were industry
consensus in public project-wide documentation.

> It seems that what is going on here is that you are invested heavily into
> existing X.509 and PKCS#7 based systems, and as a result you do not want the
> problems with these formats to be described anywhere in the kernel
> documentation.  That is understandable, but that is a special interest that
> should not be catered to here.  This documentation is trying to help users make
> a decision of what type of signature to use in new systems.  And yes, it is
> fsverity specific documentation, but there is no way for it to make the needed
> point without dicussing the underlying data formats.

Industry standards are by very definition the opposite of 'special
interests'. Look, I tried my best to provide constructive and
actionable feedback in previous replies, but given you seem only
interested in casting aspersions and hijacking kernel documentation to
promote the latest proprietary google-toy-of-the-month:

Nacked-by: Luca Boccassi <bluca@debian.org>
