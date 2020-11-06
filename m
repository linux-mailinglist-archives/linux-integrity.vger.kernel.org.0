Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036022A92D0
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Nov 2020 10:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgKFJdF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 04:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgKFJcy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 04:32:54 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1381AC0613D6
        for <linux-integrity@vger.kernel.org>; Fri,  6 Nov 2020 01:32:54 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 2so657084ljj.13
        for <linux-integrity@vger.kernel.org>; Fri, 06 Nov 2020 01:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0O2pgo+UmfykEgd2uLe7m+qSlQ1nNk7dEj4yrwl58uc=;
        b=PCF3l3Ux3vXSR5kq06buJzj4g2GvzwIdDnPfwEhAliNGMQHb2EJ8ea6CIuUPQqYO0l
         MH2/8fMTEw5ILQZPz6XCopiBtBYIfavA0rSo2PS/TtPvNoGLbYyg5+8M11pfBw+XRYo8
         zUwHn4AP/U596zU00e5leiBdAVOoqgMkc1BTnHl1/j5VFjIY8N+HPisMfLKA95pZRKVM
         xyqolq45WIaB2bOJ21n3+EBkkokbPdX9zHpsVFN64JB8Y5jfk9b8osgV4oyXljOQseTm
         h2+dW1o2oOgqTv1NjsyLLTEKA6nAd6KAW2L6LZUbJc6kPDgfKAIYXnlDsAJB5dHkh7tX
         GiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0O2pgo+UmfykEgd2uLe7m+qSlQ1nNk7dEj4yrwl58uc=;
        b=m6FJqFf3s3lM2k7sBOPw6koPGWDdMTZvFTZ+ylDAm71ojUKBJIO1V9haGHWAg28Fsn
         5HZ9vh1vv9JZyI4Se/oe/+GvMZjfuUu3o6Vp3IB+J2wrPi4gE4uZcJAY6oTAvee+BKC5
         Vfkb3tf0zFwfue8BGEnZXk5WUQEAxHmbvhxZt/vXnN4KDEgZ5TdM47jGaYuEV/Dj8u8a
         qPXefbs+Q5WYgYCzQvl0NbbTWMJ4jSOvxaSU+7he8o8G6Tz62FBzDIx5K+1Zo5GFyWop
         7MEsBgwdMuObCKr3vYetBJdHkh1z0xTBIvnwciMyad+3wu3RrQvBbUMeljK+VCcgODct
         mIfQ==
X-Gm-Message-State: AOAM531sjIk6M2c8hZ/DMjpOXOo21i5jAQVRAHkq2ecHcmmNsVsnPiPb
        fix9Du7qTIGkwq/Omj6f9vvjlcwxEoq/lsS3ULwFRA==
X-Google-Smtp-Source: ABdhPJyRRWazWWTTUshMunq0JJz7PYcu9OaGawq4/1rjyTHlsj7AVCjaucCm9rask/L4TdYyqxDT6p+HAgCzzJBgLhs=
X-Received: by 2002:a2e:9013:: with SMTP id h19mr405821ljg.4.1604655172333;
 Fri, 06 Nov 2020 01:32:52 -0800 (PST)
MIME-Version: 1.0
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org> <20201105050736.GA702944@kernel.org>
In-Reply-To: <20201105050736.GA702944@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 6 Nov 2020 15:02:41 +0530
Message-ID: <CAFA6WYPetvod-Wov2n_L5TL771j+-kt+_csyWYT-uM=haEKMZQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce TEE based Trusted Keys support
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 5 Nov 2020 at 10:37, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Nov 03, 2020 at 09:31:42PM +0530, Sumit Garg wrote:
> > Add support for TEE based trusted keys where TEE provides the functionality
> > to seal and unseal trusted keys using hardware unique key. Also, this is
> > an alternative in case platform doesn't possess a TPM device.
> >
> > This patch-set has been tested with OP-TEE based early TA which is already
> > merged in upstream [1].
>
> Is the new RPI400 computer a platform that can be used for testing
> patch sets like this? I've been looking for a while something ARM64
> based with similar convenience as Intel NUC's, and on the surface
> this new RPI product looks great for kernel testing purposes.

