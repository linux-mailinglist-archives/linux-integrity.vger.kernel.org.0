Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059A27374F3
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jun 2023 21:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjFTTP5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jun 2023 15:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFTTP4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jun 2023 15:15:56 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2271A1716;
        Tue, 20 Jun 2023 12:15:55 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5700b15c12fso55067407b3.1;
        Tue, 20 Jun 2023 12:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687288554; x=1689880554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9aIQ0PjtPWDuZDbSrp1ylwlxr0L4BcJbt/NlFEzGjw=;
        b=ZYNcoZdz6jhj90iThR2nD6kI7nAfhqRqnG2SOusSBeb+AXBv8/aW7cUrODEqZFDunR
         xQl9l8+Gehk6oyC+ir+CH+qZUR9q8E5Pugcryazp4W2GQk8iXru+1xAUBG7mSypCZDks
         Huh7wdPeqYOC0SHVoy5clHVglWoCKuiOlkuMPtq4qPGdTX5QJ0LEmeuu5F2E17Pulufh
         umVJpEsg7lbcZv3/6WL850g1r3doGYpOVjKOZWfzpSyG+mNsiMLxRAU82azm3fG6ntf9
         YR4teDkYsnFlckk0mzy5PHINpWF2RFS5hdY9zCEMjZYd7TRbq4hPTAiuLoaCdvIJDGFd
         sxIw==
X-Gm-Message-State: AC+VfDz66N1Vx7RpzGlaz1SMK6O2VDdVjaEGX4KGETZw0P7oKJFORSBa
        pGGjCAObJtsaY2udliMn4XgV2I5j7geZyg==
X-Google-Smtp-Source: ACHHUZ4mIO19oX55gJXoCQAOg2jUKZ0JWUvOQel2MBFZIvTG/+CECPNqS8MfrD+diaSXoXj7D2GMNw==
X-Received: by 2002:a81:4f95:0:b0:570:cec:804 with SMTP id d143-20020a814f95000000b005700cec0804mr13858689ywb.35.1687288554115;
        Tue, 20 Jun 2023 12:15:54 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id m125-20020a0de383000000b005732b228a83sm623354ywe.140.2023.06.20.12.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 12:15:53 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-56fff21c2ebso54929237b3.3;
        Tue, 20 Jun 2023 12:15:53 -0700 (PDT)
X-Received: by 2002:a25:ada2:0:b0:ba7:b933:9063 with SMTP id
 z34-20020a25ada2000000b00ba7b9339063mr11008259ybi.4.1687288553412; Tue, 20
 Jun 2023 12:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230620041937.5809-1-ebiggers@kernel.org>
In-Reply-To: <20230620041937.5809-1-ebiggers@kernel.org>
From:   Luca Boccassi <bluca@debian.org>
Date:   Tue, 20 Jun 2023 20:15:42 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnQg2dvdivEPdScMcgQQtj00T=EigpGn0ZRYHLMU=AKLMA@mail.gmail.com>
Message-ID: <CAMw=ZnQg2dvdivEPdScMcgQQtj00T=EigpGn0ZRYHLMU=AKLMA@mail.gmail.com>
Subject: Re: [PATCH v3] fsverity: improve documentation for builtin signature support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fsverity@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
        Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 20 Jun 2023 at 05:23, Eric Biggers <ebiggers@kernel.org> wrote:
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
> v3: fixed ioctl name, and more updates to address Luca's comments
> v2: updated two paragraphs of fsverity.rst to address Luca's comments
>
>  Documentation/filesystems/fsverity.rst | 192 ++++++++++++++++---------
>  fs/verity/Kconfig                      |  16 +--
>  fs/verity/enable.c                     |   2 +-
>  fs/verity/open.c                       |   8 +-
>  fs/verity/read_metadata.c              |   4 +-
>  fs/verity/signature.c                  |   8 ++
>  6 files changed, 149 insertions(+), 81 deletions(-)
<...>
> +- fs-verity builtin signatures are in PKCS#7 format, and the public
> +  keys are in X.509 format.  These formats are commonly used,
> +  including by some other kernel features (which is why the fs-verity
> +  builtin signatures use them), and are very feature rich.
> +  Unfortunately, history has shown that code that parses and handles
> +  these formats (which are from the 1990s and are based on ASN.1)
> +  often has vulnerabilities as a result of their complexity.  This
> +  complexity is not inherent to the cryptography itself.
> +
> +  fs-verity users who do not need advanced features of X.509 and
> +  PKCS#7 should strongly consider using simpler formats, such as plain
> +  Ed25519 keys and signatures, and verifying signatures in userspace.
> +
> +  fs-verity users who choose to use X.509 and PKCS#7 anyway should
> +  still consider that verifying those signatures in userspace is more
> +  flexible (for other reasons mentioned earlier in this document) and
> +  eliminates the need to enable CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> +  and its associated increase in kernel attack surface.  In some cases
> +  it can even be necessary, since advanced X.509 and PKCS#7 features
> +  do not always work as intended with the kernel.  For example, the
> +  kernel does not check X.509 certificate validity times.
> +
> +  Note: IMA appraisal, which supports fs-verity, does not use PKCS#7
> +  for its signatures, so it partially avoids the issues discussed
> +  here.  IMA appraisal does use X.509.

Thank you for the update, I find this new version much better as it is
clearly scoped for the specific case of fs-verity, hence:

Reviewed-by: Luca Boccassi <bluca@debian.org>
