Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D69274D89F
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 16:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjGJOK0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 10:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGJOK0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 10:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70E4DF;
        Mon, 10 Jul 2023 07:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A49461010;
        Mon, 10 Jul 2023 14:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D60AC433C7;
        Mon, 10 Jul 2023 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688998223;
        bh=CRGVL8YXgdtdfFq1hb0TSQUyjQAFF43yJebdRQR8W6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8vzNM03DlcvkiKiyHqsfg4J14YwDx18DOdZ7hhY0VfumaAOKdNSQZSffoPA+ps7v
         qvFyj3pZtodHrLdndW24rSCTL+oW2UOCqk4Fle4b5tEQB22VHlWFXPfPj0KQl572iR
         QrU1x7nkxFRbmP38/Wzp0vaQFuWLzOqm2fVFRxxE=
Date:   Mon, 10 Jul 2023 16:10:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Hesse <mail@eworm.de>
Cc:     linux-integrity@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>, stable@vger.kernel.org,
        roubro1991@gmail.com
Subject: Re: [PATCH 1/2] tpm/tpm_tis: Disable interrupts for Framework Laptop
 Intel 12th gen
Message-ID: <2023071032-eliminate-outsmart-c32d@gregkh>
References: <c0ee4b7c-9d63-0bb3-c677-2be045deda43@leemhuis.info>
 <20230710133836.4367-1-mail@eworm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710133836.4367-1-mail@eworm.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 10, 2023 at 03:38:35PM +0200, Christian Hesse wrote:
> This device suffer an irq storm, so add it in tpm_tis_dmi_table to
> force polling.
> 
> https://bugs.archlinux.org/user/38129
> https://bugzilla.kernel.org/show_bug.cgi?id=217631

Add "Link:" tags?

> 
> Fixes: e644b2f498d297a928efcb7ff6f900c27f8b788e

As per the kernel documentation, this should be:

Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")

otherwise you're going to get some emails from the linux-next bot.

thanks,

greg k-h
