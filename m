Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5950574F1A9
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 16:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGKOTb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 10:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjGKOTa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 10:19:30 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64311709;
        Tue, 11 Jul 2023 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689085127;
        bh=e18NHVmYetnGq8YqkdNUELt5bY/GInm2niFBi9elCNI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HP04nBhBg1T7mrSzrnXH1M68xlu51VjuM+Nvr3qcxOkFXfDrin/JgsJHTz56YQA7N
         xzpVdTRFDdcoGXHABdFg6uhJC55xGdQvmBl65y/RUd1/rsWg42U1nHdVrEs28XhTdO
         KGr7CNt+NrKMBzeirjk4S+3lAUwP+Ra9PyBraugI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D18D912861B5;
        Tue, 11 Jul 2023 10:18:47 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id pWlZLUf5LftT; Tue, 11 Jul 2023 10:18:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689085127;
        bh=e18NHVmYetnGq8YqkdNUELt5bY/GInm2niFBi9elCNI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HP04nBhBg1T7mrSzrnXH1M68xlu51VjuM+Nvr3qcxOkFXfDrin/JgsJHTz56YQA7N
         xzpVdTRFDdcoGXHABdFg6uhJC55xGdQvmBl65y/RUd1/rsWg42U1nHdVrEs28XhTdO
         KGr7CNt+NrKMBzeirjk4S+3lAUwP+Ra9PyBraugI=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8203D1286195;
        Tue, 11 Jul 2023 10:18:46 -0400 (EDT)
Message-ID: <a8d0a627bbce5a82a874977fa4bcc3adf9d3aa2c.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Christian Hesse <mail@eworm.de>
Cc:     linux-integrity@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>, stable@vger.kernel.org,
        roubro1991@gmail.com
Date:   Tue, 11 Jul 2023 10:18:44 -0400
In-Reply-To: <ZKxHfTkgKHYqhBz2@ziepe.ca>
References: <20230710133836.4367-1-mail@eworm.de>
         <20230710142916.18162-1-mail@eworm.de> <ZKxHfTkgKHYqhBz2@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-07-10 at 15:01 -0300, Jason Gunthorpe wrote:
> On Mon, Jul 10, 2023 at 04:28:43PM +0200, Christian Hesse wrote:
> > This device suffer an irq storm, so add it in tpm_tis_dmi_table to
> > force polling.
> 
> I can't help but feel like we are doing something wrong in the Linux
> driver that we keep having IRQ problems.
> 
> Surely Windows uses the IRQ on these devices? How does it work
> reliably there?

I've had some friends in the MS Linux team ask around to find out if
anyone in the windows group is willing to divulge a little on this.  My
suspicion is that if interrupts are enabled at all on Windows TIS, it's
via a whitelist.

James

