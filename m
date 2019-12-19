Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16629126773
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2019 17:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfLSQzn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Dec 2019 11:55:43 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36414 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSQzn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Dec 2019 11:55:43 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9CC722010C1D;
        Thu, 19 Dec 2019 08:55:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CC722010C1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576774542;
        bh=so8Lx2f9qiSk/E4NI0zuLpTEaSOcPtfK6N+bkOqOOB4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qLPJLn14e7anO0rCxRsxhWetAEhf5ceGYmYUiNFt/vFImvPItk4dDaGbMUKp+W5TT
         j62KZcJFE9Rz5VOdwEttZ2tvSN7r5472TJCbWOL8P4QGMYSO4hzccTjNJdZkOM0JTE
         U2tzdpO+LfCoT4TfP5gYn/zMKw9ll+d9xrfGHCvU=
Subject: Re: [PATCH v5 1/2] IMA: Define workqueue for early boot "key"
 measurements
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191218164434.2877-1-nramas@linux.microsoft.com>
 <20191218164434.2877-2-nramas@linux.microsoft.com>
 <1576761104.4579.426.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <503845c9-beeb-b520-ec3f-af5fa7d2b91f@linux.microsoft.com>
Date:   Thu, 19 Dec 2019 08:55:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576761104.4579.426.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/19/19 5:11 AM, Mimi Zohar wrote:

> 
> Getting rid of the temporary list is definitely a big improvement.  As
> James suggested, using test_and_set_bit() and test_bit() would improve
> this code even more.  I think, James correct me if I'm wrong, you
> would be able to get rid of both the mutex and "process".
> 
> Mimi

I am not sure if the mutex can be removed.

In ima_queue_key() we need to test the flag and add the key to the list 
as an atomic operation:

  if (!test_bit())
     insert_key_to_list

Suppose the if condition is true, but before we could insert the key to 
the list, ima_process_queued_keys() runs and processes queued keys we'll 
add the key to the list and never process it.

Is there an API in the kernel to test and add an entry to a list 
atomically?

thanks,
  -lakshmi

