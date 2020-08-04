Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C2423BE4B
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Aug 2020 18:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgHDQmv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 12:42:51 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60954 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgHDQmg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 12:42:36 -0400
Received: from [192.168.1.21] (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0697B20B4908;
        Tue,  4 Aug 2020 09:42:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0697B20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596559355;
        bh=c2LVH6nQS6RYUl+dAfkdubw/XwcvmvGT2NKU9DyNOSE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iDENLvWNZenv70hnUoZXrlCLbt029kq9WzRPh2pfG+/8GJsU6lu0L6FA4zl5VzAQv
         Dzn7sw/Bib8LeNeRLvjj07aM91DaDpz9AKbcshwFhScQbtZZb5T2/do2uNI4n2eekd
         Z4CmDNAoJ0OKAJDCgA9103yFK0jhXArHcMmaWoEY=
Subject: Re: [PATCH 1/3] IMA: Update key test documentation
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, ltp@lists.linux.it,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, tyhicks@linux.microsoft.com,
        yaneurabeya@gmail.com, zhang.jia@linux.alibaba.com
References: <20200803184726.2416-1-t-josne@linux.microsoft.com>
 <20200803184726.2416-2-t-josne@linux.microsoft.com>
 <20200804043504.GA76360@x230>
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
Message-ID: <1ccacc7c-392c-ad45-2806-048177953acf@linux.microsoft.com>
Date:   Tue, 4 Aug 2020 12:42:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804043504.GA76360@x230>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,
Thanks for updating the readme. Should I send a new patch with
the changes you have proposed?

Thanks,
Lachlan

On 8/4/20 12:35 AM, Petr Vorel wrote:
> Hi Lachlan,
>
>> The current documentation for the existing IMA key test was
>> left in by accident by a previous merge. It does not apply
>> to the test that is currently included in the LTP.
>> Update the documentation for the IMA key test.
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
> Thanks for fixing this, I propose this changes:
>
> Fixes: d2768c84e ("IMA: Add a test to verify measurement of keys")
>
>> ---
>>   .../kernel/security/integrity/ima/README.md   | 22 +++++--------------
>>   1 file changed, 5 insertions(+), 17 deletions(-)
>> diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
>> index d4644ba39..2956ac7fd 100644
>> --- a/testcases/kernel/security/integrity/ima/README.md
>> +++ b/testcases/kernel/security/integrity/ima/README.md
>> @@ -15,27 +15,15 @@ Although a custom policy, loaded via dracut, systemd or manually from user
>>   space, may contain equivalent measurement tcb rules, detecting them would
>>   require `IMA_READ_POLICY=y` therefore ignore this option.
>> -### IMA key import test
>> -`ima_keys.sh` requires a x509 public key, by default in `/etc/keys/x509_ima.der`
>> -(defined in `CONFIG_IMA_X509_PATH` kernel config option).
>> -The key must be signed by the private key you generate. Follow these instructions:
>> -https://manpages.ubuntu.com/manpages/disco/man1/evmctl.1.html#generate%20trusted%20keys
>> -
>> -The test cannot be set-up automatically because the x509 public key must be
>> -built into the kernel and loaded onto a trusted keyring
>> -(e.g. `.builtin_trusted_keys`, `.secondary_trusted_keyring`).
>> -
>> -As well as what's required for the IMA tests, the following are also required
>> -in the kernel configuration:
>> +### IMA key test
>> +`ima_keys.sh` requires a readable IMA policy, as well as a loaded policy
>> +with `func=KEY_CHECK keyrings=...`, see example in `keycheck.policy`.
>> +
>> +Mandatory kernel configuration for IMA:
> This "Mandatory kernel configuration for IMA:" would be in docs twice. The above
> one (CONFIG_INTEGRITY=y, CONFIG_IMA=y) is required for all tests.
> Take it that "### IMA key test" is header 3, but ## IMA tests
> is header 2 (upper level).
>
>>   ```
>>   CONFIG_IMA_READ_POLICY=y
>> -CONFIG_IMA_X509_PATH="/etc/keys/x509_ima.der"
>> -CONFIG_SYSTEM_TRUSTED_KEYRING=y
>> -CONFIG_SYSTEM_TRUSTED_KEYS="/etc/keys/ima-local-ca.pem"
>>   ```
>> -Test also requires loaded policy with `func=KEY_CHECK`, see example in `keycheck.policy`.
>> -
>>   ### IMA kexec test
>>   `ima_kexec.sh` requires loaded policy which contains `measure func=KEXEC_CMDLINE`,
> I also removed "IMA" from EVM tests header.
>
> Kind regards,
> Petr
>
> diff --git testcases/kernel/security/integrity/ima/README.md testcases/kernel/security/integrity/ima/README.md
> index 2956ac7fd..392e1e868 100644
> --- testcases/kernel/security/integrity/ima/README.md
> +++ testcases/kernel/security/integrity/ima/README.md
> @@ -19,7 +19,8 @@ require `IMA_READ_POLICY=y` therefore ignore this option.
>   `ima_keys.sh` requires a readable IMA policy, as well as a loaded policy
>   with `func=KEY_CHECK keyrings=...`, see example in `keycheck.policy`.
>   
> -Mandatory kernel configuration for IMA:
> +As well as what's required for the IMA tests, the following are also required
> +-in the kernel configuration:
>   ```
>   CONFIG_IMA_READ_POLICY=y
>   ```
> @@ -38,7 +39,7 @@ To kexec a different kernel image export `IMA_KEXEC_IMAGE=<pathname>`.
>   kernel parameter) which appraises the integrity of all files owned by root and EVM setup.
>   Again, for simplicity ignore possibility to load requires rules via custom policy.
>   
> -Mandatory kernel configuration for IMA & EVM:
> +Mandatory kernel configuration for EVM tests:
>   ```
>   CONFIG_INTEGRITY=y
>   CONFIG_INTEGRITY_SIGNATURE=y
> @@ -50,7 +51,7 @@ CONFIG_TRUSTED_KEYS=y
>   CONFIG_ENCRYPTED_KEYS=y
>   ```
>   
> -Example of installing IMA + EVM on openSUSE:
> +Example of preparing environment on for EVM on openSUSE:
>   
>   * Boot install system with `ima_policy=tcb|appraise_tcb ima_appraise=fix evm=fix` kernel parameters
>     (for IMA measurement, IMA appraisal and EVM protection)

