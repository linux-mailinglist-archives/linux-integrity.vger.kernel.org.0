Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF0570E042
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 17:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbjEWPUR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbjEWPUQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 11:20:16 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A96130;
        Tue, 23 May 2023 08:20:13 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 59E1E280138CF;
        Tue, 23 May 2023 17:19:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4A91127FF31; Tue, 23 May 2023 17:19:56 +0200 (CEST)
Date:   Tue, 23 May 2023 17:19:56 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, jsnitsel@redhat.com,
        hdegoede@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, p.rosenberger@kunbus.com
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Message-ID: <20230523151956.GB31298@wunner.de>
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
 <20230523074443.GA21236@wunner.de>
 <98f7dc1a-6bed-a66f-650e-10caeb7d0bca@linux.intel.com>
 <4a94b44d-1b51-2656-786e-07bf97063c3f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a94b44d-1b51-2656-786e-07bf97063c3f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 23, 2023 at 12:35:09PM +0300, Péter Ujfalusi wrote:
> In some boot I don't get a print at all and reboot takes
> 2 minutes (tpm timeout), or as it happened now:
> 
> # dmesg | grep tpm
> [    4.306999] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22)
> [    4.325868] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 1
> [    4.325908] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 2
> ...
> [    4.329579] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 91
> [    5.129056] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 1
> ...
> [    5.129561] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 10

This looks like the interrupt line may be floating and any interrupts
you get are probably caused by induced static or something.

Thanks,

Lukas
