Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA87233815
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 20:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgG3SCx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 14:02:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35040 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbgG3SCw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 14:02:52 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 508FA20B4908;
        Thu, 30 Jul 2020 11:02:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 508FA20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596132171;
        bh=Lq00ap7Yu8hoUdPCLVlYdZakWLvY3wTeBBusKqVGKL4=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=ZjcMZbIwR/fP3byLrxge5Ao5e6GNyOxy0eX1JNinRJb1DKlygk8vEypRNhuOT3BA8
         QBSKgVbqSbcijtYHbivDb7NzWH29EtNUIPqz4nmIPjJgvbngaWRjLUKQCQD6CokjSB
         FA2pANqUEaaDk+qglmoS3yYd6EEKu0thLoDca/n8=
Subject: Re: [PATCH v5 4/4] IMA: Handle early boot data measurement
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200730034724.3298-1-nramas@linux.microsoft.com>
 <20200730034724.3298-5-nramas@linux.microsoft.com>
Message-ID: <ea3bba66-9b21-b842-990b-2bf1e4ac2179@linux.microsoft.com>
Date:   Thu, 30 Jul 2020 11:02:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730034724.3298-5-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/29/20 8:47 PM, Lakshmi Ramasubramanian wrote:

Hi Tyler,

> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 080c53545ff0..86cba844f73c 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -322,10 +322,9 @@ config IMA_MEASURE_ASYMMETRIC_KEYS
>   	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
>   	default y
>   
> -config IMA_QUEUE_EARLY_BOOT_KEYS
> +config IMA_QUEUE_EARLY_BOOT_DATA
>   	bool
> -	depends on IMA_MEASURE_ASYMMETRIC_KEYS
> -	depends on SYSTEM_TRUSTED_KEYRING
> +	depends on SECURITY || (IMA_MEASURE_ASYMMETRIC_KEYS && SYSTEM_TRUSTED_KEYRING)
>   	default y
>   
Similar to the change you'd suggested for validating LSM_STATE and 
LSM_POLICY func, I think IMA_QUEUE_EARLY_BOOT_DATA config should be 
enabled for SECURITY_SELINUX.

depends on SECURITY_SELINUX ||
            (IMA_MEASURE_ASYMMETRIC_KEYS && SYSTEM_TRUSTED_KEYRING)

And, when more security modules are added update this CONFIG as appropriate.

Does that sound okay?

  -lakshmi
