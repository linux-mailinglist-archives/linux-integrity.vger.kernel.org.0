Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C073874CE96
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjGJHhW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 03:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjGJHhV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 03:37:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5905F102
        for <linux-integrity@vger.kernel.org>; Mon, 10 Jul 2023 00:37:19 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qIlSP-0006do-9Z; Mon, 10 Jul 2023 09:37:17 +0200
Message-ID: <c0ee4b7c-9d63-0bb3-c677-2be045deda43@leemhuis.info>
Date:   Mon, 10 Jul 2023 09:37:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: [regression] Kernel 6.4 failing to access TPM on Framework Laptop
 12th gen
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688974639;5b09bc05;
X-HE-SMSGID: 1qIlSP-0006do-9Z
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developers don't keep an eye on it, I decided to forward it by mail.

Lino Sanfilippo, apparently it's cause by a change of yours.

Note, you have to use bugzilla to reach the reporters, as I sadly[1] can
not CCed them in mails like this.

Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217631 :

> After updating to linux-6.4.1 several users of Framework Laptop
> running Intel 12th gen CPUs reported that their machine fails to boot
> (in my case i5-1240P). It seems it is working fine for the model
> using 11th gen CPUs. See
> https://community.frame.work/t/boot-and-shutdown-hangs-with-arch-linux-kernel-6-4-1-mainline-and-arch/33118
>
> 
> 
> * When using TPM to unlock a LUKS volume it will wait infinitely to
> start systemd-cryptsetup. When forcing a reboot, it will still wait
> for this service to stop and print the following message after
> waiting for some time (see attached cryptsetup_stack.jpg) * When
> disabling TPM unlock, systemd-cryptsetup will start successfully and
> allow to unlock the volume using the passphrase. However, after that
> the boot will also wait indefinitely for systemd-pcrphase to start.
> When force rebooting it will still wait for this service to stop (see
> pcrphase_stack.jpg).
> 
> I was able to boot successfully by either reverting
> e644b2f498d297a928efcb7ff6f900c27f8b788e or disabling interrupts for
> my model like it has been done here:
> https://lore.kernel.org/linux-integrity/20230620-flo-lenovo-l590-tpm-fix-v1-1-16032a8b5a1d%40bezdeka.de/
> 
> DMI_MATCH(DMI_SYS_VENDOR, "Framework"), 
> DMI_MATCH(DMI_PRODUCT_VERSION, "A4"),
See the ticket and the linked forum post for more details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: e644b2f498d297a
https://bugzilla.kernel.org/show_bug.cgi?id=217631
#regzbot title: tpm: boot problems with Framework Laptop 12th gen
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"
