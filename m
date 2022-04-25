Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A040450E1D9
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Apr 2022 15:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbiDYNeH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Apr 2022 09:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242143AbiDYNeA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Apr 2022 09:34:00 -0400
X-Greylist: delayed 523 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 06:30:33 PDT
Received: from ithil.bigon.be (ithil.bigon.be [IPv6:2001:bc8:25f1:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F504BE2F
        for <linux-integrity@vger.kernel.org>; Mon, 25 Apr 2022 06:30:25 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id 08D971FCDF
        for <linux-integrity@vger.kernel.org>; Mon, 25 Apr 2022 15:21:45 +0200 (CEST)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id V88AKyXsYCv3 for <linux-integrity@vger.kernel.org>;
        Mon, 25 Apr 2022 15:21:44 +0200 (CEST)
Received: from [IPV6:2a02:a03f:65c9:ec00:67d5:9dce:890f:485e] (unknown [IPv6:2a02:a03f:65c9:ec00:67d5:9dce:890f:485e])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA
        for <linux-integrity@vger.kernel.org>; Mon, 25 Apr 2022 15:21:44 +0200 (CEST)
Message-ID: <c3ad6b7c-7dc1-7308-dc47-bed5354bfce8@debian.org>
Date:   Mon, 25 Apr 2022 15:21:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Laurent Bigonville <bigon@debian.org>
Subject: tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
To:     linux-integrity@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

I'm coming back to a problem I've on an old machine that has a TPM 1.2 chip.

We already had an exchange of mail on this mailing list about a (few) 
year(s) ago, but the problem still exist on 5.17 on debian unstable

[    1.071637] tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
[    1.071694] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G I       
5.17.0-1-amd64 #1  Debian 5.17.3-1
[    1.071697] Hardware name: System manufacturer System Product 
Name/P6T DELUXE V2, BIOS 0406    04/24/2009
[    1.071699] Call Trace:
[    1.071702]  <TASK>
[    1.071705]  dump_stack_lvl+0x48/0x5e
[    1.071711]  tpm_tis_status.cold+0x19/0x20
[    1.071714]  wait_for_tpm_stat+0xf7/0x200
[    1.071718]  ? get_page_from_freelist+0xc33/0xf10
[    1.071722]  ? tpm_tcg_read_bytes+0x30/0x50
[    1.071725]  tpm_tis_send_data+0x90/0x250
[    1.071728]  tpm_tis_send_main+0x2e/0xf0
[    1.071731]  ? __mod_node_page_state+0x7c/0xb0
[    1.071733]  tpm_transmit+0xd6/0x3e0
[    1.071737]  tpm_transmit_cmd+0x25/0x90
[    1.071739]  tpm2_probe+0xe2/0x140
[    1.071742]  tpm_tis_core_init+0x2d0/0x330
[    1.071745]  ? tpm_tis_init.part.0+0x120/0x120
[    1.071747]  tpm_tis_pnp_init+0xe2/0x110
[    1.071750]  pnp_device_probe+0xb0/0x140
[    1.071754]  really_probe+0x1f5/0x3d0
[    1.071758]  __driver_probe_device+0xfe/0x180
[    1.071761]  driver_probe_device+0x1e/0x90
[    1.071763]  __driver_attach+0xc0/0x1c0
[    1.071766]  ? __device_attach_driver+0xe0/0xe0
[    1.071768]  ? __device_attach_driver+0xe0/0xe0
[    1.071771]  bus_for_each_dev+0x78/0xc0
[    1.071774]  bus_add_driver+0x149/0x1e0
[    1.071777]  driver_register+0x8f/0xe0
[    1.071780]  ? tpm_init+0xf1/0xf1
[    1.071783]  init_tis+0x9b/0xde
[    1.071786]  ? driver_register+0xc2/0xe0
[    1.071789]  do_one_initcall+0x44/0x200
[    1.071794]  kernel_init_freeable+0x21b/0x282
[    1.071798]  ? rest_init+0xd0/0xd0
[    1.071801]  kernel_init+0x16/0x120
[    1.071803]  ret_from_fork+0x22/0x30
[    1.071807]  </TASK>

[...]

[    1.800842] tpm tpm0: tpm_try_transmit: send(): error -62
[    1.800894] tpm_tis 00:06: 1.2 TPM (device-id 0x6871, rev-id 1)

[...]

[    4.156840] tpm tpm0: tpm_try_transmit: send(): error -62
[    4.156891] ima: Error Communicating to TPM chip

And then the console is spammed with several more:

[  149.636208] tpm tpm0: tpm_try_transmit: send(): error -62

The /dev/tpm0 device error is present, but trousers/tcsd fails with:

avr 25 15:12:06 fornost tcsd[4667]: TCSD TDDL[4667]: TrouSerS ERROR: 
write to device /dev/tpm0 failed: Timer expired
avr 25 15:12:06 fornost tcsd[4667]: TCSD TCS[4667]: TrouSerS ERROR: TCS 
GetCapability failed with result = 0x1087

An idea?

Kind regards,

Laurent Bigonville

