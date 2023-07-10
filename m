Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E1B74D842
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGJN4N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjGJN4M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 09:56:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE88B103;
        Mon, 10 Jul 2023 06:56:10 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qIrN3-0006B0-8i; Mon, 10 Jul 2023 15:56:09 +0200
Message-ID: <8265a711-30cc-cc1f-b29e-2181f575cffd@leemhuis.info>
Date:   Mon, 10 Jul 2023 15:56:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] tpm/tpm_tis: Disable interrupts for Framework Laptop
 Intel 12th gen
Content-Language: en-US, de-DE
To:     Christian Hesse <mail@eworm.de>, linux-integrity@vger.kernel.org
Cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>, stable@vger.kernel.org,
        roubro1991@gmail.com
References: <c0ee4b7c-9d63-0bb3-c677-2be045deda43@leemhuis.info>
 <20230710133836.4367-1-mail@eworm.de>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230710133836.4367-1-mail@eworm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688997370;88e3f50e;
X-HE-SMSGID: 1qIrN3-0006B0-8i
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. I'm not a
proper reviewer for patches like this, but nevertheless two small things:

On 10.07.23 15:38, Christian Hesse wrote:
> This device suffer an irq storm, so add it in tpm_tis_dmi_table to
> force polling.

Thx for working on this!

> https://bugs.archlinux.org/user/38129

Not sure why this link might be helpful. Did you maybe mean to include
another one? Like this one?

https://community.frame.work/t/boot-and-shutdown-hangs-with-arch-linux-kernel-6-4-1-mainline-and-arch/33118

> https://bugzilla.kernel.org/show_bug.cgi?id=217631
>
> Fixes: e644b2f498d297a928efcb7ff6f900c27f8b788e

This should be:

Fixes: e644b2f498d ("tpm, tpm_tis: Enable interrupt test")

> Cc: stable@vger.kernel.org
> Reported-by:  <roubro1991@gmail.com>

The bugzilla link from above above should be here like this instead:

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217631

BTW, checkpatch.pl should have mentioned the two latter things.

HTH, Ciao, Thorsten

> Signed-off-by: Christian Hesse <mail@eworm.de>
> ---
>  drivers/char/tpm/tpm_tis.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 7db3593941ea..2979f8b9aaa0 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -114,6 +114,14 @@ static int tpm_tis_disable_irq(const struct dmi_system_id *d)
>  }
>  
>  static const struct dmi_system_id tpm_tis_dmi_table[] = {
> +	{
> +		.callback = tpm_tis_disable_irq,
> +		.ident = "Framework Laptop Intel 12th gen",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "A4"),
> +		},
> +	},
>  	{
>  		.callback = tpm_tis_disable_irq,
>  		.ident = "ThinkPad T490s",
