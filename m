Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6516063BE
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Oct 2022 17:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJTPCW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Oct 2022 11:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJTPCV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Oct 2022 11:02:21 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAF2189822
        for <linux-integrity@vger.kernel.org>; Thu, 20 Oct 2022 08:02:19 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i127so14190201ybc.11
        for <linux-integrity@vger.kernel.org>; Thu, 20 Oct 2022 08:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rcTa90JUvI4y1R1ZthoT1dW/zruRGzn7zHD3hFfi0sE=;
        b=yT3oVQvzp8PnMy6ag8eQKBvl2KmH0clKcs7VbSS2Mv8938UtG+IpN5Mle2//gTp7Jn
         qgXnvFxXaeMdThibjBKAPwq8dXIuNscyoFUuHAoLOr3HVHXpVu4gsY3nxayn2RKgwP+T
         HfAmrE+8Z9hnkpo6QyAaDz6fhMhVcOVhB38hUh2tSe0wKzcztxmEmLiuoNQP/qqRG3kN
         5pZgZ5q/cD8IS0ZWUohRen1iFFTZSgyvsJtPReWEpPY7tMnZdCwOVVka/nkXo7tpumaD
         eL9tLIlCzPdGjnF6J/Si9kUy63KKktuuV+1DQAgpllpdY5TOSV1mRjN0P6CMrpm1diro
         m42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcTa90JUvI4y1R1ZthoT1dW/zruRGzn7zHD3hFfi0sE=;
        b=X/GRd/YDrbFXDEBCkUKd/JrjZbLbmtYDzP1aPBFmPlKhkktep6OrD3v4kgIeO/HpGe
         rbgoelIqQ2bm2yK8H7g9uHhDGj8E064L1vQSbDi/C6MyH+OAHpkJzCBwNkHHMjme6rvd
         RlfzLqdC6hEGoaksgLXKOLVeCFclBLDAf8gmcJxWrxWGTWUhg6Fhhe5ae6CcC284HNN1
         6+WBvf5oOpKLSLe3KE7QKuLVNTczoord5MvWYnIyUQ97ASlRFqBd7rvPIFIGrg+0n09E
         ZR1g73bznr/qMIvug1fFdxX3u3OBW3V/4XA3rVrfp75W8oehsnoUnoIOXX/VIXGV2oR8
         0rHA==
X-Gm-Message-State: ACrzQf2TC25OcGlUUDWyNPrO1xbLmMbemdRltCSIbMOxbMoGTFro4+4F
        CZwFaj6qcGvk9VUY+VPJ22A/kQxw2rM/h4bTK+P/
X-Google-Smtp-Source: AMsMyM4t5COoCp7gwRsg3P0hucIliUrFLd4rMO4OysTa0+j6zK1+RGwX65OV/qpwJoo1U09CyOEQJfD1NiFUd5VuEHw=
X-Received: by 2002:a05:6902:724:b0:6c0:1784:b6c7 with SMTP id
 l4-20020a056902072400b006c01784b6c7mr11786995ybt.15.1666278138672; Thu, 20
 Oct 2022 08:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <Y1FTSIo+1x+4X0LS@archlinux>
In-Reply-To: <Y1FTSIo+1x+4X0LS@archlinux>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Oct 2022 11:02:07 -0400
Message-ID: <CAHC9VhS-RwQwg3o0+8n-UsqvhpR+WESOsFQ3T_ax1YWY51Eksw@mail.gmail.com>
Subject: Re: [PATCH] evm: Correct inode_init_security hooks behaviors
To:     Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Cc:     linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com, davem@davemloft.net,
        lucien.xin@gmail.com, vgoyal@redhat.com, omosnace@redhat.com,
        mortonm@chromium.org, nicolas.bouchinet@ssi.gouv.fr,
        mic@digikod.net, cgzones@googlemail.com,
        linux-security-module@vger.kernel.org, brauner@kernel.org,
        keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 20, 2022 at 9:55 AM Nicolas Bouchinet
<nicolas.bouchinet@clip-os.org> wrote:
>
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>
> Fixes a NULL pointer dereference occuring in the
> `evm_protected_xattr_common` function of the EVM LSM. The bug is
> triggered if a `inode_init_security` hook returns 0 without initializing
> the given `struct xattr` fields (which is the case of BPF) and if no
> other LSM overrides thoses fields after. This also leads to memory
> leaks.

You'll have to forgive me, my connection is poor at the moment and my
time is limited, but why not simply add some additional checking at
the top of evm_inode_init_security()? The LSM hook already memset()'s
the passed lsm_attrs to zero so xattr::{name,value,value_len} should
all be zero/NULL.  Can you help me understand why that is not
possible?

Based on my current understanding, I believe this is something that
should be addressed at the IMA/EVM level and not necessairly at the
LSM layer.

> Adds a `call_int_hook_xattr` macro that fetches and feed the
> `new_xattrs` array with every called hook xattr values.
>
> Adds a `evm_init_hmacs` function which init the EVM hmac using every
> entry of the array contrary to `evm_init_hmac`.
>
> Fixes the `evm_inode_init_security` function to use `evm_init_hmacs`.
>
> The `MAX_LSM_EVM_XATTR` value has been raised to 5 which gives room for
> SMACK, SELinux, Apparmor, BPF and IMA/EVM security attributes.
>
> Changes the default return value of the `inode_init_security` hook
> definition to `-EOPNOTSUPP`.
>
> Changes the hook documentation to match the behavior of the LSMs using
> it (only xattr->value is initialised with kmalloc and thus is the only
> one that should be kfreed by the caller).
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  include/linux/lsm_hook_defs.h       |  2 +-
>  include/linux/lsm_hooks.h           |  4 ++--
>  security/integrity/evm/evm.h        |  2 ++
>  security/integrity/evm/evm_crypto.c | 23 ++++++++++++++++++++++-
>  security/integrity/evm/evm_main.c   | 11 ++++++-----
>  security/security.c                 | 29 ++++++++++++++++++++++++++---
>  6 files changed, 59 insertions(+), 12 deletions(-)

-- 
paul-moore.com
