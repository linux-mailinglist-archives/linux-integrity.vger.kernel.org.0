Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0D8687A2B
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Feb 2023 11:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjBBK20 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Feb 2023 05:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjBBK2X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Feb 2023 05:28:23 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0A239BB8;
        Thu,  2 Feb 2023 02:28:21 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pNWpH-0008CR-12; Thu, 02 Feb 2023 11:28:19 +0100
Message-ID: <3a196414-68d8-29c9-24cc-2b8cb4c9d358@leemhuis.info>
Date:   Thu, 2 Feb 2023 11:28:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, de-DE
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        reach622@mailcuk.com, 1138267643@qq.com,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] Bug 216989 - since 6.1 systems with AMD Ryzen stutter
 when fTPM is enabled
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675333701;09b4a742;
X-HE-SMSGID: 1pNWpH-0008CR-12
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216989 :

>  reach622@mailcuk.com 2023-02-02 02:49:48 UTC
> 
> Linux kernel >=6.1 exhibits a stuttering issue that occurs once every few hours. See https://www.reddit.com/r/archlinux/comments/zvgev0/audio_stuttering_issues_with_kernel_611/ https://www.reddit.com/r/linux_gaming/comments/zzqaf7/having_intermittent_stutters_with_a_ryzen_cpu/ https://bbs.archlinux.org/viewtopic.php?id=282333 for detailed information.
> 
> The stutter lasts for 1-2 seconds and causes the framerate of the display to decrease dramatically and causes bursts in audio output.
> 
> Additional info:
> 
> * linux 6.1.0 or later
> 
> Steps to reproduce:
> 
> * Use Linux kernel >=6.1
> 
> * Use AMD Ryzen CPU with fTPM enabled
> 
> * Wait for a few hours
> 
> [reply] [−] Comment 1 Bell 2023-02-02 03:33:24 UTC
> 
> Hey, Let me add some extra information to help.
> 1. this issue can happen in 6.2-rc6 without loading third-party kernel modules. (NVIDIA or Virtualbox and so)
> 2. some guy on the Desktop/Laptop who can disable ftpm and did eliminate the problem.
> 3. this problem can happen in newer AMD processors from the 4000 series to the 6000 series.
> 4. this problem isn't caused by the dedicated graphics card I guess, here are some combinations that stuttering can happen:
> AMD(built-in GPU) + NVIDIA  Laptop
> AMD(No built-in GPU) + AMD(dedicated) Desktop
> AMD(built-in GPU) + AMD(dedicated) Laptop/Desktop
> AMD + AMD(Built-in GPU only) Laptop
> all suffer from this.
> 
> Hope this can help :)

See the ticket for more details.

I briefly looked into the links and found this:
https://www.amd.com/en/support/kb/faq/pa-410

> 
> Intermittent System Stutter Experienced with fTPM Enabled on Windows® 10
> and 11
> Article Number
> PA-410
> 
> This documentation provides information on improving intermittent
> performance stutter(s) on select PCs running Windows® 10 and 11 with
> Firmware Trusted Platform Module (“fTPM”) enabled.
> 
> 
> 
> Issue Description
> 
> AMD has determined that select AMD Ryzen™ system configurations may
> intermittently perform extended fTPM-related memory transactions in SPI
> flash memory (“SPIROM”) located on the motherboard, which can lead to
> temporary pauses in system interactivity or responsiveness until the
> transaction is concluded.
> 
> 
> 
> Update and Workaround
> 
>     Update: Affected PCs will require a motherboard system BIOS (sBIOS)
> update containing enhanced modules for fTPM interaction with SPIROM. AMD
> expects that flashable customer sBIOS files to be available starting in
> early May, 2022. Exact BIOS availability timing for a specific
> motherboard depends on the testing and integration schedule of your
> manufacturer. Flashable updates for motherboards will be based on AMD
> AGESA 1207 (or newer).
> 
>     Workaround: As an immediate solution, affected customers dependent
> on fTPM functionality for Trusted Platform Module support may instead
> use a hardware TPM (“dTPM”) device for trusted computing. Platform dTPM
> modules utilize onboard non-volatile memory (NVRAM) that supersedes the
> TPM/SPIROM interaction described in this article.
> 
>         COMPATIBILITY: Please check with your system or motherboard
> manufacturer to ensure that your platform supports add-in dTPM modules
> before attempting or implementing this workaround.
> 
>         WARNING: If switching an active system from fTPM to dTPM, it is
> critical that you disable TPM-backed encryption systems (e.g. BitLocker
> Drive Encryption) and/or back up vital system data prior to switching
> TPM devices. You must have full administrative access to the system, or
> explicit support from your IT administrator if the system is managed.
> For more information on transferring ownership to a new TPM device,
> please visit this Microsoft webpage.
> 

So it's a firmware problem, but apparently one that Linux only triggers
since 6.1.

Jason, could the hwrng changes have anything to do with this?

A bisection really would be helpful, but I guess that is not easy as the
problem apparently only shows up after some time...


Anyway:

[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.0..v6.1
https://bugzilla.kernel.org/show_bug.cgi?id=216989
#regzbot title: tpm: systems with AMD Ryzen stutter when fTPM is enabled
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
