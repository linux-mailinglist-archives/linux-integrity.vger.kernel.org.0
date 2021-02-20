Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB80320314
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 03:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBTCVJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 21:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhBTCVI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 21:21:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FBBC061574;
        Fri, 19 Feb 2021 18:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=vkHct5nZ9eo2GX6kg3o550luk7j4MmaPBgMkq/hkd9k=; b=svpg8ZecDW5spllYjvOFHvISS6
        lqXen/Xmy3JT1u52u0xFPmZxmZdfzmPqSmaGmNof4WwY6rwjS9TKXbYB5GVWGfLdKP9KuXLOaoxhi
        ihhhrUiDCgwzeh4vLfItkNNk1ql5BlYrAHVB8+bv/qHSE00eHtIcDW1wP82Rtse6n7+N3A+kHHNMW
        tOU9Tx1WXQzgRev/EUMEuLNimJxsmJReUD32fiPI+aM8TOJXQwA4WuxxSPVSSi3054Bn5diizYZBh
        roB+iwkSHGYLL+jErZRVCItdXROC6kkw3m0L8F1EJlqzRnUTcpzZgP+OU7JeR0SslIm1lionRolKy
        JPqNdLlg==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lDHsZ-0001CX-1i; Sat, 20 Feb 2021 02:20:19 +0000
Subject: Re: [PATCH 7/9] pm: hibernate: Optionally use TPM-backed keys to
 protect image integrity
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com, jejb@linux.ibm.com,
        jarkko@kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        Matthew Garrett <mjg59@google.com>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <20210220013255.1083202-8-matthewgarrett@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4c265e1d-0a02-207a-cc10-9a49b4fc5169@infradead.org>
Date:   Fri, 19 Feb 2021 18:20:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210220013255.1083202-8-matthewgarrett@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi--

On 2/19/21 5:32 PM, Matthew Garrett wrote:
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index a7320f07689d..0279cc10f319 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -92,6 +92,21 @@ config HIBERNATION_SNAPSHOT_DEV
>  
>  	  If in doubt, say Y.
>  
> +config SECURE_HIBERNATION
> +       bool "Implement secure hibernation support"
> +       depends on HIBERNATION && TCG_TPM
> +       select KEYS
> +       select TRUSTED_KEYS
> +       select CRYPTO
> +       select CRYPTO_SHA256
> +       select CRYPTO_AES
> +       select TCG_TPM_RESTRICT_PCR
> +       help
> +         Use a TPM-backed key to securely determine whether a hibernation
> +	 image was written out by the kernel and has not been tampered with.
> +	 This requires a TCG-compliant TPM2 device, which is present on most
> +	 modern hardware.

Please follow coding-style for Kconfig files:

from Documentation/process/coding-style.rst, section 10):

  For all of the Kconfig* configuration files throughout the source tree,
  the indentation is somewhat different.  Lines under a ``config`` definition
  are indented with one tab, while help text is indented an additional two
  spaces.


Also, one feature should not be responsible for enabling other "subsystems,"
such as KEYS and CRYPTO. They should instead be listed as dependencies.


-- 
~Randy

