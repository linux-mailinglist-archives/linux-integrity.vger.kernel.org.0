Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CAB616FC1
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Nov 2022 22:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKBV31 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Nov 2022 17:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKBV24 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Nov 2022 17:28:56 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210C3FAC8
        for <linux-integrity@vger.kernel.org>; Wed,  2 Nov 2022 14:28:48 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q142so10087082iod.5
        for <linux-integrity@vger.kernel.org>; Wed, 02 Nov 2022 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kk3ON7oKr0DXltTERjD9VAgx2qz3ErmvVhiYuoaolyQ=;
        b=PhgjGvYqiwBfLKR8oPqOmlg6HR8v2LlpUNDzQAGWms9ldh4YERTv6qxczRJHANaRFz
         xMcyjVVybEqGWzyKVmsjX3mkcNqjhDUDm4AEg1wgKUQ020FZkXxlCF2JiYs+heJYQhoO
         vdOy11oE0hlFsVZzgWsHTAAmRO3Q0hQlHi2gRNFuSo2ia6wQ9aDMtuW4FdCsNO6xTpN6
         nyIjOrpkeCWZzYVJXVU1tSUksGodJSjn1Y/eM/1iAw8F1YXjipJVGHXUrPSU8558wgyD
         xZwFBrmzZC6vQc9kXTytB1BAK5ZBNsTURYkx49BymV4cXM8mSN47eEPHRcmf/PU6t5J6
         T2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kk3ON7oKr0DXltTERjD9VAgx2qz3ErmvVhiYuoaolyQ=;
        b=2PzFuareWfikrG/nAW8UakJ7qLRoUeqql2ptcyqERyR8sGi9kDquAb4xF6yQtb50+c
         sysZeCbqscjA9K5wKARXQf/GOX5scuTcOxH0DEluXe38XmokSK64/zaq8jUQKGUWF4Pk
         QJot+hGhKBlb8w+b4OMmx1RbmeJVpQJfDCBTWPSIUjIWQkaW/Wx7rIqk8oAytxyZCf+w
         L2gdWx0Z7tbj1fn7abZvBTe67r+5QoE4Oh53+cPp3akJoquxsC+iKGzSH4+uuJbEpxpD
         iDq/T4L15eDtI2gB3e5a8o0/qHVnpbFwClvY+dHLaouN2H4CJCwMt/2rL8rEtg/sTEOk
         EOTg==
X-Gm-Message-State: ACrzQf3YWHwDYBX1inYm0jtqEUNx0MrETD9zUYqPHAPhLXZifpQuZsp6
        Utgmb2BhePrPT2dVZdZKpfgS9SCZJlDHAvt7DuJ4lQ==
X-Google-Smtp-Source: AMsMyM4jo/DAl57yWFnALlR5PuSXqUFwc8/8gpmgyvIc9QAxViA2Zertx2CdnMGDbzAt1oOyhg/l+YnEMY1bM+DpuN4=
X-Received: by 2002:a05:6638:1187:b0:375:2e5a:71ef with SMTP id
 f7-20020a056638118700b003752e5a71efmr17128628jas.121.1667424527533; Wed, 02
 Nov 2022 14:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221101020352.939691-1-jsd@semihalf.com> <20221101020352.939691-2-jsd@semihalf.com>
 <CANkg5eyWqhReHJd7Bj5EEG5chz89M-PKCnak91qPRWZEzm3NRw@mail.gmail.com>
In-Reply-To: <CANkg5eyWqhReHJd7Bj5EEG5chz89M-PKCnak91qPRWZEzm3NRw@mail.gmail.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Wed, 2 Nov 2022 22:28:36 +0100
Message-ID: <CAOtMz3Od-r03EigmuEAG_q27bvifRS8ZV8YPOUHrayEW6YXO-Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] char: tpm: Protect tpm_pm_suspend with locks
To:     Tim Van Patten <timvp@google.com>
Cc:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de, rrangel@chromium.org, apronin@google.com,
        mw@semihalf.com, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> > -       if (!tpm_chip_start(chip)) {
> > +       rc = tpm_try_get_ops(chip);
> > +       if (!rc) {
> >                 if (chip->flags & TPM_CHIP_FLAG_TPM2)
> >                         tpm2_shutdown(chip, TPM2_SU_STATE);
> >                 else
> >                         rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
>
> This if-else block is still interacting with the TPM even though
> you're not guaranteed to have the lock, which could lead to
> racy/inchorent results. Would it be better to just bail out entirely
> since we can't safely attempt any recovery at this point. If it's
> still worth attempting the shutdown command, it would at least be good
> to add a comment admitting that we have no choice but to communicate
> with the TPM without a lock.

If tpm_try_get_ops() returns 0 it means that we have a lock. And if we
don't have a lock, then we are not executing any TPM commands. Are you
referring to tpm_mutex or something different?

Best Regards,
Jan
