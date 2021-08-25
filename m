Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824F03F7E4B
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 00:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhHYWVJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Aug 2021 18:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229922AbhHYWVH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Aug 2021 18:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02B18610A6;
        Wed, 25 Aug 2021 22:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629930021;
        bh=EdxC7NvY8PGaN7XBJ+O0ooR81Ip9IFKy1jLH2LAc2a4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HSWCPTZpOecKEQj33udn7+/MiCUCmJJ4vArZlzdD0OFISMlmoEKIadcXLjwruOf3Q
         rJJ1mDwCD1bjEus0XWuy2ZcKzi7cVNILUGU5RJeDa37XjcRy5PhKZMtQty6GQ+CJt0
         MrVMTDfrn7jlbRltQQZsczPdBnZjaPMsA3q/+SA5sW+18Bx23JFuvF4zRsOSKgeB3W
         AivmDLJdc/tMzNrWem85x8XVq+z4idRyeXFVSTxVGzxPlTD9OcxvxdnMru+pI45TaY
         s5d7Q9zLr11yu3HY+/mq2dHc9/dnBXg11IoWIFWbe4mEWvAZtolm14K+0t6sLYLMy2
         kksi+gd3oYkGw==
Message-ID: <c497b3055c49733a10a25e0356090d593874e2ea.camel@kernel.org>
Subject: Re: [PATCH] tpm: tis: Kconfig: Add helper dependency on COMPILE_TEST
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>, peterhuewe@gmx.de, jgg@ziepe.ca
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 26 Aug 2021 01:20:18 +0300
In-Reply-To: <20210825062617.2435-1-caihuoqing@baidu.com>
References: <20210825062617.2435-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-08-25 at 14:26 +0800, Cai Huoqing wrote:
> it's helpful for complie test in other platform(e.g.X86)

You need to write a proper long description, starting from that
sentences start with capital letter and end with a period.

What is "it"?


> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/char/tpm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index d6ba644f6b00..4a5516406c22 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -76,7 +76,7 @@ config TCG_TIS_SPI_CR50
> =20
>  config TCG_TIS_SYNQUACER
>  	tristate "TPM Interface Specification 1.2 Interface / TPM 2.0 FIFO Inte=
rface (MMIO - SynQuacer)"
> -	depends on ARCH_SYNQUACER
> +	depends on ARCH_SYNQUACER || COMPILE_TEST
>  	select TCG_TIS_CORE
>  	help
>  	  If you have a TPM security chip that is compliant with the

/Jarkko

