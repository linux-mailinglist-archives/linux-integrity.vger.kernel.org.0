Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478AD1F41A1
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2020 19:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbgFIRAy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Jun 2020 13:00:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45178 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731252AbgFIRAy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jun 2020 13:00:54 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8740B20B717B;
        Tue,  9 Jun 2020 10:00:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8740B20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591722053;
        bh=eHqftMUsYLvGMdmTnyPr8237agaQbFw3GmsqdWzzSEI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QFNe6S3sAJRGrAyO/dmtBvFD5IVr/ErIwOycCD37C77Bcyy7Ke8pVwuMbfDVs9hIc
         qREtSaDGXeXQZr0PSrMIFQIUlyuBqEJY0VNGXIml0CkioWd7Dnq9OttoCW12c/X+RM
         C4hj9MsS9FZ1B0BOp3FcvoX07Cs36QrygHqkJjso=
Subject: Re: [PATCH v3] IMA: Add audit log for failure conditions
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     linux-audit@redhat.com, zohar@linux.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200608215343.4491-1-nramas@linux.microsoft.com>
 <27448076.Og45N0Lxmj@x2>
 <ada45440-aefd-a4b2-2a3b-c012872e86cb@linux.microsoft.com>
 <3776526.Vj75JV9fuy@x2>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <518a51b7-6c8d-f55f-c73a-b15abae8e0af@linux.microsoft.com>
Date:   Tue, 9 Jun 2020 10:00:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3776526.Vj75JV9fuy@x2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/9/20 9:43 AM, Steve Grubb wrote:

>> The number in parenthesis is the error code (such as ENOMEM, EINVAL,
>> etc.) IMA uses this format for reporting TPM errors in one of the audit
>> messages (In ima_add_template_entry()). I followed the same pattern.
>>
>> Would it be better if the value for "cause" is formatted as
>>
>>      cause=hashing_error_-22
>>
>>      cause=alloc_entry_-12
> 
> Neither fit the name=value style that all other events follow. What would fit
> the style is something like this:
> 
> cause=hashing_error  errno=-22
>   
> cause=alloc_entry errno=-12
> 
> Would this be OK? Also, errno is only to illustrate. You can name it
> something else as long as there are no use case collisions with our
> dictionary of field names.
> 
> https://github.com/linux-audit/audit-documentation/blob/master/specs/fields/
> field-dictionary.csv

I am fine with this.

"errno" is currently not listed in the dictionary of audit message field 
names (Thanks for the pointer to this one Steve)

Mimi - please let me know if you have any concerns with adding the 
"result" code in "errno" field in integrity_audit_msg().

Sample message:

[    8.051937] audit: type=1804 audit(1591633422.365:8): pid=1 uid=0 
auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
op=measuring_keys cause=hashing_error errno=-22 comm="systemd" 
name=".builtin_trusted_keys" res=0

thanks,
  -lakshmi

