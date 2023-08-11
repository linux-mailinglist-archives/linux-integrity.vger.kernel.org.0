Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE1778C36
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Aug 2023 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjHKKor (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Aug 2023 06:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHKKoo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Aug 2023 06:44:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF9E127;
        Fri, 11 Aug 2023 03:44:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe44955decso2139243e87.1;
        Fri, 11 Aug 2023 03:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691750681; x=1692355481;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/KHTf1iExmrDmR1L307QMJ8Ss20ebDX4ev01rwBTDq0=;
        b=YTSJ6caXyJUQG4faDg2n6Ln4Dtd/B9OnNexQk/mHIjhGdc5yA/SwXIEnQpeuyrWOzp
         OT+sTscgllDETksfT9MK0oAGif8QVqgAXcDKHYxHojzsRPpCqvNwKR9COq/OyG05mYo1
         ZnSS6bsFf3+UM+miacAwC8Ev5TBANHxVPipFcXSPzBhNzi/1P+Z1Oru3MY/gwa8L5g6F
         5d2CjKAzu2pha0kuHJh2If9Mm9yQlrP19X4ea45mrhP5SuDKJh6pV06CUEO9Ie12CPte
         v8B3mR7XQYo5fPoX06RXUwSFHzWtXNKWdIoHmLsLgM/w4wsEVps/PP3+FbWGJUbkvjve
         z1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691750681; x=1692355481;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KHTf1iExmrDmR1L307QMJ8Ss20ebDX4ev01rwBTDq0=;
        b=VOwBuHMSH1B+tyCc59Q2EabKabfpt5VBkGqXDFSIou96ZHQ0MMveyyTTtoOcimJzEB
         ZF/XUlZbOJgGhM4JoyeYHbxrC719nFoYvgvpi14PkVr0zwLxmlupARKWSs7lqIqxQPqO
         AzOxMgYEfsWaZs53zjHocRnIiIuYoboXFADQEhKJWdt2ngxVXi2fmk2y/OAgcVdZkqqu
         yALUmwxo3FEp8HwwBaLGN63peGsYFA1FKIT4GEjTrTm2yx+m7SBT+7A6jm23ALuGtQvR
         cGhKbTDAUx0iDFiDTmr7/+yTI/y17w8Q2ETMgiYk2xYfsST8mkqejfP0oJbeFFU6F+Eh
         n9bQ==
X-Gm-Message-State: AOJu0YySbWXVkQGJqNmfD8b567s24nwEwGLsHI9OOEGeikImQhLmthAa
        acSFVeqRyaqgr0bxMk8pTvc=
X-Google-Smtp-Source: AGHT+IFG0c7hEB4PsXcVn4DHs9+Fm7ucRIN8zARsyGXaMgVeVY7AswFWuFWIB0BOjnjOk941cuLoBQ==
X-Received: by 2002:a05:6512:33d2:b0:4fe:8ba8:66c2 with SMTP id d18-20020a05651233d200b004fe8ba866c2mr1995309lfg.18.1691750680752;
        Fri, 11 Aug 2023 03:44:40 -0700 (PDT)
Received: from [192.168.1.23] ([176.232.63.90])
        by smtp.gmail.com with ESMTPSA id f22-20020ac251b6000000b004edc72be17csm674986lfk.2.2023.08.11.03.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 03:44:40 -0700 (PDT)
Message-ID: <fed7ec9d048c26e9526ccd909132c51e8e3e78cc.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   Grundik <ggrundik@gmail.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Hesse <list@eworm.de>,
        linux-integrity@vger.kernel.org
Date:   Fri, 11 Aug 2023 13:44:37 +0300
In-Reply-To: <a588d1d3-12e0-b078-b6cc-b0a63c54ab37@leemhuis.info>
References: <20230710133836.4367-1-mail@eworm.de>
         <20230710142916.18162-1-mail@eworm.de>
         <20230710231315.4ef54679@leda.eworm.net>
         <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
         <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
         <0f272843a33a1706dbcbb2d84b02e3951ee60cbb.camel@kernel.org>
         <fdd5fd9ece045ebd1888672a75f157e64ade98fb.camel@gmail.com>
         <a588d1d3-12e0-b078-b6cc-b0a63c54ab37@leemhuis.info>
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

On Fri, 2023-08-11 at 10:18 +0200, Thorsten Leemhuis wrote:
> Jarkko & Lino, did you see this msg Grundik posted that about a week
> ago? It looks like there is still something wrong there that need
> attention. Or am I missing something?
>=20
> FWIW, two more users reported that they still see similar problems
> with
> recent 6.4.y kernels that contain the "tpm,tpm_tis: Disable
> interrupts
> after 1000 unhandled IRQs" patch. Both also with MSI laptops:
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217631#c18
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217631#c20
>=20
> No reply either afaics.

As I said before: it does not looks like blacklisting is a good
solution at all.

If there are general fix, then blacklisting only makes testing of that
fix more difficult. If general fix works, why blacklist? If it does not
work and its impossible to figure out why =E2=80=94 maybe there should be
kernel boot option to select between polling/irq instead of/in addition
to hard-coded blacklist.

Unfortunately, its very hard to test this fixes on my side: since TPM
is not a module, but compiled into kernel itself, it requires
recompiling a whole kernel, which is quite a task for a laptop. But I
will try my best, if needed.

