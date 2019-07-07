Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 276DC6164E
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Jul 2019 21:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfGGTde (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Jul 2019 15:33:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfGGTde (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jul 2019 15:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jU5cEjUtcVYO3EaFU5lWyybUeSozoad8uL7Kr7BLfLM=; b=gb9drmike6oRAXpcP1cYg9E/h
        L/qk0ptX30TDgNFuHLR4AGhKrfBn3QTrfMYf7J8/R6SfcsgC8EBDhVRkAYVokbnjdPYqW+Am4Bsiw
        mbEwPjYMf8iqI37MI5DgNjkfhtG55g6EeWM2IWE24ntmKDiDxBhbLf6EjUVJO2VNNtq7v76E9ekBX
        so5Bz++sxMLYMAzj28hL5zn6FC6xwAqTak5e7uNp0vfS/ofPIooa884l7zevYmDTBlhUgBProdfSU
        a+qbyHJRObWin6sU9Omyyj6IL1TMp51Suyr0r2CpLAN77BskyyQQSfj5O0QoG+lB6MAVyWZb/RkrG
        I3AGMBoug==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkCuh-0003co-Vv; Sun, 07 Jul 2019 19:33:32 +0000
Subject: Re: [PATCH] tpm: Document UEFI event log quirks
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     tweek@google.com, matthewgarrett@google.com,
        Jonathan Corbet <corbet@lwn.net>
References: <20190703161109.22935-1-jarkko.sakkinen@linux.intel.com>
 <6acf78df-b168-14d3-fea4-9a9d2945e77f@infradead.org>
 <a8ee93721a674434e22d31fd1d10bf9472c1c739.camel@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ec274596-6bc8-07a0-d09b-1d191646c5cd@infradead.org>
Date:   Sun, 7 Jul 2019 12:33:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a8ee93721a674434e22d31fd1d10bf9472c1c739.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/5/19 3:15 AM, Jarkko Sakkinen wrote:
> On Wed, 2019-07-03 at 09:45 -0700, Randy Dunlap wrote:
>>> +This introduces another problem: nothing guarantees that it is not
>>> +called before the stub gets to run. Thus, it needs to copy the final
>>> +events table preboot size to the custom configuration table so that
>>> +kernel offset it later on.

     (so that)
     the kernel can use that final table preboot size as an events table
     offset later on.

>>
>> ?  kernel can offset it later on.
> 
> EFI stub calculates the total size of the events in the final events
> table at the time.
> 
> Later on, TPM driver uses this offset to copy only the events that
> were actually generated after ExitBootServices():
> 
> /*
>  * Copy any of the final events log that didn't also end up in the
>  * main log. Events can be logged in both if events are generated
>  * between GetEventLog() and ExitBootServices().
>  */
> memcpy((void *)log->bios_event_log + log_size,
>        final_tbl->events + log_tbl->final_events_preboot_size,
>        efi_tpm_final_log_size);
> 
> What would be a better way to describe this?

Yeah, I think I see what it's doing, how it's using that.
See above.

OK?

-- 
~Randy
