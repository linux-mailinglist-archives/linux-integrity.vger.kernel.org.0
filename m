Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0488233D946
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Mar 2021 17:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbhCPQYF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 12:24:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38518 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbhCPQYD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 12:24:03 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1561F20B26E1;
        Tue, 16 Mar 2021 09:24:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1561F20B26E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1615911842;
        bh=y4Z7ovh3h5VbNC+wfzD4pyuYxRSzFDGiST75RbHzIT0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DoQ0y8Cs5W8kpKV0mV4+wDWxncdLEk+RHTrrnfrLh6pJkBtJHqsJdm2k08GDsQ6Zn
         IrjvWmfn16DSGrUb0H5IHP0ENmRa/ejNKXgbdGd4nDfjJnCJOux8mkDs4BTAy5Fk4y
         O9BD84yQu960er7bqEc0xOp8qYtsh+NmVf4wTLW0=
Subject: Re: [PATCH v2] IMA: Allow only ima-buf template for key measurement
To:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     tusharsu@linux.microsoft.com, ltp@lists.linux.it,
        linux-integrity@vger.kernel.org
References: <20210314233646.2925-1-nramas@linux.microsoft.com>
 <YFC7j4+wA8xorNgu@pevik>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <deeb4320-a064-fd0f-bc1e-8e52be079ff9@linux.microsoft.com>
Date:   Tue, 16 Mar 2021 09:23:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFC7j4+wA8xorNgu@pevik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/16/21 7:07 AM, Petr Vorel wrote:
> Hi Lakshmi, Mimi,
> 
>> ima-buf is the default IMA template used for all buffer measurements.
>> Therefore, IMA policy rule for measuring keys need not specify
>> an IMA template.  But if a template is specified for key measurement
>> rule then it must be only ima-buf.
> 
>> Update keys tests to not require a template to be specified for
>> key measurement rule, but if a template is specified verify it is
>> only ima-buf.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
Thanks Petr.

> 
> Just a double check does it always work without template=ima-buf for all kernel versions?
> Or only for kernels with dea87d0889dd ("ima: select ima-buf template for buffer measurement")
> i.e. v5.11-rc1 or backport?
The above change is required. Prior to this change, template has to be 
specified in the policy, otherwise the default template would be used.

> 
> Also, don't we want to change also keycheck.policy?
> Currently it contains:
> measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
> Do we want to drop template=ima-buf to test the default value? Or have two rules
> (one with template=ima-buf, other w/a?)
Good point.

I will send you the v3 patch - with two rules: one with template=buf and 
other without a template, like the following example:

measure func=KEY_CHECK 
keyrings=.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf

measure func=KEY_CHECK keyrings=.ima|.evm

  -lakshmi

> 
> Mimi, any comment on this?
> 
> Kind regards,
> Petr
> 

