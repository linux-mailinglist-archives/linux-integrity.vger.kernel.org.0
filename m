Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73346519767
	for <lists+linux-integrity@lfdr.de>; Wed,  4 May 2022 08:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbiEDGgk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 02:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbiEDGge (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 02:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8FA101CB
        for <linux-integrity@vger.kernel.org>; Tue,  3 May 2022 23:32:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A1E6110F
        for <linux-integrity@vger.kernel.org>; Wed,  4 May 2022 06:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39888C385A4;
        Wed,  4 May 2022 06:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651645975;
        bh=Id7/5kGXadjcY2sbsRNoi1JRh8XPAUHQC5NwktD4BEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEhOLh6+VYoMSbDei2kcqzhgSql8UuCz59Bw75JwlzgaVTudamzuejh6bH+idAZ5j
         dBT+tRgYYMeyxDZ0pvqaSuYUEPU1xyKsD8h5RwFHIwzeAAUaabjA/sHQlQ7WUinSjw
         e+VV4tddl8XQmTwqqRpQ2AL20GTDmQA782wtKjzsKYJRcKsZm7yAYm1l7JTP/U62Z4
         7ta7KelQwgYfvnvFoYbxtA/EMTkc7olwlsEIGL0caBigi8CRgVL+fjn5rncPrWw7T+
         a6c2lKcVsh+NcRhWY4EdqA81Q7dXnTfXAHfxHUGNYpl9YDBGbHj4Zrha0PSYWgS8Y1
         3S1BOPxdK0mMg==
Date:   Wed, 4 May 2022 09:31:30 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
        jgg@ziepe.ca, James.Bottomley@hansenpartnership.com
Subject: Re: Dell XPS 13 9310 2-in-1: tpm tpm0: invalid TPM_STS.x 0xff,
 dumping stack for forensics
Message-ID: <YnIdwmLR4qtJUbS3@kernel.org>
References: <a1d39c04-d0a4-4b0b-5e39-5330e79d5fc0@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1d39c04-d0a4-4b0b-5e39-5330e79d5fc0@molgen.mpg.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 28, 2022 at 05:35:37PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a Dell XPS 13 9310 2-in-1, Linux 5.17.3 on Debian sid/unstable logs the
> trace below:
> 
> ```
> [    0.000000] Linux version 5.17.0-1-amd64 (debian-kernel@lists.debian.org)
> (gcc-11 (Debian 11.2.0-20) 11.2.0, GNU ld (GNU Binutils for Debian) 2.38) #1
> SMP PREEMPT Debian 5.17.3-1 (2022-04-18)
> […]
> [    0.000000] DMI: Dell Inc. XPS 13 9310 2-in-1/02P55J, BIOS 2.7.0
> 12/11/2021
> […]
> [171059.677004] tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for
> forensics
> [171059.677012] CPU: 5 PID: 38885 Comm: kworker/5:0 Not tainted
> 5.17.0-1-amd64 #1  Debian 5.17.3-1
> [171059.677014] Hardware name: Dell Inc. XPS 13 9310 2-in-1/02P55J, BIOS
> 2.7.0 12/11/2021
> [171059.677016] Workqueue: tpm_dev_wq tpm_dev_async_work
> [171059.677022] Call Trace:
> [171059.677025]  <TASK>
> [171059.677028]  dump_stack_lvl+0x48/0x5e
> [171059.677032]  tpm_tis_status.cold+0x19/0x20
> [171059.677035]  tpm_tis_send_data+0x3f/0x250
> [171059.677037]  tpm_tis_send_main+0x2e/0xf0
> [171059.677039]  tpm_transmit+0xd3/0x3e0
> [171059.677041]  tpm_dev_transmit.constprop.0+0x67/0xc0
> [171059.677043]  ? tpm_try_get_ops+0x44/0x90

Weird, TPM gives 0xFF when locality is not set, and it is set according
to the log. Initially looks like faulty behaving TPM.

BR, Jarkko
