Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A7A4BD294
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 00:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiBTXFm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Feb 2022 18:05:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiBTXFl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Feb 2022 18:05:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39984477D;
        Sun, 20 Feb 2022 15:05:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FB4260FC8;
        Sun, 20 Feb 2022 23:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19626C340E8;
        Sun, 20 Feb 2022 23:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645398318;
        bh=WEigyHym8SL+eQLKpwgUOuryIp8HNx3u/9ThKQ85NWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=smUdnBvCRQ8GbwYUMVhG0Y6/evChhHhjUWFahl8NgOPqMiAtynTA1YhHQGodjGJy1
         oEnQtLxn53eQeh2JEb/NWETQ+9WpfMP/BvHiidU+TRXM+zmuisp043J4cfE6ul+cHa
         HOJUQteInnx4n4KwKsDDZaTntFIq++y3pQROpbExs9H0QKUvzBR+PRgrQ1z+ViUoKB
         9HZ+tN7SUmL7pJQQitsvMZECSO4+imQ9yDzdoaGDqHKo2gJZtchRtt6MLI4uzL8vXZ
         5tOS7iCa1RHiHCdCHSaR7lvVGXdBQ9vfgu7zz3wU0bSLS+8G/y9yOyCgbjt2pJHvV5
         kkXVK18T55Pxw==
Date:   Mon, 21 Feb 2022 00:05:57 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: fix crash when TPM/TEE are built as module
Message-ID: <YhLJVTQJ2o3fUCwy@iki.fi>
References: <20220204200342.48665-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204200342.48665-1-ztong0001@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 04, 2022 at 12:03:42PM -0800, Tong Zhang wrote:
> when TCG_TPM and TEE are built as module, trusted_key_sources will be an
> empty array, loading it won't do what it is supposed to do and unloading
> it will cause kernel crash.
> 
> To reproduce:
> $ modprobe trusted
> $ modprobe -r trusted
> 
> [  173.749423] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [  173.755268] Backtrace:
> [  173.755378]  cleanup_trusted [trusted] from sys_delete_module+0x15c/0x22c
> [  173.755589]  sys_delete_module from ret_fast_syscall+0x0/0x1c
> 
> To fix this issue, we also need to check CONFIG_TCG_TPM_MODULE and
> CONFIG_TEE_MODULE.
> 
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  security/keys/trusted-keys/trusted_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index d5c891d8d353..b3a3b2f2d4a4 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp, 0);
>  MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
>  
>  static const struct trusted_key_source trusted_key_sources[] = {
> -#if defined(CONFIG_TCG_TPM)
> +#if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
>  	{ "tpm", &trusted_key_tpm_ops },
>  #endif
> -#if defined(CONFIG_TEE)
> +#if defined(CONFIG_TEE) || defined(CONFIG_TEE_MODULE)
>  	{ "tee", &trusted_key_tee_ops },
>  #endif
>  };
> -- 
> 2.25.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
