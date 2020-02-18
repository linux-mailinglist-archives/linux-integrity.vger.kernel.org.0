Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1E1162D75
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2020 18:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBRRwp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Feb 2020 12:52:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:60182 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgBRRwp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Feb 2020 12:52:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 09:52:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; 
   d="scan'208";a="224215401"
Received: from tstruk-mobl1.jf.intel.com (HELO [10.24.11.30]) ([10.24.11.30])
  by orsmga007.jf.intel.com with ESMTP; 18 Feb 2020 09:52:44 -0800
Subject: Re: Debugging errors with Dell XPS 9560 TPM
To:     Alex Guzman <alex@guzman.io>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org
References: <CAJ7-PMaLw_H8Fc1tyoT95f5EWpS3nvJt1Wx9=xpuiSotJ2h9VA@mail.gmail.com>
 <CAJ7-PMbJ5fiQAj-5QAzAcFW0eMNkxpQSs=r_wUEfED33XZAPDg@mail.gmail.com>
 <1581712162.16860.8.camel@HansenPartnership.com>
 <20200214210203.dgzhkrvagiozezfi@cantor>
 <1581714273.16860.18.camel@HansenPartnership.com>
 <76b24921c76dbc8fe6ea04b44e695d8a5c89a356.camel@guzman.io>
From:   Tadeusz Struk <tadeusz.struk@intel.com>
Autocrypt: addr=tadeusz.struk@intel.com; keydata=
 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
Message-ID: <f5406106-d6dd-6d53-8ddf-a795da5e4657@intel.com>
Date:   Tue, 18 Feb 2020 09:52:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <76b24921c76dbc8fe6ea04b44e695d8a5c89a356.camel@guzman.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/14/20 5:47 PM, Alex Guzman wrote:
> I just tested with 5.6_rc1. The behavior is still present:
> 
> 
> ERROR:tcti:src/tss2-tcti/tcti-device.c:290:tcti_device_receive() Failed
> to read response from fd 3, got errno 1: Operation not permitted 
> ERROR:esys:src/tss2-
> esys/api/Esys_GetCapability.c:307:Esys_GetCapability_Finish() Received
> a non-TPM Error 
> ERROR:esys:src/tss2-
> esys/api/Esys_GetCapability.c:107:Esys_GetCapability() Esys Finish
> ErrorCode (0x000a000a) 
> ERROR: Esys_GetCapability(0xA000A) - tcti:IO failure
> ERROR: Unable to run tpm2_getcap

I tried to reproduce this, but I couldn't. Do you know what version
of TSS are you using, and what is the configuration used to build it.
Could you try to rebuild it with --enable-tcti-device-async=no
and try that.
Thanks,
-- 
Tadeusz
