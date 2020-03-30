Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8792198136
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 18:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgC3Q3b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 12:29:31 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36896 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgC3Q3b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 12:29:31 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0E06F20B46F0;
        Mon, 30 Mar 2020 09:29:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E06F20B46F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1585585770;
        bh=VBLOSlyTvBF8+a6X04IrIVbhxucbYbN+ks9wyEvzf34=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=ItzjdJYu1CUfs3TSEMxZwZF93wYX73xqpb1rr+3ZVHLxbuClO84WFGUSduOeOQV7M
         R3JchlDCGIkG3O+bkkaFIQ7yusRFIwFsXm0+/f9Vij9gn7e0HSW+zwmOCMYmTskxaz
         lQc4OBPQsxDtiZSC6G9ebErct13TCeHkqmfKE/DA=
Subject: Re: [PATCH v8 1/2] ima-evm-utils: Add some tests for evmctl
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <20200327042515.22315-1-vt@altlinux.org>
 <20200327042515.22315-2-vt@altlinux.org>
 <f9b36972-df5d-db9a-d840-52e9ff76d271@linux.microsoft.com>
Message-ID: <f6c1766f-20c0-782d-0c3c-a522babd9142@linux.microsoft.com>
Date:   Mon, 30 Mar 2020 09:29:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f9b36972-df5d-db9a-d840-52e9ff76d271@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/30/20 9:16 AM, Lakshmi Ramasubramanian wrote:

> On 3/26/20 9:25 PM, Vitaly Chikunov wrote:
> 
>> Run `make check' to execute the tests.
> 
> autogen.sh followed by configure need to be run. Could you please add 
> that in the patch description?
> 
>> diff --git a/tests/functions.sh b/tests/functions.sh
>> new file mode 100755
>> index 0000000..16c8d89
>> --- /dev/null
>> +++ b/tests/functions.sh
>> @@ -0,0 +1,272 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
> 
> In some source files in the kernel repo I have seen the following:
> 
>      // SPDX-License-Identifier: GPL-2.0+
> 
> Not sure if it is applicable here.
> 
>> +check() {
>> +  local alg=$1 pref=$2 chash=$3 hash
>> +  local file=$alg-hash.txt
>> +
>> +  rm -f $file
>> +  touch $file
>> +  # Generate hash with openssl, if it's failed skip test,
> 
> "if it failed skip test"
> 
>> +  # unless it's negative test, then pass to evmctl
>> +  cmd="openssl dgst $OPENSSL_ENGINE -$alg $file"
>> +}
>> +
> 
>> +# check args: algo hdr-prefix canonic-hash
>> +expect_pass check  md4        0x01 31d6cfe0d16ae931b73c59d7e0c089c0
>> +expect_pass check  md5        0x01 d41d8cd98f00b204e9800998ecf8427e
> Is MD4 and MD5 tests still needed?
> 
> 
>   -lakshmi

+ Mimi and linux-integrity
