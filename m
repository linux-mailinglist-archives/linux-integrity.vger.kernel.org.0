Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA09779763
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Aug 2023 20:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjHKSzj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Aug 2023 14:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbjHKSzi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Aug 2023 14:55:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C86630F0
        for <linux-integrity@vger.kernel.org>; Fri, 11 Aug 2023 11:55:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so35237911fa.3
        for <linux-integrity@vger.kernel.org>; Fri, 11 Aug 2023 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691780135; x=1692384935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uuRnK69MU6Lcim2KwchdBtj06ixdIXcvFeb8SD9Pua0=;
        b=bevpvsPX4n5ismYz2JRzJu3RxtNmuz61zrOXwgrXa4rs6IMeUV8CWTvkBCunEuZUVD
         EaIyx4/QXJzEiuBJ9Has3ZXHwuiPuduUzPaVKbnpOeunmDsNMao0rE2+NVH98dkurQax
         je2nblq7WDYb8HO7/BgOlgz88FjsDBATEjxuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691780135; x=1692384935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuRnK69MU6Lcim2KwchdBtj06ixdIXcvFeb8SD9Pua0=;
        b=bnTmg2e22GTFsAA0MZowwnnG2dQmxJ3V1MBTCIyuCLMJadoMP1OuPi4RoGdfAIIH6w
         CHX1dHLXUC5apa0zdmi02JQ+QW+xMfPNRwBuLT0VYGH2+347K2bYc5m/1bLxWzvvGlXF
         hLIS3RGtWEpdeO9DEFn/HdaHoyd1+UMKLx3OtviSq95JNVJDHZzi9+CXdBLLnSBywjK5
         IofdFNJsDPIcPWc/hjFe61LgYNLm6VXzhY5ZQDZ9Bmfn12j1j7ug2UDHoTajzLM7tgeG
         OIUjM0ksip+bppZ8bLCzEt42z2HSyGXtE0pWnxpbXplUB2ZBsVjv51y4ch8yYRfTzE0Q
         DEHA==
X-Gm-Message-State: AOJu0Yy1PWBWzWmWUVWo852+Y67UZc4hFkwQ/O3tPhl9BwAt9MFh4fIg
        dEzFAV4d2+dpUMOV3gNzogIhaJuvcb6YwfRRTYt7hkmX
X-Google-Smtp-Source: AGHT+IFcJVysX0WwItb/lIpqiIXcxqbMpAXrmR91FSkcBbMO2pOvQbFWI55r+TtgEDSCR0o/JFKo2g==
X-Received: by 2002:a2e:a41a:0:b0:2b9:20fe:4bc4 with SMTP id p26-20020a2ea41a000000b002b920fe4bc4mr2179343ljn.40.1691780135373;
        Fri, 11 Aug 2023 11:55:35 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e910c000000b002b94327308asm973192ljg.133.2023.08.11.11.55.33
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 11:55:34 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so3702758e87.1
        for <linux-integrity@vger.kernel.org>; Fri, 11 Aug 2023 11:55:33 -0700 (PDT)
X-Received: by 2002:a05:6512:10cd:b0:4fd:fef8:7a81 with SMTP id
 k13-20020a05651210cd00b004fdfef87a81mr2309540lfg.55.1691780133463; Fri, 11
 Aug 2023 11:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230710133836.4367-1-mail@eworm.de> <20230710142916.18162-1-mail@eworm.de>
 <20230710231315.4ef54679@leda.eworm.net> <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
 <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
 <0f272843a33a1706dbcbb2d84b02e3951ee60cbb.camel@kernel.org>
 <fdd5fd9ece045ebd1888672a75f157e64ade98fb.camel@gmail.com>
 <a588d1d3-12e0-b078-b6cc-b0a63c54ab37@leemhuis.info> <CUPW0XP1RFXI.162GZ78E46TBJ@suppilovahvero>
In-Reply-To: <CUPW0XP1RFXI.162GZ78E46TBJ@suppilovahvero>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Aug 2023 11:55:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRVp4h8uWOX1YO+Y99+44u4s=XxMK4v00B6F1mOfqPLg@mail.gmail.com>
Message-ID: <CAHk-=whRVp4h8uWOX1YO+Y99+44u4s=XxMK4v00B6F1mOfqPLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com, Grundik <ggrundik@gmail.com>,
        Christian Hesse <list@eworm.de>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 11 Aug 2023 at 10:22, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> I was planning to send a PR to Linus with a quirk for MSI GS66 Stealth
> 11UG, and apparently this bug report would add two additional MSI
> entries. This is becoming quickly a maintenance hell.

Honestly, what would be the immediate effects of just not enabling the
TPM irq by default at all, and making it an explicit opt-in?

When a common solution is to just disable the TPM in the BIOS
entirely, and the end result is a working system, I really get the
teeling that this is all pain for very very little gain.

Would anybody even notice if we just disabled it by default and added
a "if you really want it, use 'tpm=irq' kernel command line"?

Hmm?

             Linus
