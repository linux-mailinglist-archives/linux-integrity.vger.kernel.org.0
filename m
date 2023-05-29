Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A07714515
	for <lists+linux-integrity@lfdr.de>; Mon, 29 May 2023 08:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjE2Gp0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 May 2023 02:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjE2GpO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 May 2023 02:45:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681EFA4;
        Sun, 28 May 2023 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685342713; x=1716878713;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CARm2alkIYsv+uMBImaHq5Qbxi4vwTSJdHj2kvPFm+A=;
  b=IFjt2I7gQKdvFwzqCUgDQKecFyfEtbCGrYfyLcgOeliQtwrJjIoXPPwP
   KN2fxlrGqGEnh1Ceq8nXAUZLVGimmhRm9JEbSXVH9fbSjCfMLZDOzIgR0
   BCUeJL9as6B7+2pv6zZ25HG2PJFHMRFe/4GJTOd+GORD9E+ToVx2etsr6
   bPs6noxd9iprRlkT243A77p4PRPK7BkYSnPm9dEcKJvUZyXhqyn33iUW8
   vaR9tqD4xXgtZabJjljL8TIWHjAs1qHvuJ5lYLxJIavIKPW+Rur2eYp7i
   gGOkv1atyC1p3EXMi5pa9wy+7bshwSCsdFQ1XIyYKeMsEMEE7j+U+jeRZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="440991636"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="440991636"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="771033579"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="771033579"
Received: from bgrzesko-mobl.ger.corp.intel.com (HELO [10.252.52.205]) ([10.252.52.205])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:45:09 -0700
Message-ID: <a84c447f-cdfb-d33c-62cb-bb5d9aa8510b@linux.intel.com>
Date:   Mon, 29 May 2023 09:46:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Content-Language: en-US
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com, peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
 <da435e0d-5f22-fac7-bc10-96a0fd4c6d54@kunbus.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <da435e0d-5f22-fac7-bc10-96a0fd4c6d54@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lino,

On 23/05/2023 23:46, Lino Sanfilippo wrote:
>> On the other hand any new functionality is objectively a maintanance
>> burden of some measure (applies to any functionality). So how do we know
>> that taking this change is less of a maintenance burden than just add
>> new table entries, as they come up?
>>
> 
> Initially this set was created as a response to this 0-day bug report which you asked me
> to have a look at:
> 
> https://lore.kernel.org/linux-integrity/d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org/
> 
> My hope was that it could also avoid some of (existing or future) DMI entries. But even if it does not
> (e.g. the problem Péter Ujfalusi reported with the UPX-i11 cannot be fixed by this patch set and thus
> needs the DMI quirk) we may at least avoid more bug reports due to interrupt storms once
> 6.4 is released. 

I'm surprised that there is a need for a storm detection in the first
place... Do we have something else on the same IRQ line on the affected
devices which might have a bug or no driver at all?
It is hard to believe that a TPM (Trusted Platform Module) is integrated
so poorly ;)

But put that aside: I think the storm detection is good given that there
is no other way to know which machine have sloppy TPM integration.
There are machines where this happens, so it is a know integration
issue, right?

My only 'nitpick' is with the printk level to be used.
The ERR level is not correct as we know the issue and we handle it, so
all is under control.
If we want to add these machines to the quirk list then WARN is a good
level to gain attention but I'm not sure if a user will know how to get
the machine in the quirk (where to file a bug).
If we only want the quirk to be used for machines like UPX-i11 which
simply just have broken (likely floating) IRQ line then the WARN is too
high level, INFO or even DBG would be appropriate as you are not going
to update the quirk, it is just handled under the hood (which is a great
thing, but on the other hand you will have the storm never the less and
that is not a nice thing).

It is a matter on how this is going to be handled in a long term. Add
quirk for all the known machines with either stormy or plain broken IRQ
line or handle the stormy ones and quirk the broken ones only.

>>> Detect an interrupt storm by counting the number of unhandled interrupts
>>> within a 10 ms time interval. In case that more than 1000 were unhandled
>>> deactivate interrupts, deregister the handler and fall back to polling.
>>
>> I know it can be sometimes hard to evaluate but can you try to explain
>> how you came up to the 10 ms sampling period and 1000 interrupt
>> threshold? I just don't like abritrary numbers.
> 
> At least the 100 ms is not plucked out of thin air but its the same time period
> that the generic code in note_interrupt() uses - I assume for a good reason.
> Not only this number but the whole irq storm detection logic is taken from 
> there: 
> 
>>
>>> This equals the implementation that handles interrupt storms in
>>> note_interrupt() by means of timestamps and counters in struct irq_desc.
>> The number of 1000 unhandled interrupts is still far below the 99900
used in
> note_interrupt() but IMHO enough to indicate that there is something seriously
> wrong with interrupt processing and it is probably saver to fall back to polling.

Except that if the line got the spurious designation in core, the
interrupt line will be disabled while the TPM driver will think that it
is still using IRQ mode and will not switch to polling.

A storm of 1000 is better than a storm of 99900 for sure but quirking
these would be the desired final solution. imho

There are many buts around this ;)

-- 
Péter
