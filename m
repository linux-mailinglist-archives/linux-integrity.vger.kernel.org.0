Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F4411D851
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 22:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbfLLVLv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 16:11:51 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52650 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730806AbfLLVLu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 16:11:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 464A88EE18E;
        Thu, 12 Dec 2019 13:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576185110;
        bh=yv+HcFhaQIT9rAZ7nFInNgC/snyyLwKN8IuDMxHyfBk=;
        h=In-Reply-To:References:Subject:From:Date:To:CC:From;
        b=RhFXmawa0U2zgCzGKSIRRJRSNVq5buQ59TU3mTXfiGbN9ZJ9dPx7WZ6Utb39OyqTr
         P9D8Pf4tWKAIn3WF3oHUErLxGbZQ719fCx5VVdUjSKWp2Q6j/hude1hbEAGjyMR3qn
         CxzA4cH3t2YVcShy6uV3o23/vJfnItviTjwga5Gw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8tNC8mHn8sfW; Thu, 12 Dec 2019 13:11:50 -0800 (PST)
Received: from [9.232.166.242] (unknown [129.33.253.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 07B058EE0C7;
        Thu, 12 Dec 2019 13:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576185110;
        bh=yv+HcFhaQIT9rAZ7nFInNgC/snyyLwKN8IuDMxHyfBk=;
        h=In-Reply-To:References:Subject:From:Date:To:CC:From;
        b=RhFXmawa0U2zgCzGKSIRRJRSNVq5buQ59TU3mTXfiGbN9ZJ9dPx7WZ6Utb39OyqTr
         P9D8Pf4tWKAIn3WF3oHUErLxGbZQ719fCx5VVdUjSKWp2Q6j/hude1hbEAGjyMR3qn
         CxzA4cH3t2YVcShy6uV3o23/vJfnItviTjwga5Gw=
User-Agent: K-9 Mail for Android
In-Reply-To: <bb256d5a-5c8c-d5ec-5ad2-ddfaf1c83217@intel.com>
References: <157617292787.8172.9586296287013438621.stgit@tstruk-mobl1> <157617293957.8172.1404790695313599409.stgit@tstruk-mobl1> <1576180263.10287.4.camel@HansenPartnership.com> <c3bffb8c-d454-1f53-7f7e-8b65884ffaf6@intel.com> <1576184085.10287.13.camel@HansenPartnership.com> <bb256d5a-5c8c-d5ec-5ad2-ddfaf1c83217@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH =v2 3/3] tpm: selftest: cleanup after unseal with wrong auth/policy test
From:   James Bottomley <James.Bottomley@Hansenpartnership.com>
Date:   Thu, 12 Dec 2019 16:11:42 -0500
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com
CC:     peterz@infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        mingo@redhat.com, jeffrin@rajagiritech.edu.in,
        linux-integrity@vger.kernel.org, will@kernel.org, peterhuewe@gmx.de
Message-ID: <0cfd1aa8-b4d4-4903-a7cc-70191ca842f4@email.android.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On December 12, 2019 4:07:26 PM EST, Tadeusz Struk <tadeusz.struk@intel.com> wrote:
>On 12/12/19 12:54 PM, James Bottomley wrote:
>> Not in the modern kernel resource manager world: anyone who is in the
>> tpm group can access the tpmrm device and we haven't added a
>dangerous
>> command filter like we promised we would, so unless they have
>actually
>> set lockout or platform authorization, they'll find they can execute
>it
>
>The default for the tpm2_* tools with '-T device' switch is to talk to
>/dev/tpm0.
>
>If one would try to run it, by mistake, it would fail with:
>
>$ tpm2_clear -T device
>ERROR:tcti:src/tss2-tcti/tcti-device.c:439:Tss2_Tcti_Device_Init()
>Failed to open device file /dev/tpm0: Permission denied
>
>To point it to /dev/tpmrm0 it would need to be:
>$ tpm2_clear -T device:/dev/tpmrm0

And most other toolkits talk to the tpmrm device because the tpm 1.2 daemon based architecture didn't work so well.  The point is that if tpm2_clear works on your emulator, it likely works on your real tpm, so making the tests safer to run is not unreasonable.

James

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
