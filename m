Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2352610EF64
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 19:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfLBSj1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 13:39:27 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51038 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfLBSj1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 13:39:27 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 09B1D20B7185;
        Mon,  2 Dec 2019 10:39:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09B1D20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575311966;
        bh=wg913gH9ZJLPwcHiC0YhT9cCRRz7LfaWFv/LBba+5cY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sdKmUrTf4ECy39T2kUyLJATwkpHu2Ozq5rgsJul1R1hrnx7vb1qdrPep41kqc6wHD
         xPpOCnRpm9hmQJtwQoccDZ60XREF7nUYx7Eb4fgeZwnAFOUugqJTWILFaalrDN9Yb6
         MVIOyvZCzhwd8KYYbr9KDS/z7uckQyfy0Tpe6BGg=
Subject: Re: [PATCH v0 1/2] IMA: Defined queue functions
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Janne Karhunen <janne.karhunen@gmail.com>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
 <20191127025212.3077-2-nramas@linux.microsoft.com>
 <1574887137.4793.346.camel@linux.ibm.com>
 <ea2fafb8-a97f-5365-debd-d90143e549bf@linux.microsoft.com>
 <1575309622.4793.413.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <6ec16f9d-b4f4-bb85-3496-be110fa68f6b@linux.microsoft.com>
Date:   Mon, 2 Dec 2019 10:39:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1575309622.4793.413.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/2/19 10:00 AM, Mimi Zohar wrote:

> 
> ima_update_policy() is called from multiple places.  Initially, it is
> called before a custom policy has been loaded.  The call to
> ima_process_queued_keys_for_measurement() needs to be moved to within
> the test, otherwise it runs the risk of dropping "key" measurements.

static const struct file_operations ima_measure_policy_ops = {
	.release = ima_release_policy,
};

ima_update_policy() is called from ima_release_policy() function.

On my test machine I have the IMA policy in /etc/ima/ima-policy file. 
When IMA policy is setup from this file, I see ima_release_policy() 
called (which in turn calls ima_update_policy()).

How can I have ima_update_policy() called before a custom policy is loaded?

If CONFIG_IMA_WRITE_POLICY is enabled, IMA policy can be updated at 
runtime - which would invoke ima_update_policy().

Is there any other way ima_update_policy() can get called?

> All the queued keys need to be processed at the same time.  Afterwards
> the queue should be deleted.  Unfortunately, the current queue locking
> assumes ima_process_queued_keys_for_measurement() is called multiple
> times.

When ima_process_queued_keys_for_measurement() is called the first time, 
the flag ima_process_keys_for_measurement is set to true and all queued 
keys are processed at that time.

The queue is not used after this point - In the IMA hook the key is 
processed immediately when ima_process_keys_for_measurement is set to true.

ima_process_queued_keys_for_measurement() can be called multiple times, 
but on 2nd and subsequent calls it will be a NOP.

> 
> Perhaps using the RCU method of walking lists would help.  I need to
> think about it some more.
> 
> Mimi

Please let me know how using RCU method would help.

thanks,
  -lakshmi


