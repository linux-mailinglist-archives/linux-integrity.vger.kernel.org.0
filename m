Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB676530F49
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiEWLZ0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 07:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiEWLZZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 07:25:25 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C034D61B;
        Mon, 23 May 2022 04:25:22 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 61A882223A;
        Mon, 23 May 2022 13:25:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1653305118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsXq3th7KqpBvPTEbSWU6wXjcgL9YnnmXPhc+v/K/h4=;
        b=rwIFeJ5bAtimtL42sR4L5KB9hlq0ZYeY0eBYD4mmSfA6AnR2fL3qds3NkJyNhwkxmQaXIE
        dZWeRzb4f5/OwjeD1WFK1d/Jr1mMyEqmqTrgBmcUcP880Y0q7S1BEU5ThREYuHUc4Q412K
        abGZxDI0lFp10gGOBsZLV1NQkRe4eqk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 May 2022 13:25:16 +0200
From:   Michael Walle <michael@walle.cc>
To:     Paul Barker <paul.barker@sancloud.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Stuart Rubin <stuart.rubin@trustiphi.com>
Subject: Re: Sending vendor specific commands to spi-nor flash
In-Reply-To: <821b7140-abb0-17d2-4aab-07247a250e9c@sancloud.com>
References: <416958ee-c2df-0981-8c77-298561d09381@sancloud.com>
 <418e465f5156adb340976bac209539f8@walle.cc>
 <821b7140-abb0-17d2-4aab-07247a250e9c@sancloud.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9b85e0336f11fc6d4aa66f991ce9b9a9@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[+ linux-security-module, linux-integrity, sorry if these are the
wrong MLs, but I don't have any experiences with crypto]

Am 2022-05-23 12:02, schrieb Paul Barker:
> On 23/05/2022 09:31, Michael Walle wrote:
>> Am 2022-05-18 14:32, schrieb Paul Barker:
>>> We're looking to add support for sending vendor specific commands to
>>> Micron Authenta flash devices over the SPI bus.
>> 
>> Please elaborate a bit more on the use case. Is this something 
>> specific
>> to the flash or is it more of a general feature?
> 
> The Authenta flash devices support two groups of vendor-specific 
> commands:
> 
> 1) "Advanced Sector Protection" commands, common to several Micron
> parts. These include volatile & non-volatile lock bits, password
> protection and a global freeze bit.

Parts of that isn't really specific to Micron, is it? Sounds like
a per sector locking. AFAIR Tudor was working on advanced sector
protection.

> 2) "Authenticated Core Root of Trust for Measurement (A-CRTM)"
> commands, specific to Authenta flash devices. These include
> authenticated write operations where the data to be written must be
> signed with a cryptographic key and measurement operations which allow
> remote attestation of the contents of the flash. These features
> interact with the cloud-based Authenta Key Management Service (KMS)
> provided by Micron and user-controlled cryptographic keys can also be
> supported for these devices.
> 
> To make use of these features vendor-specific commands are sent to the
> flash device. We expect to send these commands during the boot process
> and during the process of securely deploying a new software image to
> the flash device.
> 
> Brief information on the Authenta features is available as a PDF [1].
> 
> [1]:
> https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/mt25q_a_crtm_rpmc_addendum_rev_1_6_brief.pdf
> 
> 
>> 
>>> Since we're using the
>>> MTD block interface to support a filesystem on the SPI flash we need
>>> to send these vendor specific commands via some sort of IOCTL.
>>> 
>>> I can see a couple of ways to achieve this (as follows) and would 
>>> like
>>> to get some feedback from the MTD & spi-nor maintainers on which
>>> approach is preferred:
>>> 
>>> 1) Add new IOCTLs to the mtdchar device to support these vendor
>>> specific operations. An initial set of patches was sent back in
>>> October 2021 which took this route [1], but no further progress was
>>> made. The new IOCTLs would exist for all mtdchar devices (regardless
>>> of vendor) if we go this route and we'd need to ensure -EINVAL or
>>> -ENOTSUPP is returned as appropriate if these IOCTLs are called on a
>>> device which does not implement them.
>>> 
>>> 2) Add a vendor-specific IOCTL layer to the mtdchar device interface.
>>> When the mtdchar IOCTL handler is called with a command not defined 
>>> in
>>> mtdchar.c, pass the call on to a device-specific IOCTL handler which
>>> can potentially handle vendor specific commands.
>>> 
>>> 3) Add a generic SPI transfer IOCTL for spi-nor MTD devices. This
>>> would avoid the need to define IOCTLs for every vendor specific
>>> command supported by SPI flash devices. Instead, knowledge of the
>>> vendor specific commands would be kept in userspace and the kernel
>>> would simply provide an API for sending & receiving arbitrary bytes
>>> over the SPI bus. This is similar to the MMC_IOC_CMD IOCTL supported
>>> by the MMC driver.
>>> 
>>> My preference would be for option (3) since it minimizes the scope of
>>> the changes we need to make in the kernel. We're not tied to this
>>> though, so let us know if a different option is preferred.
>> 
>> I'm not sure we should allow a generic "issue anything to the spi
>> flash". It it is just a one time thing, like for example, program
>> a password during production, or program non-volatile memory during
>> production of the board, I'm fine with it. Most probably, calling
>> that ioctl will also call add_taint(). This will also need to go
>> with proper userspace util support.
>> 
>> But if it is something for general use, please provide a proper API
>> and don't write userspace drivers.
> 
> I've been looking at how the eMMC/SD and NVMe drivers support passing
> through vendor specific commands using MMC_IOC_CMD for eMMC/SD and
> NVME_IOCTL_ADMIN_CMD/NVME_IOCTL_IO_CMD for NVMe. Neither of these
> ioctl handlers appear to call add_taint().

I don't know the use case for MMC/NVMe, but until you convince me
otherwise, I see "sending raw commands to the SPI flash" as something
exceptional, and thus you'd taint the kernel.

> For A-CRTM operations, in our current use case the command bytes to be
> sent over the SPI bus to the flash device are sent from a cloud-based
> service to a userspace agent on the device. The agent simply needs a
> way to pass these command bytes over the SPI bus to the device and
> retrieve the sequence of response bytes to send back to the
> cloud-based service. For this we could use either a generic SPI
> transfer IOCTL or a Micron specific A-CRTM command IOCTL.
> 
> For the Advanced Sector Protection commands we can add IOCTLs for each
> command if that's the preferred approach. The command list can be seen
> on page 35 of the datasheet for the MT25QL02GCBB spi-nor flash device
> [2] and on other Micron flash device datasheets.

This doesn't sound like a proper abstraction to me. Again, the per
sector lock protection should be integrated into the current locking
ioctls. Regarding the security commands, I'm afraid I can't help
you on that point, but it sounds like bypassing the kernel is the
wrong thing to do.

-michael

> 
> [2]:
> https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_l_02g_cbb_0.pdf
> 
> We're happy to look at extending libmtd and/or mtd-utils to wrap any
> IOCTLs added to the drivers. Would that provide the proper API you're
> looking for?
> 
> Thanks,
