Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4B73D18E
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jun 2023 16:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjFYOyE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 25 Jun 2023 10:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFYOyE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 25 Jun 2023 10:54:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B9D1A4;
        Sun, 25 Jun 2023 07:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 614BA60B42;
        Sun, 25 Jun 2023 14:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEC3C433C0;
        Sun, 25 Jun 2023 14:54:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WmH9DycT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1687704835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXHrakrWANJGXtSmv2LXWfIVLyVyzM/MWJ9MJLB4jFA=;
        b=WmH9DycTnbOnz5PFXFGNihIAxsJ9ufubvgMJ5GKS/0JS2uth5avKSoDYBqFhHvhMY0nEYe
        va4Nw6EYatoyErsBgqxEMqR/54Vq9NiL+hSDoH3Balg/Ww8uprdkI0OisyAThbtb7kbXQS
        HyxNOwlGIlGCo7NagSFvHGUDKjcKSFY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 28262728 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 25 Jun 2023 14:53:55 +0000 (UTC)
Date:   Sun, 25 Jun 2023 16:53:53 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: MSI B350M MORTAR: tpm tpm0: AMD fTPM version 0x3005700000004
 causes system stutter; hwrng disabled
Message-ID: <ZJhVAX6b6bcZtguo@zx2c4.com>
References: <8999a30b-e165-f39d-864a-ce1c559e725d@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8999a30b-e165-f39d-864a-ce1c559e725d@molgen.mpg.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jun 25, 2023 at 10:20:22AM +0200, Paul Menzel wrote:
> Thank you for your great work on the Linux kernel.
> 
> On an MSI MS-7A37/B350M MORTAR (MS-7A37) even updating to their latest 
> system firmware 1.O7 released on their Web site on May, 23rd 2023 [1].
> 
> > Beschreibung:
> > -  AGESA ComboAm4v2PI 1.2.0.A. update.
> > -  TPM Out of Bounds Access security patch.
> 
> But Linux 6.4.-rc7 still disables the hwrng from AMD fTPM.
> 
>      Jun 24 21:32:09.978772 tokeiihto kernel: DMI: Micro-Star 
> International Co., Ltd. MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.O7 05/09/2023
>      […]
>      Jun 24 21:32:10.259986 tokeiihto kernel:  tpm tpm0: AMD fTPM 
> version 0x3005700000004 causes system stutter; hwrng disabled
> 
> Unfortunately, the warning does not say, what firmware version is 
> needed, and what the user can do about it.
> 
> The comment in the code, added in v6.3-rc2 with commit f1324bbc4011 
> (tpm: disable hwrng for fTPM on some AMD designs) [2], says:
> 
>      /*
>       * Some AMD fTPM versions may cause stutter
>       * https://www.amd.com/en/support/kb/faq/pa-410
>       *
>       * Fixes are available in two series of fTPM firmware:
>       * 6.x.y.z series: 6.0.18.6 +
>       * 3.x.y.z series: 3.57.y.5 +
>       */
> 
> Mapping 0x3005700000004 from the Linux warning to the comment, I assume 
> the board’s firmware is 3.57.0.4?
> 
> What AGESA ComboAm4v2PI would MSI need to ship, so the issue is fixed? 
> The previous system firmware version shipped 3.4e.0.4? (Is it decimal or 
> hexadecimal?)

Sounds like this is a question for MSI - why they haven't updated from
3.57.y.4 to 3.57.y.5+. What can we possibly say about this from a
Linux perspective? The Linux code apparently is working as designed by
avoiding using the buggy firmware gracefully.
