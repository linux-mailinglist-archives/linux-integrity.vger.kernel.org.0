Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD8BA6DC5
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 18:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfICQQy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 12:16:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:44742 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbfICQQy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 12:16:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 09:16:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="184805065"
Received: from vkuppusa-mobl2.ger.corp.intel.com ([10.252.39.67])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2019 09:16:50 -0700
Message-ID: <3f3ce42707f09eded801ff8543be6aee6ef35cf8.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism
 for supporting AMD's fTPM
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Seunghun Han <kkamagui@gmail.com>,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Sep 2019 19:16:49 +0300
In-Reply-To: <CAHjaAcRPg9-9MXiLH7AfJO6P1k25CSwJrSiuUwzFLwN5Ynr0DQ@mail.gmail.com>
References: <20190830095639.4562-1-kkamagui@gmail.com>
         <20190830095639.4562-3-kkamagui@gmail.com>
         <20190830124334.GA10004@ziepe.ca>
         <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
         <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CC59@ALPMBAPA12.e2k.ad.ge.com>
         <CAHjaAcQu3jOSj0QV3u4GSgnhpkTmJTMqckY_cnuzeTY-HNUWcA@mail.gmail.com>
         <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CD06@ALPMBAPA12.e2k.ad.ge.com>
         <CAHjaAcRPg9-9MXiLH7AfJO6P1k25CSwJrSiuUwzFLwN5Ynr0DQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-09-03 at 18:56 +0900, Seunghun Han wrote:
> Thank you for your notification. I am sorry. I missed it and
> misunderstood Jarkko's idea. So, I would like to invite Matthew
> Garrett to this thread and attach my opinion on that. The problem is
> that command and response buffers are in ACPI NVS area. ACPI NVS area
> is saved and restored by drivers/acpi/nvs.c during hibernation, so
> command and response buffers in ACPI NVS are also handled by nvs.c
> file. However, TPM CRB driver uses the buffers to control a TPM
> device, therefore, something may break.
> 
> I agree on that point. To remove uncertainty and find the solution,
> I read the threads we discussed and did research about two points, 1)
> the race condition and 2) the unexpected behavior of the TPM device.
> 
> 1) The race condition concern comes from unknowing buffer access order
> while hibernation.
> If nvs.c and TPM CRB driver access the buffers concurrently, the race
> condition occurs. Then, we can't know the contents of the buffers
> deterministically, and it may occur the failure of TPM device.
> However, hibernation_snapshot() function calls dpm_suspend() and
> suspend_nvs_save() in order when the system enters into hibernation.
> It also calls suspend_nvs_restore() and dpm_resume() in order when the
> system exits from hibernation. So, no race condition occurs while
> hibernation, and we always guarantee the contents of buffers as we
> expect.
> 
> 2) The unexpected behavior of the TPM device.
> If nvs.c saves and restores the contents of the TPM CRB buffers while
> hibernation, it may occur the unexpected behavior of the TPM device
> because the buffers are used to control the TPM device. When the
> system entered into hibernation, suspend_nvs_save() saved the command
> and response buffers, and they had the last command and response data.
> After exiting from hibernation, suspend_nvs_restore() restored the
> last command and response data into the buffers and nothing happened.
> I realized that they were just buffers. If we want to send a command
> to the TPM device, we have to set the CRB_START_INVOKE bit to a
> control_start register of a control area. The control area was not in
> the ACPI NVS area, so it was not affected by nvs.c file. We can
> guarantee the behavior of the TPM device.
> 
> Because of these two reasons, I agreed on Jarkko's idea in
> https://lkml.org/lkml/2019/8/29/962 . It seems that removing or
> changing regions described in the ACPI table is not natural after
> setup. In my view, saving and restoring buffers was OK like other NVS
> areas were expected because the buffers were in ACPI NVS area.
> 
> So, I made and sent this patch series. I would like to solve this
> AMD's fTPM problem because I have been doing research on TPM and this
> problem is critical for me (as you know fTPM doesn't work). If you
> have any other concern or advice on the patch I made, please let me
> know.

Please take time to edit your responses. Nobody will read that properly
because it is way too exhausting. A long prose only indicates unclear
thoughts in the end. If you know what you are doing, you can put things
into nutshell only in few senteces.

/Jarkko

