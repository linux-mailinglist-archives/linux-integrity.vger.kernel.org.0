Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C726173251C
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jun 2023 04:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjFPCRP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Jun 2023 22:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbjFPCRM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Jun 2023 22:17:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC92C26B8;
        Thu, 15 Jun 2023 19:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 740A461C9A;
        Fri, 16 Jun 2023 02:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FD6C433C8;
        Fri, 16 Jun 2023 02:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686881829;
        bh=RDwrAfGJKYQ/d8/J++9rOAJk7PbSqAYC4oQisvSDjFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XN9cDPFbLi9xSKxUtYlQt5LjXyklInB4pmPy02CMgWaZ9JDeDhK++nU2nfJ+GnZRT
         X4uhNO/LcQg+en8xpqmZPDQ9vLniLp7fGl+rqhbWcg4cETCgU3r0KLc72XG4NSxs7L
         BDj59C1aUxZpuQALj3h9sI50LVfF0wmW2PGXq2EGHpe7EbfGlHx8hpIUC1uZMixbQS
         nRWOi9qBBVfSc3AduK/w8r/A7Eo0HN2bb7LaYOQbIV+U4uTPjj/CXvYzisCAPaBEsk
         JiCT9I1CBZGJvt+v7xLMnvQn1u5+XCKJXULk105w+cEMPddq+TzbbmEiFZ96L0zUf0
         YQ8kRAuLW9qdw==
Date:   Thu, 15 Jun 2023 19:17:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     fsverity@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH] fsverity: improve documentation for builtin signature
 support
Message-ID: <20230616021707.GA87129@sol.localdomain>
References: <20230615230537.30429-1-ebiggers@kernel.org>
 <CAMw=ZnR69AhMMQUOwKv9RtP85JzxQhMGO3yzyeEagWxaGiPAZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnR69AhMMQUOwKv9RtP85JzxQhMGO3yzyeEagWxaGiPAZg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Luca,

On Fri, Jun 16, 2023 at 02:10:35AM +0100, Luca Boccassi wrote:
> On Fri, 16 Jun 2023 at 00:07, Eric Biggers <ebiggers@kernel.org> wrote:
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
> > This patch applies to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next
> >
> >  Documentation/filesystems/fsverity.rst | 176 ++++++++++++++++---------
> >  fs/verity/Kconfig                      |  16 +--
> >  fs/verity/enable.c                     |   2 +-
> >  fs/verity/open.c                       |   8 +-
> >  fs/verity/read_metadata.c              |   4 +-
> >  fs/verity/signature.c                  |   8 ++
> >  6 files changed, 139 insertions(+), 75 deletions(-)
> >
> > diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
> > index ede672dedf110..e990149cfdf5c 100644
> > --- a/Documentation/filesystems/fsverity.rst
> > +++ b/Documentation/filesystems/fsverity.rst
> 
> Most of the patch looks fine, two notes:
> 
> > +- Trusted userspace code.  When the accesses to a file happen in a
> > +  well-defined way, userspace code can authenticate the file's
> > +  fs-verity digest before accessing the file.  This can be done by
> > +  verifying a signature of the fs-verity file digest using any
> > +  userspace cryptographic library that supports digital signatures.
> > +  Consider using `libsodium
> > +  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_
> > +  or `Tink <https://developers.google.com/tink/digitally-sign-data>`_.
> > +  Other options include OpenSSL, JCA, and libgcrypt.
> 
> This should at least mention something like "depending on whether the
> threat model allows trusting userspace with such tasks", because it is
> by no means guaranteed that it is the case.

Sure, that's why it says "Trusted userspace code", but I can make it clearer.

> 
> > +- fs-verity builtin signatures are in PKCS#7 format, and the public
> > +  keys are in X.509 format.  These data formats are complex and prone
> > +  to vulnerabilities, so parsing them is preferably done in userspace.
> > +  (fs-verity builtin signatures were made to use these formats because
> > +  other kernel subsystems, such as the module loader, unfortunately
> > +  used these formats already.)  Most cryptographic libraries also
> > +  support working with raw keys and signatures, which are much
> > +  simpler.  For example, consider using `libsodium
> > +  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_.
> > +
> > +  IMA appraisal, which supports fs-verity, does not use PKCS#7, so it
> > +  partially avoids this issue as well (though it does use X.509).
> 
> The kernel makes extensive use of PKCS7, it's the foundation of the
> trust chain with secure boot (and kernel modules as noted) after all,
> among other things, so this description looks very out of place as
> part of the same project. Readers might be led to believe that using
> secure boot or signed modules is useless, or worse, dangerous, and
> that it's better not to, and I'm quite sure that's not something we
> want.
> 

Unfortunately just because PKCS#7, X.509, and ASN.1 is being used does not mean
it is a good idea.  Have you read the kernel code that implements these formats?
A few years ago I went through some of it.  Here are some of the bugs I fixed:

    2eb9eabf1e86 ("KEYS: fix out-of-bounds read during ASN.1 parsing")
    624f5ab8720b ("KEYS: fix NULL pointer dereference during ASN.1 parsing [ver #2]")
    e0058f3a874e ("ASN.1: fix out-of-bounds read when parsing indefinite length item")
    81a7be2cd69b ("ASN.1: check for error from ASN1_OP_END__ACT actions")
    0f30cbea005b ("X.509: reject invalid BIT STRING for subjectPublicKey")
    54c1fb39fe04 ("X.509: fix comparisons of ->pkey_algo")
    971b42c038dc ("PKCS#7: fix certificate chain verification")
    29f4a67c17e1 ("PKCS#7: fix certificate blacklisting")
    437499eea429 ("X.509: fix BUG_ON() when hash algorithm is unsupported")
    4b34968e77ad ("X.509: fix NULL dereference when restricting key with unsupported_sig") 

971b42c038dc is noteworthy; it turned out the kernel did not properly verify
certificate chains in PKCS#7 messages.  That was fundamentally a PKCS#7-specific
security bug that was directly caused by the complexity that is specific to
PKCS#7.  Simple signatures do not have certificate chains.

I hope the code is in slightly better shape now.  But I really haven't looked at
it in several years.  In any case, the fact is that these formats are complex,
which causes bugs.  I don't think we should be trying to pretend otherwise.

As for under what circumstances these risks are worth taking anyway, it's an
interesting question.  Part of my concern is actually about people who don't
actually use any of these integrity/authenticity oriented kernel features at
all.  They are getting no benefit from them, and we don't want to create
problems for them.  But, by CONFIG_FS_VERITY_BUILTIN_SIGNATURES being in their
kernel config, their system is potentially opened up to exploits by
FS_IOC_ENABLE_VERITY(malicious_pkcs7_signature).  Or just by
CONFIG_X509_CERTIFICATE_PARSER being in their kernel config, their system is
potentially opened up to exploits by sys_add_key(malicious_X509_certificate).
They could eliminate this risk by disabling these kernel config options.

So I think that mentioning the risks of processing these data formats in the
kernel is useful.  Though it maybe should be made clear that attack surface
mainly comes from these features being configured into the kernel, not whether
they're actually being used.

- Eric
