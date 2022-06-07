Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9254853F5DA
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jun 2022 08:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiFGGG5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jun 2022 02:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiFGGGz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jun 2022 02:06:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37625FD36
        for <linux-integrity@vger.kernel.org>; Mon,  6 Jun 2022 23:06:54 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nySMU-0001nK-Lo; Tue, 07 Jun 2022 08:06:42 +0200
Message-ID: <64511312-df94-c40b-689c-5fc3823e91f5@pengutronix.de>
Date:   Tue, 7 Jun 2022 08:06:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next] evm: Use IS_ENABLED to initialize .enabled
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220606101042.89638-1-xiujianfeng@huawei.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220606101042.89638-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 06.06.22 12:10, Xiu Jianfeng wrote:
> Use IS_ENABLED(CONFIG_XXX) instead of #ifdef/#endif statements to
> initialize .enabled, minor simplicity improvement.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> ---
>  security/integrity/evm/evm_main.c | 52 ++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 29 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index cc88f02c7562..397fea5b3fa6 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -36,42 +36,36 @@ static const char * const integrity_status_msg[] = {
>  int evm_hmac_attrs;
>  
>  static struct xattr_list evm_config_default_xattrnames[] = {
> -	{.name = XATTR_NAME_SELINUX,
> -#ifdef CONFIG_SECURITY_SELINUX
> -	 .enabled = true
> -#endif
> +	{
> +	 .name = XATTR_NAME_SELINUX,
> +	 .enabled = IS_ENABLED(CONFIG_SECURITY_SELINUX)
>  	},
> -	{.name = XATTR_NAME_SMACK,
> -#ifdef CONFIG_SECURITY_SMACK
> -	 .enabled = true
> -#endif
> +	{
> +	 .name = XATTR_NAME_SMACK,
> +	 .enabled = IS_ENABLED(CONFIG_SECURITY_SMACK)
>  	},
> -	{.name = XATTR_NAME_SMACKEXEC,
> -#ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
> -	 .enabled = true
> -#endif
> +	{
> +	 .name = XATTR_NAME_SMACKEXEC,
> +	 .enabled = IS_ENABLED(CONFIG_EVM_EXTRA_SMACK_XATTRS)
>  	},
> -	{.name = XATTR_NAME_SMACKTRANSMUTE,
> -#ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
> -	 .enabled = true
> -#endif
> +	{
> +	 .name = XATTR_NAME_SMACKTRANSMUTE,
> +	 .enabled = IS_ENABLED(CONFIG_EVM_EXTRA_SMACK_XATTRS)
>  	},
> -	{.name = XATTR_NAME_SMACKMMAP,
> -#ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
> -	 .enabled = true
> -#endif
> +	{
> +	 .name = XATTR_NAME_SMACKMMAP,
> +	 .enabled = IS_ENABLED(CONFIG_EVM_EXTRA_SMACK_XATTRS)
>  	},
> -	{.name = XATTR_NAME_APPARMOR,
> -#ifdef CONFIG_SECURITY_APPARMOR
> -	 .enabled = true
> -#endif
> +	{
> +	 .name = XATTR_NAME_APPARMOR,
> +	 .enabled = IS_ENABLED(CONFIG_SECURITY_APPARMOR)
>  	},
> -	{.name = XATTR_NAME_IMA,
> -#ifdef CONFIG_IMA_APPRAISE
> -	 .enabled = true
> -#endif
> +	{
> +	 .name = XATTR_NAME_IMA,
> +	 .enabled = IS_ENABLED(CONFIG_IMA_APPRAISE)
>  	},
> -	{.name = XATTR_NAME_CAPS,
> +	{
> +	 .name = XATTR_NAME_CAPS,
>  	 .enabled = true
>  	},
>  };


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
