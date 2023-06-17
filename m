Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D0B733E15
	for <lists+linux-integrity@lfdr.de>; Sat, 17 Jun 2023 06:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjFQEvI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 17 Jun 2023 00:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjFQEvH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 17 Jun 2023 00:51:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A160D10C1;
        Fri, 16 Jun 2023 21:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CFAD60CBA;
        Sat, 17 Jun 2023 04:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F985C433C0;
        Sat, 17 Jun 2023 04:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686977465;
        bh=JkdQR20ShOJ/lF5M3KLtBhHDScXeHiAAFg7kkEihbjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pbgTgTIH8yxmS4rQvDmgvjIyAGBxTAyR7SmaKBA3Wt6FYLCfBEQFl5wvb+E0sXjHA
         6cAA+91A8TdakW6XOBDog7yJzG2/7iqt8Cbc7utzUY0eTEqHgjhXLM9hJpMmq42g9H
         EOTLB1gus2HzJuUHoHrj+d8cZCFOJij+h9rsdu/DbM3uDEBBZWfawRJXAc4Sw1g7ZN
         QeAk443csFAQApler1q7rahm62TNHwoIw2JWLRkMmVI7CGK/iD8lQf6D2U7MjIBLYN
         bfVQeANh9qwtG/fmVEFudoXWPTf0pE08WUcBWBjyv3EXdbYXaUF/1zTZLCb0zHAIAz
         sKvb8lOANepBQ==
Date:   Fri, 16 Jun 2023 21:51:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     fsverity@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH] fsverity: improve documentation for builtin signature
 support
Message-ID: <20230617045103.GA1090@sol.localdomain>
References: <20230615230537.30429-1-ebiggers@kernel.org>
 <CAMw=ZnR69AhMMQUOwKv9RtP85JzxQhMGO3yzyeEagWxaGiPAZg@mail.gmail.com>
 <20230616021707.GA87129@sol.localdomain>
 <CAMw=ZnTEV=GuEE=wB0Z4E1x_uH5zzjyQkB1ycrYnWB2GCMaRTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnTEV=GuEE=wB0Z4E1x_uH5zzjyQkB1ycrYnWB2GCMaRTA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 16, 2023 at 02:27:28PM +0100, Luca Boccassi wrote:
> > Unfortunately just because PKCS#7, X.509, and ASN.1 is being used does not mean
> > it is a good idea.  Have you read the kernel code that implements these formats?
> > A few years ago I went through some of it.  Here are some of the bugs I fixed:
> >
> >     2eb9eabf1e86 ("KEYS: fix out-of-bounds read during ASN.1 parsing")
> >     624f5ab8720b ("KEYS: fix NULL pointer dereference during ASN.1 parsing [ver #2]")
> >     e0058f3a874e ("ASN.1: fix out-of-bounds read when parsing indefinite length item")
> >     81a7be2cd69b ("ASN.1: check for error from ASN1_OP_END__ACT actions")
> >     0f30cbea005b ("X.509: reject invalid BIT STRING for subjectPublicKey")
> >     54c1fb39fe04 ("X.509: fix comparisons of ->pkey_algo")
> >     971b42c038dc ("PKCS#7: fix certificate chain verification")
> >     29f4a67c17e1 ("PKCS#7: fix certificate blacklisting")
> >     437499eea429 ("X.509: fix BUG_ON() when hash algorithm is unsupported")
> >     4b34968e77ad ("X.509: fix NULL dereference when restricting key with unsupported_sig")
> 
> I have no doubt that there are bugs, as I have no doubts that there
> are bugs in every other subsystem, including fsverity, once you start
> looking hard enough.

My point was not that there are bugs, but rather that there are *unnecessary*
bugs (many with possible security impact) that are directly caused by the
complexities of these formats versus the alternatives.

> That's not the point. The point is that having
> the documentation of one kernel subsystem disparaging the mechanisms
> that are central to other kernel subsystems' functionality is weird
> and out of place. Something like that is fine to post on social media
> or a blog post or so. A user jumping from one page of kernel doc
> saying, paraphrasing heavily for the sake of argument, "use pkcs7 to
> ensure the security of your system via secure boot, measured boot and
> signed kernel modules" and another saying "pkcs7 is bad and broken,
> stay away from it" is just strange, confusing and incoherent from the
> point of view of a reader.

I'll add a note that PKCS#7 and X.509 should still be used in situations where
they are the only option.  I think that would handle your main concern here,
which is that people might misunderstand the paragraph as recommending using no
signatures, instead of signatures using a PKCS#7 and X.509 based system.

I don't think it would be appropriate to remove the paragraph entirely.  It
provides useful information that helps users decide what type of signatures to
use.  I understand that people who are invested greatly into PKCS#7 and X.509
based systems might be resistant to learning about the problems with these
formats, but that is to be expected.

- Eric
