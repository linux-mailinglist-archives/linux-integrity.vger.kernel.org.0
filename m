Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239E473CF45
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jun 2023 10:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjFYIVA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 25 Jun 2023 04:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjFYIU7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 25 Jun 2023 04:20:59 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3398DE5D;
        Sun, 25 Jun 2023 01:20:57 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aed7f.dynamic.kabel-deutschland.de [95.90.237.127])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6C19861E5FE0A;
        Sun, 25 Jun 2023 10:20:23 +0200 (CEST)
Message-ID: <8999a30b-e165-f39d-864a-ce1c559e725d@molgen.mpg.de>
Date:   Sun, 25 Jun 2023 10:20:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: MSI B350M MORTAR: tpm tpm0: AMD fTPM version 0x3005700000004 causes
 system stutter; hwrng disabled
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Mario, dear Jason, dear Linux folks,


Thank you for your great work on the Linux kernel.

On an MSI MS-7A37/B350M MORTAR (MS-7A37) even updating to their latest 
system firmware 1.O7 released on their Web site on May, 23rd 2023 [1].

> Beschreibung:
> -  AGESA ComboAm4v2PI 1.2.0.A. update.
> -  TPM Out of Bounds Access security patch.

But Linux 6.4.-rc7 still disables the hwrng from AMD fTPM.

     Jun 24 21:32:09.978772 tokeiihto kernel: DMI: Micro-Star 
International Co., Ltd. MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.O7 05/09/2023
     […]
     Jun 24 21:32:10.259986 tokeiihto kernel:  tpm tpm0: AMD fTPM 
version 0x3005700000004 causes system stutter; hwrng disabled

Unfortunately, the warning does not say, what firmware version is 
needed, and what the user can do about it.

The comment in the code, added in v6.3-rc2 with commit f1324bbc4011 
(tpm: disable hwrng for fTPM on some AMD designs) [2], says:

     /*
      * Some AMD fTPM versions may cause stutter
      * https://www.amd.com/en/support/kb/faq/pa-410
      *
      * Fixes are available in two series of fTPM firmware:
      * 6.x.y.z series: 6.0.18.6 +
      * 3.x.y.z series: 3.57.y.5 +
      */

Mapping 0x3005700000004 from the Linux warning to the comment, I assume 
the board’s firmware is 3.57.0.4?

What AGESA ComboAm4v2PI would MSI need to ship, so the issue is fixed? 
The previous system firmware version shipped 3.4e.0.4? (Is it decimal or 
hexadecimal?)

     [  282.864564] tpm tpm0: AMD fTPM version 0x3004e00000004 causes 
system stutter; hwrng disabled


Kind regards,

Paul


[1]: https://de.msi.com/Motherboard/B350M-MORTAR/support#bios
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1324bbc4011ed8aef3f4552210fc429bcd616da
