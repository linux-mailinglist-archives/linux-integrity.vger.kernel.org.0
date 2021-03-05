Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E96C32F5BA
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 23:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCEWKd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 17:10:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43618 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCEWKZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 17:10:25 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1F51A20B83EA;
        Fri,  5 Mar 2021 14:10:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F51A20B83EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614982225;
        bh=tS0kZd38cOZYLhiGPqvSavC58Q8S3BMf+o9IS38H8nQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kboBfiBs6sRWbRp8dsjwiDjBIlhxry7KlLF4JwBi6NCs9Tltbf+ECDX/wS8Sf4nWL
         irGUQ2Zcbf0P5D77u03Bv2aAeP63i9oWG+pCAx3l9ZJOLiFW15Xmy6rZPNNlnBj+8V
         DFp+28GLAsIxPB8qqjCU75jhHKLnomrCWJHnJNSw=
Subject: Re: [PATCH] IMA: Allow only ima-buf template for key measurement
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
References: <20210303203254.12856-1-nramas@linux.microsoft.com>
 <YEJZIQqa1arYKwK+@pevik>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <33ba6274-e7ef-27de-b481-5a702136c0df@linux.microsoft.com>
Date:   Fri, 5 Mar 2021 14:10:20 -0800
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

A small change is needed:

In the while loop, for each line of the KEY_CHECK policy, we need to 
check if a "template" is specified, and if it is then verify if it is 
"ima-buf".

> You need to do:
> while read line; do
> 	if ! echo $line | grep -q $template; then
> 		tst_res TCONF "only $template can be specified for $func"
> 		return 1
> 	fi
> done < $TST_TMPDIR/policy.txt
> return 0

Please see the change below:

while read line; do
	if echo $line | grep -q 'template=' && ! echo $line | grep -q $template 
; then
		tst_res TCONF "only $template can be specified for $func"
		return 1
	fi
done < $TST_TMPDIR/policy.txt
return 0

With check_policy_template() moved from ima_setup.sh to ima_keys.sh, the 
test works fine

When the policy contains the following
    measure func=KEY_CHECK keyrings=key_import_test template=ima-buf
    measure func=KEY_CHECK keyrings=.builtin_trusted_keys

the test passes:

ima_keys 1 TINFO: verify key measurement for keyrings and templates 
specified in IMA policy
ima_keys 1 TINFO: keyrings: 'key_import_test|\.builtin_trusted_keys'
ima_keys 1 TINFO: templates: 'ima-buf'
ima_keys 1 TPASS: specified keyrings were measured correctly


But if the policy is changed to below:
    measure func=KEY_CHECK keyrings=key_import_test template=ima-buf
    measure func=KEY_CHECK keyrings=.builtin_trusted_keys template=ima-sig

the test fails as expected.

ima_keys 1 TINFO: verify key measurement for keyrings and templates 
specified in IMA policy
ima_keys 1 TCONF: only template=ima-buf can be specified for func=KEY_CHECK

I'll post the updated patch shortly.

thanks,
  -lakshmi


