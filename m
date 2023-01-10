Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFE0663785
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jan 2023 03:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjAJCvs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Jan 2023 21:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjAJCvr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Jan 2023 21:51:47 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA576D109
        for <linux-integrity@vger.kernel.org>; Mon,  9 Jan 2023 18:51:45 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s67so7275135pgs.3
        for <linux-integrity@vger.kernel.org>; Mon, 09 Jan 2023 18:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5meWItoTd251picJ9ZZoggNoMLVQJNPZDukwLx4P4Fo=;
        b=FTIN0qCwcdC0RFsTbszZsp8hpV0nAzklNuFi+W48h/6zQm7mVQnulh7P53TOwENCWK
         FJK4yzNhIuHCTb+yZ8V9Tb4LTk7dp7UdVjJ7HQTG/vdflFy+2gC05o27/lm6jU2OZcMI
         p67fOS8j4whKCWLdPjsmJRrwD+PPdy8TbpKtQ6TuzMT+rH+Wc/zvUIakCbJLCWHtCsnl
         IiGWmshq5Wq1R3UZc9sRWcieQiZp93pEIAqk5b9lNT5jOizUIrBhdRUCAGz8l8+i4z9b
         t/vJ5yuV0GmlNuQYSjYeJodBTrtPF8RnJESeI9ZCL6DjcgBwpQxT/z2rdsDstCzFwPda
         JeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5meWItoTd251picJ9ZZoggNoMLVQJNPZDukwLx4P4Fo=;
        b=u1FZ/YLPZsxgUPLiK3aYSydhR/WHup4SNaEFc95qA4Lu5vuMn06bD155rK/ioD+EJc
         +OSCwbq1oFrdFkF/VtgiabA7A9+/hZYXMaPc1e/oO9/pSTcYLdOau0sEdSU3qycB19TY
         9A/jW1UxMaW6wIk1umTAhWcWOoiKQJyYNC968bTmLVZSMD5tKuBu0kMy+y2hEEz4E/pm
         wL7jpOvBkSM1tgwSrnVtfiOyXy2hQvIc3zNaj5N7QPiDk4cIGKxssq3g9MUXvBXVCc6z
         JljE0eDcmxF96IsXSOvUMkX91nzxbQ+umzqMMjm2VPCiCoWh18sTPKZz6I0CVdn/Gu0V
         7GjA==
X-Gm-Message-State: AFqh2kpifHoAlyxVQ1KOz9F3tADumDNY6dgE8Vp2EbCZCwGxQpHMJV7q
        2k5aTxXOVdCccS/WNFNVKeEkvhmYRbGSfCXg2lnD
X-Google-Smtp-Source: AMrXdXuUZ5WLT6djW0CNkEpfzxyMHta7DZhjMwqsgvtHpwUDkM1FcUIKllbnolg0mFubdUk+JTKOseZRdKMR+5AFjok=
X-Received: by 2002:a63:e20b:0:b0:479:2109:506 with SMTP id
 q11-20020a63e20b000000b0047921090506mr3643575pgh.92.1673319105204; Mon, 09
 Jan 2023 18:51:45 -0800 (PST)
MIME-Version: 1.0
References: <20230106012106.21559-1-guozihua@huawei.com>
In-Reply-To: <20230106012106.21559-1-guozihua@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Jan 2023 21:51:34 -0500
Message-ID: <CAHC9VhR7JXB5KNGardhRA2422VLEUmWVx-AQVPCFANikdsUbEw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] ima: Fix IMA mishandling of LSM based rule during
To:     GUO Zihua <guozihua@huawei.com>
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        luhuaxin1@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 5, 2023 at 8:24 PM GUO Zihua <guozihua@huawei.com> wrote:
>
> Backports the following three patches to fix the issue of IMA mishandling
> LSM based rule during LSM policy update, causing a file to match an
> unexpected rule.
>
> v7:
>   Fixed the target for free in ima_lsm_copy_rule().
>
> v6:
>   Removed the redundent i in ima_free_rule().
>
> v5:
>   goes back to ima_lsm_free_rule() instead to avoid freeing
> rule->fsname.
>
> v4:
>   Make use of the exisiting ima_free_rule() instead of backported
> ima_lsm_free_rule(). Which resolves additional memory leak issues.
>
> v3:
>   Backport "LSM: switch to blocking policy update notifiers" as well, as
> the prerequsite of "ima: use the lsm policy update notifier".
>
> v2:
>   Re-adjust the bacported logic.
>
> GUO Zihua (1):
>   ima: Handle -ESTALE returned by ima_filter_rule_match()
>
> Janne Karhunen (2):
>   LSM: switch to blocking policy update notifiers
>   ima: use the lsm policy update notifier

I'll defer to Mimi for the IMA bits, but the LSM and SELinux related
bits looks fine to me and appear to be faithful backports of patches
already in Linus' tree.

>  drivers/infiniband/core/device.c    |   4 +-
>  include/linux/security.h            |  12 +--
>  security/integrity/ima/ima.h        |   2 +
>  security/integrity/ima/ima_main.c   |   8 ++
>  security/integrity/ima/ima_policy.c | 151 ++++++++++++++++++++++------
>  security/security.c                 |  23 +++--
>  security/selinux/hooks.c            |   2 +-
>  security/selinux/selinuxfs.c        |   2 +-
>  8 files changed, 155 insertions(+), 49 deletions(-)
>
> --
> 2.17.1

-- 
paul-moore.com
