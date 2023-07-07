Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F8574B4E2
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jul 2023 18:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjGGQHz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jul 2023 12:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGGQHz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jul 2023 12:07:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0151BF4;
        Fri,  7 Jul 2023 09:07:53 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qHnzr-00059o-1C; Fri, 07 Jul 2023 18:07:51 +0200
Message-ID: <5b9ec275-31b5-7b77-d00b-da128bea8bb3@leemhuis.info>
Date:   Fri, 7 Jul 2023 18:07:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] tpm: return false from tpm_amd_is_rng_defective on
 non-x86 platforms
Content-Language: en-US, de-DE
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, stable@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
References: <20230629204147.1852823-1-jsnitsel@redhat.com>
 <CTPWGNGECE0A.7MSU6S60YWDK@suppilovahvero>
 <mbbb2mdlmkhnkgmw37glklmllzelolmdvmdgz5pziidromxsh5@gkflot73u6gd>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <mbbb2mdlmkhnkgmw37glklmllzelolmdvmdgz5pziidromxsh5@gkflot73u6gd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688746073;278e6ddb;
X-HE-SMSGID: 1qHnzr-00059o-1C
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

So what's the way forward now? It sounded like Jarkko wanted to apply
the patch from this thread days ago, but that didn't happen afaics. Then
below message showed up, but Marios patch also wasn't applied.

Is this intentional, or did something somewhere fall through the cracks?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 05.07.23 19:04, Jerry Snitselaar wrote:
> On Fri, Jun 30, 2023 at 01:07:00PM +0300, Jarkko Sakkinen wrote:
>> On Thu Jun 29, 2023 at 11:41 PM EEST, Jerry Snitselaar wrote:
>>> tpm_amd_is_rng_defective is for dealing with an issue related to the
>>> AMD firmware TPM, so on non-x86 architectures just have it inline and
>>> return false.
>>>
>>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>>> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
>>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>>> Cc: Peter Huewe <peterhuewe@gmx.de>
>>> Cc: stable@vger.kernel.org
>>> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>> Reported-by: Aneesh Kumar K. V <aneesh.kumar@linux.ibm.com>
>>> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
>>> Closes: https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/
>>> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
>>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>> ---
>>>  drivers/char/tpm/tpm-chip.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>>> index cd48033b804a..cf5499e51999 100644
>>> --- a/drivers/char/tpm/tpm-chip.c
>>> +++ b/drivers/char/tpm/tpm-chip.c
>>> @@ -518,6 +518,7 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
>>>   * 6.x.y.z series: 6.0.18.6 +
>>>   * 3.x.y.z series: 3.57.y.5 +
>>>   */
>>> +#ifdef CONFIG_X86
>>>  static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
>>>  {
>>>  	u32 val1, val2;
>>> @@ -566,6 +567,12 @@ static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
>>>  
>>>  	return true;
>>>  }
>>> +#else
>>> +static inline bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
>>> +{
>>> +	return false;
>>> +}
>>> +#endif /* CONFIG_X86 */
>>>  
>>>  static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>>>  {
>>> -- 
>>> 2.38.1
>>
>> Sanity check, this was the right patch, right?
>>
>> I'll apply it.
>>
>> BR, Jarkko
> 
> Sorry, I've been dealing with a family health issue the past week. It wasn't clear
> to me why chip->ops was null when I first took a look, but I think I understand
> now looking at it again this morning. The stack trace shows it in the device_shutdown() path:
> 
>     [ 34.381674] NIP [c0000000009db1e4] tpm_amd_is_rng_defective+0x74/0x240
>     [ 34.381681] LR [c0000000009db928] tpm_chip_unregister+0x138/0x160
>     [ 34.381685] Call Trace:
>     [ 34.381686] [c00000009742faa0] [c0000000009db928] tpm_chip_unregister+0x138/0x160
>     [ 34.381690] [c00000009742fae0] [c0000000009eab94] tpm_ibmvtpm_remove+0x34/0x130
>     [ 34.381695] [c00000009742fb50] [c000000000115738] vio_bus_remove+0x58/0xd0
>     [ 34.381701] [c00000009742fb90] [c000000000a01ecc] device_shutdown+0x21c/0x39c
>     [ 34.381705] [c00000009742fc20] [c0000000001a2684] kernel_restart_prepare+0x54/0x70
>     [ 34.381710] [c00000009742fc40] [c000000000292c48] kernel_kexec+0xa8/0x100
>     [ 34.381714] [c00000009742fcb0] [c0000000001a2cd4] __do_sys_reboot+0x214/0x2c0
>     [ 34.381718] [c00000009742fe10] [c000000000034adc] system_call_exception+0x13c/0x340
>     [ 34.381723] [c00000009742fe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
> 
> So I think what happened is:
> 
> device_shutdown -> dev->class->shutdown_pre (tpm_class_shutdown) // clears chip->ops
>                 -> dev->bus->shutdown (vio_bus_shutdown) -> vio_bus_remove -> viodrv->remove (tpm_ibmvtpm_remove) -> tpm_chip_unregister -> tpm_amd_is_rng_defective -> oops!
> 
> 
> I guess anything that gets called in the tpm_chip_unregister path
> should be doing a check of chip->ops prior to using it. So I think
> Mario's patch would still be a good thing to have.
> 
> Regards,
> Jerry
> 
> 
> 
