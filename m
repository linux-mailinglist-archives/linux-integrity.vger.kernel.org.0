Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C3E19813B
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 18:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgC3Q34 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 12:29:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37046 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgC3Q34 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 12:29:56 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0A39120B46F0;
        Mon, 30 Mar 2020 09:29:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A39120B46F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1585585795;
        bh=/uE4PNGYDjaWEhSP/18WL1yBhY94x9WBhDaXJf6pNck=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=WBwGnJAsot7BnUhe1kWS4GB2JX37eRYjZsWdMBck2tkBfH71Uu6q3xLUnaVAvu+3L
         RjFh7+kR/NmIQGvCVwXUgWrhPs70jXf7qZW48FuA7sAfb6UG0XcXTvanU+Jl8pxonl
         8tVAxgiTSggPWNUYS5BJq/Zf6a94Y/QgpgKtPNlw=
Subject: Re: [PATCH v8 2/2] ima-evm-utils: Add sign/verify tests for evmctl
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <20200327042515.22315-1-vt@altlinux.org>
 <20200327042515.22315-3-vt@altlinux.org>
 <98cfccc0-2191-6072-aebe-296e6e150e0c@linux.microsoft.com>
Message-ID: <4f2de793-dab2-e3e9-90a6-bf4ef139400f@linux.microsoft.com>
Date:   Mon, 30 Mar 2020 09:29:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <98cfccc0-2191-6072-aebe-296e6e150e0c@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/30/20 9:26 AM, Lakshmi Ramasubramanian wrote:
> On 3/26/20 9:25 PM, Vitaly Chikunov wrote:
> 
>> --- /dev/null
>> +++ b/tests/gen-keys.sh
>> @@ -0,0 +1,97 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
> Should this be "# SPDX-License-Identifier: GPL-2.0+"
> 
>> +# This script leaves test-ca.conf, *.cer, *.pub, *.key files for 
>> sing/verify tests.
>> +# They are never deleted except by `make distclean'.
>> +
>> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
>> new file mode 100755
>> index 0000000..190b23a
>> --- /dev/null
>> +++ b/tests/sign_verify.test
>> @@ -0,0 +1,364 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
> Same comment as above.
> 
>> +# Check that detached signature matches xattr signature
>> +_test_sigfile() {
>> +  local file=$1 attr=$2 file_sig=$3 file_sig2=$4
>> +
>> +  if [ ! -e $file_sig ]; then
>> +    red_always
>> +    echo "evmctl ima_sign: no detached signature $file_sig"
>> +    color_restore
>> +    rm $file
> 
> Should the file be not deleted in case of failure, so that one can check 
> the file manually?
> 
>> +    return $FAIL
>> +  fi
>> +
>> +  _extract_xattr $file $attr $file_sig2
>> +  if ! cmp -bl $file_sig $file_sig2; then
>> +    red_always
>> +    echo "evmctl ima_sign: xattr signature on $file differ from 
>> detached $file_sig"
>> +    color_restore
>> +    rm $file $file_sig $file_sig2
> Same as above - should the files be not deleted in case of failure?
> 
> thanks,
>   -lakshmi

+ Mimi and linux-integrity
