Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC211282AF
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2019 20:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLTTYj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Dec 2019 14:24:39 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42402 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfLTTYi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Dec 2019 14:24:38 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id A28A920106BA;
        Fri, 20 Dec 2019 11:24:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A28A920106BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576869877;
        bh=As6dpOsf+0riwLRnC5ZjUILruPScY2eVZszSrSI5Cd8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kUGvvJ6dcrzmRg6yQIHWK+vkBOmQrWBPnG/GWsAmjA6mV1Tj8vVloSBeRF/K83DHQ
         RaliTuE8jI443Po8PE5bFR4GpYgcK1xUl/C+RQvU0TkmtoNexZaFDTYQ2vF/qTKuPN
         6ETCl70BWHtQixoh+of6InLkDFDepaCvIVdvi0sI=
Subject: Re: [PATCH v5 0/2] IMA: Deferred measurement of keys
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191218164434.2877-1-nramas@linux.microsoft.com>
 <1576868506.5241.65.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <589b893b-52e4-783c-0f32-608ed1cfd7f9@linux.microsoft.com>
Date:   Fri, 20 Dec 2019 11:25:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576868506.5241.65.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/20/2019 11:01 AM, Mimi Zohar wrote:

Hi Mimi,

>> If the kernel is built with both CONFIG_IMA and
>> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE enabled then the IMA policy
>> must be applied as a custom policy. Not providing a custom policy
>> in the above configuration would result in asymmeteric keys being queued
>> until a custom policy is loaded. This is by design.
> 
> I didn't notice the "This is by design" here, referring to the memory
> never being freed.  "This is by design" was suppose to refer to
> requiring a custom policy for measuring keys.
> 
> For now, these two patches are queued in the next-integrity-testing
> branch, but I would appreciate your addressing not freeing the memory
> associated with the keys, if a custom policy is not loaded.
> 
> Please note that I truncated the 2/2 patch description, as it repeats
> the existing verification example in commit ("2b60c0ecedf8 IMA: Read
> keyrings= option from the IMA policy").
> 
> thanks,
> 
> Mimi
> 

Sure - I am fine with truncating the 2/2 patch description. Thanks for 
doing that.

Regarding "Freeing the queued keys if custom policy is not loaded":

Shall I create a new patch set to address that and have that be reviewed 
independent of this patch set?

Like you'd suggested earlier, we can wait for a certain time, after IMA 
is initialized, and free the queue if a custom policy was not loaded.

Please let me know.

thanks,
  -lakshmi


