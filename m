Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D3B4B291C
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Feb 2022 16:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351381AbiBKPbJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Feb 2022 10:31:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiBKPbI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Feb 2022 10:31:08 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583951A1;
        Fri, 11 Feb 2022 07:31:03 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebe1.dynamic.kabel-deutschland.de [95.90.235.225])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 20C7A61EA1927;
        Fri, 11 Feb 2022 16:31:01 +0100 (CET)
Message-ID: <53069280-73e6-4502-d366-4990b74cf059@molgen.mpg.de>
Date:   Fri, 11 Feb 2022 16:31:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        linux-security-module@vger.kernel.org
References: <cover.1641900831.git.msuchanek@suse.de>
 <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
 <b56fe3a2-b145-9d4e-acf2-4991204b3102@molgen.mpg.de>
 <20220209120154.GC3113@kunlun.suse.cz>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220209120154.GC3113@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Michal,


Am 09.02.22 um 13:01 schrieb Michal Suchánek:

> On Wed, Feb 09, 2022 at 07:44:15AM +0100, Paul Menzel wrote:

>> Am 11.01.22 um 12:37 schrieb Michal Suchanek:

[…]

>> How can this be tested?
> 
> Apparently KEXEC_SIG_FORCE is x86 only although the use of the option is
> arch neutral:
> 
> arch/x86/Kconfig:config KEXEC_SIG_FORCE
> kernel/kexec_file.c:            if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE))
> {
> 
> Maybe it should be moved?

Sounds good.

> I used a patched kernel that enables lockdown in secure boot, and then
> verified that signed kernel can be loaded by kexec and unsigned not,
> with KEXEC_SIG enabled and IMA_KEXEC disabled.
> 
> The lockdown support can be enabled on any platform, and although I
> can't find it documented anywhere there appears to be code in kexec_file
> to take it into account:
> kernel/kexec.c: result = security_locked_down(LOCKDOWN_KEXEC);
> kernel/kexec_file.c:                security_locked_down(LOCKDOWN_KEXEC))
> kernel/module.c:        return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
> kernel/params.c:            security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
> and lockdown can be enabled with a buildtime option, a kernel parameter, or a
> debugfs file.
> 
> Still for testing lifting KEXEC_SIG_FORCE to some arch-neutral Kconfig file is
> probably the simplest option.
> 
> kexec -s option should be used to select kexec_file rather than the old
> style kexec which would either fail always or succeed always regardelss
> of signature.

Thank you.

>>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>>> ---
>>> v3: - Philipp Rudo <prudo@redhat.com>: Update the comit message with
>>>         explanation why the s390 code is usable on powerpc.
>>>       - Include correct header for mod_check_sig
>>>       - Nayna <nayna@linux.vnet.ibm.com>: Mention additional IMA features
>>>         in kconfig text
>>> ---
>>>    arch/powerpc/Kconfig        | 16 ++++++++++++++++
>>>    arch/powerpc/kexec/elf_64.c | 36 ++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 52 insertions(+)
>>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index dea74d7717c0..1cde9b6c5987 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -560,6 +560,22 @@ config KEXEC_FILE
>>>    config ARCH_HAS_KEXEC_PURGATORY
>>>    	def_bool KEXEC_FILE
>>> +config KEXEC_SIG
>>> +	bool "Verify kernel signature during kexec_file_load() syscall"
>>> +	depends on KEXEC_FILE && MODULE_SIG_FORMAT
>>> +	help
>>> +	  This option makes kernel signature verification mandatory for
>>> +	  the kexec_file_load() syscall.
>>> +
>>> +	  In addition to that option, you need to enable signature
>>> +	  verification for the corresponding kernel image type being
>>> +	  loaded in order for this to work.
>>> +
>>> +	  Note: on powerpc IMA_ARCH_POLICY also implements kexec'ed kernel
>>> +	  verification. In addition IMA adds kernel hashes to the measurement
>>> +	  list, extends IMA PCR in the TPM, and implements kernel image
>>> +	  blacklist by hash.
>>
>> So, what is the takeaway for the user? IMA_ARCH_POLICY is preferred? What is
>> the disadvantage, and two implementations(?) needed then? More overhead?
> 
> IMA_KEXEC does more than KEXEC_SIG. The overhead is probably not big
> unless you are trying to really minimize the kernel code size.
> 
> Arguably the simpler implementation has less potential for bugs, too.
> Both in code and in user configuration required to enable the feature.
> 
> Interestingly IMA_ARCH_POLICY depends on KEXEC_SIG rather than
> IMA_KEXEC. Just mind-boggling.

I have not looked into that.

> The main problem with IMA_KEXEC from my point of view is it is not portable.
> To record the measurements TPM support is requireed which is not available on
> all platforms. It does not support PE so it cannot be used on platforms
> that use PE kernel signature format.

Could you add that to the comment please?

>>> +
>>>    config RELOCATABLE
>>>    	bool "Build a relocatable kernel"
>>>    	depends on PPC64 || (FLATMEM && (44x || FSL_BOOKE))
>>> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
>>> index eeb258002d1e..98d1cb5135b4 100644
>>> --- a/arch/powerpc/kexec/elf_64.c
>>> +++ b/arch/powerpc/kexec/elf_64.c
>>> @@ -23,6 +23,7 @@
>>>    #include <linux/of_fdt.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/types.h>
>>> +#include <linux/module_signature.h>
>>>    static void *elf64_load(struct kimage *image, char *kernel_buf,
>>>    			unsigned long kernel_len, char *initrd,
>>> @@ -151,7 +152,42 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>>    	return ret ? ERR_PTR(ret) : NULL;
>>>    }
>>> +#ifdef CONFIG_KEXEC_SIG
>>> +int elf64_verify_sig(const char *kernel, unsigned long kernel_len)
>>> +{
>>> +	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
>>> +	struct module_signature *ms;
>>> +	unsigned long sig_len;
>>
>> Use size_t to match the signature of `verify_pkcs7_signature()`?
> 
> Nope. struct module_signature uses unsigned long, and this needs to be
> matched to avoid type errors on 32bit.

I meant for `sig_len`.

> Technically using size_t for in-memory buffers is misguided because
> AFAICT no memory buffer can be bigger than ULONG_MAX, and size_t is
> non-native type on 32bit.
> 
> Sure, the situation with ssize_t/int is different but that's not what we
> are dealing with here.
True. In my experience it prevents compiler warnings when building for 
32 bit or 64 bit. Anyway, not that important.


Kind regards,

Paul
