Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB3023F426
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Aug 2020 23:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgHGVMR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Aug 2020 17:12:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58456 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgHGVMQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Aug 2020 17:12:16 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8BF9720B4908;
        Fri,  7 Aug 2020 14:12:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8BF9720B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596834734;
        bh=Sy9TTYhS/706YXpBmc/pTUl7FcVCyhKEuXK1ETFx33Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oOkQ6Jc1sqXCyEpZQzZZcoGG5an/KKb5Fixj4qpgtT2NRU40pRLMvpfknRoDXSs5E
         Jv8QQ3cdIuo/MmdG/qef0639x3OA/1EHjmsWn2E+ZxY3Hb3iY/7+V3cBfep86lO4lr
         fpHKSgJOMFw8vCylaqCYQ6m7wrFNEMoSiqY7RSi0=
Subject: Re: [PATCH v2 3/4] IMA: Add a test to verify measurement of
 certificate imported into a keyring
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
References: <20200807204652.5928-1-pvorel@suse.cz>
 <20200807204652.5928-4-pvorel@suse.cz>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b9059e60-40da-d6ef-632e-ad958cddbb0d@linux.microsoft.com>
Date:   Fri, 7 Aug 2020 14:12:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807204652.5928-4-pvorel@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/7/20 1:46 PM, Petr Vorel wrote:

Hi Petr,

> From: Lachlan Sneff <t-josne@linux.microsoft.com>
> 
> The IMA subsystem supports measuring certificates that have been
> imported into either system built-in or user-defined keyrings.
> A test to verify measurement of a certificate imported
> into a keyring is required.
> 
> Add an IMA measurement test that verifies that an x509 certificate
> can be imported into a newly-created, user-defined keyring and measured
> correctly by the IMA subsystem.
> 
> A certificate used by the test is included in the `datafiles/keys`
> directory.
> 
> There can be restrictions on importing a certificate into a builtin
> trusted keyring. For example, the `.ima` keyring requires that
> imported certs be signed by a kernel private key in certain
> kernel configurations. For this reason, this test defines
> a user-defined keyring and imports a certificate into that.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> [ pvorel: Added key_import_test into keycheck.policy, reword
> instructions in README.md, LTP API related fixes ]
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> I did various changes:
> * fix error check in pipe command (grep $keyring_name
>    $ASCII_MEASUREMENTS ...) $? contains exit code just of last command
>    (xxd) => check for empty file.
> * use more propriate error flags (TCONF => TFAIL, but some of them could
>    be also TBROK)
> * tst_brk => tst_res && return in test1 (to give chance test2 to be run)
> * add TINFO message about test
> * remove obvious comment

Thanks for updating the patches.

In testcases/kernel/security/integrity/ima/datafiles/ima_keys/Makefile
the following change (include x509_ima.der) needed to be made to run 
ima_keys.sh tests

INSTALL_TARGETS := *.policy x509_ima.der

Other than that the patches look good.

thanks,
  -lakshmi

