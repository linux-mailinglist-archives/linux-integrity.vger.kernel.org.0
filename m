Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F62C732476
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jun 2023 03:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjFPBKw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Jun 2023 21:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjFPBKu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Jun 2023 21:10:50 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA381FE2;
        Thu, 15 Jun 2023 18:10:48 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-bc4e41b7bc9so98401276.2;
        Thu, 15 Jun 2023 18:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686877847; x=1689469847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfbNROs6Pgx0jh/QUciGEinEqOd0nb4vq/TV0kvqbQo=;
        b=gTK8Cv6eFtbLgE/zfUwBjmGBzANbNJnULQkjdZsqzXJErvHwD1mwEfqfSaWX5gFv6Y
         ejpixWdCKuqznhLc3HsDHGPPOBhRnSRZXltJ4VPvwSPYAbuqfraKVCVtWDH374ZR6bst
         VRF21Cto11sjMNZ8DTHPChL9KDGaOahwjpln26jZK+SuwjfECyQvGkvaez09Cy9va0qm
         IcifmMFSQbD2Am1mzrwTLTcrb0eJKf3mjO5CchRm/d9jab8OTDYJrgoKNIHuopzvi7CN
         Bpvi0VwR0XjqfaYCoFrHk3KE190hff4PB4JK7m5/HikX62kWNCqv/Gs2/ATVNTSlXHxT
         c5cQ==
X-Gm-Message-State: AC+VfDxfHAaAkHA2gwko8y3FWWLOrxcpHFpEwIXBLSMsAoG+4x9yl0Jh
        8PbZ3F7OK+Hcjqe8tH7rgNQfbHbxEJBvNuFU
X-Google-Smtp-Source: ACHHUZ7wlaqhzDPGMQG3IuZzoJKV5t+NBTLjV00lzeEt9HEbmQBwstS0wmZiS8zX+OaZk0O5J5rHng==
X-Received: by 2002:a25:c0c7:0:b0:ba8:6530:d561 with SMTP id c190-20020a25c0c7000000b00ba86530d561mr446899ybf.30.1686877847158;
        Thu, 15 Jun 2023 18:10:47 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id l23-20020a25b317000000b00bc9588e9a05sm2580768ybj.37.2023.06.15.18.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 18:10:46 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5700b15c12fso2790737b3.1;
        Thu, 15 Jun 2023 18:10:46 -0700 (PDT)
X-Received: by 2002:a0d:d5d5:0:b0:56d:4d7:4a45 with SMTP id
 x204-20020a0dd5d5000000b0056d04d74a45mr304478ywd.52.1686877846182; Thu, 15
 Jun 2023 18:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230615230537.30429-1-ebiggers@kernel.org>
In-Reply-To: <20230615230537.30429-1-ebiggers@kernel.org>
From:   Luca Boccassi <bluca@debian.org>
Date:   Fri, 16 Jun 2023 02:10:35 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnR69AhMMQUOwKv9RtP85JzxQhMGO3yzyeEagWxaGiPAZg@mail.gmail.com>
Message-ID: <CAMw=ZnR69AhMMQUOwKv9RtP85JzxQhMGO3yzyeEagWxaGiPAZg@mail.gmail.com>
Subject: Re: [PATCH] fsverity: improve documentation for builtin signature support
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

On Fri, 16 Jun 2023 at 00:07, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> fsverity builtin signatures (CONFIG_FS_VERITY_BUILTIN_SIGNATURES) aren't
> the only way to do signatures with fsverity, and they have some major
> limitations.  Yet, more users have tried to use them, e.g. recently by
> https://github.com/ostreedev/ostree/pull/2640.  In most cases this seems
> to be because users aren't sufficiently familiar with the limitations of
> this feature and what the alternatives are.
>
> Therefore, make some updates to the documentation to try to clarify the
> properties of this feature and nudge users in the right direction.
>
> Note that the Integrity Policy Enforcement (IPE) LSM, which is not yet
> upstream, is planned to use the builtin signatures.  (This differs from
> IMA, which uses its own signature mechanism.)  For that reason, my
> earlier patch "fsverity: mark builtin signatures as deprecated"
> (https://lore.kernel.org/r/20221208033548.122704-1-ebiggers@kernel.org),
> which marked builtin signatures as "deprecated", was controversial.
>
> This patch therefore stops short of marking the feature as deprecated.
> I've also revised the language to focus on better explaining the feature
> and what its alternatives are.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>
> This patch applies to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next
>
>  Documentation/filesystems/fsverity.rst | 176 ++++++++++++++++---------
>  fs/verity/Kconfig                      |  16 +--
>  fs/verity/enable.c                     |   2 +-
>  fs/verity/open.c                       |   8 +-
>  fs/verity/read_metadata.c              |   4 +-
>  fs/verity/signature.c                  |   8 ++
>  6 files changed, 139 insertions(+), 75 deletions(-)
>
> diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
> index ede672dedf110..e990149cfdf5c 100644
> --- a/Documentation/filesystems/fsverity.rst
> +++ b/Documentation/filesystems/fsverity.rst

Most of the patch looks fine, two notes:

> +- Trusted userspace code.  When the accesses to a file happen in a
> +  well-defined way, userspace code can authenticate the file's
> +  fs-verity digest before accessing the file.  This can be done by
> +  verifying a signature of the fs-verity file digest using any
> +  userspace cryptographic library that supports digital signatures.
> +  Consider using `libsodium
> +  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_
> +  or `Tink <https://developers.google.com/tink/digitally-sign-data>`_.
> +  Other options include OpenSSL, JCA, and libgcrypt.

This should at least mention something like "depending on whether the
threat model allows trusting userspace with such tasks", because it is
by no means guaranteed that it is the case.

> +- fs-verity builtin signatures are in PKCS#7 format, and the public
> +  keys are in X.509 format.  These data formats are complex and prone
> +  to vulnerabilities, so parsing them is preferably done in userspace.
> +  (fs-verity builtin signatures were made to use these formats because
> +  other kernel subsystems, such as the module loader, unfortunately
> +  used these formats already.)  Most cryptographic libraries also
> +  support working with raw keys and signatures, which are much
> +  simpler.  For example, consider using `libsodium
> +  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_.
> +
> +  IMA appraisal, which supports fs-verity, does not use PKCS#7, so it
> +  partially avoids this issue as well (though it does use X.509).

The kernel makes extensive use of PKCS7, it's the foundation of the
trust chain with secure boot (and kernel modules as noted) after all,
among other things, so this description looks very out of place as
part of the same project. Readers might be led to believe that using
secure boot or signed modules is useless, or worse, dangerous, and
that it's better not to, and I'm quite sure that's not something we
want.

Kind regards,
Luca Boccassi
