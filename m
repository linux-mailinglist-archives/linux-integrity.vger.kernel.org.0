Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D87321F79
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 19:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhBVS4k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Feb 2021 13:56:40 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58286 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhBVSzA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Feb 2021 13:55:00 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 254BE20B6C40;
        Mon, 22 Feb 2021 10:54:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 254BE20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614020058;
        bh=F2Q+wGBpdBRbQLa+Yjt0vgkaEnf0Irr3K423f6dNoP0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ps/yOWdYkgDYhpSRJjnZ8Fmb+hq+dLEa+J6KYhar4dBjNeN/igRNDKGDRynmgeOAu
         vjwj5z18OmitPl//Ogi5+3x/qZw0MDRhz4Uej+hsdwBNP1cUcWVEkoWQDC4qfT1Nmd
         8S8XoExUKRI6xQiD5XAvblSnc6ZxHgGlwMhJRDdM=
Subject: Re: [PATCH v2 1/2] IMA: generalize key measurement tests
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, dm-devel@redhat.com,
        ltp@lists.linux.it
References: <20200928035605.22701-1-tusharsu@linux.microsoft.com>
 <20200928035605.22701-2-tusharsu@linux.microsoft.com>
 <20201221230531.GD4453@pevik>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <28c14c80-660a-0f36-64ca-ae5230992032@linux.microsoft.com>
