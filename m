Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9648DD94E8
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 17:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392868AbfJPPE7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Oct 2019 11:04:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49312 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfJPPE7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Oct 2019 11:04:59 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id C06CF20B7116;
        Wed, 16 Oct 2019 08:04:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C06CF20B7116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571238298;
        bh=TXmTAKnOpUgk584jT9NBfpnw88paR+EVc6/0jeTaVKQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=echK35uqoNaKQ9/ua/9my98Cb8IjNLF/4I2OBaCCH7sD705kmN2E0kLLRhW7BGNcm
         JBATKyDaZFjoi+YP3Ofmy8vc/j7riwVfaiBZva+o4E2xqOh3oc4oJs+2DW/H5r31M7
         0Bq4u1b25UkEm0uoZ6xJeqcxDtCBBEf0QwHS7gvY=
Subject: Re: [PATCH v0 1/1] KEYS: LSM Hook for key_create_or_update
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        kgoldman@us.ibm.com, mjg59@google.com, dhowells@redhat.com
Cc:     balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        jorhand@linux.microsoft.com, patatash@linux.microsoft.com
References: <20191015231750.25992-1-nramas@linux.microsoft.com>
 <20191015231750.25992-2-nramas@linux.microsoft.com>
 <1571185832.5250.153.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <e356ff4f-5664-7d09-4b1d-c96c2ed81e55@linux.microsoft.com>
Date:   Wed, 16 Oct 2019 08:04:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571185832.5250.153.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/15/19 5:30 PM, Mimi Zohar wrote:

> As per Documentation/process/submitting-patches.rst section "2)
> Describe your changes", please begin the patch description by
> describing the problem.
Will do.

> 
> This patch should be broken up even further.[1]  In this case to
> simplify review, separate defining the new LSM hook from any IMA code.
>   Different maintainers need to Ack/sign off on these patches.
> 
> The new LSM hook patch, with a clear well written patch description,
> should be posted on the LSM mailing list as well.
Will do

>> +
>> +inline bool is_platform_trusted_keyring(struct key *keyring)
>> +{
>> +	#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
>> +	return (keyring == platform_trusted_keys);
>> +	#else
>> +	return false;
>> +	#endif
>> +}
> 
> Why are these functions defined in a new LSM hook patch?  Before
> posting a patch, please review the patch line by line, making sure
> that there isn't anything extraneous.

Since these are helper functions that will be used by IMA (which I will 
post shortly), I thought it is appropriate to include this.
Sorry about that - I'll move it out of this patch set.

Will send an updated change today.

thanks,
  -lakshmi
