Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2C17B068
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2020 22:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgCEVRD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Mar 2020 16:17:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCEVQx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Mar 2020 16:16:53 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B21F820728;
        Thu,  5 Mar 2020 21:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583443013;
        bh=TwO5bwawSGBd1hvXvSkBLj+ILLCCIBlCvGCMPQ8I2c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdWl/xjGhfe8AKx4gpf1+pTdzly+8Vw6cUxr4Dy4g6e/giV8iCGLZTBYALqfTRnW7
         Wq3TB/+Ek0YX+fvgK7QRy+qGFMS7sTmnHAakfRHiyKa6JB1O9V/GpM+BdgTzoGmYe2
         nenXuvZHS0ixwjtE/x0jRLbXfYNFYqfxat8gl61M=
Date:   Thu, 5 Mar 2020 13:16:51 -0800
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
Subject: Re: [PATCH] KEYS: Don't write out to userspace while holding key
 semaphore
Message-ID: <20200305211651.GA225345@gmail.com>
References: <20200305210640.15315-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305210640.15315-1-longman@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 05, 2020 at 04:06:40PM -0500, Waiman Long wrote:
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 9b898c969558..564a4d187329 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -846,14 +846,36 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
>  can_read_key:
>  	ret = -EOPNOTSUPP;
>  	if (key->type->read) {
> -		/* Read the data with the semaphore held (since we might sleep)
> +		/*
> +		 * Read the data with the semaphore held (since we might sleep)
>  		 * to protect against the key being updated or revoked.
> +		 *
> +		 * Allocating a temporary buffer to hold the keys before
> +		 * transferring them to user buffer to avoid potential
> +		 * deadlock involving page fault and mmap_sem.
>  		 */
> +		char *tmpbuf = kmalloc(buflen, GFP_KERNEL);

This is passing an arbitrarily large size from userspace into kmalloc().

- Eric
