Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1488A723803
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 08:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjFFGqL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 02:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjFFGqJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 02:46:09 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9451E40;
        Mon,  5 Jun 2023 23:46:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 919075C01F8;
        Tue,  6 Jun 2023 02:46:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Jun 2023 02:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686033963; x=1686120363; bh=o7SSrfzUD1BBjb2/mMl6Iu/GxXw8/KbK1ba
        shc2GhzQ=; b=1qfSigFL86S7wmKW3fUR6MIG8JuLt06U2MMqP+oj+J833YvXLdL
        hEZPrWpe0dvXsJDxMuh34gW6BXWj1Vuqa41jIt6411gLvAQigKBBkXRHrYGECsNR
        1piyyPWxpfiDFiS3i/TRhGM+Vlh9uwVB/DW92WH+UEgSXXfUrRrJMvDQ0SaC2p3f
        pyy2O++tH8lKvKtdMKVVszaMJiUgKKUMMEuyglQ47otX2c5kalhFfvlKDHBN1d4U
        GBWz9nUX4xtow9del+fh5dlzbxTWonbynyxDQGlRquw17mohfWnSBA8xeXt8pMTU
        MeJiOlYRzRSubbQhbqx1RjUZ+045qXZHTJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686033963; x=1686120363; bh=o7SSrfzUD1BBjb2/mMl6Iu/GxXw8/KbK1ba
        shc2GhzQ=; b=NMU3zfTXDaIqKoyrNUxhq6Js6NchT1l+YFT7SGH7c2ekgoxNjuA
        3RCjjy85jCeIc7RPGK4W7xYyAYClxwpbmeXjna3knG0dtBr8ePoYQzQz3sWjaVM4
        GhONOgyJ7bD/7165PQBuFhHT4mH1Ick31jTS86sqKX9TIU/AaY0n0gEML24btIxG
        yKbgJR4abR7HGOG0EmSMtkILkPuPRMHlB1UwAjaS+gZmz1Ay/GMSPhx/hLrnIehd
        2EDP/mZxEmKOlTw5TzTOolaBow4CE1Br2KdwKEPRsUZpvDidXUeAqtz4oD+/Li4w
        I8C9FD4vbkyxOeJ176Nredvqp9K6Ae1fRtA==
X-ME-Sender: <xms:K9Z-ZFpqnmB0ua5W1fm_RtuMaIYN63way7_zsmQGGOWAR9kcpxPMDg>
    <xme:K9Z-ZHpA7tXM8Her1AoZtM9VP8p2bJjmmZKZeO9cQ5rgt_Lhtjye6pmMKfPPWQiMB
    IS6nU9ndEkOYA>
X-ME-Received: <xmr:K9Z-ZCNoN1ifFyB3HxQNsE9ES2ocBI5F3KJ33khJC9DLbN5869lP9GIKhTKzyn7cyt5B-qMQ0JUPilgQqrITtYzfzzR-TUJYhv8FJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnheple
    ehheduudeugeegjefgheeuudffheevueekgfekueefledtjeetieeutdekkeelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrh
    horghhrdgtohhm
X-ME-Proxy: <xmx:K9Z-ZA41TvY_DozdbifyIfsAOC-sHp5NyXtbkEJGNgW7JGBPbWhsgg>
    <xmx:K9Z-ZE7vImz6UMVDkbqC7thGFxCA9kSz0D6WNpqp9Or13A2XBQX__Q>
    <xmx:K9Z-ZIiUri7RnkXXMIjNsMiqqsDpHl7NFfygaDxB2J8PyvPElbFqyQ>
    <xmx:K9Z-ZBxqi-Keb5giFqUD8V2NP-tAutryKMzMmeKfGiQOpGtomRXugw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 02:46:02 -0400 (EDT)
Date:   Tue, 6 Jun 2023 08:45:53 +0200
From:   Greg KH <greg@kroah.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Message-ID: <2023060606-unlatch-yiddish-a45f@gregkh>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <ZHQIFLWvrWUNMVxb@debian.me>
 <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
 <2b09d2ed-0852-bbc9-b792-aad92235c7fa@gmail.com>
 <03daca5c-e468-8889-4dc2-e625a664d571@alliedtelesis.co.nz>
 <ec5245bd-3103-f0c7-d3ef-85aabb4d4712@alliedtelesis.co.nz>
 <ZH6TIjXeXJVMvSKa@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZH6TIjXeXJVMvSKa@debian.me>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 06, 2023 at 09:00:02AM +0700, Bagas Sanjaya wrote:
