Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D31D64D9CB
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Dec 2022 11:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLOKzL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Dec 2022 05:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLOKzK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Dec 2022 05:55:10 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B79ADBE
        for <linux-integrity@vger.kernel.org>; Thu, 15 Dec 2022 02:55:10 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-142b72a728fso20430514fac.9
        for <linux-integrity@vger.kernel.org>; Thu, 15 Dec 2022 02:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9px8uuUvWN6UAOmU7FIp8gmc4rC/nF0UNn6m0f34hXU=;
        b=d9PaL4V6e9zl7erfFsEmxnOPq3gkQVSqZDvNOt/yXW2fYV3ourjktTSKJ/5SgbRPBP
         ZPpULxuM9c9Vt9aejvivHEeLJ375uxckaw0w2n9VKYpdV8QqHh+FebY1g0xAkzaq7jo1
         gk7YGQaLA/LB6AbvvE4EBt6+OppQPWBrlcZZRhHp4AuS30nzXbqtN4eHC9Bgzqs+7l3q
         zaOw3VaKZtwAjXJzalu+7iGVQZCG5PFdVUBENkohSmrGD3W4ZtHRXB6z/di71hGYG6Nq
         X7bMtjDv7IDqhnGK8yv/acAlRW5h2tSnwDRlQe2sxV25dkRrF7Yw7i3Kp1NxK9UQPnBe
         qz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9px8uuUvWN6UAOmU7FIp8gmc4rC/nF0UNn6m0f34hXU=;
        b=jD7FS16fshSSbbRlvR8Z+qXtZUY/l42P1+kEp8/iGpsVxYULA3T37sWe3CVT31/VIA
         1azE6X9B4BXWaXLJ9cGC2krptH8GOtL6GQaNgYvlnPRSwXr0S73XRHGs8QhehXEhY3se
         91vA1+iX4at+87dZ8SK030iYKqGwcD+gzmD6mw8dh1xxpQSpVfiVnP39i86Xek3Emam9
         fhW5nTbUu+YB5T00N1jOXDuXXIGjXfgK2hi3fi3t3zVPiOBGXXL06EfzuHAAonNQTI2S
         cmIIn1ALxeUC9riCEZk2u4RASvbxxERBPDDVnl+9IV6I08COVV6VNByIymUrvXmjt2Q8
         UVmQ==
X-Gm-Message-State: AFqh2kq9DVXb8Zsar4j9x0bZiAWlJ/b25c1Tv2S6DktswSfFc76EsSJm
        NxP2wcVLSvEb80qbpnr8stBgsuFFedrJ3J4G8i5miXJ7+pY=
X-Google-Smtp-Source: AMrXdXuNTxFjKcKlnrxyt2pF8z07D/AKXjTd7jB8pEOdLiRj1DkwBYAEdngeI2HKlDxeHvo9NMUKTl+vxQmH+biHzww=
X-Received: by 2002:a05:6870:3397:b0:144:ef27:1e8f with SMTP id
 w23-20020a056870339700b00144ef271e8fmr117584oae.257.1671101709448; Thu, 15
 Dec 2022 02:55:09 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Micha=C3=ABl_Musset?= <mickamusset@gmail.com>
Date:   Thu, 15 Dec 2022 11:54:58 +0100
Message-ID: <CAF+MRt=yraJgxyXtv==30_drA=wLi36RVBPwK_34WCzw=C_Z3A@mail.gmail.com>
Subject: IMA & tpm_unsealdata with PCR 10
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

I've enabled IMA , policy that are enabled, checked only binary file and module.

The problem is that the booting of systemd is not predictable, so
after each boot the PCR 10 is different.

Then I'm unable to use tpm_unsealdata at PCR 10 .

I would like to have your opinion on that. What is the point of PCR 10
if it's not the same at a certain moment on the linux boot.

I wanted to use PCR 10 to protect a key based on the hash of each
binary in my linux SD.

looks like this is not the correct way,

I've an idea to fix it :

sort -k 5 /sys/kernel/security/ima/ascii_runtime_measurements > somefile.txt
sha1sum somefile.txt
with this somefile.txt contain a hash that is always the same after each boot
