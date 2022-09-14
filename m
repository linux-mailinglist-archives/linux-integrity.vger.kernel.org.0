Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286085B8E7D
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 20:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiINSCF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 14:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiINSCD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 14:02:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B2286066;
        Wed, 14 Sep 2022 11:01:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 859D6B81C51;
        Wed, 14 Sep 2022 18:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AD3C433B5;
        Wed, 14 Sep 2022 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663178509;
        bh=IaRc+kbMjivZhNvmyVyVqhwHTTU7PnRXsB1LvpQ4Cww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XGPDFpbKDV3XAt7Vn879yC0fY/+0YrQaS4Cgsy3aHHL8qAb1c3izwYcG861CT8zWI
         VpUEAKanXJZVTW0d9yD6FyJBHizlErC20snhHBCuGuRWm7R2BDuBntpPWEUX6e8LoG
         uqVJydc7xlCJ5qFFAZSpv+1m4c/CBpUYYIa6krdzaJ5g6d5EGIhzO/iSwZ6KEBbUZV
         H8C8lIZg08UjzH9AGVuMz5oaFOGcOuIZSMYsVJ2mKhAooBXy0YwCXCmVz8sGOl7f2K
         Atj1uVj+PFkk0GTbzw0OPOSmOE1aE75oiLvlHL3ZDyySC1hx1EEpdjxLqCNo6dWm0c
         lRCXpbQlddZlQ==
Received: by mail-vs1-f53.google.com with SMTP id m66so16725496vsm.12;
        Wed, 14 Sep 2022 11:01:49 -0700 (PDT)
X-Gm-Message-State: ACgBeo1sxSAoBX1QjVBI10ojZ64vt1gwiwhU1fEHQhskFaf8bFwqE8Gx
        fFvH0VMiiprfvJgNB+0DHcBjKr2JX91gozJKWA==
X-Google-Smtp-Source: AA6agR4wk4fVXgojqfepqtmAKcZuFmARTsF1HTjrVBKEDbldUowx1Yjycvtlq2KIVEkqCjZHz854cskHl7lOJAOW+dU=
X-Received: by 2002:a67:c097:0:b0:390:d097:df91 with SMTP id
 x23-20020a67c097000000b00390d097df91mr11602815vsi.85.1663178508243; Wed, 14
 Sep 2022 11:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220901214610.768645-1-stefanb@linux.ibm.com> <ce08b0af-fb1b-0ade-61ac-f66e95d6eb6a@linux.ibm.com>
In-Reply-To: <ce08b0af-fb1b-0ade-61ac-f66e95d6eb6a@linux.ibm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 14 Sep 2022 13:01:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ+M6TP9kWXDAUqqh7wfPHkE8YfEU7j5HWqeGMhL=c6bg@mail.gmail.com>
Message-ID: <CAL_JsqJ+M6TP9kWXDAUqqh7wfPHkE8YfEU7j5HWqeGMhL=c6bg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec (ppc64)
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, nasastry@in.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 12, 2022 at 8:01 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>
> Hi Rob,
>
>    can you take this series in your tree?

IMO, it should be someone that cares about TPM, kexec, or powerpc.
Yes, there's code in drivers/of/, but that is purely to avoid
duplication of code across powerpc and arm64.

Rob