> On Tue, Jun 06, 2023 at 01:41:01AM +0000, Chris Packham wrote:
> > 
> > On 2/06/23 16:19, Chris Packham wrote:
> > >
> > > On 2/06/23 16:10, Bagas Sanjaya wrote:
> > >> On 5/29/23 09:37, Chris Packham wrote:
> > >>> On 29/05/23 14:04, Bagas Sanjaya wrote:
> > >>>> On Sun, May 28, 2023 at 11:42:50PM +0000, Chris Packham wrote:
> > >>>>> Hi,
> > >>>>>
> > >>>>> We have an embedded product with an Infineon SLM9670 TPM. After 
> > >>>>> updating
> > >>>>> to a newer LTS kernel version we started seeing the following 
> > >>>>> warning at
> > >>>>> boot.
> > >>>>>
> > >>>>> [    4.741025] ------------[ cut here ]------------
> > >>>>> [    4.749894] irq 38 handler tis_int_handler+0x0/0x154 enabled 
> > >>>>> interrupts
> > >>>>> [    4.756555] WARNING: CPU: 0 PID: 0 at kernel/irq/handle.c:159
> > >>>>> __handle_irq_event_percpu+0xf4/0x180
> > >>>>> [    4.765557] Modules linked in:
> > >>>>> [    4.768626] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.113 #1
> > >>>>> [    4.774747] Hardware name: Allied Telesis x250-18XS (DT)
> > >>>>> [    4.780080] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
> > >>>>> BTYPE=--)
> > >>>>> [    4.787072] pc : __handle_irq_event_percpu+0xf4/0x180
> > >>>>> [    4.792146] lr : __handle_irq_event_percpu+0xf4/0x180
> > >>>>> [    4.797220] sp : ffff800008003e40
> > >>>>> [    4.800547] x29: ffff800008003e40 x28: ffff8000093951c0 x27:
> > >>>>> ffff80000902a9b8
> > >>>>> [    4.807716] x26: ffff800008fe8d28 x25: ffff8000094a62bd x24:
> > >>>>> ffff000001b92400
> > >>>>> [    4.814885] x23: 0000000000000026 x22: ffff800008003ec4 x21:
> > >>>>> 0000000000000000
> > >>>>> [    4.822053] x20: 0000000000000001 x19: ffff000002381200 x18:
> > >>>>> ffffffffffffffff
> > >>>>> [    4.829222] x17: ffff800076962000 x16: ffff800008000000 x15:
> > >>>>> ffff800088003b57
> > >>>>> [    4.836390] x14: 0000000000000000 x13: ffff8000093a5078 x12:
> > >>>>> 000000000000035d
> > >>>>> [    4.843558] x11: 000000000000011f x10: ffff8000093a5078 x9 :
> > >>>>> ffff8000093a5078
> > >>>>> [    4.850727] x8 : 00000000ffffefff x7 : ffff8000093fd078 x6 :
> > >>>>> ffff8000093fd078
> > >>>>> [    4.857895] x5 : 000000000000bff4 x4 : 0000000000000000 x3 :
> > >>>>> 0000000000000000
> > >>>>> [    4.865062] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> > >>>>> ffff8000093951c0
> > >>>>> [    4.872230] Call trace:
> > >>>>> [    4.874686]  __handle_irq_event_percpu+0xf4/0x180
> > >>>>> [    4.879411]  handle_irq_event+0x64/0xec
> > >>>>> [    4.883264]  handle_level_irq+0xc0/0x1b0
> > >>>>> [    4.887202]  generic_handle_irq+0x30/0x50
> > >>>>> [    4.891229]  mvebu_gpio_irq_handler+0x11c/0x2a0
> > >>>>> [    4.895780]  handle_domain_irq+0x60/0x90
> > >>>>> [    4.899720]  gic_handle_irq+0x4c/0xd0
> > >>>>> [    4.903398]  call_on_irq_stack+0x20/0x4c
> > >>>>> [    4.907338]  do_interrupt_handler+0x54/0x60
> > >>>>> [    4.911538]  el1_interrupt+0x30/0x80
> > >>>>> [    4.915130]  el1h_64_irq_handler+0x18/0x24
> > >>>>> [    4.919244]  el1h_64_irq+0x78/0x7c
> > >>>>> [    4.922659]  arch_cpu_idle+0x18/0x2c
> > >>>>> [    4.926249]  do_idle+0xc4/0x150
> > >>>>> [    4.929404]  cpu_startup_entry+0x28/0x60
> > >>>>> [    4.933343]  rest_init+0xe4/0xf4
> > >>>>> [    4.936584]  arch_call_rest_init+0x10/0x1c
> > >>>>> [    4.940699]  start_kernel+0x600/0x640
> > >>>>> [    4.944375]  __primary_switched+0xbc/0xc4
> > >>>>> [    4.948402] ---[ end trace 940193047b35b311 ]---
> > >>>>>
> > >>>>> Initially I dismissed this as a warning that would probably be 
> > >>>>> cleaned
> > >>>>> up when we did more work on the TPM support for our product but we 
> > >>>>> also
> > >>>>> seem to be getting some new i2c issues and possibly a kernel stack
> > >>>>> corruption that we've conflated with this TPM warning.
> > >>>> Can you reproduce this issue on mainline? Can you also bisect to find
> > >>>> the culprit?
> > >>> No the error doesn't appear on a recent mainline kernel. I do still get
> > >>>
> > >>> tpm_tis_spi spi1.1: 2.0 TPM (device-id 0x1B, rev-id 22)
> > >>> tpm tpm0: [Firmware Bug]: TPM interrupt not working, polling instead
> > >>> tpm tpm0: A TPM error (256) occurred attempting the self test
> > >>>
> > >>> but I think I was getting that on v5.15.110
> > >>>
> > >> I repeat: Can you bisect between v5.15 and v5.15.112?
> > >
> > > It's definitely between v5.15.110 and v5.15.112.
> > >
> > > I'll do a proper bisect next week but I'm pretty sure it's related to 
> > > the "tpm, tpm_tis:" series. The problem can be worked around by 
> > > removing the TPM interrupt from the device tree for the board.
> > 
> > Bisecting between v5.15.110 and v5.15.112 points to
> > 
> > 51162b05a44cb5d98fb0ae2519a860910a47fd4b is the first bad commit
> 
> Thanks for the bisection.
> 
> Lino, it looks like this regression is caused by (backported) commit of yours.
> Would you like to take a look on it?
> 
> Anyway, telling regzbot:
> 
> #regzbot introduced: 51162b05a44cb5

There's some tpm backports to 5.15.y that were suspect and I'll look
into reverting them and see if this was one of the ones that was on that
list.  Give me a few days...

thanks,

greg k-h
