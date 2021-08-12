Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F31B3EAB09
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 21:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhHLTdO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 15:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhHLTdO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 15:33:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 146F66103E;
        Thu, 12 Aug 2021 19:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628796768;
        bh=lg/8arNicmC18ApageDiCyUDx1jcCzPLdyS+XQwn3PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RElh9eQskkp0T8qjm1HbZTAQ6eLqgaXSObL33NSTZEDcoYv5+CK8ZTeMzd6nUPwp9
         B5MAsHJcCQ5zJw8TS96FcyyYQ5qeGGGush4eYiIsH6rlzN3iOUoN0f7ASF+r7o3sEW
         J6Q+dsRrLxnZppivTVBVOZQ5vmL7k3DJy5JFINxYDfqY/2ZS9tNpQTh+f06LoIDNKB
         DWo5b0Obn7c46uDKV7DnIZJezgaRv8Sx/DnBbMFzemzYxy4bhlXbgX3DS8I6lUYUgh
         gvgTMcVTDWmSxA67Iw7rg24YJkonmWmcfcF1lAxL5idevHMFYOZoDnFDeCmJIiU2kv
         lNWgZ06EAfIOg==
Date:   Thu, 12 Aug 2021 22:32:45 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        glin@suse.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v3 04/14] integrity: add add_to_mok_keyring
Message-ID: <20210812193245.yev4gyeuxrfwqfty@kernel.org>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
 <20210812021855.3083178-5-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812021855.3083178-5-eric.snowberg@oracle.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 11, 2021 at 10:18:45PM -0400, Eric Snowberg wrote:
> Add the ability to load Machine Owner Key (MOK) keys to the mok keyring.
> If the permissions do not allow the key to be added to the mok keyring
> this is not an error, add it to the platform keyring instead.

Should state why it isn't an error for clarity.

/Jarkko

> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v1: Initial version
> v3: Unmodified from v1
> ---
>  security/integrity/integrity.h                |  4 ++++
>  .../integrity/platform_certs/mok_keyring.c    | 21 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index e0e17ccba2e6..60d5c7ba05b2 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -278,9 +278,13 @@ integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
>  #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
>  void __init add_to_platform_keyring(const char *source, const void *data,
>  				    size_t len);
> +void __init add_to_mok_keyring(const char *source, const void *data, size_t len);
>  #else
>  static inline void __init add_to_platform_keyring(const char *source,
>  						  const void *data, size_t len)
>  {
>  }
> +void __init add_to_mok_keyring(const char *source, const void *data, size_t len)
> +{
> +}
>  #endif
> diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
> index fe4f2d336260..f260edac0863 100644
> --- a/security/integrity/platform_certs/mok_keyring.c
> +++ b/security/integrity/platform_certs/mok_keyring.c
> @@ -21,6 +21,27 @@ static __init int mok_keyring_init(void)
>  }
>  device_initcall(mok_keyring_init);
>  
> +void __init add_to_mok_keyring(const char *source, const void *data, size_t len)
> +{
> +	key_perm_t perm;
> +	int rc;
> +
> +	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
> +	rc = integrity_load_cert(INTEGRITY_KEYRING_MOK, source, data, len, perm);
> +
> +	/*
> +	 * If the mok keyring restrictions prevented the cert from loading,
> +	 * this is not an error.  Just load it into the platform keyring
> +	 * instead.
> +	 */
> +	if (rc)
> +		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
> +					 data, len, perm);
> +
> +	if (rc)
> +		pr_info("Error adding keys to mok keyring %s\n", source);
> +}
> +
>  /*
>   * Try to load the MokListTrustedRT UEFI variable to see if we should trust
>   * the mok keys within the kernel. It is not an error if this variable
> -- 
> 2.18.4
> 
> 