Date:   Mon, 22 Feb 2021 10:54:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201221230531.GD4453@pevik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On 2020-12-21 3:05 p.m., Petr Vorel wrote:
> Hi Tushar,
> 
> I'm very sorry about the delay. I'll finish this review in January,
> here just some quick thoughts (minor style nits, I'll fix it before merge).
> 
> Generally LGTM, thanks for your work.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 

Thanks for your review.
My sincere apologies for missing this email and not responding in time.

The device mapper measurement work is being revisited - to cover aspects
like more DM targets (not just dm-crypt), better memory management,
more relevant attributes from the DM targets, other corner cases etc.

Therefore, even though this patch, "1/2: generalize key measurement
tests", would be useful for other tests; I will have to revisit the
second patch, "2/2: dm-crypt measurements", to address the DM side 
changes I mentioned above.

I will revisit this series, esp. testing the DM target measurements
part, once the kernel work I mentioned above is close to completion.

I will also address your feedback on patch #1 and #2 from v2 iteration
at that time.

Thanks again for your review and feedback.

Thanks,
Tushar

>> New functionality is being added in IMA to measure data provided by
>> kernel components. Tests have to be added in LTP to validate this new
>> feature. The functionality in ima_keys.sh can be reused to test this new
>> feature if it is made generic.
> 
>> Refactor check_keys_policy() and test1() implemented in ima_keys.sh to
>> make it generic, and move the functionality to ima_setup.sh as new
>> functions - check_policy_pattern() and check_ima_ascii_log_for_policy().
> 
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   .../security/integrity/ima/tests/ima_keys.sh  | 62 +++------------
>>   .../security/integrity/ima/tests/ima_setup.sh | 79 +++++++++++++++++++
>>   2 files changed, 92 insertions(+), 49 deletions(-)
> 
>> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
>> index c9eef4b68..c2120358a 100755
>> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
>> @@ -6,7 +6,7 @@
> 
>>   # Verify that keys are measured correctly based on policy.
> 
>> -TST_NEEDS_CMDS="cmp cut grep sed xxd"
>> +TST_NEEDS_CMDS="cmp cut grep xxd"
> It still requires sed, it's just hidden in check_ima_ascii_log_for_policy
> 
> Maybe just put at the top of check_ima_ascii_log_for_policy():
> tst_require_cmds cut grep sed xxd
> 
> And here still keep
> TST_NEEDS_CMDS="cmp cut grep tail xxd"
> 
> This leads to duplicity in check, but it will not lead to hidden "command not
> found".
> 
>>   TST_CNT=2
>>   TST_NEEDS_DEVICE=1
>>   TST_SETUP=setup
>> @@ -28,64 +28,28 @@ cleanup()
>>   	tst_is_num $KEYRING_ID && keyctl clear $KEYRING_ID
>>   }
> 
>> -check_keys_policy()
>> -{
>> -	local pattern="$1"
>> -
>> -	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
>> -		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK, $TEMPLATE_BUF"
>> -		return 1
>> -	fi
>> -	return 0
>> -}
>> -
>>   # Based on https://lkml.org/lkml/2019/12/13/564.
>>   # (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
> OK, it has been merged in v5.6-rc1. Any more relevant commits, changes since
> then?
> 
>>   test1()
>>   {
>>   	local keycheck_lines i keyrings templates
>>   	local pattern='keyrings=[^[:space:]]+'
>> -	local test_file="file.txt" tmp_file="file2.txt"
>> +	local policy="keyrings"
>> +	local tmp_file="$TST_TMPDIR/keycheck_tmp_file.txt"
>> +	local res
> Will be unused, see below.
> 
>>   	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
> 
>> -	check_keys_policy "$pattern" > $tmp_file || return
>> -	keycheck_lines=$(cat $tmp_file)
>> -	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
>> -		sed "s/\./\\\./g" | cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
>> -	if [ -z "$keyrings" ]; then
>> -		tst_res TCONF "IMA policy has a keyring key-value specifier, but no specified keyrings"
>> -		return
>> -	fi
>> -
>> -	templates=$(for i in $keycheck_lines; do echo "$i" | grep "template" | \
>> -		cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
>> -
>> -	tst_res TINFO "keyrings: '$keyrings'"
>> -	tst_res TINFO "templates: '$templates'"
>> -
>> -	grep -E "($templates).*($keyrings)" $ASCII_MEASUREMENTS | while read line
>> -	do
>> -		local digest expected_digest algorithm
>> -
>> -		digest=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)
>> -		algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
>> -		keyring=$(echo "$line" | cut -d' ' -f5)
>> +	check_policy_pattern "$pattern" $FUNC_KEYCHECK $TEMPLATE_BUF > $tmp_file || return
> 
>> -		echo "$line" | cut -d' ' -f6 | xxd -r -p > $test_file
>> +	res="$(check_ima_ascii_log_for_policy $policy $tmp_file)"
> 
>> -		if ! expected_digest="$(compute_digest $algorithm $test_file)"; then
>> -			tst_res TCONF "cannot compute digest for $algorithm"
>> -			return
>> -		fi
>> -
>> -		if [ "$digest" != "$expected_digest" ]; then
>> -			tst_res TFAIL "incorrect digest was found for $keyring keyring"
>> -			return
>> -		fi
>> -	done
>> +	if [ "$res" = "0" ]; then
>> +		tst_res TPASS "specified keyrings were measured correctly"
>> +	else
>> +		tst_res TFAIL "failed to measure specified keyrings"
>> +	fi
> 
> Instead of:
>         res="$(check_ima_ascii_log_for_policy $policy $tmp_file)"
>         if [ "$res" = "0" ]; then
> 
> I'd prefer to have it as:
>         check_ima_ascii_log_for_policy $policy $tmp_file
>         if [ $? -eq 0 ]; then
> 
> 
>> -	tst_res TPASS "specified keyrings were measured correctly"
>>   }
> 
>>   # Create a new keyring, import a certificate into it, and verify
>> @@ -97,11 +61,11 @@ test2()
>>   	local cert_file="$TST_DATAROOT/x509_ima.der"
>>   	local keyring_name="key_import_test"
>>   	local pattern="keyrings=[^[:space:]]*$keyring_name"
>> -	local temp_file="file.txt"
>> +	local temp_file="$TST_TMPDIR/key_import_test_file.txt"
> 
>>   	tst_res TINFO "verify measurement of certificate imported into a keyring"
> 
>> -	check_keys_policy "$pattern" >/dev/null || return
>> +	check_policy_pattern "$pattern" $FUNC_KEYCHECK $TEMPLATE_BUF >/dev/null || return
> 
>>   	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
>>   		tst_brk TBROK "unable to create a new keyring"
>> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
>> index 1f17aa707..2841d7df5 100644
>> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
>> @@ -54,6 +54,85 @@ compute_digest()
>>   	return 1
>>   }
> 
>> +check_policy_pattern()
>> +{
>> +	local pattern="$1"
>> +	local func="$2"
>> +	local template="$3"
>> +
>> +	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
>> +		tst_res TCONF "IMA policy must specify $pattern, $func, $template"
>> +		return 1
>> +	fi
>> +	return 0
>> +}
> Probably ok for now (yes, it removes the duplicity with function used in two
> tests, it's very policy specific).
> 
>> +
>> +check_ima_ascii_log_for_policy()
>> +{
>> +	local test_file="$TST_TMPDIR/ascii_log_test_file.txt"
>> +	local grep_file="$TST_TMPDIR/ascii_log_grep_file.txt"
> nit: Since the real description is in variable, I'd just use:
> 
> local test_file="$TST_TMPDIR/test.txt"
> local grep_file="$TST_TMPDIR/grep.txt"
> 
>> +	local func_lines sources templates i src
>> +	local input_digest_res=1
>> +	local policy_option="$1"
>> +	local input_digest="$3"
> 
> tst_require_cmds cut grep sed xxd
>> +
>> +	func_lines=$(cat $2)
>> +
>> +	sources=$(for i in $func_lines; do echo "$i" | grep "$policy_option" | \
>> +		sed "s/\./\\\./g" | cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
>> +	if [ -z "$sources" ]; then
>> +		tst_res TCONF "IMA policy $policy_option is a key-value specifier, but no values specified"
>> +		echo "1"
>> +		return
>> +	fi
>> +
>> +	templates=$(for i in $func_lines; do echo "$i" | grep "template" | \
>> +		cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
>> +
>> +	tst_res TINFO "policy sources: '$sources'"
>> +	tst_res TINFO "templates: '$templates'"
>> +
>> +	grep -E "($templates).*($sources)" $ASCII_MEASUREMENTS > $grep_file
>> +
>> +	while read line
>> +	do
>> +		local digest expected_digest algorithm
>> +
>> +		digest=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)
>> +		algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
>> +		src_line=$(echo "$line" | cut -d' ' -f5)
>> +
>> +		echo "$line" | cut -d' ' -f6 | xxd -r -p > $test_file
>> +
>> +		if ! expected_digest="$(compute_digest $algorithm $test_file)"; then
>> +			tst_res TCONF "cannot compute digest for $algorithm"
>> +			echo "1"
>> +			return
>> +		fi
>> +
>> +		if [ "$digest" != "$expected_digest" ]; then
>> +			tst_res TINFO "incorrect digest was found for $src_line $policy_option"
>> +			echo "1"	
>> +			return
>> +		fi
>> +
>> +		if [ "$input_digest" ]; then
>> +			if [ "$digest" = "$input_digest" ]; then
>> +				input_digest_res=0
>> +			fi
>> +		fi
> I'd prefer it as single if:
>          if [ -n "$input_digest" -a "$digest" = "$input_digest" ]; then
>              input_digest_res=0
>          fi
> 
>> +
>> +	done < $grep_file
>> +
>> +	if [ "$input_digest" ]; then
>> +		echo "$input_digest_res"
>> +		return
> this return is redundant.
>> +	else
>> +		echo "0"
>> +		return
> Also this one.
> 
>> +	fi
> 
> And actually, instead of whole if/else block wouldn't be just this enough?
> echo "$input_digest_res"
> 
> Isn't it the zero value set in the loop at:
> 
>          if [ -n "$input_digest" -a "$digest" = "$input_digest" ]; then
>              input_digest_res=0
>          fi
> 
> Kind regards,
> Petr
> 
