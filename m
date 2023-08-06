Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6A2771614
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Aug 2023 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjHFQa0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Aug 2023 12:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFQa0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Aug 2023 12:30:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD71F115;
        Sun,  6 Aug 2023 09:30:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5222bc916acso4722781a12.3;
        Sun, 06 Aug 2023 09:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691339423; x=1691944223;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4FzIGJB3RF9rAhmTZEhvxM+refdOYwtltFRNRcqfwUU=;
        b=MYpX1fWWRMg7736RNBD69cMPy67TLJxBxJnyk1gXkqaz6uXV19IgSd+K7dT8JWKhjw
         Zsuwa+dgW2zOu8HtICpnZDFBL+HRmcVHDYSxjA7RyVIwhPT59nOUa0LIlITuC+BlFfGd
         iRx3yLe4tPS3rpA4oM7pSGu7v+DvR2uV+dwsH4JAKDxQkyTodGC0JTcyZ8L5UQYFoGq2
         RBMTFh7RrZ9iLYqldgjb4YTNpH0V6aHysGSLF9WdhEqvnSEz2ba363CqDQBf9z1+brB/
         NUPmu/UkMvlvHgisnt+yZSItJdRZ57f7Zo4qaYd58PJyGiuXAs3AwJA7djJoAKFRwOtZ
         sbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691339423; x=1691944223;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4FzIGJB3RF9rAhmTZEhvxM+refdOYwtltFRNRcqfwUU=;
        b=MQJvLsn9EBEUImihmf0Qxoq5EjyAFuWa1pYS3wQvn1N3dZRV78qbcjqB3/Z+lINq1M
         WC5MUqyON2O42BrRtQiPQyasgNsdlVnmZex/nOIO8P9h+N/bLP08Vz6AUQ4rjJWYVqmA
         EM5QjOaFynfcdb3zzqtQUldOnDVdmDJEosMaxvgnCcyLSYgu3LRGsWO7OT1HjUxVdM7H
         U2TFvRNgd+Iq0InCuV0V8ksyD0+pHejdpqBSiTQahKgWzGFX2YVy8rRvQKKtnDO2O1C1
         TlHEMGxqvX16PKc1vtx29N3ynDSgdUAkEZincgGoEaoW4JziWBGcQ/cIMA58KQB/tlu0
         WRDA==
X-Gm-Message-State: AOJu0YwxB0wyBARw+IORIGfGi8KD1glBAlPVINBsXBTVuYlRK99xIWtc
        SDzrMGJGVe6aRhDw0Rsjubk=
X-Google-Smtp-Source: AGHT+IFBgcTomtBPCWj3ELlkRqpOeLLFbgNNd0voEnTkW6Tkl4KJgY/36xffVukkLB+Ou2WdyYy81Q==
X-Received: by 2002:a17:906:2d4:b0:99c:c15f:31b2 with SMTP id 20-20020a17090602d400b0099cc15f31b2mr3356297ejk.8.1691339422791;
        Sun, 06 Aug 2023 09:30:22 -0700 (PDT)
Received: from [192.168.1.23] ([176.232.63.90])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090668c700b0099315454e76sm4008742ejr.211.2023.08.06.09.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 09:30:22 -0700 (PDT)
Message-ID: <fdd5fd9ece045ebd1888672a75f157e64ade98fb.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   Grundik <ggrundik@gmail.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Christian Hesse <list@eworm.de>,
        linux-integrity@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 06 Aug 2023 19:30:19 +0300
In-Reply-To: <0f272843a33a1706dbcbb2d84b02e3951ee60cbb.camel@kernel.org>
References: <20230710133836.4367-1-mail@eworm.de>
         <20230710142916.18162-1-mail@eworm.de>
         <20230710231315.4ef54679@leda.eworm.net>
         <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
         <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
         <0f272843a33a1706dbcbb2d84b02e3951ee60cbb.camel@kernel.org>
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

On Wed, 2023-07-12 at 00:50 +0300, Jarkko Sakkinen wrote:
> > I want to say: this issue is NOT limited to Framework laptops.
> >=20
> > For example this MSI gen12 i5-1240P laptop also suffers from same
> > problem:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Manufacturer: Micro-Star Int=
ernational Co., Ltd.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Product Name: Summit E13Flip=
Evo A12MT
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Version: REV:1.0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SKU Number: 13P3.1
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Family: Summit
> >=20
> > So, probably just blacklisting affected models is not the best
> > solution...
>=20
> It will be supplemented with
>=20
> https://lore.kernel.org/linux-integrity/CTYXI8TL7C36.2SCWH82FAZWBO@suppil=
ovahvero/T/#me895f1920ca6983f791b58a6fa0c157161a33849
>=20
> Together they should fairly sustainable framework.
>=20

Unfortunately, they dont. Problem still occurs in debian 6.5-rc4
kernel, with forementioned laptop. According to sources, these patches
are applied in that kernel version.

What can I do to assist fixing it?..

