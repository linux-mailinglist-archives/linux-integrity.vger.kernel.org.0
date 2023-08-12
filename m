Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E46779FB5
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Aug 2023 13:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbjHLL2g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Aug 2023 07:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjHLL2e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Aug 2023 07:28:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915FA1997;
        Sat, 12 Aug 2023 04:28:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso24167645e9.3;
        Sat, 12 Aug 2023 04:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691839694; x=1692444494;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=70k139ecuFQpmPCRNgfFtrlYieqZo6GAcu4jEsA6JKA=;
        b=nXrB3COXiLAq2Q75l0l+IMRfQJq6CTo3uN8+OZcmxjFYaJGJayQ0z5ooFFswFlT4St
         S0HcKzXZMDlC/pbAEeDX7mVoacjSLURm8KWO5D2gvtIysZFPEjCBLw/9DaFCXy5dxuPc
         NYaxZq5gNzZwtf/qN1D9dgj21hJUYOXHL3jd5sVn8xI0lnCw+W+pJDIwGQGXltiH6bHJ
         7Rz8U0no5UjqLwpIFmc3RWKQjgbmA17yMYz59Mbj9uB3IjkcT1rXdV3qMn/ifnBQ/vQp
         oG8aRv2m3kZV+FepnIHpb/skBHlVO5LVozpshkHRYuQ3vk/cGlZuDCMAFq5c6a2kVMC8
         Ihjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691839694; x=1692444494;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70k139ecuFQpmPCRNgfFtrlYieqZo6GAcu4jEsA6JKA=;
        b=Th7jQD+bDi4r9BHXGnjn1Zc2OMk7uwbO2/Smhag3FPu3mbeHwxFTRgD3lAnC5ohTXg
         FH5XisPLrE2eHDw3Xnv9T6TrwfzST8AIM6HVaTNpCu9ToZvHrxtfhUiUPKzD2x7tAX2C
         QOwXsJ9hJOZR7yf3SSL6lVrFKmibCZUfy0ygP/9UbH1mDHBWIMSPHmDwjUOwBj1fPeC8
         i/Gk7eXnPD5e5iF55le3hwivY4i7GN4J+We99nHw0k1Y5DkR7izvbd5gbtiEAbg1pCQU
         EmO6nS0w7KO+krb/MY9prry+qAeuB1zZ6ck0u/Ywq7iq7+nSHUGar2wisruJ6tSuSipM
         rCuQ==
X-Gm-Message-State: AOJu0YzRc4zcqNz83GnHJRv9lOtQ0pyuRbDwqV/LcVadSE/CRCEimg+Q
        4pmojqLNHFDBBZ6USSNPYr0=
X-Google-Smtp-Source: AGHT+IHEPq1fiwSQ1ALm2QJMf/pdFBSIgoM0YqLd75gCv+KCwrLgEzhLyqL/R0cbXylP9xVbTN8cpA==
X-Received: by 2002:a05:600c:252:b0:3fe:111b:7fc4 with SMTP id 18-20020a05600c025200b003fe111b7fc4mr3430160wmj.21.1691839693879;
        Sat, 12 Aug 2023 04:28:13 -0700 (PDT)
Received: from [192.168.1.23] ([176.232.63.90])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b003fa95f328afsm10971998wmr.29.2023.08.12.04.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 04:28:13 -0700 (PDT)
Message-ID: <2c5abdca1e93894ff3ee41ab1da90a5f8e38657f.camel@gmail.com>
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
Date:   Sat, 12 Aug 2023 14:28:11 +0300
In-Reply-To: <CUPZF09RGD86.VQN9BOMEYZX5@suppilovahvero>
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
         <5806ebf113d52c660e1c70e8a57cc047ab039aff.camel@gmail.com>
         <CUPZF09RGD86.VQN9BOMEYZX5@suppilovahvero>
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

On Fri, 2023-08-11 at 23:01 +0300, Jarkko Sakkinen wrote:
>=20
>=20
> Thanks for sharing your opinion. I'll take the necessary steps.
>=20

I was thinking... Maybe I'm wrong, maybe I mistaking, but isnt this TPM
located inside of the CPU chip? So that issue is not specific to laptop
vendor or model, but its CPU-specific.

My MSI A12MT laptop has i5-1240P, Framework laptops mentioned in this
thread, also has i5-1240P CPU. Unfortunately there are no such
information about other affected models, but could it be just that CPU
line?

