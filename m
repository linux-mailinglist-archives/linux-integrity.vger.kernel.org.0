Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41F97135EA6
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jan 2020 17:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbgAIQrv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jan 2020 11:47:51 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42460 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbgAIQrv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jan 2020 11:47:51 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id EDBF720B4798;
        Thu,  9 Jan 2020 08:47:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EDBF720B4798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578588470;
        bh=LW9r8q2BLTAvuoOoNc++KjWmbMuRSSbPiPkebfGA588=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oA97qXMRNlJuZjxe0Nn1daIjBuYzhdOG1OJvN7g0EzxuxWeoCW6nIrStONG+aznMH
         q/DbK0L09y2WFd2MW5EFetlXbbV8A6pCEB5w3PfvU9W+6sjySx26clkWylY5Poy80b
         3Hf8Cq88+nKDl5wUrhzbwk8fNCxJKg2L8a0NpkeQ=
Subject: Re: [PATCH v8 0/3] IMA: Deferred measurement of keys
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, arnd@arndb.de, matthewgarrett@google.com,
        sashal@kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20200109024359.3410-1-nramas@linux.microsoft.com>
 <1578546442.5147.37.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <259affae-d579-d7b8-7fff-ff6ef440ac29@linux.microsoft.com>
Date:   Thu, 9 Jan 2020 08:47:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1578546442.5147.37.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/8/20 9:07 PM, Mimi Zohar wrote:

> On Wed, 2020-01-08 at 18:43 -0800, Lakshmi Ramasubramanian wrote:
> 
>> Changelog:
>>
>>    v8
>>
>>    => Rebased the changes to linux-next
>>    => Need to apply the following patch first
>>    https://lore.kernel.org/linux-integrity/20200108160508.5938-1-nramas@linux.microsoft.com/
> 
> Unless you made some other changes, the previous version of this patch
> set is already in next-integrity-testing.  There's no reason to re-
> post these patches again, and definitely not against linux-next.
> 
> Mimi
> 

The change was to integrate the changes from the patch for the CONFIG issue:

https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/commit/?h=next-integrity-testing&id=50a2506e069fc71f4be1bbcc2c5534bf58ed94ab

The following commit needs to be updated to use the new config 
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS instead of 
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE

https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/commit/?h=next-integrity-testing&id=e164a1695a5705c24c897b0bc7e9b97abb0830c8

Please let me know if I can clone next-integrity-testing and make the 
above update. I'll post the updated patch today.

thanks,
  -lakshmi
