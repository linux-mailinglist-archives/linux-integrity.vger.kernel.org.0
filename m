Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE48168B11E
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Feb 2023 18:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBERi2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Feb 2023 12:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBERi1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Feb 2023 12:38:27 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50914420E;
        Sun,  5 Feb 2023 09:38:26 -0800 (PST)
Received: from [46.183.103.17] (helo=[172.18.99.178]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pOiy6-0001nS-HZ; Sun, 05 Feb 2023 18:38:22 +0100
Message-ID: <1c04756b-574b-210d-9580-a4de2aa16a20@leemhuis.info>
Date:   Sun, 5 Feb 2023 18:38:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [regression] Bug 216989 - since 6.1 systems with AMD Ryzen
 stutter when fTPM is enabled
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        reach622@mailcuk.com, 1138267643@qq.com,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <3a196414-68d8-29c9-24cc-2b8cb4c9d358@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <3a196414-68d8-29c9-24cc-2b8cb4c9d358@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675618706;f47b7259;
X-HE-SMSGID: 1pOiy6-0001nS-HZ
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[ccing Dominik (who authored the culprit) and Herbert (who merged it)]

On 02.02.23 11:28, Linux kernel regression tracking (Thorsten Leemhuis)
wrote:
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216989 :

Turns out according to a bisection from one of the reporters that
b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted
sources") (merged for 6.1) apparently makes this hardware issue occur
quicker/more frequently a lot quicker on any board that didn't get the
firmware update yet. So it could be argued that from the point of the
kernel it *might* be considered a regression.

For details see the ticket.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot introduced: b006c439d58d

>>  reach622@mailcuk.com 2023-02-02 02:49:48 UTC
>>
>> Linux kernel >=6.1 exhibits a stuttering issue that occurs once every few hours. See https://www.reddit.com/r/archlinux/comments/zvgev0/audio_stuttering_issues_with_kernel_611/ https://www.reddit.com/r/linux_gaming/comments/zzqaf7/having_intermittent_stutters_with_a_ryzen_cpu/ https://bbs.archlinux.org/viewtopic.php?id=282333 for detailed information.
>>
>> The stutter lasts for 1-2 seconds and causes the framerate of the display to decrease dramatically and causes bursts in audio output.
>>
>> Additional info:
>>
>> * linux 6.1.0 or later
>>
>> Steps to reproduce:
>>
>> * Use Linux kernel >=6.1
>>
>> * Use AMD Ryzen CPU with fTPM enabled
>>
>> * Wait for a few hours
>>
>> [reply] [−] Comment 1 Bell 2023-02-02 03:33:24 UTC
>>
>> Hey, Let me add some extra information to help.
>> 1. this issue can happen in 6.2-rc6 without loading third-party kernel modules. (NVIDIA or Virtualbox and so)
>> 2. some guy on the Desktop/Laptop who can disable ftpm and did eliminate the problem.
>> 3. this problem can happen in newer AMD processors from the 4000 series to the 6000 series.
>> 4. this problem isn't caused by the dedicated graphics card I guess, here are some combinations that stuttering can happen:
>> AMD(built-in GPU) + NVIDIA  Laptop
>> AMD(No built-in GPU) + AMD(dedicated) Desktop
>> AMD(built-in GPU) + AMD(dedicated) Laptop/Desktop
>> AMD + AMD(Built-in GPU only) Laptop
>> all suffer from this.
>>
>> Hope this can help :)
> 
> See the ticket for more details.
> 
> I briefly looked into the links and found this:
> https://www.amd.com/en/support/kb/faq/pa-410
> 
>>
>> Intermittent System Stutter Experienced with fTPM Enabled on Windows® 10
>> and 11
>> Article Number
>> PA-410
>>
>> This documentation provides information on improving intermittent
>> performance stutter(s) on select PCs running Windows® 10 and 11 with
>> Firmware Trusted Platform Module (“fTPM”) enabled.
>>
>>
>>
>> Issue Description
>>
>> AMD has determined that select AMD Ryzen™ system configurations may
>> intermittently perform extended fTPM-related memory transactions in SPI
>> flash memory (“SPIROM”) located on the motherboard, which can lead to
>> temporary pauses in system interactivity or responsiveness until the
>> transaction is concluded.
>>
>>
>>
>> Update and Workaround
>>
>>     Update: Affected PCs will require a motherboard system BIOS (sBIOS)
>> update containing enhanced modules for fTPM interaction with SPIROM. AMD
>> expects that flashable customer sBIOS files to be available starting in
>> early May, 2022. Exact BIOS availability timing for a specific
>> motherboard depends on the testing and integration schedule of your
>> manufacturer. Flashable updates for motherboards will be based on AMD
>> AGESA 1207 (or newer).
>>
>>     Workaround: As an immediate solution, affected customers dependent
>> on fTPM functionality for Trusted Platform Module support may instead
>> use a hardware TPM (“dTPM”) device for trusted computing. Platform dTPM
>> modules utilize onboard non-volatile memory (NVRAM) that supersedes the
>> TPM/SPIROM interaction described in this article.
>>
>>         COMPATIBILITY: Please check with your system or motherboard
>> manufacturer to ensure that your platform supports add-in dTPM modules
>> before attempting or implementing this workaround.
>>
>>         WARNING: If switching an active system from fTPM to dTPM, it is
>> critical that you disable TPM-backed encryption systems (e.g. BitLocker
>> Drive Encryption) and/or back up vital system data prior to switching
>> TPM devices. You must have full administrative access to the system, or
>> explicit support from your IT administrator if the system is managed.
>> For more information on transferring ownership to a new TPM device,
>> please visit this Microsoft webpage.
>>
> 
> So it's a firmware problem, but apparently one that Linux only triggers
> since 6.1.
> 
> Jason, could the hwrng changes have anything to do with this?
> 
> A bisection really would be helpful, but I guess that is not easy as the
> problem apparently only shows up after some time...
> 
> 
> Anyway:
> 
> [TLDR for the rest of this mail: I'm adding this report to the list of
> tracked Linux kernel regressions; the text you find below is based on a
> few templates paragraphs you might have encountered already in similar
> form.]
> 
> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
> 
> #regzbot introduced: v6.0..v6.1
> https://bugzilla.kernel.org/show_bug.cgi?id=216989
> #regzbot title: tpm: systems with AMD Ryzen stutter when fTPM is enabled
> #regzbot ignore-activity
> 
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
> 
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
> this thread sees some discussion). See page linked in footer for details.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
