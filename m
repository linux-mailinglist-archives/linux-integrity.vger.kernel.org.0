Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9585C323422
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 00:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhBWXK0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 18:10:26 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40070 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbhBWXCa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 18:02:30 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0208620B6C40;
        Tue, 23 Feb 2021 15:01:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0208620B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614121308;
        bh=YgvvF1ZA37nOG01x0OVvh9FjTSqplz7AT39j3cpYs3c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Tbou0/fsQ80HZAFWAkqhTGGyVkIRBky07qUStocc9fhuyEyurENl1GS6AwsrLN6fN
         WIIiaKLlFddpFAxN2ob+6WjrrHipM/lrc1EgJrziTwcnaSUJVKrGD8mJ82AzrO7nK9
         1kSTbQQ5/BjlvYf3+VxUnl1ouQX5XxFd3VmEJRvY=
Subject: Re: [PATCH] IMA: Add test for selinux measurement
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
References: <20210222023805.12846-1-nramas@linux.microsoft.com>
 <YDVCsNAfn+Ot6QIB@pevik>
 <fdda206c-e156-d66b-7f53-0ee9c1417597@linux.microsoft.com>
 <YDV+SdQqGnCoykph@pevik>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <21490e27-a965-7d25-4c44-07bd89d0ac40@linux.microsoft.com>
Date:   Tue, 23 Feb 2021 15:01:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YDV+SdQqGnCoykph@pevik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/23/21 2:14 PM, Petr Vorel wrote:
>> On 2/23/21 10:00 AM, Petr Vorel wrote:
> 
> 
>>>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
>>> ...
>>>> +validate_policy_capabilities()
>>>> +{
>>>> +	local measured_cap measured_value expected_value
>>>> +	local result=1
>>>> +	local inx=7
>>>> +
>>>> +	# Policy capabilities flags start from "network_peer_controls"
>>>> +	# in the measured SELinux state at offset 7 for 'awk'
>>>> +	while [ $inx -lt 20 ]; do
>>>> +		measured_cap=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
>>>> +		inx=$(( $inx + 1 ))
>>>> +
>>>> +		measured_value=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
>>>> +		expected_value=$(cat "$SELINUX_DIR/policy_capabilities/$measured_cap")
>>>> +		if [ "$measured_value" != "$expected_value" ];then
>>>> +			tst_res TWARN "$measured_cap: expected: $expected_value, got: $digest"
>>> We rarely use TWARN in the tests, only when the error is not related to the test result.
>>> Otherwise we use TFAIL.
>> ok - I will change it to TFAIL.
> Thanks!
> But I've noticed that this error is handled twice, first in validate_policy_capabilities()
> as TWARN (or TFAIL) and then in test2(). Let's use TPASS/TFAIL in
> validate_policy_capabilities():
Sure - will make that change.

> 
> validate_policy_capabilities()
> {
> 	local measured_cap measured_value expected_value
> 	local inx=7
> 
> 	# Policy capabilities flags start from "network_peer_controls"
> 	# in the measured SELinux state at offset 7 for 'awk'
> 	while [ $inx -lt 20 ]; do
> 		measured_cap=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
> 		inx=$(($inx + 1))
> 
> 		measured_value=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
> 		expected_value=$(cat "$SELINUX_DIR/policy_capabilities/$measured_cap")
> 		if [ "$measured_value" != "$expected_value" ]; then
> 			tst_res TFAIL "$measured_cap: expected: $expected_value, got: $digest"
> 			return
> 		fi
> 
> 		inx=$(($inx + 1))
> 	done
> 
> 	tst_res TPASS "SELinux state measured correctly"
> }
> 
> test2()
> {
> 	...
> 	validate_policy_capabilities $measured_data
> }
> 
> ...
>>> As we discuss, I'm going tom merge test when patchset is merged in maintainers tree,
>>> please ping me. And ideally we should mention kernel commit hash as a comment in
>>> the test.
>> Will do. Thank you.
> Thanks!
> 
> ...
>>> +++ testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
>>> @@ -13,16 +13,14 @@ TST_SETUP="setup"
>>>    . ima_setup.sh
>>>    FUNC_CRITICAL_DATA='func=CRITICAL_DATA'
>>> -REQUIRED_POLICY="^measure.*($FUNC_CRITICAL_DATA)"
>>> +REQUIRED_POLICY="^measure.*$FUNC_CRITICAL_DATA"
>>>    setup()
>>>    {
>>> -	SELINUX_DIR=$(tst_get_selinux_dir)
>>> -	if [ -z "$SELINUX_DIR" ]; then
>>> -		tst_brk TCONF "SELinux is not enabled"
>>> -		return
>>> -	fi
>>> +	tst_require_selinux_enabled
>> Please correct me if I have misunderstood this one:
> 
>> tst_require_selinux_enabled is checking if SELinux is enabled in "enforce"
>> mode. Would this check fail if SELinux is enabled in "permissive" mode?
> 
>> For running the test, we just need SELinux to be enabled. I verify that by
>> checking for the presence of SELINUX_DIR.
> 
> Good catch. Your original version is correct (put it back into ima/selinux.v2.fixes).
> I didn't put a helper for it, because you need $SELINUX_DIR anyway.
> Thus removed tst_require_selinux_enabled() as not needed.
Thanks

> 
> I renamed tst_selinux_enabled() to tst_selinux_enforced() to make the purpose clearer
> (commit 82b598ea1 IMA: Add test for selinux measurement).
> 
> I've updated branch ima/selinux.v2.fixes with all mentioned changes
> https://github.com/pevik/ltp/commits/ima/selinux.v2.fixes
> 
Thanks again. I'll make my changes in this branch and post the patches 
later this week.

  -lakshmi

