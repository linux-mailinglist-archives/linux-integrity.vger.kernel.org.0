Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6B379D733
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Sep 2023 19:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbjILRHz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Sep 2023 13:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbjILRHy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Sep 2023 13:07:54 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F7E10F9
        for <linux-integrity@vger.kernel.org>; Tue, 12 Sep 2023 10:07:50 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-68faf930054so2666600b3a.0
        for <linux-integrity@vger.kernel.org>; Tue, 12 Sep 2023 10:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538470; x=1695143270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9tCnWlA9XrE1nFim4ctCI9ELCfqKkedS78A2cZgsAs=;
        b=RWK2VWBJ0Jj+BWvTEYsHyhRVssu8y6q1KFVx2rPYt4hA30MKizvrIrSqA9N5zSCwKP
         e9QJwlLUy/TIZAVQHWXUoFJMmVFADSmNsG0XaWoUXcBJEIajPy6/QGZYIpYIvhkAUn1v
         EaJXs33gcqWQ6n7E8ZFAearQC/y04maqrc/xxfSYwxKDho2UR+YW0+aOMNTpCbDhPNdy
         JaAt9VNI0Lp2HX5ILf6xnH+HuSAzDoLA08sY9TPoPXtatzG9pBRz1tsQ8mh6ZPMUW5pR
         4XkJd6voPxi5TGxmr7Y1a3heSokxplcqJCF9lmhQR5AfLGgL5XoUAPn8Xuapz250zHaJ
         XHbw==
X-Gm-Message-State: AOJu0Yzs4Hut7NpVK8OLw6kwLgsCZaGdI6uQ8PjS25y27kGzX/bnHpCD
        QB/PLIKTZA3HdV7rolonOLLBeOQIAN0QHuQPK+IkSrC1JRsmZNI6uZzWsaOK46KOlg==
X-Google-Smtp-Source: AGHT+IEX304k/En1unElz+dinA3pOm9BIfW/BeJRpXk+dmhwOWv24esWXOeFgonERRywb9hmuicVqc7Me333ZHXCx3Q=
X-Received: by 2002:a05:6a20:54a1:b0:155:2c91:f8e5 with SMTP id
 i33-20020a056a2054a100b001552c91f8e5mr25646pzk.14.1694538470311; Tue, 12 Sep
 2023 10:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230911223238.3495955-1-jforbes@fedoraproject.org> <CVGU920P4LEH.4WNZCAJI4URK@suppilovahvero>
In-Reply-To: <CVGU920P4LEH.4WNZCAJI4URK@suppilovahvero>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Tue, 12 Sep 2023 12:07:38 -0500
Message-ID: <CAFxkdAoSswhixvD6u0VLD=D9aaX-JFAdDewTF_WJmMwSbZDxeg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Fix typo in tpmrm class definition
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 12, 2023 at 4:41 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue Sep 12, 2023 at 1:32 AM EEST, Justin M. Forbes wrote:
> > Commit d2e8071bed0be ("tpm: make all 'class' structures const")
> > unfortunately had a typo for the name on tpmrm.
> >
> > Fixes: d2e8071bed0b ("tpm: make all 'class' structures const")
> > Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> > ---
> >  drivers/char/tpm/tpm-chip.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 23f6f2eda84c..42b1062e33cd 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -33,7 +33,7 @@ const struct class tpm_class = {
> >       .shutdown_pre = tpm_class_shutdown,
> >  };
> >  const struct class tpmrm_class = {
> > -     .name = "tmprm",
> > +     .name = "tpmrm",
> >  };
> >  dev_t tpm_devt;
> >
> > --
> > 2.41.0
>
> Unfortunately your patch does not apply:

Fixed with the V2 I just sent out. Seems I had suppress-blank-empty =
true in a config file somewhere. Apologies for wasting your time.

Justin

> $ git-tip
> 0bb80ecc33a8 (HEAD -> next, tag: v6.6-rc1, upstream/master, origin/next) Linux 6.6-rc1
>
> $ b4 am 20230911223238.3495955-1-jforbes@fedoraproject.org
> Analyzing 1 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   ✓ [PATCH] tpm: Fix typo in tpmrm class definition
>   ---
>   ✓ Signed: DKIM/linuxtx.org (From: jforbes@fedoraproject.org)
> ---
> Total patches: 1
> ---
>  Link: https://lore.kernel.org/r/20230911223238.3495955-1-jforbes@fedoraproject.org
>  Base: applies clean to current tree
>        git checkout -b 20230911_jforbes_fedoraproject_org HEAD
>        git am ./20230911_jforbes_tpm_fix_typo_in_tpmrm_class_definition.mbx
>
> $ git am -3 20230911_jforbes_tpm_fix_typo_in_tpmrm_class_definition.mbx
> Applying: tpm: Fix typo in tpmrm class definition
> error: corrupt patch at line 18
> error: could not build fake ancestor
> Patch failed at 0001 tpm: Fix typo in tpmrm class definition
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> BR, Jarkko
