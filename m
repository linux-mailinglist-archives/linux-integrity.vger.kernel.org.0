Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE8474EF29
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 14:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGKMlP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 08:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjGKMlO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 08:41:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227C49E;
        Tue, 11 Jul 2023 05:41:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31297125334so4076277f8f.0;
        Tue, 11 Jul 2023 05:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689079268; x=1691671268;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t/3Y5eqgUDi7lnr0rk+hWsRfp5e3voV9c3ZLFxt0Inc=;
        b=c7ka5wjnDDt+Qsm1M0tCumBT7q4VnoBU/CsY5j79PwKYyD0g31Tl6Mw6I6UJ4OHtxd
         iEth1DprPLB6THVlX8GMLcacluvnaoJZlgq2l3wV1wdedTNDFSu8Af6HcG8fUoZvE+XH
         3rXacNuOt9HJjfUrtLANBu858uBEO/34h5m86Hz7AbooJwmXmPVSBkHN+YHVs3C3UmUL
         FiX3vG5S7pZt2YLf1kG0xFOPg6VyWjqs13KMoq0yxv72UncwUzSUe9tGTVbpC/G6ZAmK
         YJfNvTmC8s4neip6dkvdyCOZCB9LalDtIv+5un3TJZk/4A+DIDkn16i8QVB5o+3po71k
         /rNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689079268; x=1691671268;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/3Y5eqgUDi7lnr0rk+hWsRfp5e3voV9c3ZLFxt0Inc=;
        b=Z3zOo61LWPoTabph9+LFiiv4i4qDM8ACMA5mGl1SKKPLSdo+og115R2x7kyAwe+hr/
         uh7dDzB5ffPrpe5GmeCstRm5eg+W8n5T49pJh2Cl2+lu5TA29bgTK0oQPow3YgaMS7Oo
         GA/hxC5XNVCFpHsMvSgfEIaleTVVL7ptcUOeLfmh/gNlNu9WY/t1/129zL/ymFCVrzg0
         BuUxTIOdF40yAfIhLfs8DqOWCRaE5qBUlH0BCX7Ghzb0EjiAQU4o2S/KFp3bCcFSOijg
         pkz90NTRdpdrZthNRPVg7+FWbgZY/k84eOWiPfX1+rjUW0jN9G3EVczlvh3YhDb3wSn0
         FykA==
X-Gm-Message-State: ABy/qLaIlFwM3odPp3Wey2+d1O/FjqrwYyk0FUNSCSwR9Dfg4VzP5lnX
        eOc7ZVOgPKF301GLVuWQw0A=
X-Google-Smtp-Source: APBJJlEi3QmwW3hwZSARaZwsURkuc1YZVSe0WBhWz6AyB6fPXT8oNYBGxh7NbHB6m6Pf32AJadzU2w==
X-Received: by 2002:adf:ef89:0:b0:314:140a:e629 with SMTP id d9-20020adfef89000000b00314140ae629mr17326624wro.7.1689079268381;
        Tue, 11 Jul 2023 05:41:08 -0700 (PDT)
Received: from [192.168.1.23] ([176.232.61.170])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d5510000000b0031417b0d338sm2167257wrv.87.2023.07.11.05.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:41:07 -0700 (PDT)
Message-ID: <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   Grundik <ggrundik@gmail.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Christian Hesse <list@eworm.de>,
        linux-integrity@vger.kernel.org
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jul 2023 15:41:05 +0300
In-Reply-To: <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
References: <20230710133836.4367-1-mail@eworm.de>
         <20230710142916.18162-1-mail@eworm.de>
         <20230710231315.4ef54679@leda.eworm.net>
         <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-07-11 at 00:29 +0300, Jarkko Sakkinen wrote:
> On Mon, 2023-07-10 at 23:13 +0200, Christian Hesse wrote:
>=20
>=20
> OK, this good to hear! I've been late with my pull request (past rc1)
> because of kind of conflicting timing with Finnish holiday season and
> relocating my home office.
>=20
> I'll replace v2 patches with v3 and send the PR for rc2 after that.
> So unluck turned into luck this time :-)
>=20
> Thank you for spotting this!

I want to say: this issue is NOT limited to Framework laptops.

For example this MSI gen12 i5-1240P laptop also suffers from same
problem:
        Manufacturer: Micro-Star International Co., Ltd.
        Product Name: Summit E13FlipEvo A12MT
        Version: REV:1.0
        SKU Number: 13P3.1
        Family: Summit

So, probably just blacklisting affected models is not the best
solution...

