Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68EDA184CBB
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2020 17:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCMQnJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Mar 2020 12:43:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgCMQnJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Mar 2020 12:43:09 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F872206BE;
        Fri, 13 Mar 2020 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584117788;
        bh=9uZEI+oOcFKGuYiAX/4oCsXo600bTwJmNKjcMRlMz9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCHJb8mk/tD9veVKos8z2FAbiYflpUdwh1BVM3NL5KiPVTBt0ISp3dxLCmlpy8Ent
         dwWFZ/r8SWaEhaZ8yMnRUDZZWO2QPmFMvCySTZcr256MwJjE3eUOQzAwFQEoc7JMDk
         ZCwEQAbwK6dV8lgwYLH1qlQq5X0gj2RVvz0JKkPU=
Date:   Fri, 13 Mar 2020 09:43:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large
 buffer allocation
Message-ID: <20200313164306.GA907@sol.localdomain>
References: <20200313152102.1707-1-longman@redhat.com>
 <20200313152102.1707-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313152102.1707-4-longman@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 13, 2020 at 11:21:02AM -0400, Waiman Long wrote:
> For large multi-page temporary buffer allocation, the security/keys
> subsystem don't need contiguous physical pages. It will work perfectly
> fine with virtually mapped pages.
> 
> Replace the kmalloc() call by kvmalloc() and provide a __kvzfree()
> helper function to clear and free the kvmalloc'ed buffer. This will
> reduce the chance of memory allocation failure just because of highly
> fragmented pages.
> 
> Suggested-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  security/keys/internal.h | 14 ++++++++++++++
>  security/keys/keyctl.c   | 10 +++++-----
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index ba3e2da14cef..855b11eb73ee 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -16,6 +16,8 @@
>  #include <linux/keyctl.h>
>  #include <linux/refcount.h>
>  #include <linux/compat.h>
> +#include <linux/mm.h>
> +#include <linux/vmalloc.h>
>  
>  struct iovec;
>  
> @@ -349,4 +351,16 @@ static inline void key_check(const struct key *key)
>  
>  #endif
>  
> +/*
> + * Helper function to clear and free a kvmalloc'ed memory object.
> + */
> +static inline void __kvzfree(const void *addr, size_t len)
> +{
> +	if (is_vmalloc_addr(addr)) {
> +		memset((void *)addr, 0, len);
> +		vfree(addr);
> +	} else {
> +		kzfree(addr);
> +	}
> +}

Since this takes the length as a parameter, it can be simplified to:

static inline void __kvzfree(const void *addr, size_t len)
{
	if (addr) {
		memset((void *)addr, 0, len);
		kvfree(addr);
	}
}

>  			if (!tmpbuf || unlikely(ret > tmpbuflen)) {
>  				if (unlikely(tmpbuf))
> -					kzfree(tmpbuf);
> +					__kvzfree(tmpbuf, tmpbuflen);

Both kzfree() and __kvzfree() handle a NULL pointer, so there's no need for the
NULL check first.

> @@ -920,7 +920,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
>  				ret = -EFAULT;
>  		}
>  		if (tmpbuf)
> -			kzfree(tmpbuf);
> +			__kvzfree(tmpbuf, tmpbuflen);

Likewise here.  No need for the NULL check.

- Eric