> 
>   .../kernel/security/integrity/ima/README.md   |  12 ++--
>   .../ima/datafiles/ima_keys/keycheck.policy    |   2 +-
>   .../ima/datafiles/ima_keys/x509_ima.der       | Bin 0 -> 650 bytes
>   .../security/integrity/ima/tests/ima_keys.sh  |  68 +++++++++++++++---
>   4 files changed, 69 insertions(+), 13 deletions(-)
>   create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_keys/x509_ima.der
> 
> diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
> index 392e1e868..68d046678 100644
> --- a/testcases/kernel/security/integrity/ima/README.md
> +++ b/testcases/kernel/security/integrity/ima/README.md
> @@ -16,11 +16,15 @@ space, may contain equivalent measurement tcb rules, detecting them would
>   require `IMA_READ_POLICY=y` therefore ignore this option.
>   
>   ### IMA key test
> -`ima_keys.sh` requires a readable IMA policy, as well as a loaded policy
> -with `func=KEY_CHECK keyrings=...`, see example in `keycheck.policy`.
> +The measuring keys test (first test) in `ima_keys.sh` requires a readable IMA
> +policy, as well as a loaded measure policy with `func=KEY_CHECK keyrings=...`.
>   
> -As well as what's required for the IMA tests, the following are also required
> --in the kernel configuration:
> +The certificate import test (second test) require measure policy with
> +`func=KEY_CHECK keyrings=key_import_test`. Valid policy for both is in
> +`keycheck.policy`.
> +
> +As well as what's required for the IMA tests, key tests require reading the IMA
> +policy allowed in the kernel configuration:
>   ```
>   CONFIG_IMA_READ_POLICY=y
>   ```
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_keys/keycheck.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_keys/keycheck.policy
> index 3f1934a3d..623162002 100644
> --- a/testcases/kernel/security/integrity/ima/datafiles/ima_keys/keycheck.policy
> +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_keys/keycheck.policy
> @@ -1 +1 @@
> -measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist template=ima-buf
> +measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_keys/x509_ima.der b/testcases/kernel/security/integrity/ima/datafiles/ima_keys/x509_ima.der
> new file mode 100644
> index 0000000000000000000000000000000000000000..92be058da22adffa9d6b6e51efa0c737ebbbbdcd
> GIT binary patch
> literal 650
> zcmXqLVrnyJVtl`VnTe5!NhJD#vj69`9|BBf8}FEsx@^_9$Clp>c-c6$+C196^D;7W
> zvoaV27z!HjvoVLVaPe?t<QJFZCFZ6YN*hRmgqV4R$}{p4b2Al+Gt=`j^U@WvQ!5SS
> z3}oO&a59SVLzFncG#ki?^BP(jSQr@@7#Ud_7)6Qm8W{k&hEOgIY;2s5>?=lA2Ij_I
> z27|^<rp88wchfeduxmMW^j9qUxkIugeev4q7u7yrJR_rW$*!>VOo=tim8DK0r^FsU
> zl)K`}`+CO4@4KBkoLmcj?fH`%wbDvU<d=4Z>6-SMf6Eh}{&)1rdsOoNQ-1fgBQ1t{
> zVTqGwuK95LlFE)6i{@=vlP6!2`Y}x<BF&oXU_nlDxy@C+CNp&=W=00a#jys_20XwZ
> zl@(@W{LjK<z+k`);_<VvFf*|?7|4P+d@N!tBCNWX-0#?!UAx9s`mgFmW+nI2#6kmk
> zkhC(3gn?Lt$m4W@56wQ)?QVKW<nOtpT)HJrB?Q^`z&K?FdV8b(y8m)~mOOvswu^9m
> z-o7mOwCAzaT*~`Y4wxFtmNA_89`W;j{r#iww*5OC5vgEziqD_%=ki$*`;s}`Pfwi{
> zbotZ0X`ckHOmaVLm85n@E9hN_K;~PUB>DFAzh(;(UoMln9V>g;W#-LUGS7A`nYQKY
> WBem{7L5JThS+;$vggi%(*E;~nlJ80Y
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> index 53c289054..30950904e 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -6,8 +6,8 @@
>   #
>   # Verify that keys are measured correctly based on policy.
>   
> -TST_NEEDS_CMDS="cut grep sed tr xxd"
> -TST_CNT=1
> +TST_NEEDS_CMDS="cmp cut grep sed tr xxd"
> +TST_CNT=2
>   TST_NEEDS_DEVICE=1
>   
>   . ima_setup.sh
> @@ -20,20 +20,22 @@ test1()
>   	local pattern="func=KEY_CHECK"
>   	local test_file="file.txt"
>   
> -	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
> +	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
>   
>   	require_ima_policy_content "$pattern"
>   	keycheck_lines=$(check_ima_policy_content "$pattern" "")
>   	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
>   
>   	if [ -z "$keycheck_line" ]; then
> -		tst_brk TCONF "ima policy does not specify a keyrings to check"
> +		tst_res TCONF "IMA policy does not specify a keyrings to check"
> +		return
>   	fi
>   
>   	keyrings=$(echo "$keycheck_line" | tr " " "\n" | grep "keyrings" | \
>   		sed "s/\./\\\./g" | cut -d'=' -f2)
>   	if [ -z "$keyrings" ]; then
> -		tst_brk TCONF "ima policy has a keyring key-value specifier, but no specified keyrings"
> +		tst_res TCONF "IMA policy has a keyring key-value specifier, but no specified keyrings"
> +		return
>   	fi
>   
>   	templates=$(echo "$keycheck_line" | tr " " "\n" | grep "template" | \
> @@ -49,11 +51,13 @@ test1()
>   
>   		echo "$line" | cut -d' ' -f6 | xxd -r -p > $test_file
>   
> -		expected_digest="$(compute_digest $algorithm $test_file)" || \
> -			tst_brk TCONF "cannot compute digest for $algorithm"
> +		if ! expected_digest="$(compute_digest $algorithm $test_file)"; then
> +			tst_res TCONF "cannot compute digest for $algorithm"
> +			return
> +		fi
>   
>   		if [ "$digest" != "$expected_digest" ]; then
> -			tst_res TFAIL "incorrect digest was found for the ($keyring) keyring"
> +			tst_res TFAIL "incorrect digest was found for $keyring keyring"
>   			return
>   		fi
>   	done
> @@ -61,4 +65,52 @@ test1()
>   	tst_res TPASS "specified keyrings were measured correctly"
>   }
>   
> +# Create a new keyring, import a certificate into it, and verify
> +# that the certificate is measured correctly by IMA.
> +test2()
> +{
> +	tst_require_cmds evmctl keyctl openssl
> +
> +	local cert_file="$TST_DATAROOT/x509_ima.der"
> +	local keyring_name="key_import_test"
> +	local temp_file="file.txt"
> +	local keyring_id
> +
> +	tst_res TINFO "verify measurement of certificate imported into a keyring"
> +
> +	if ! check_ima_policy_content "^measure.*func=KEY_CHECK.*keyrings=.*$keyring_name"; then
> +		tst_brk TCONF "IMA policy does not contain $keyring_name keyring"
> +	fi
> +
> +	keyctl new_session > /dev/null
> +
> +	keyring_id=$(keyctl newring $keyring_name @s) || \
> +		tst_brk TBROK "unable to create a new keyring"
> +
> +	tst_is_num $keyring_id || \
> +		tst_brk TBROK "unable to parse the new keyring id"
> +
> +	evmctl import $cert_file $keyring_id > /dev/null || \
> +		tst_brk TBROK "unable to import a certificate into $keyring_name keyring"
> +
> +	grep $keyring_name $ASCII_MEASUREMENTS | tail -n1 | cut -d' ' -f6 | \
> +		xxd -r -p > $temp_file
> +
> +	if [ ! -s $temp_file ]; then
> +		tst_res TFAIL "keyring $keyring_name not found in $ASCII_MEASUREMENTS"
> +		return
> +	fi
> +
> +	if ! openssl x509 -in $temp_file -inform der > /dev/null; then
> +		tst_res TFAIL "logged certificate is not a valid x509 certificate"
> +		return
> +	fi
> +
> +	if cmp -s $temp_file $cert_file; then
> +		tst_res TPASS "logged certificate matches the original"
> +	else
> +		tst_res TFAIL "logged certificate does not match original"
> +	fi
> +}
> +
>   tst_run
> 

