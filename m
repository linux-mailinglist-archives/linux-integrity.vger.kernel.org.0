Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECAE76A4D5
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Aug 2023 01:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGaX2h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Jul 2023 19:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGaX2f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Jul 2023 19:28:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5C3FB
        for <linux-integrity@vger.kernel.org>; Mon, 31 Jul 2023 16:28:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99357737980so791110166b.2
        for <linux-integrity@vger.kernel.org>; Mon, 31 Jul 2023 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690846112; x=1691450912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2GbKQbR8WQDKm/09hjFJLqAkFDHcK7ngIt0eeXc/7M4=;
        b=ZekSgBZkAavLHGGah0w31PCLHlAqS/S9ypHQf2oGzr6j+sNI2t9uQ/p9xkhUBiSnXM
         WgV/J3qKPl0g/CG0GqD/ITJtAYWXtykxHf6PJhd6gKD4vdcSQC0yFuOrPFUoIv2P1NXP
         wU7sML2VwwbarztWTEem8URdK5+0BOJKp7y0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690846112; x=1691450912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GbKQbR8WQDKm/09hjFJLqAkFDHcK7ngIt0eeXc/7M4=;
        b=XMcsjxsWMZo1rNlvth8W2tvKGqzfh6odvVaB9xXvIHl8o9Lae3Kndhf0N+wQ4KcDcW
         TbDLw7VlvQ8WYIY8b7d/Xz9qnEmiGZrwsjRiPCN7JFxG7kiZcsf9zpFNO8sIieN8s6Dl
         3TDFx8SVTAdJJ5AEDQVPi/8QiyTlC7G7BptQS5VDNX5HKU7Leud3gX2OLUF562/0oGJm
         4vtMPrv0eOl5Sa9X7dqSSOmlYvG9chtfR+fpRm76jJyd13jgr4NGQgLizImn8tuiDDfQ
         3YWu5usiB5jZWONsFfjBEXPNZbAaknwkK3+tQPdsTLyUAyk9pqnFYOQgpNIHLmBSk/6W
         f/Wg==
X-Gm-Message-State: ABy/qLZrsartZfCM7/K28VF3hM11kDNLrTyi7xhGfqqOqIbNSHWZoQZA
        l9gyXPWxDuKegB1qrtz6UhnWhw20q0WsHX7N2dqkhMw6
X-Google-Smtp-Source: APBJJlGKOixxtAPctwvB6FzZGDgFoc1I8WGXKVW+5kj++flrSt/nwAGdgwW/CPRppH4Vn8tag836rw==
X-Received: by 2002:a17:906:c1:b0:99b:eeae:23d0 with SMTP id 1-20020a17090600c100b0099beeae23d0mr856186eji.12.1690846111910;
        Mon, 31 Jul 2023 16:28:31 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709064d9100b0098e4aef0791sm6805845eju.66.2023.07.31.16.28.30
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 16:28:30 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-314417861b9so4265318f8f.0
        for <linux-integrity@vger.kernel.org>; Mon, 31 Jul 2023 16:28:30 -0700 (PDT)
X-Received: by 2002:adf:f9cf:0:b0:316:ff0e:81b6 with SMTP id
 w15-20020adff9cf000000b00316ff0e81b6mr941858wrr.32.1690846110462; Mon, 31 Jul
 2023 16:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14> <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki> <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com> <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
 <fd3cc87a-97ec-00ea-e480-f6597664c13a@amd.com>
In-Reply-To: <fd3cc87a-97ec-00ea-e480-f6597664c13a@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 16:28:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPvSJH=H9eHZbJQ+sxC-AVDvrgJ+M14fD3K5A+5s=zVA@mail.gmail.com>
Message-ID: <CAHk-=whPvSJH=H9eHZbJQ+sxC-AVDvrgJ+M14fD3K5A+5s=zVA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     linux@dominikbrodowski.net, Jarkko Sakkinen <jarkko@kernel.org>,
        Daniil Stas <daniil.stas@posteo.net>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 31 Jul 2023 at 14:57, Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> Are you thinking then to unregister the tpm hwrng "sometime" after boot?

No, I was more thinking that instead of registering it as a randomness
source, you'd just do a one-time

    tpm_get_random(..);
    add_hwgenerator_randomness(..);

and leave it at that.

Even if there is some stutter due to some crazy firmware
implementation for reading the random data, at boot time nobody will
notice it.

           Linus
