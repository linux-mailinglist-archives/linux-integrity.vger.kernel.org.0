Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7273A61A097
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Nov 2022 20:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKDTLp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Nov 2022 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiKDTLo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Nov 2022 15:11:44 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BB569DC8;
        Fri,  4 Nov 2022 12:11:41 -0700 (PDT)
Date:   Fri, 4 Nov 2022 20:11:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1667589096; bh=mmhBi7QB7LltXTiDiPTvIZiQKPGsrakjKVHkFQwHxR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RliUcthLTL78oYdnbv6cGpfbEI9Ctu78m6xqETt0VvL6oyYBSajt/HJ8Mt88J5BDf
         sq1o5hYgXh9ek5gwC9YSiqasvHu/2LUT4bfmFtSsARlNC4yB0QyCProJbtQ4X+Q2V8
         tFMBlND0nUzObQbJFrcuFH3v3XA4L8y7IXH1kr8I=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [BUG] blacklist: Problem blacklisting hash (-13) during boot
Message-ID: <632d2180-02f8-4a5f-803a-57a6443a60f4@t-8ch.de>
References: <c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de>
 <af0d6881-76c0-f570-0c5b-f664e261c4cf@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af0d6881-76c0-f570-0c5b-f664e261c4cf@digikod.net>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mickaël,

On 2022-11-04 18:03+0100, Mickaël Salaün wrote:
> Thanks for this report. These error messages seem correct but I don't see
> any legitimate reason for the firmware to store duplicate blacklisted
> hashes.
> 
> According to the blacklist_init() function, the "blacklisting failed"
> message could be improved to explain that only a set of hashes failed, and
> why they failed. However, despite this message, this should work as expected
> and should not generate any issue.
> 
> Did you contact Lenovo to report this issue (i.e. duplicate hashes in their
> firmware)?

I CCed Mark Person from Lenovo on this mail, nothing more for now.

There seem to more devices than just from Lenovo to be affected:
* Samsung: https://askubuntu.com/questions/1436856/
* Acer: https://ubuntuforums.org/showthread.php?t=2478840
* MSI: https://forum.archlabslinux.com/t/blacklist-problem-blacklisting-hash-13-errors-on-boot/6674/7
* Micro-Star: https://bbs.archlinux.org/viewtopic.php?id=278860

While there are reports that it helps to reset the blacklist in firmware this
doesn't seem like a general solution for endusers.

FYI I also posted a patch that silences the spurious logs:
https://lore.kernel.org/lkml/20221104014704.3469-1-linux@weissschuh.net/

> Could you please provide the list of duplicate hashes?

bin:80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d411f92659f0a
bin:f52f83a3fa9cfbd6920f722824dbe4034534d25b8507246b3b957dac6e1bce7a
bin:c5d9d8a186e2c82d09afaa2a6f7f2e73870d3e64f72c4e08ef67796a840f0fbd
bin:1aec84b84b6c65a51220a9be7181965230210d62d6d33c48999c6b295a2b0a06
bin:c3a99a460da464a057c3586d83cef5f4ae08b7103979ed8932742df0ed530c66
bin:58fb941aef95a25943b3fb5f2510a0df3fe44c58c95e0ab80487297568ab9771
bin:5391c3a2fb112102a6aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
bin:d626157e1d6a718bc124ab8da27cbb65072ca03a7b6b257dbdcbbd60f65ef3d1
bin:d063ec28f67eba53f1642dbf7dff33c6a32add869f6013fe162e2c32f1cbe56d
bin:29c6eb52b43c3aa18b2cd8ed6ea8607cef3cfae1bafe1165755cf2e614844a44
bin:90fbe70e69d633408d3e170c6832dbb2d209e0272527dfb63d49d29572a6f44c
bin:106faceacfecfd4e303b74f480a08098e2d0802b936f8ec774ce21f31686689c
bin:174e3a0b5b43c6a607bbd3404f05341e3dcf396267ce94f8b50e2e23a9da920c
bin:2b99cf26422e92fe365fbf4bc30d27086c9ee14b7a6fff44fb2f6b9001699939
bin:2e70916786a6f773511fa7181fab0f1d70b557c6322ea923b2a8d3b92b51af7d
bin:3fce9b9fdf3ef09d5452b0f95ee481c2b7f06d743a737971558e70136ace3e73
bin:47cc086127e2069a86e03a6bef2cd410f8c55a6d6bdb362168c31b2ce32a5adf
bin:71f2906fd222497e54a34662ab2497fcc81020770ff51368e9e3d9bfcbfd6375
bin:82db3bceb4f60843ce9d97c3d187cd9b5941cd3de8100e586f2bda5637575f67
bin:8ad64859f195b5f58dafaa940b6a6167acd67a886e8f469364177221c55945b9
bin:8d8ea289cfe70a1c07ab7365cb28ee51edd33cf2506de888fbadd60ebf80481c
bin:aeebae3151271273ed95aa2e671139ed31a98567303a332298f83709a9d55aa1
bin:c409bdac4775add8db92aa22b5b718fb8c94a1462c1fe9a416b95d8a3388c2fc
bin:c617c1a8b1ee2a811c28b5a81b4c83d7c98b5b0c27281d610207ebe692c2967f
bin:c90f336617b8e7f983975413c997f10b73eb267fd8a10cb9e3bdbfc667abdb8b
bin:64575bd912789a2e14ad56f6341f52af6bf80cf94400785975e9f04e2d64d745
bin:45c7c8ae750acfbb48fc37527d6412dd644daed8913ccd8a24c94d856967df8e
bin:47ff1b63b140b6fc04ed79131331e651da5b2e2f170f5daef4153dc2fbc532b1
bin:5391c3a2fb112102a6aa1edc25ae77e19f5d6f09cd09eeb2509922bfcd5992ea
bin:80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d411f92659f0a
bin:992d359aa7a5f789d268b94c11b9485a6b1ce64362b0edb4441ccc187c39647b
bin:c452ab846073df5ace25cca64d6b7a09d906308a1a65eb5240e3c4ebcaa9cc0c
bin:e051b788ecbaeda53046c70e6af6058f95222c046157b8c4c1b9c2cfc65f46e5

Thanks,
Thomas

> On 15/10/2022 05:16, Thomas Weißschuh wrote:
> > Hi,
> > 
> > Since 5.19 during boot I see lots of the following entries in dmesg:
> > 
> > blacklist: Problem blacklisting hash (-13)
> > 
> > This happens because the firmware contains duplicate blacklist entries.
> > As commit 6364d106e041 [0] modified the "blacklist" keyring to reject updates
> > this now leads to the spurious error messages.
> > 
> > The machine is a Thinkpad X1 Cargon Gen9 with BIOS revision 1.56 and firmware
> > revision 1.33.
> > 
> > [0] 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")
