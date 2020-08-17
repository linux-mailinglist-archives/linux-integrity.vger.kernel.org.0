Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104C5245BD1
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 07:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgHQFNZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 01:13:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35462 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHQFNY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 01:13:24 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id F409220B4908;
        Sun, 16 Aug 2020 22:13:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F409220B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597641204;
        bh=qbuxvMsPJpMYhSJpirTpZzrEV8fYC5SSNw37I5HFHHY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Z8tv+g4/pKX1o9EyE6X0xPnN6q/VBNBXBopoovxStJs7AiLf7QnsBJuWUdyTlIy8h
         ihi4AeaXL6OT/irxHIJ8b6S8glbDsq/TWl0XtlwTp/FhtXinA6uUARkEYOTlhDHVFB
         fapN1aM5QAq5/AIkT1mYozAT0NcDt17bSmgJaXRk=
Subject: Re: [PATCH v2 3/4] IMA: Add a test to verify measurement of
 certificate imported into a keyring
To:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
References: <20200807204652.5928-1-pvorel@suse.cz>
 <20200807204652.5928-4-pvorel@suse.cz>
 <25a78f42d15dcb3312a59de587cb9f4e31ccd5b5.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <a537bbdb-1383-48f4-99a5-42ce6d082ddf@linux.microsoft.com>
Date:   Sun, 16 Aug 2020 22:13:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <25a78f42d15dcb3312a59de587cb9f4e31ccd5b5.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/16/20 8:21 PM, Mimi Zohar wrote:

Hi Mimi,

>> +# Create a new keyring, import a certificate into it, and verify
>> +# that the certificate is measured correctly by IMA.
>> +test2()
>> +{
>> +	tst_require_cmds evmctl keyctl openssl
>> +
>> +	local cert_file="$TST_DATAROOT/x509_ima.der"
>> +	local keyring_name="key_import_test"
>> +	local temp_file="file.txt"
>> +	local keyring_id
>> +
>> +	tst_res TINFO "verify measurement of certificate imported into a keyring"
>> +
>> +	if ! check_ima_policy_content "^measure.*func=KEY_CHECK.*keyrings=.*$keyring_name"; then
>> +		tst_brk TCONF "IMA policy does not contain $keyring_name keyring"
>> +	fi
>> +
> 
> If the IMA policy contains multiple KEY_CHECK measurement policy rules
> it complains about "grep: Unmatched ( or \(".
> 
> Sample rules:
> measure func=KEY_CHECK template=ima-buf
> keyrings=.ima|.builtin_trusted_keys
> measure func=KEY_CHECK template=ima-buf keyrings=key_import_test
> 

I tried with the above policy entries, but am unable to reproduce the 
error you are seeing.

ima_keys 1 TINFO: verifying key measurement for keyrings and templates 
specified in IMA policy file
ima_keys 1 TPASS: specified keyrings were measured correctly
ima_keys 2 TPASS: logged cert matches original cert

>> +	keyctl new_session > /dev/null
>> +
>> +	keyring_id=$(keyctl newring $keyring_name @s) || \
>> +		tst_brk TBROK "unable to create a new keyring"
>> +
>> +	tst_is_num $keyring_id || \
>> +		tst_brk TBROK "unable to parse the new keyring id"
>> +
>> +	evmctl import $cert_file $keyring_id > /dev/null || \
>> +		tst_brk TBROK "unable to import a certificate into $keyring_name keyring"
> 
> "cert_file" needs to be updated from
> "ltp/testcases/kernel/security/integrity/ima/tests/datafiles/x509_ima.d
> er" to
> "ltp/testcases/kernel/security/integrity/ima/tests/../datafiles/ima_key
> s/x509_ima.der".
> 

The problem is actually due to missing "x509_ima.der" in 
"INSTALL_TARGETS" in datafiles/keys/Makefile

Adding the following line in the Makefile fixes the problem

INSTALL_TARGETS		:= x509_ima.der

  -lakshmi

> On failure to open the file,
> errno: No such file or directory (2)
> ima_keys 2 TBROK: unable to import a certificate into key_import_test keyring
> ima_keys 2 TINFO: SELinux enabled in enforcing mode, this may affect test results
> ima_keys 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=1 (requires super/root)
> ima_keys 2 TINFO: install seinfo to find used SELinux profiles
> ima_keys 2 TINFO: loaded SELinux profiles: none
> 
> Mimi
> 
>> +
>> +	grep $keyring_name $ASCII_MEASUREMENTS | tail -n1 | cut -d' ' -f6 | \
>> +		xxd -r -p > $temp_file
>> +
>> +	if [ ! -s $temp_file ]; then
>> +		tst_res TFAIL "keyring $keyring_name not found in $ASCII_MEASUREMENTS"
>> +		return
>> +	fi
>> +
>> +	if ! openssl x509 -in $temp_file -inform der > /dev/null; then
>> +		tst_res TFAIL "logged certificate is not a valid x509 certificate"
>> +		return
>> +	fi
>> +
>> +	if cmp -s $temp_file $cert_file; then
>> +		tst_res TPASS "logged certificate matches the original"
>> +	else
>> +		tst_res TFAIL "logged certificate does not match original"
>> +	fi
>> +}
>> +
>>   tst_run
> 

