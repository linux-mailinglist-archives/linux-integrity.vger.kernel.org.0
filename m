Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8762B70D92A
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 11:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjEWJee (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 05:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbjEWJeY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 05:34:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFB7E54;
        Tue, 23 May 2023 02:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684834455; x=1716370455;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=7PrrEP2po1mUE8S7jR3Uof8Mlc7GiCrzDGOiWsjUZ5s=;
  b=MUOifUnE92R+MYYva/YjZkn/KQ9n42cp/ku+nBWa5XCE/cEJyiX42aFi
   3ysnhlmjwNbUQqRH31D923fPezUoEUgy6vCYmFSe7rxzmLngRmIuYCduw
   w9KOn557akWHos4B7nPROcjXs0Raph3QKnD+A1YG5LBbUS7LMt2cYAxyv
   NGF65xPM9qAd3XQpD5sWfDFIRrxmeJFXvDv9LMNOjUJm28Xjf5kZrbMaf
   /PDg43PZ5HkVv7LuppDx79a2gam9Cc/G7Tn0KRZcOmFKcKU19x1iA1XQR
   J27BcqrOLf5OeMat9HYi2B0+XNDo+BZRlH3ESw4utkejtroXd6ozgrhLR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="342648688"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="342648688"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 02:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="878134951"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="878134951"
Received: from nmkenne1-mobl2.ger.corp.intel.com (HELO [10.252.53.154]) ([10.252.53.154])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 02:34:10 -0700
Message-ID: <4a94b44d-1b51-2656-786e-07bf97063c3f@linux.intel.com>
Date:   Tue, 23 May 2023 12:35:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, jsnitsel@redhat.com,
        hdegoede@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
 <20230523074443.GA21236@wunner.de>
 <98f7dc1a-6bed-a66f-650e-10caeb7d0bca@linux.intel.com>
In-Reply-To: <98f7dc1a-6bed-a66f-650e-10caeb7d0bca@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

sorry for the unwrapped lines...

On 23/05/2023 12:14, Péter Ujfalusi wrote:
> 
> 
> On 23/05/2023 10:44, Lukas Wunner wrote:
>> On Tue, May 23, 2023 at 09:48:23AM +0300, Péter Ujfalusi wrote:
>>> On 22/05/2023 17:31, Lino Sanfilippo wrote:
>> [...]
>>> This looked promising, however it looks like the UPX-i11 needs the DMI
>>> quirk.
>>
>> Why is that?  Is there a fundamental problem with the patch or is it
>> a specific issue with that device?
> 
> The flood is not detected (if there is a flood at all), interrupt stops
> working after about 200 interrupts - in the latest boot at 118th.
> I can check this later, likely tomorrow.

With the patches and this diff:

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 8f4f2cb5520f..6a910d3277d5 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -795,6 +795,7 @@ static void tpm_tis_process_unhandled_interrupt(struct tpm_chip *chip)
 
 	priv->last_unhandled_irq = jiffies;
 
+	pr_warn("[PETER] %s: unhandled_irqs: %d\n", __func__, priv->unhandled_irqs);
 	if (priv->unhandled_irqs > MAX_UNHANDLED_IRQS)
 		tpm_tis_handle_irq_storm(chip);
 }


In some boot I don't get a print at all and reboot takes
2 minutes (tpm timeout), or as it happened now:

# dmesg | grep tpm
[    4.306999] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22)
[    4.325868] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 1
[    4.325908] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 2
...
[    4.329579] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 91
[    5.129056] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 1
...
[    5.129561] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 10

# cat /proc/interrupts | grep tpm
  28:          0          0          0        133  IR-IO-APIC   28-fasteoi   tpm0

Reboot takes in all cases 2 minutes to pass the timeout for the TPM2_CC_SHUTDOWN

-- 
Péter
