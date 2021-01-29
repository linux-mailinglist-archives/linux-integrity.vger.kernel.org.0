Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABCD309090
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 00:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhA2XZ7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Jan 2021 18:25:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhA2XZ6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jan 2021 18:25:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9CCF64DDC;
        Fri, 29 Jan 2021 23:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611962717;
        bh=biXf3usoLvz/XI5DdROrIQTGXFjcCLjEeRhBwIclSc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQ/p+ZuRU9XWPZ2oVOyy/NElFLj3Me0Ta4IEPcb+uMnQ3WgTKEUtCeO5RtKXTfQu1
         e9SnNjP+D6e41pDG9Fzw/Lshd1Z9jRj2ESzibp2gx7cbNnTiIbPMdZrHcCFXZ9sC8K
         LHyh6UbvXznD75j4BSRF4SDXBipikK8G7n6/EWVYcNR1XKueqDbIOYHi1jckWLZOY8
         rBxnpgVJ4J4gO5S7WLaYVU8G2gPm6zOk6Z/wfFiFtY1apPj5nV4E98ZW7MAeppCaih
         9Da0SVKK4p3EhQ0L7Go05xxLBhd7R8pGjgzF82q0uB6B3T6Rk3PwwTJC0WVSriFCXg
         WCu4rzAvL8Q6A==
Date:   Sat, 30 Jan 2021 01:25:12 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "florian.manoel@siemens.com" <florian.manoel@siemens.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Fuchs, Andreas" <andreas.fuchs@sit.fraunhofer.de>,
        "Peter.Huewe@infineon.com" <Peter.Huewe@infineon.com>,
        "joshz@google.com" <joshz@google.com>
Subject: Re: TPM V2: kernel panic on linux reboot
Message-ID: <YBSZWPNUV2y09Yg0@kernel.org>
References: <VI1PR10MB2559EB47FE26FA85EB4B4D4484A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB2559EA5D0EC208129AA503F684A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
 <YASDd5pphvndrsm+@kernel.org>
 <AM0PR10MB25481FFED2CDFBEC5596098F84BB0@AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR10MB25481FFED2CDFBEC5596098F84BB0@AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 27, 2021 at 02:51:56PM +0000, florian.manoel@siemens.com wrote:
> Hi,
> 
> thanks for your support,
> an update on the kernel panic I am experiencing while trying to set up a TPM V2 on an ARM64 NXP LS1043a custom board :
> We updated the kernel from 4.19.144 to 4.19.165, no changes, the panic is still occurring.
> 
> I started to debug, and identify what I believe is the point where this kernel panic is triggered:
> '/drivers/char/tpm/tpm-interface.c'
> 
> "
> 	if (chip->ops->clk_enable != NULL)
> 		chip->ops->clk_enable(chip, true);
> "

BTW, that is quite stupid code from us. In all cases a direct call to
tpm_tis_clkrun_enable() would make a lot more sense. Anyway, this does
not explain the bug. This just hurts my eyes, that's all..

Anyway we, can disclose that function given the IS_ENABLED() check early
on:

static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
{
	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
	u32 clkrun_val;

	if (!IS_ENABLED(CONFIG_X86) || !is_bsw() ||
	    !data->ilb_base_addr)
		return;

I think a safe conclusion to make that chip->ops is NULL, and causes the
panic.

> It looks a lot like an issue that is described here with a TPM 1.2 :
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/01d1d6e2a1a74b9b8acba7d5eee67fe83e914aa1


I get:

"NOT_FOUND: Requested entity was not found"

Please try out with the mainline kernel. I only now spotted that you are
using a really old kernel. And I have no idea how patched the kernel is.

I misread last time that this happening with the mainline kernel. Debugging
downstream kernel is unfortunately out-of-scope.

When you have test data with the latest unpatched mainline kernel, it makes
sense to look this further.


/Jarkko
