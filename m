Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4021549FA
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 18:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgBFRHF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Feb 2020 12:07:05 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48792 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgBFRHF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 12:07:05 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5D69420B7130;
        Thu,  6 Feb 2020 09:07:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D69420B7130
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581008824;
        bh=hlwVzxb4UU8cnAPgCWYXMIzujw/M5LqObBrLV/WPdAQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hsGIOcRzVlgnAFz2oSVbcMwignzylsslDSCi4BNXDUebD6t0cGiFTCrRp6DTjvpo/
         f97gPayBkib+gu1X0xoGC2sCDAhchXiGDPjLfDDh2zZAWMH/WUMsmeyiH2Zdlvl1Em
         wSdzg/ItePKTkBY+mZ1kaAJIMftKIjNMFg74AZL4=
Subject: Re: [RFC PATCH 1/2] ima: Implement support for uncompressed module
 appended signatures
To:     Eric Snowberg <eric.snowberg@oracle.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     dhowells@redhat.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        tglx@linutronix.de, bauerman@linux.ibm.com, mpe@ellerman.id.au,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
 <20200206164226.24875-2-eric.snowberg@oracle.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <fda8b3e4-e3aa-a83a-0ddc-8ec096e67316@linux.microsoft.com>
Date:   Thu, 6 Feb 2020 09:07:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206164226.24875-2-eric.snowberg@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/6/2020 8:42 AM, Eric Snowberg wrote:

>   
> @@ -31,6 +32,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
>   	".ima",
>   #endif
>   	".platform",
> +	".builtin_trusted_keys",
>   };
>   
>   #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> @@ -45,8 +47,11 @@ static struct key *integrity_keyring_from_id(const unsigned int id)
>   		return ERR_PTR(-EINVAL);
>   
>   	if (!keyring[id]) {
> -		keyring[id] =
> -			request_key(&key_type_keyring, keyring_name[id], NULL);
> +		if (id == INTEGRITY_KEYRING_KERNEL)
> +			keyring[id] = VERIFY_USE_SECONDARY_KEYRING;

Since "Built-In Trusted Keyring" or "Secondary Trusted Keyring" is used, 
would it be more appropriate to name this identifier 
INTEGRITY_KEYRING_BUILTIN_OR_SECONDARY?

> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 73fc286834d7..63f0e6bff0e0 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -145,7 +145,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>   #define INTEGRITY_KEYRING_EVM		0
>   #define INTEGRITY_KEYRING_IMA		1
>   #define INTEGRITY_KEYRING_PLATFORM	2
> -#define INTEGRITY_KEYRING_MAX		3
> +#define INTEGRITY_KEYRING_KERNEL	3
> +#define INTEGRITY_KEYRING_MAX		4


  -lakshmi
