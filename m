Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7A332F403
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 20:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCETgz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 14:36:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52774 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhCETgw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 14:36:52 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B84F620B83EA;
        Fri,  5 Mar 2021 11:36:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B84F620B83EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614973011;
        bh=4XfKI01xCGDF7/kmNKwFpOEKuZ6joFfuhk32D0n4kn8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GUC8b22xykyN8ATFMSP79Z8qSm/7lsAlL1fP4qUW7TuWpAnOv8h+aM2jGoSrACexA
         8UxZToa4s5zOA0PAMI47ELxwMSqCqLCb5BCUWRjheJPKW9xZAY1OQNgphHMCis93DK
         7y8ZzT37JqcdBJguCstuU1jTUe1a8t9D3yevWkJQ=
Subject: Re: [PATCH] IMA: Allow only ima-buf template for key measurement
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
References: <20210303203254.12856-1-nramas@linux.microsoft.com>
 <YEJZIQqa1arYKwK+@pevik>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <466bc969-977f-e843-1f90-711a6d1193e0@linux.microsoft.com>
Date:   Fri, 5 Mar 2021 11:36:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YEJZIQqa1arYKwK+@pevik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/5/21 8:15 AM, Petr Vorel wrote:

Hi Petr,

> 
> for my record: previous version was
> https://patchwork.ozlabs.org/project/ltp/patch/20210222023421.12576-1-nramas@linux.microsoft.com/
> 
>> ima-buf is the default IMA template used for all buffer measurements.
>> Therefore, IMA policy rule for measuring keys need not specify
>> an IMA template.  But if a template is specified for key measurement
>> rule then it must be only ima-buf.
> 
>> Update keys tests to not require a template to be specified for
>> key measurement rule, but if a template is specified verify it is
>> only ima-buf.
> Good, but there are some issues, see below.
> 
> ...
>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> ...
>> +	check_policy_template "template=ima-buf" $FUNC_KEYCHECK || return
>> +
>>   	check_keys_policy "$pattern" > $tmp_file || return
>>   	keycheck_lines=$(cat $tmp_file)
>>   	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
>> @@ -101,6 +103,8 @@ test2()
> 
>>   	tst_res TINFO "verify measurement of certificate imported into a keyring"
> 
>> +	check_policy_template "template=ima-buf" $FUNC_KEYCHECK || return
>> +
>>   	check_keys_policy "$pattern" >/dev/null || return
> 
>>   	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
>> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
>> index 59a7ffeac..01ebec2b6 100644
>> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
>> @@ -107,6 +107,22 @@ check_ima_policy_cmdline()
>>   	return 1
>>   }
> 
>> +check_policy_template()
>> +{
>> +	local template="$1"
>> +	local func="$2"
>> +	grep -E "template=" $TST_TMPDIR/policy.txt | while read line
>> +	do
>> +		ima_template=$(echo $line | grep $template)
>> +		if [ -z "$ima_template" ]; then
> instead of putting it into variable, why not just using grep?
> if ! echo $line | grep -q $template; then
> 
Sure - will make this change.

>> +			tst_res TCONF "Only $template can be specified for $func"
>> +			return 1
> Have you test it? This will not work. There is ${PIPESTATUS[@]} bash/zsh
> array, thus 1 is in $pipestatus[1]. But that's bashism, which will not work on
> dash busybox ash, ...
> 

I tested it by running "/opt/ltp/run -f ima -s keys" to run the keys 
test in IMA. I followed the pattern in check_keys_policy() to check for 
the template and validate the change. I will check this again and 
update. Sorry about that.

> You need to do:
> while read line; do
> 	if ! echo $line | grep -q $template; then
> 		tst_res TCONF "only $template can be specified for $func"
> 		return 1
> 	fi
> done < $TST_TMPDIR/policy.txt
> return 0

Sure - will make this change.

> 
> *BUT* on vanilla 5.11 with and SLES 5.3.18-47-default with many backports when
> testing with this wrong policy:
> measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-ng
> 
> 
> ima_keys 1 TINFO: verify key measurement for keyrings and templates specified in IMA policy
> ima_keys 1 TCONF: Only template=ima-buf can be specified for func=KEY_CHECK
> ima_keys 1 TINFO: keyrings: '\.ima|\.evm|\.builtin_trusted_keys|\.blacklist|key_import_test'
> ima_keys 1 TINFO: templates: 'ima-ng'
> ima_keys 1 TPASS: specified keyrings were measured correctly
>             ^
> first test passes. Why? Is that correct?
> I haven't tested any other templates.
No - the test should not pass if an incorrect template is specified. I 
will check this again and update.

> 
> ima_keys 2 TINFO: verify measurement of certificate imported into a keyring
> ima_keys 2 TCONF: Only template=ima-buf can be specified for func=KEY_CHECK
> errno: No such file or directory (2)
> ima_keys 2 TBROK: unable to import a certificate into key_import_test keyring
> 
>> +		fi
>> +	done
> 
> Besides that, I'd like to put check_policy_template() into ima_keys.sh because
> 1) is so far needed only in ima_keys.sh 2) it expects $TST_TMPDIR/policy.txt.
> Functions in ima_setup.sh which are used for more tests should not expect any
> function was called before.
Agreed. I'll move check_policy_template() to ima_keys.sh.

> 
> dm-crypt measurement tests from Tushar Sugandhi will require these, I'll put it
> into ima_setup.sh during rebase and probably add policy file as a function parameter.
That sounds good.

Thanks a lot Petr.

  -lakshmi

