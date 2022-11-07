Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2EF61EF86
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiKGJr4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 04:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiKGJr4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 04:47:56 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F2A17A82
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 01:47:55 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id d123so8352194iof.7
        for <linux-integrity@vger.kernel.org>; Mon, 07 Nov 2022 01:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MTuS5IqksW809wrmS6ToW9l0x4pdln/2ATfcNmIWQUI=;
        b=iCHjwr8Ijq5NSR6ct8gFJo26pCm3laOnIkhfWSgehG4yhXT3koIyVMJrgBcjig8/La
         u3LHeVABdNP2qR9J7tIwzd54HkwIeAMNmKzMAALam9iFa21cLKBf0oO4Os+siHn0EUSv
         wkZgoT31ey2d8DrTW0SslriLY6ieu1Ev52jFoQtlJUMrnrsU/JYtng0BEGf06F9n41ap
         KtrLmkfL7Cxzs0nDSVaUPbDCjQekT1j5OmHYsKbN5+a6+dQipUiaKJ/tWDmXMrFPjXlE
         JdxwJ+PhN8A0lc63DUR3mhaM01/wxT6vlhUqnvE4ASntPZ3Me2J9eyqYG1H8TwFNAxxT
         4uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTuS5IqksW809wrmS6ToW9l0x4pdln/2ATfcNmIWQUI=;
        b=OU27DuFhr1X8tUMks1193vvhaQDiDnbt47AvjQOARf9uV/U0p521ZMhv5YJAU18w9L
         ywzRNMQM1U0ntnm3qkpBK4+SdecLWD9Qz8CO0DsAGOzbesDzLR4CXypLkXCnROSg1RAw
         PzAK9v3PXiWGSwtlbD29ZCfzDQQZzDD1LrY5YL3Tq0d+RxgU2oheeyY/caWU3imABJMa
         yyo/z9EuUEQswC/mn6FkJJ48fPUyZzAuXbuxnUUsXR90Ar0YP2Onnd8C1810Bb4gSudn
         aaZkKlfM/Ou6nwyBE9RWOzzAsOcCsJu9HePhNWcsW5Y+PvBxvkDZHx+G1oEZkqpf29DF
         Hn1w==
X-Gm-Message-State: ACrzQf19qbTuoEaXvRgTlKTy0UZlGmVSm8h43Rhhl5/Bx8z+QhL/4+0w
        QFmRDCvl3OFuySo649iSBINvKz2b/u4X/ti0MHKtoA==
X-Google-Smtp-Source: AMsMyM7UkAzimBV9S6ZSJvkfNDfgCwwq6nx0w5jVbKivJ6gt1k8kqBIBoGzKpfLy6dbl9IQOULwWbfUi12f2BSnpdjY=
X-Received: by 2002:a05:6638:4118:b0:375:97af:c5a3 with SMTP id
 ay24-20020a056638411800b0037597afc5a3mr10855697jab.2.1667814474793; Mon, 07
 Nov 2022 01:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20221103145450.1409273-1-jsd@semihalf.com> <20221103145450.1409273-4-jsd@semihalf.com>
 <Y2jOXcsXCGyYtCR9@kernel.org>
In-Reply-To: <Y2jOXcsXCGyYtCR9@kernel.org>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Mon, 7 Nov 2022 10:47:44 +0100
Message-ID: <CAOtMz3PpurnM8je0o8zSHFEyUCeiyVeZfU1-=vsO6uB2+e0O8w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] char: tpm: cr50: Move i2c locking to
 request/relinquish locality ops
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Thu, Nov 03, 2022 at 03:54:50PM +0100, Jan Dabros wrote:
> > Move i2c locking primitives to request_locality and relinquish_locality
> > callbacks, what effectively blocks TPM bus for the whole duration of
> > logical TPM operation.
> >
> > With this in place, cr50-equipped TPM may be shared with external CPUs -
> > assuming that underneath i2c controller driver is aware of this setup
> > (see i2c-designware-amdpsp as an example).
>
> Nit: s/CPUs/peripherals/ ? I'm not sure why you want to emphasize external
> chips having CPU.

My point was that we can have a multi-controller setup and each
controller may work with the TPM chip, so let me s/CPUs/controllers/.

Best Regards,
Jan
