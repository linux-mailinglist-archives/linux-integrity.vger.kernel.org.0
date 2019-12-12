Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166D911D8F0
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 22:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfLLV7i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 16:59:38 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48162 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfLLV7i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 16:59:38 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9B1D120B7187;
        Thu, 12 Dec 2019 13:59:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B1D120B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576187977;
        bh=Y9Ia1uhAwwdt2/y4b2PdNeomp16sm0N1Qu1cAFv7fSk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FU9Q2wyf7nNhxOjtT5IYizTDNqX1dmscLVC6mRe5Qw2DTXgm1Ve6622U8GntPorMc
         l5MTV79TxG3Wwo4nG/xHx/t5BIjG5FfrW1YipvcJnuXD7HJgv/8bY9dpp7awwhOlXJ
         2VKkAyRxQ/WF6WnJwS7Z8feLgzSD6Iq5VOwZn8wo=
Subject: Re: [PATCH v2 1/2] IMA: Define workqueue for early boot "key"
 measurements
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191211185116.2740-1-nramas@linux.microsoft.com>
 <20191211185116.2740-2-nramas@linux.microsoft.com>
 <1576138743.4579.147.camel@linux.ibm.com>
 <0cc15a43-8e1b-9819-33fe-8325068f8df2@linux.microsoft.com>
 <1576185189.4579.165.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b4ff3607-076e-7b90-24d1-9a129d9ce720@linux.microsoft.com>
Date:   Thu, 12 Dec 2019 13:59:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576185189.4579.165.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/12/19 1:13 PM, Mimi Zohar wrote:

> 
> Looking at this again, something seems off or at least the comment
> doesn't match the code.
> 
>         /*
>           * To avoid holding the mutex while processing queued keys,
>           * transfer the queued keys with the mutex held to a temp list,
>           * release the mutex, and then process the queued keys from
>           * the temp list.
>           *
>           * Since ima_process_keys is set to true above, any new key will
>           * be processed immediately and not queued.
>           */
> 
> Setting ima_process_key before taking the lock won't prevent the race.
>   I think you want to test ima_process_keys before taking the lock and
> again immediately afterward taking the lock, before setting it.  Then
> the comment would match the code.
> 
> Shouldn't ima_process_keys be defined as static to limit the scope to
> this file?
> 
> Mimi
> 

In IMA hook, ima_process_key is checked without lock. If it is false, 
ima_queue_key is called. If the key was queued (by ima_queue_key()) then 
the hook defers measurement. Else, it processes it immediately.

In ima_queue_key() function the check for ima_process_key is done after 
taking the lock and the key queued if the flag is false.

In ima_process_keys() ima_process_key is set without lock and then the 
queued keys are moved to a temp list after taking the lock.

I have reviewed the changes myself and also with a few of my colleagues. 
I don't think there is a race condition. Please let me know if you do 
see a problem.

I can move the setting of ima_process_key flag inside the lock. But 
honestly I don't think that is necessary.

I agree that ima_process_keys should be static since it is used in this 
file one. I'll make that change.

I can also move the setting of ima_process_key flag inside the lock 
along with the above change.

thanks,
  -lakshmi
