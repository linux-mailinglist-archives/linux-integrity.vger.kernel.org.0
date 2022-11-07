Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DE961ED44
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 09:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiKGIpx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 03:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiKGIpx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 03:45:53 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F78AC62
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 00:45:52 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n191so8245266iod.13
        for <linux-integrity@vger.kernel.org>; Mon, 07 Nov 2022 00:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gO7KYbvGE1WDs0bJ/NlL4CWjmtLe+DbWd87Q0QV4CbM=;
        b=nw8qWU6jx+E56gYX6To9qBar529wr/bv0UyDm4wQ3dAtCX95AMLnU4WuXPj7YE47gV
         OsWkaAA7D7qcx1+tCM4xRor3YfuGtFh1PPDx2mZt4QeKBo/9VIyjVxM+jV3kscWrdN0F
         yx7MmIt9PjYMa2/x+etbsEjhoRfh6za/B+mhqB1wh2/ABpxWoFol3/proSZIL9/2heU0
         HdM+tkSTypefCWZRk5oW10CcUzMC2Dl7mgBlsUPIo909xISiMmMcb4wZoAf/FIGQudIQ
         qe76sqCNkqjt/rlrBE0gTJGOA4TfnjY3Y/UwzUeLL0AAeuJB4CsfOs+96py8iJNoxE0a
         jZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gO7KYbvGE1WDs0bJ/NlL4CWjmtLe+DbWd87Q0QV4CbM=;
        b=5VFNnhBkZgJw1NltlfFS9q9I32z6aMjQPiH7iYA5yyBXOaLaMVlseiuaglwc/twMcp
         FnXYlRsEzceB35zN3m+odZaCKk8q5GTr+Zp6My73FsuvmUwCQzEKSY6hMejdRf9LOLbI
         q1DZ5jxCdvwHrRMgLeh4wTNr7Zg6HQM+miPLH3EqHDLyr+YoOGajX9LM1fF/SN4+AH7Z
         STQXf7GANih0/eTlbiISfIfAxBSEWjO9RUtsjLASHliWv3N7SKbhcNqe5q0LevJkTFe7
         ncQepOl/h2neVzsmZhLhRYD1v+VzkdmeI8Hg1qMO4dy/E626ApFw6+0TprQmwA6mpNaB
         /FNw==
X-Gm-Message-State: ACrzQf0xjuUybWtRZxdUSiSsL2q7fHKhOZUFhO9/nbPrCRyfKJWeKM4I
        7D4XAx0qrjAnPWxabeF/p04Rji6iHVRvdSYa36Fj/dK2bY5avA==
X-Google-Smtp-Source: AMsMyM7Fn+4JPafX/16M/lJK3FFHzo5dS8bAQmz8825aHDJGmhQsm0q41+tL1zVZtwNPrJA91sRD1rAxchw9GqBsR/o=
X-Received: by 2002:a05:6602:164f:b0:6d4:8783:8019 with SMTP id
 y15-20020a056602164f00b006d487838019mr16400404iow.77.1667810751791; Mon, 07
 Nov 2022 00:45:51 -0800 (PST)
MIME-Version: 1.0
References: <20221103145450.1409273-1-jsd@semihalf.com> <20221103145450.1409273-2-jsd@semihalf.com>
 <Y2f/pExGdDBGhNZA@kernel.org>
In-Reply-To: <Y2f/pExGdDBGhNZA@kernel.org>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Mon, 7 Nov 2022 09:45:41 +0100
Message-ID: <CAOtMz3MRyTVHEmoiR95jUCtEM-JXNMVLzE08HiENPhdpWL2LVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] char: tpm: Protect tpm_pm_suspend with locks
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

niedz., 6 lis 2022 o 20:49 Jarkko Sakkinen <jarkko@kernel.org> napisa=C5=82=
(a):
>
> On Thu, Nov 03, 2022 at 03:54:48PM +0100, Jan Dabros wrote:
> > Currently tpm transactions are executed unconditionally in
> > tpm_pm_suspend() function, what may lead to races with other tpm
> > accessors in the system.
> >
> > Add proper locking mechanisms by calling tpm_try_get_ops() which is a
> > wrapper on tpm_chip_start().
> >
> > Signed-off-by: Jan Dabros <jsd@semihalf.com>
>
> AFAIK processes are freezed before suspend callbacks are called, and
> the callbacks are called sequentially. I have no idea what is meant
> by "TPM accessor" here.

User space processes are freezed before suspend, but kernel threads
are not freezable by default. In my particular case it was a hwrng
thread started from drivers/char/hw_random/core.c - I was referring to
it as "TPM accessor". For sure I should be more precise in a commit
msg.

> Please describe the concurrency scenario in the commit message where the
> race could happen, if it is hard to reproduce, and add an appropriate fix=
es
> tag.

I will describe my scenario in more detail in the next version.
Regarding the "fixes" tag - I'm not too familiar with it, but looking
at the kernel submission guide, "fixes" should be used either when
there was a particular commit in the past which introduced the bug or
if a patch fixes an already logged bug entry (so that one can paste
URL). In my case both are not applicable, so please advise what
exactly I should put after this tag?

Best Regards,
Jan
