Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9333C689B
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jul 2021 04:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhGMCnC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 22:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhGMCnB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 22:43:01 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66529C0613EE
        for <linux-integrity@vger.kernel.org>; Mon, 12 Jul 2021 19:40:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id dj21so11126318edb.0
        for <linux-integrity@vger.kernel.org>; Mon, 12 Jul 2021 19:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6SKPfn6xRnP6RvM1343nJURmtoEoYmDq0f1l/33/h84=;
        b=x7RRPQyv9jG3OzPccMOSnW3VrdK3C+C7wh57/h4YZqZTFnUPLVZIkbejJqFM1bGJXD
         hevjB4DEy9ElJW2GegUT1Xz2iGCm80zDMxIHFu6XRcIUtWY+iXCOVvT0Riyb19LtNK/X
         RALuOfemsmqkkECHX8UFntgZwQiBNizAreHhCk+nxQ9KufS/UsFKP4VvmFp4KT9issBw
         d3HYbjdCRd67BmavBuE9GJTUdo8fV2oYiXZC7dHoKcGKuGW1xjO37V29xWHAPtcL2ejB
         2C2bzm6u2g5vlaz5YJv05KqWddMghzzTRd6D0hlHY3+5n9BgfSBLXDolpjLtUY0GcJNu
         torw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SKPfn6xRnP6RvM1343nJURmtoEoYmDq0f1l/33/h84=;
        b=afUt8VQCN8VJsnUvoDFlM1hbemhYXw0+5KVHklOdJQ5snGubeTGwjujbI1qNtWMjkm
         QYxGMbTAgG2jQHp9Nybv+yNN9wSWADyH7Xdd0sxwtrl960rgFcxPF6yUU9r+VQrgDICo
         MBbLPzTQPle0YB85sAWxHU04dPMBAGpIjAUkAoWynwdE9YeKXXe7fL7jAXsmridU5aTm
         ABc5rgjztaSh9Go5r1rf0G+5OeOZTOAQ131HzjkCJrbYvYz1LwCfs2Yfg44IUm99VGfb
         Tgzw7d2o5IfBugIiyu7NT3yUC277XE0o8u8juxgXIzWFSAxPNCQaeXi39ULyiBr7aaqu
         iqww==
X-Gm-Message-State: AOAM532h5hj2KOPPRuPVn8WTNricOLxdFwS0iaFv6tY0gccO1VBlzi5U
        HppVZcQ1KgpSIEv0d9mhfBK8nNwtjr0SSIDyY7/O
X-Google-Smtp-Source: ABdhPJyZ/TPOOkCsJy185npELs8RkJjMh8prX3d/UtGFgQ0YS2+kXH0n7ovix3Q1wjS+ou3pLjc8wCtqxZLZR+mgDZA=
X-Received: by 2002:aa7:dd88:: with SMTP id g8mr2479547edv.196.1626144010862;
 Mon, 12 Jul 2021 19:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090922.3321178-1-roberto.sassu@huawei.com> <20210705090922.3321178-4-roberto.sassu@huawei.com>
In-Reply-To: <20210705090922.3321178-4-roberto.sassu@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Jul 2021 22:40:00 -0400
Message-ID: <CAHC9VhQAM+-TXOHLkcY2VGyJ3PNES0EaNr3PccHT=j3nGAvfPQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ima: Add digest and digest_len params to the
 functions to measure a buffer
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        prsriva02@gmail.com, tusharsu@linux.microsoft.com,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 5, 2021 at 5:09 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> This patch adds the 'digest' and 'digest_len' parameters to
> ima_measure_critical_data() and process_buffer_measurement(), so that
> callers can get the digest of the passed buffer.
>
> These functions calculate the digest even if there is no suitable rule in
> the IMA policy and, in this case, they simply return 1 before generating a
> new measurement entry.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/ima.h                          |  5 +--
>  security/integrity/ima/ima.h                 |  2 +-
>  security/integrity/ima/ima_appraise.c        |  2 +-
>  security/integrity/ima/ima_asymmetric_keys.c |  2 +-
>  security/integrity/ima/ima_init.c            |  3 +-
>  security/integrity/ima/ima_main.c            | 36 ++++++++++++++------
>  security/integrity/ima/ima_queue_keys.c      |  2 +-
>  security/selinux/ima.c                       |  6 ++--
>  8 files changed, 39 insertions(+), 19 deletions(-)

The SELinux changes are trivial and fall into that
cross-subsystem-ACK-not-really-necessary category, but why not :)

For the SELinux bits:
Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
