Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB073123D9A
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 03:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLRC7o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 21:59:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57032 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfLRC7o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 21:59:44 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id D0DA320106B3;
        Tue, 17 Dec 2019 18:59:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D0DA320106B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576637984;
        bh=Z44wdEIcJtKPFcY3vbh8wsiIFch8YhhPxMzvPWXXNjY=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=ZNbUAdYjtY9qgyFgDaZsasSYZuLl6ChuL25ub8ag3UA0ZP3DGCH3CTxI88c8qErM0
         3g+fTf/eUCEmvAVROLyBjsIaZUfq7GobLfEXufnuCp1YAUtn0udiejKb7LVDOyVF/8
         xU1XvBAUKei+HlozOahrn1Jm5w44Up1xq1lHJGZc=
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued
 keys
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
 <20191213171827.28657-3-nramas@linux.microsoft.com>
 <1576257955.8504.20.camel@HansenPartnership.com>
 <39624b97-245c-ed05-27c5-588787aacc00@linux.microsoft.com>
 <1576423353.3343.3.camel@HansenPartnership.com>
 <1568ff14-316f-f2c4-84d4-7ca4c0a1936a@linux.microsoft.com>
 <1576479187.3784.1.camel@HansenPartnership.com>
 <8844a360-6d1e-1435-db7c-fd7739487168@linux.microsoft.com>
 <1576531022.3365.6.camel@HansenPartnership.com>
 <35a6c241-9a46-2657-51d1-0c04d32a9fae@linux.microsoft.com>
 <f25b7299-1530-2e43-cdf4-2208c82fc768@linux.microsoft.com>
 <152580f3-2a1f-fa33-cc25-f25747a470a5@linux.microsoft.com>
 <1576634499.14900.10.camel@HansenPartnership.com>
 <edda07dc-c615-58f1-5689-4692c3fb3315@linux.microsoft.com>
Message-ID: <95606a84-ea7d-dda2-5ced-7418fe802ecf@linux.microsoft.com>
Date:   Tue, 17 Dec 2019 19:00:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <edda07dc-c615-58f1-5689-4692c3fb3315@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/17/2019 6:44 PM, Lakshmi Ramasubramanian wrote:

>>
>> The direct implication of the comment and the lock dance with the
>> temporary list and the processed flag is that stuff can be added to the
>> ima_keys list after you drop the mutex.  Your explanation in the prior
>> couple of emails says that nothing can be added because the
>> ima_process_keys flag setting prevents it.  If the latter is true, you
>> can simply drop the lock after setting the flag and rely on ima_keys
>> not changing to run it through process_buffer_measurement without
>> needing any of the intermediate list or the processed flag.  If the
>> latter isn't true then any key added to ima_keys after the mutex is
>> dropped is never processed.
>>
>> James

One more scenario needs to be taken care - that still doesn't require a 
temp list, but will need a local flag.

Say, two threads race to call ima_process_queued_keys().
Both find ima_process_keys flag is false.
They now race to take to the lock.
Only the 1st one setting the flag to true should process queued keys.

  -lakshmi

