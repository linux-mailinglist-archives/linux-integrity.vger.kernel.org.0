Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1E779742
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Aug 2023 20:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHKSrN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Aug 2023 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHKSrN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Aug 2023 14:47:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEF630E6;
        Fri, 11 Aug 2023 11:47:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso20006235e9.2;
        Fri, 11 Aug 2023 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691779631; x=1692384431;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lxiy661bwby5aRoESXiqAzZ+scVqqbirnP6RZhCnFMM=;
        b=A7ILmlQA5bAiH10V7GlC8sTxKLx9opJQGSJL4IhDwDxykOuY/Xwk67uZzoN8yINKvL
         8b0JyhV9U1ExuK970841hQyGd9FsSkEI5XiTF+THXpZwJpzs+oOG+lTgXpwZtJMInL25
         dE+Y1qIrKLCG2/VGZNMXUWxWnEqEuXaOqpdwPGrdG/hlT09iWJ25oyo/FbIKBf3zVV0e
         Mve9jAMHREhI8RexUeM5LQrBUaj2nyuUoisi5YXP0HxSo6YfeN/zG3ef1HVRShRhOyAq
         owhy8i1hRoeWRQTXKk+25PDQS0RTihMyO0pZeVEe4qFALQjqvAMvIveboGH1BGWVk4Kl
         znSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691779631; x=1692384431;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lxiy661bwby5aRoESXiqAzZ+scVqqbirnP6RZhCnFMM=;
        b=DxegkZw7xv48vSTgjiSsRalCIqbYu3A1C3mavMUFv5V+ozSbV7VVPKoG7jgLY2VlzA
         s/dY4KoJPLfLnfq1iVdISNJb4yGcZ+cQ3zB2OMlqWB3VpCwU4W2lZTVITCqxrBU3uIeC
         GTLDMiskcvQbButQI6YJwsXICt46gQsBAMa/Tm+1QeG/OYr+s5ZX/mIsAz3bGWO6OQ+q
         21UVubjzecbXIbjTSq7GHvr1uSQY75k8E497JYQKErr8gjPbyXTgb/2ueWdXJdiGjL2d
         hqdnMoaEbp3QP6R/1gdB5h/Bw6yRJf/dTXNaUSlDu2Um8k16gEOBSpaK7lELxh6hcf+0
         IIOw==
X-Gm-Message-State: AOJu0YwsHMo5DZtqJTtkiQK/fgbFj7d/i67AtSj9BX39OEmwCwNPxktE
        v0dt5lUjD2cnfaZ3LSJFp3Y=
X-Google-Smtp-Source: AGHT+IH6iK08CJx3BF9fpDiBYtjrGSt7m8PU976946+kY85EA3t09QFl/CIA8khqPgbgmBL9w1BNUw==
X-Received: by 2002:a05:600c:2946:b0:3fe:1f2c:df2b with SMTP id n6-20020a05600c294600b003fe1f2cdf2bmr2410275wmd.11.1691779630782;
        Fri, 11 Aug 2023 11:47:10 -0700 (PDT)
Received: from [192.168.1.23] ([176.232.63.90])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5089000000b0031434c08bb7sm6236129wrt.105.2023.08.11.11.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 11:47:09 -0700 (PDT)
Message-ID: <5806ebf113d52c660e1c70e8a57cc047ab039aff.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   Grundik <ggrundik@gmail.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Hesse <list@eworm.de>,
        linux-integrity@vger.kernel.org
Date:   Fri, 11 Aug 2023 21:47:07 +0300
In-Reply-To: <CUPWEV9HSGHY.MLO0B4RRH4RR@suppilovahvero>
References: <20230710133836.4367-1-mail@eworm.de>
         <20230710142916.18162-1-mail@eworm.de>
         <20230710231315.4ef54679@leda.eworm.net>
         <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
         <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
         <0f272843a33a1706dbcbb2d84b02e3951ee60cbb.camel@kernel.org>
         <fdd5fd9ece045ebd1888672a75f157e64ade98fb.camel@gmail.com>
         <a588d1d3-12e0-b078-b6cc-b0a63c54ab37@leemhuis.info>
         <CUPW0XP1RFXI.162GZ78E46TBJ@suppilovahvero>
         <CUPWEV9HSGHY.MLO0B4RRH4RR@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-08-11 at 20:40 +0300, Jarkko Sakkinen wrote:
> On Fri Aug 11, 2023 at 8:22 PM EEST, Jarkko Sakkinen wrote:
> > On Fri Aug 11, 2023 at 11:18 AM EEST, Thorsten Leemhuis wrote:
> >=20
> >=20
> > I see two long-standing options:
> >=20
> > A. Move from deny list to allow list when considering using IRQs.
> > This
> > =C2=A0=C2=A0 can be supplemented with a kernel command-line parameter t=
o
> > enforce
> > =C2=A0=C2=A0 IRQs and ignore the allow list (and IRQ storm detection pr=
ovides
> > =C2=A0=C2=A0 additional measure in case you try to enforce)
> > B. Change deny list to match only vendors for the time being. This
> > can
> > =C2=A0=C2=A0 be supplemented with a allow list that is processed after =
the
> > deny
> > =C2=A0=C2=A0 list for models where IRQs are known to work.
[...]
>=20
> This is also super time consuming and takes the focus away from more
> important matters (like most likely the AMD rng fix would have gone
> smoother without these getting in the way all the time).

Main problem of any list is maintaining of them. So, I think there
should not be any black or white lists at all. Module should work with
reasonable default (polling is the one, which lived without problems
for years and years due to bug, as I understand), and probably a boot
option to force IRQ. Maybe module should warn user to try that option.

I don't know: is it even worth it to use IRQ, if it so problematic? Are
there any significant advantages of that? I understand, polling is a
resource consumer, but its just TPM, which is used mainly at the boot
time, is it worth it?

