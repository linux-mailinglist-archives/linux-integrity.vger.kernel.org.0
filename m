Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E3E11D840
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 22:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfLLVHX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 16:07:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:6822 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730742AbfLLVHX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 16:07:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 13:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; 
   d="scan'208";a="364097914"
Received: from tstruk-mobl1.jf.intel.com (HELO [10.7.196.67]) ([10.7.196.67])
  by orsmga004.jf.intel.com with ESMTP; 12 Dec 2019 13:07:22 -0800
Subject: Re: [PATCH =v2 3/3] tpm: selftest: cleanup after unseal with wrong
 auth/policy test
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        mingo@redhat.com, jeffrin@rajagiritech.edu.in,
        linux-integrity@vger.kernel.org, will@kernel.org, peterhuewe@gmx.de
References: <157617292787.8172.9586296287013438621.stgit@tstruk-mobl1>
 <157617293957.8172.1404790695313599409.stgit@tstruk-mobl1>
 <1576180263.10287.4.camel@HansenPartnership.com>
 <c3bffb8c-d454-1f53-7f7e-8b65884ffaf6@intel.com>
 <1576184085.10287.13.camel@HansenPartnership.com>
From:   Tadeusz Struk <tadeusz.struk@intel.com>
Autocrypt: addr=tadeusz.struk@intel.com; keydata=
 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
Message-ID: <bb256d5a-5c8c-d5ec-5ad2-ddfaf1c83217@intel.com>
Date:   Thu, 12 Dec 2019 13:07:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1576184085.10287.13.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/12/19 12:54 PM, James Bottomley wrote:
> Not in the modern kernel resource manager world: anyone who is in the
> tpm group can access the tpmrm device and we haven't added a dangerous
> command filter like we promised we would, so unless they have actually
> set lockout or platform authorization, they'll find they can execute it

The default for the tpm2_* tools with '-T device' switch is to talk to
/dev/tpm0.

If one would try to run it, by mistake, it would fail with:

$ tpm2_clear -T device
ERROR:tcti:src/tss2-tcti/tcti-device.c:439:Tss2_Tcti_Device_Init()
Failed to open device file /dev/tpm0: Permission denied

To point it to /dev/tpmrm0 it would need to be:
$ tpm2_clear -T device:/dev/tpmrm0

-- 
Tadeusz
