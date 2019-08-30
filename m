Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6391A3F9B
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 23:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfH3VUz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 17:20:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:33549 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbfH3VUy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 17:20:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 14:20:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="265437774"
Received: from tstruk-mobl1.jf.intel.com ([10.24.8.137])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2019 14:20:54 -0700
Subject: Re: TPM 2.0 Linux sysfs interface
To:     Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     =?UTF-8?Q?Piotr_Kr=c3=b3l?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
 <20190827010559.GA31752@ziepe.ca> <1567007592.6115.58.camel@linux.ibm.com>
 <20190828161502.GC933@ziepe.ca>
From:   Tadeusz Struk <tadeusz.struk@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tadeusz.struk@intel.com; prefer-encrypt=mutual; keydata=
 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
 FheFfUJaD4iEjuL98uUjS/AI
Message-ID: <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
Date:   Fri, 30 Aug 2019 14:20:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828161502.GC933@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/28/19 9:15 AM, Jason Gunthorpe wrote:
>>> So exposing PCRs and things through sysfs is not going to happen.
>>>
>>> If you had some very narrowly defined things like version, then
>>> *maybe* but I think a well defined use case is needed for why this
>>> needs to be sysfs and can't be done in C as Jarkko explained.
>> Piotr's request for a sysfs file to differentiate between TPM 1.2 and
>> TPM 2.0 is a reasonable request and probably could be implemented on
>> TPM registration.
>>
>> If exposing the PCRs through sysfs is not acceptable, then perhaps
>> suggest an alternative.
> Use the char dev, this is exactly what is is for.

What about a new /proc entry?
Currently there are /proc/cpuinfo, /proc/meminfo, /proc/slabinfo...
What about adding a new /proc/tpminfo that would print info like
version, number of enabled PCR banks, physical interface [tis|crb],
vendor, etc.

Thanks,
-- 
Tadeusz
