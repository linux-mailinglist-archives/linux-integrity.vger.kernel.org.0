Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797616A88CD
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 20:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCBTBF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 14:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCBTBE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 14:01:04 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C00A2006F
        for <linux-integrity@vger.kernel.org>; Thu,  2 Mar 2023 11:01:01 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id ay18so97187pfb.2
        for <linux-integrity@vger.kernel.org>; Thu, 02 Mar 2023 11:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677783660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbKqTB1BWmST+UKS3o/pcnOIniBYA6/WBLEtc9haQn4=;
        b=f6CB0s+KV2OW0hRLDgrai9rYXWAdgEzOd1HKjzgncsSTbWytg8B0shiJ79cVHIi1vO
         NfrTj+lMOtmVES/SN5tUizQ34VKdLqix9CWELeH+KrTcEymXdzPIEexDiBaqMU7ww0GK
         sGzZ7mXcF5H5dCoMBQm44MSvQYc8W4Wy/Uzn9pe7oVpFrQ270ldOFxuD0OsCggJ0HBqc
         bMLhtiOMAAtD+EpZC0R6O8ttn+ahurnj9OFXO0sVBcvxvdJHFYhROyspmOHRH+P1DqMB
         PN1J3UoPaWpHoy6A49mEBkZV5JgSIJF6mSkQjZ9rqaOJmSJo8zGtxSMzri02uyU/YtOE
         ipwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677783660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbKqTB1BWmST+UKS3o/pcnOIniBYA6/WBLEtc9haQn4=;
        b=TcFNrWExYuZ010d1qrX2pK4LaHchSjz7kDiWQOPxOmLNXywvLF4wAsfGzZoG45nMdx
         8hWjK5klQa+P8sEIA0rGJ5t2nPwPZjOl4R8hUFmgp9tsECPktbytgGlciEFW7Nz8A3OG
         ZLWk4h8A53rbMk2fU7Tp8jV1+7ErH+tuWUTI+hpUkwSylX3hsW+vlf8kOZP1Y6ZsnH8n
         OfB3AAH4XSYJRib93GlH9HjdwwriWcBc35aBlQM1Av1Jefy3AAadw5aI/HU1N197Rv3a
         nJ+2cFwy8T78R4o2Cza0ahmPQ6DgBMxvSjNGpDvK4jIYTQ1PauVJdYIpRoru/52y+1wt
         HAWg==
X-Gm-Message-State: AO0yUKUJtHWWtW5tHnikDyk2EVUBAYxsGG7gVKoyPanJ4E2tydqk2zQx
        Hk14aYyyag6qVJmJV9LWWyzVHaJsrM4aSxjxMcki
X-Google-Smtp-Source: AK7set/JqphcjYj9seuvS6xKNvURMu+S3V/LEScKzhxHP7SqFb0AhXhOojS1vVfFsCMHm+0xdSDtgJ0BLFb+6ahFIIw=
X-Received: by 2002:a63:2953:0:b0:503:91ff:8dd8 with SMTP id
 bu19-20020a632953000000b0050391ff8dd8mr2858904pgb.4.1677783659129; Thu, 02
 Mar 2023 11:00:59 -0800 (PST)
MIME-Version: 1.0
References: <1675119451-23180-1-git-send-email-wufan@linux.microsoft.com> <1675119451-23180-2-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1675119451-23180-2-git-send-email-wufan@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Mar 2023 14:00:48 -0500
Message-ID: <CAHC9VhTtXC=HMUF8uak-29E__xLN2Kh_znn0xdRbm-GkgqBNiA@mail.gmail.com>
Subject: Re: [RFC PATCH v9 01/16] security: add ipe lsm
To:     Fan Wu <wufan@linux.microsoft.com>
Cc:     corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
        axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        eparis@redhat.com, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-audit@redhat.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 30, 2023 at 5:58=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> =
wrote:
>
> From: Deven Bowers <deven.desai@linux.microsoft.com>
>
> Integrity Policy Enforcement (IPE) is an LSM that provides an
> complimentary approach to Mandatory Access Control than existing LSMs
> today.
>
> Existing LSMs have centered around the concept of access to a resource
> should be controlled by the current user's credentials. IPE's approach,
> is that access to a resource should be controlled by the system's trust
> of a current resource.
>
> The basis of this approach is defining a global policy to specify which
> resource can be trusted.
>
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

...

> ---
>  MAINTAINERS           |  5 +++++
>  security/Kconfig      | 11 ++++++-----
>  security/Makefile     |  1 +
>  security/ipe/Kconfig  | 17 +++++++++++++++++
>  security/ipe/Makefile | 10 ++++++++++
>  security/ipe/ipe.c    | 40 ++++++++++++++++++++++++++++++++++++++++
>  security/ipe/ipe.h    | 13 +++++++++++++
>  7 files changed, 92 insertions(+), 5 deletions(-)
>  create mode 100644 security/ipe/Kconfig
>  create mode 100644 security/ipe/Makefile
>  create mode 100644 security/ipe/ipe.c
>  create mode 100644 security/ipe/ipe.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a5c25c20d00..5e27e84763cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10273,6 +10273,11 @@ T:     git git://git.kernel.org/pub/scm/linux/ke=
rnel/git/zohar/linux-integrity.git
>  F:     security/integrity/ima/
>  F:     security/integrity/
>
> +INTEGRITY POLICY ENFORCEMENT (IPE)
> +M:     Fan Wu <wufan@linux.microsoft.com>
> +S:     Supported
> +F:     security/ipe/

You should probably add a mailing list (L:) and source tree URL (T:)
to the IPE entry.  You can use the LSM mailing list to start if you
like, there are several LSMs that do that today, e.g. Smack, Landlock,
etc.  As far as the source tree is concerned, probably the easiest
option is a simple GitHub repo, but there are plenty of other choices
too.

Both the mailing list and the source URLs can always be updated in the
future so don't worry too much about being stuck with either long
term.

--
paul-moore.com
