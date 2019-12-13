Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B01C11E942
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2019 18:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfLMRbu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Dec 2019 12:31:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40174 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfLMRbu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Dec 2019 12:31:50 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0C6BA20B71AD;
        Fri, 13 Dec 2019 09:31:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C6BA20B71AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576258309;
        bh=K8f1QxAwXDzLq4vB/wOBc1ZmhGBElxdEEuD/7WAuoGk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aDF8A9pPBRvhWqxjVunYKVN/H6/GBV2B4zniutWLU6iqiAKdZpeqdBsQTQsqGPyAi
         jpkmp60+UPv1NEbKt8kBuNhTDIKAsRKiffGLf5cEb+E/W6lzirp+WxLfCTsgkHTz8B
         Qc3hsLbqJHf5es5VFTi5XXxURRHOd2TfKaTp1g3g=
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued
 keys
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
 <20191213171827.28657-3-nramas@linux.microsoft.com>
 <1576257955.8504.20.camel@HansenPartnership.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <39624b97-245c-ed05-27c5-588787aacc00@linux.microsoft.com>
Date:   Fri, 13 Dec 2019 09:31:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576257955.8504.20.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/13/19 9:25 AM, James Bottomley wrote:

Hi James,

> 
> There's no locking around the ima_process_keys flag.  If you get two
> policy updates in quick succession can't this flag change as you're
> processing the second update meaning you lose it because the flag was
> false when you decided to build it for the queue but becomes true
> before you check above whether you need to queue it?
> 
> Note you don't need locking to fix this, you just need to ensure that
> you use the same copy of the flag value for both tests.
> 
> James
> 

Same flag (ima_process_keys) is used for making the queuing decision.

Taking a lock to access ima_process_keys is required only if the flag is 
false. That is handled in ima_queue_key() and ima_process_queued_keys() 
functions.

Queued keys are processed when the first policy update occurs. 
Subsequently, the keys are processed immediately (not queued).

Could you please review those functions in this patch and let me know if 
you see a problem?

thanks,
  -lakshmi

