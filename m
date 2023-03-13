Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE46B6CC3
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Mar 2023 01:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjCMAQG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Mar 2023 20:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCMAQF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Mar 2023 20:16:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9CC37F2D;
        Sun, 12 Mar 2023 17:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=P/sel3BtUOQTvgaqpVzYhV2ah2rUR9TtQOcd7tdtyuI=; b=CnW5AWrX0qyjrZVlFC/txc9nfS
        Ec6869Tai/NmyyLx53gX3ofEDnAf2VSFOhlUSsACFRTEUv1fqy5LrAUyq29IiSfzOk0e3TJJZrado
        So9kZKBPYjz8xv+M5Qr9RT9mOi2Q1G7XsFJ4anV8DMC0o5JTW4keyOTwJjW5kinXEl25Ee666GPzk
        cVAhOeMjG/O6dD9UfSHKCbgrVBuHAg8IJx95w9Fgd1LVmhcDhed6enVkqHaZif9JWOaGlyt+lNhvn
        aWXCA2veyP0Npr1x7YJRKIYUTk13Ahjtwx+KmGKBNcfNQkoBZieeq6uiEHwBzGk5d0SX6aphBAb7D
        K3MO7VOw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbVr5-003s13-Dj; Mon, 13 Mar 2023 00:15:59 +0000
Message-ID: <4ebfb363-6552-d387-9912-47eb4acfd9f8@infradead.org>
Date:   Sun, 12 Mar 2023 17:15:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] IMA: allow/fix UML builds
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Rajiv Andrade <srajiv@linux.vnet.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
References: <20230224032703.7789-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230224032703.7789-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ping?

On 2/23/23 19:27, Randy Dunlap wrote:
> UML supports HAS_IOMEM since 0bbadafdc49d (um: allow disabling
> NO_IOMEM).
> 
> Current IMA build on UML fails on allmodconfig (with TCG_TPM=m):
> 
> ld: security/integrity/ima/ima_queue.o: in function `ima_add_template_entry':
> ima_queue.c:(.text+0x2d9): undefined reference to `tpm_pcr_extend'
> ld: security/integrity/ima/ima_init.o: in function `ima_init':
> ima_init.c:(.init.text+0x43f): undefined reference to `tpm_default_chip'
> ld: security/integrity/ima/ima_crypto.o: in function `ima_calc_boot_aggregate_tfm':
> ima_crypto.c:(.text+0x1044): undefined reference to `tpm_pcr_read'
> ld: ima_crypto.c:(.text+0x10d8): undefined reference to `tpm_pcr_read'
> 
> Modify the IMA Kconfig entry so that it selects TCG_TPM if HAS_IOMEM
> is set, regardless of the UML Kconfig setting.
> This updates TCG_TPM from =m to =y and fixes the linker errors.
> 
> Fixes: f4a0391dfa91 ("ima: fix Kconfig dependencies")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rajiv Andrade <srajiv@linux.vnet.ibm.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org
> ---
>  security/integrity/ima/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -8,7 +8,7 @@ config IMA
>  	select CRYPTO_HMAC
>  	select CRYPTO_SHA1
>  	select CRYPTO_HASH_INFO
> -	select TCG_TPM if HAS_IOMEM && !UML
> +	select TCG_TPM if HAS_IOMEM
>  	select TCG_TIS if TCG_TPM && X86
>  	select TCG_CRB if TCG_TPM && ACPI
>  	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES

-- 
~Randy