Here [1] is the list of supported versions of Raspberry Pi in OP-TEE.
The easiest approach would be to pick up a supported version or else
do an OP-TEE port for an unsupported one (which should involve minimal
effort).

[1] https://optee.readthedocs.io/en/latest/building/devices/rpi3.html#what-versions-of-raspberry-pi-will-work

-Sumit

>
> /Jarkko
>
> >
> > [1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37ee070d7e5b86b
> >
> > Changes in v8:
> > 1. Added static calls support instead of indirect calls.
> > 2. Documented trusted keys source module parameter.
> > 3. Refined patch #1 commit message discription.
> > 4. Addressed misc. comments on patch #2.
> > 5. Added myself as Trusted Keys co-maintainer instead.
> > 6. Rebased to latest tpmdd master.
> >
> > Changes in v7:
> > 1. Added a trusted.source module parameter in order to enforce user's
> >    choice in case a particular platform posses both TPM and TEE.
> > 2. Refine commit description for patch #1.
> >
> > Changes in v6:
> > 1. Revert back to dynamic detection of trust source.
> > 2. Drop author mention from trusted_core.c and trusted_tpm1.c files.
> > 3. Rebased to latest tpmdd/master.
> >
> > Changes in v5:
> > 1. Drop dynamic detection of trust source and use compile time flags
> >    instead.
> > 2. Rename trusted_common.c -> trusted_core.c.
> > 3. Rename callback: cleanup() -> exit().
> > 4. Drop "tk" acronym.
> > 5. Other misc. comments.
> > 6. Added review tags for patch #3 and #4.
> >
> > Changes in v4:
> > 1. Pushed independent TEE features separately:
> >   - Part of recent TEE PR: https://lkml.org/lkml/2020/5/4/1062
> > 2. Updated trusted-encrypted doc with TEE as a new trust source.
> > 3. Rebased onto latest tpmdd/master.
> >
> > Changes in v3:
> > 1. Update patch #2 to support registration of multiple kernel pages.
> > 2. Incoporate dependency patch #4 in this patch-set:
> >    https://patchwork.kernel.org/patch/11091435/
> >
> > Changes in v2:
> > 1. Add reviewed-by tags for patch #1 and #2.
> > 2. Incorporate comments from Jens for patch #3.
> > 3. Switch to use generic trusted keys framework.
> >
> > Sumit Garg (4):
> >   KEYS: trusted: Add generic trusted keys framework
> >   KEYS: trusted: Introduce TEE based Trusted Keys
> >   doc: trusted-encrypted: updates with TEE as a new trust source
> >   MAINTAINERS: Add myself as Trusted Keys co-maintainer
> >
> >  Documentation/admin-guide/kernel-parameters.txt   |  12 +
> >  Documentation/security/keys/trusted-encrypted.rst | 203 +++++++++++--
> >  MAINTAINERS                                       |   2 +
> >  include/keys/trusted-type.h                       |  47 +++
> >  include/keys/trusted_tee.h                        |  55 ++++
> >  include/keys/trusted_tpm.h                        |  17 +-
> >  security/keys/trusted-keys/Makefile               |   2 +
> >  security/keys/trusted-keys/trusted_core.c         | 354 ++++++++++++++++++++++
> >  security/keys/trusted-keys/trusted_tee.c          | 278 +++++++++++++++++
> >  security/keys/trusted-keys/trusted_tpm1.c         | 336 ++++----------------
> >  10 files changed, 979 insertions(+), 327 deletions(-)
> >  create mode 100644 include/keys/trusted_tee.h
> >  create mode 100644 security/keys/trusted-keys/trusted_core.c
> >  create mode 100644 security/keys/trusted-keys/trusted_tee.c
> >
> > --
> > 2.7.4
> >
> >
