Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADCA3E4BC4
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 20:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhHISDF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 14:03:05 -0400
Received: from smtp2.axis.com ([195.60.68.18]:32087 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232642AbhHISDB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 14:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1628532161;
  x=1660068161;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BAbSpS9w1mb8jC0QX4qPtgQN+0VrGOBi0Yz/oH4kaGk=;
  b=YY8PvX1jrekqd/1mEnjIsAWbHhO2WJlLAGQK5NcMy9PSRGCFVunsfg7C
   mqIbwbYYOyA3Wy+OmVu9QQaWyIO2jPbtr6Z9l9E0hEtXjwyjiWHX+scJE
   IdTGItMmKvW44L5mDWGTQlTEucffoR1feVO2hHdThX0NmS4RxYwcCTG8K
   wBJGO1VQNwkI5mNR2w4upFtmqyO/L1NZrLHjHFTO3y2gboH7QQqdRyUlV
   OE9AMel2ECdCO1lgNQqiv+dfJ03i6OaKfzCnkP4junh5s/+L+3i7cVX7Q
   cjAFbpTQ+wMkkSn4dhBvX+Pem5iZIAx2RZbt9ZWZNmgVaiNoJpNDFf20q
   g==;
Subject: Re: [PATCH v4] tpm: Add Upgrade/Reduced mode support for TPM2 modules
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Borys Movchan <Borys.Movchan@axis.com>
CC:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        kernel <kernel@axis.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210806141808.6537-1-borysmn@axis.com>
 <20210809045529.wz54przgpqgjs67q@kernel.org>
From:   Borys Movchan <borysmn@axis.com>
Message-ID: <36bc0c9d-d34a-9711-7d14-69d23993da57@axis.com>
Date:   Mon, 9 Aug 2021 20:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809045529.wz54przgpqgjs67q@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail08w.axis.com (10.20.40.14) To se-mail07w.axis.com
 (10.20.40.13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 8/9/21 6:55 AM, Jarkko Sakkinen wrote:
> On Fri, Aug 06, 2021 at 04:18:08PM +0200, Borys Movchan wrote:
>> If something went wrong during the TPM firmware upgrade, like power
>> failure or the firmware image file get corrupted, the TPM might end
>> up in Upgrade or Failure mode upon the next start. The state is
>> persistent between the TPM power cycle/restart.
>>
>> According to TPM specification:
>>  * If the TPM is in Upgrade mode, it will answer with TPM2_RC_UPGRADE
>>    to all commands except Field Upgrade related ones.
>>  * If the TPM is in Failure mode, it will allow performing TPM
>>    initialization but will not provide any crypto operations.
>>    Will happily respond to Field Upgrade calls.
>>
>> Change the behavior of the tpm2_auto_startup(), so it detects the active
>> running mode of the TPM.  It is easy to determine that TPM is in Upgrade
>> mode by relying on the fact that tpm2_do_selftest() will return
>> TPM2_RC_UPGRADE. In such a case, there is no point to finish the
>> start-up procedure as the TPM will not accept any commands, except
>> firmware upgrade related.
>>
>> On the other hand, if the TPM is in Failure mode, it will successfully
>> respond to both tpm2_do_selftest() and tpm2_startup() calls. Although,
>> will fail to answer to tpm2_get_cc_attrs_tbl(). Use this fact to
>> conclude that TPM is in Failure mode.
>>
>> If the chip is in the Upgrade or Failure mode, the function returns -EIO
>> error code.
>>
>> The return value is checked in the tpm_chip_register() call to determine
>> the state of the TPM. If the TPM is not in normal operation mode, set
>> the `limited_mode` flag. If the flag is set then the TPM is not able to
> Nit: do not use hyphens for limited mode. 'limited_mode' is fine. I'm
> also fine with just limited_mode.


Done


>> provide any crypto functionality.  Correspondignly, the calls to
>> tpm2_get_cc_attrs_tbl(), tpm_add_hwrng() and tpm_get_pcr_allocation()
>> will fail. Use the flag to exclude them from the initialization
>> sequence.
> This is blacklisting. E.g. I'm not sure why all of the sysfs attributes
> would still be exported. Some of them use TPM commands. That was just
> one random example I came up with.
>
> It's easy to come up other examples, like, why you provide still tpmrm0,
> which is dependent on a TPM running normal mode?
>
> This misses completely the rationale for ever acking this change: which
> parts of the uapi are export and *why*.
>
> Please whitelist the things that should still work. Even the obvious
> ones like /dev/tpm0 (because of TPM_RC_UPGRADE).
>
> This is clearly a faulty and incomplete patch in its current form.


I expected something like this. In new patch version I tried to disable all
functionality which should not work in Upgrade/Failure mode.

Basically, I am interested in getting /dev/tpm0 working when TPM is in limited mode.
In this state, the TPM is not capable to provide any other functionality except firmware
upgrade/recovery. So the rest of features should be disabled/removed.
Physical reset of the TPM is mandatory part of the firmware upgrade/recovery. Which will
lead to driver rebind/reload and reappearance of all interfaces applicable to normal operational
mode.


> /Jarkko
>

Kind regards,
Borys

