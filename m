Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9EB624867
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 18:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiKJRce (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Nov 2022 12:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJRcc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Nov 2022 12:32:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BE2314E
        for <linux-integrity@vger.kernel.org>; Thu, 10 Nov 2022 09:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668101550; bh=FEIXSHtxVizZfmOZBBLQmoULTgs44dMYrS19AJ+f3qk=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=CG7AXdeCFCBadpmwheV1OslsG5W2T4Rhr1Rf8gDxGZiL2rfsrxh0ugZyfLoLp7FtS
         wyQZ1zD5djJ2h1J+eYb/wYwWakhUU86hRPptkLRIGEs3+BNbsrdO7MFZA8WG3z2u+W
         gly0DNkxk6IhlO7rES8ib5Vi0tZ8qx/ORpKEnb+3vvTPk5XcSDKNDAbR1B3JqNDyVB
         ut8Z5dnSZuzmRRZrlraw72sJ5FHqWJlZ8jD/vifi5jYuD0f0Mv3t58R228S7+B5NOo
         e3NulKBdJ+XWO8LcSOjBgrEi7B3CmOBbn0JM1KMMQon2fWxtjP5LABgjCJgiIJ2JdN
         GtCAoVos18Fag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.179.24] ([82.207.253.174]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeI8-1oRiOX3bam-00RZDv for
 <linux-integrity@vger.kernel.org>; Thu, 10 Nov 2022 18:32:29 +0100
Message-ID: <a71739c0-368b-61d5-6203-a81955980f4f@gmx.de>
Date:   Thu, 10 Nov 2022 18:32:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     linux-integrity@vger.kernel.org
Content-Language: en-US
From:   Martin Maurer <referme@gmx.de>
Subject: Invalid TPM_STS.x ... dumping stack for forensics...
 tpm_try_transmit: send(): error -62
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O5Ik+lkyu/Nx5DcSe3VcvBU/vZ33ECgmnFOTx00ABAfVkQ9DLob
 jpepxYJImAIlHqYEGb3tAwNYhdATmhUVOgDbl4mq4XNtCVTRk/wN84Uqg+prJsJhECpSdw0
 rHLv1F8vdy6aTXNKSYPlS8OZm4Wjr1Kit40nMlLVzHzYu1sHjB47BmUaiZbsHLkXUY/Z8ol
 yXYDGMOfRKmPgwuz8zQKg==
UI-OutboundReport: notjunk:1;M01:P0:uSuspM5pH04=;67rwQT3a69QKpC2vdtYn3RSA1Sr
 bRmOo/dI/wZgdipMEQ9DFo6jMg+1HtBqLKKZl/3POIeL4HoWWhWzH6Zjl4BCkQgQFHt1wIIAm
 hUy+QT+FIrG7/ENHglrU0kt89PvAdbzFoEUXIvk88NpOjgk2U+jVCpls+Sade1Gk8TPTWxlW1
 2rAtebBb38Vuyfc5x4RaBLvGdxk1qL0Um6gIYd0u55GmY7Mxlwtcn5VqnVvxxhYSBzACGauMt
 qnmp+4LekHcDwwYo0nITAMBxUhnGqPn8YM0YABe+C69u0GFPqCwjQ/Xbuvcr8xdzB72+JBs4d
 XyNsKeI9lNejtddlklrw1t8XjTyQfQXyeID0eD1UtJ/ooPE7oJFgJvZlu5Q78D5TKJcDWH58V
 tpffdGcsawzutmgMi9wP7fsX3Yxnp99KmE5OQlNCQahe5p0onCajXHjniwOKjwzVXZyXHNIYi
 8L/l8DLCGBz0hbPwiBMpQtV9BsTcQLkGus5A4omcQDn9N/ul6bT0AgIo/3KgTDNAArmZ9OZDb
 BT/ytgZLReCZPy4LoZSMmdGXcW7DFzIrsgyTkKMfVE4TEG6tXIREv8EeUGjyF+ZLzvnZU9faU
 TL7exuU56cPuXkfV3I5/wz5CLx16lvPXwGdANvLtmwTvOG4/C7YVWgXiqngbzlCPT4zpZHnaJ
 aBygF0AOCKPScnA1AAWws/QUDKOelGiYcjXpD/qZstZqpkXo2TSxto3T9l+7d2GKbmtY6NqBo
 0C8MgD6uWYUvBNkzg68L3BuRJ9zLMMi2nXwUPvfHEICy0U29DV9HCknjFZhTt2ZR5N78xeptb
 xrBWYa04WM/Vw/N1LJ9YDNiMnbaPd0nls9hSDq9iLDEMXbtH7rHsRI0BQ9MTjB0WaAcn7iAXH
 bQ/zTCMxeImEbkXSlhp5C21O7on7n4p+qjmsdU7iEuaJcJdcf3yjg2GYTeStt9pJQYO5snU+3
 LqBU/IXp0PGe7SMACUOYaVD0Dhw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

I am not completely sure, if this is the right place to ask for help for
a bug which occurred:

|Oct 27 22:53:32 xxx kernel: [11801.147084] tpm tpm0: invalid TPM_STS.x
0xff, dumping stack for forensics Oct 27 22:53:32 xxx kernel:
[11801.147105] CPU: 0 PID: 8474 Comm: kworker/0:0 Tainted: G C
5.10.60-v7+ #1449 Oct 27 22:53:32 xxx kernel: [11801.147109] Hardware
name: BCM2835 Oct 27 22:53:32 xxx kernel: [11801.147137] Workqueue:
tpm_dev_wq tpm_dev_async_work [tpm] Oct 27 22:53:32 xxx kernel:
[11801.147146] Backtrace: Oct 27 22:53:32 xxx kernel: [11801.147162]
[<809f0078>] (dump_backtrace) from [<809f0408>] (show_stack+0x20/0x24)
Oct 27 22:53:32 xxx kernel: [11801.147170] r7:ffffffff r6:00000000
r5:60000013 r4:80fe5e94 Oct 27 22:53:32 xxx kernel: [11801.147179]
[<809f03e8>] (show_stack) from [<809f4618>] (dump_stack+0xcc/0xf8) Oct
27 22:53:32 xxx kernel: [11801.147191] [<809f454c>] (dump_stack) from
[<7f16f654>] (tpm_tis_status+0xb8/0xc0 [tpm_tis_core]) Oct 27 22:53:32
xxx kernel: [11801.147199] r10:00000000 r9:00000015 r8:80f05008
r7:7f18556c r6:8252d800 r5:00000000 Oct 27 22:53:32 xxx kernel:
[11801.147204] r4:80f05008 r3:3054eb81 Oct 27 22:53:32 xxx kernel:
[11801.147217] [<7f16f59c>] (tpm_tis_status [tpm_tis_core]) from
[<7f16f82c>] (wait_for_tpm_stat+0x108/0x210 [tpm_tis_core]) Oct 27
22:53:32 xxx kernel: [11801.147224] r7:00118cad r6:00000080 r5:80f03d00
r4:8252d800 Oct 27 22:53:32 xxx kernel: [11801.147236] [<7f16f724>]
(wait_for_tpm_stat [tpm_tis_core]) from [<7f16fa14>]
(tpm_tis_send_data+0xe0/0x254 [tpm_tis_core]) Oct 27 22:53:32 xxx
kernel: [11801.147244] r10:84b20062 r9:00000015 r8:848a21c0 r7:7f185540
r6:8252d800 r5:00000015 Oct 27 22:53:32 xxx kernel: [11801.147248]
r4:00000015 Oct 27 22:53:32 xxx kernel: [11801.147261] [<7f16f934>]
(tpm_tis_send_data [tpm_tis_core]) from [<7f16fbc0>]
(tpm_tis_send_main+0x38/0x110 [tpm_tis_core]) Oct 27 22:53:32 xxx
kernel: [11801.147269] r10:00001000 r9:00000014 r8:84b20062 r7:8252d800
r6:80f03d00 r5:848a21c0 Oct 27 22:53:32 xxx kernel: [11801.147273]
r4:80f05008 Oct 27 22:53:32 xxx kernel: [11801.147286] [<7f16fb88>]
(tpm_tis_send_main [tpm_tis_core]) from [<7f170370>]
(tpm_tis_send+0x4c/0xc4 [tpm_tis_core]) Oct 27 22:53:32 xxx kernel:
[11801.147293] r8:00000008 r7:0000017a r6:80f03d00 r5:84b20062
r4:8252d800 Oct 27 22:53:32 xxx kernel: [11801.147315] [<7f170324>]
(tpm_tis_send [tpm_tis_core]) from [<7f14d5c8>] (tpm_transmit+0xd4/0x334
[tpm]) Oct 27 22:53:32 xxx kernel: [11801.147321] r7:0000017a
r6:80f03d00 r5:84b20062 r4:8252d800 Oct 27 22:53:32 xxx kernel:
[11801.147353] [<7f14d4f4>] (tpm_transmit [tpm]) from [<7f14cb88>]
(tpm_dev_transmit.constprop.0+0x74/0xe8 [tpm]) Oct 27 22:53:32 xxx
kernel: [11801.147360] r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:8252d800 r5:84b20062 Oct 27 22:53:32 xxx kernel: [11801.147364]
r4:80f05008 Oct 27 22:53:32 xxx kernel: [11801.147395] [<7f14cb14>]
(tpm_dev_transmit.constprop.0 [tpm]) from [<7f14cc68>]
(tpm_dev_async_work+0x6c/0xa4 [tpm]) Oct 27 22:53:32 xxx kernel:
[11801.147402] r7:ff7b4500 r6:b6b2b640 r5:84b20008 r4:84b20040 Oct 27
22:53:32 xxx kernel: [11801.147425] [<7f14cbfc>] (tpm_dev_async_work
[tpm]) from [<8013b948>] (process_one_work+0x250/0x5a0) Oct 27 22:53:32
xxx kernel: [11801.147431] r7:ff7b4500 r6:b6b2b640 r5:9a9a3180
r4:84b20040 Oct 27 22:53:32 xxx kernel: [11801.147440] [<8013b6f8>]
(process_one_work) from [<8013bcf8>] (worker_thread+0x60/0x5c4) Oct 27
22:53:32 xxx kernel: [11801.147448] r10:b6b2b640 r9:80f03d00 r8:b6b2b658
r7:00000008 r6:b6b2b640 r5:9a9a3194 Oct 27 22:53:32 xxx kernel:
[11801.147452] r4:9a9a3180 Oct 27 22:53:32 xxx kernel: [11801.147462]
[<8013bc98>] (worker_thread) from [<801437cc>] (kthread+0x170/0x174) Oct
27 22:53:32 xxx kernel: [11801.147470] r10:a124de74 r9:9a9a3180
r8:8013bc98 r7:a11cc000 r6:00000000 r5:964c6900 Oct 27 22:53:32 xxx
kernel: [11801.147474] r4:97c8c600 Oct 27 22:53:32 xxx kernel:
[11801.147483] [<8014365c>] (kthread) from [<801000ec>]
(ret_from_fork+0x14/0x28) Oct 27 22:53:32 xxx kernel: [11801.147488]
Exception stack(0xa11cdfb0 to 0xa11cdff8) Oct 27 22:53:32 xxx kernel:
[11801.147493] dfa0: 00000000 00000000 00000000 00000000 Oct 27 22:53:32
xxx kernel: [11801.147500] dfc0: 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 Oct 27 22:53:32 xxx kernel:
[11801.147506] dfe0: 00000000 00000000 00000000 00000000 00000013
00000000 Oct 27 22:53:32 xxx kernel: [11801.147514] r10:00000000
r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8014365c Oct 27
22:53:32 xxx kernel: [11801.147518] r4:964c6900 Oct 27 22:53:32 xxx
kernel: [11801.345307] tpm tpm0: tpm_try_transmit: send(): error -62 |

Since this happened the module (Infineon SLB9670) seems to malfunction.
Does someone have an explanation what it wants to tell me?

Best regards,

Martin

