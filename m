Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6CA4AEA89
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Feb 2022 07:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiBIGod (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Feb 2022 01:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiBIGoT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Feb 2022 01:44:19 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6409EC0401C7;
        Tue,  8 Feb 2022 22:44:18 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee30.dynamic.kabel-deutschland.de [95.90.238.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 441A661E64846;
        Wed,  9 Feb 2022 07:44:16 +0100 (CET)
Message-ID: <b56fe3a2-b145-9d4e-acf2-4991204b3102@molgen.mpg.de>
Date:   Wed, 9 Feb 2022 07:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
Content-Language: en-US
To:     Michal Suchanek <msuchanek@suse.de>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
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
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
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


Thank you for the patch.


Am 11.01.22 um 12:37 schrieb Michal Suchanek:

Could you please remove the dot/period at the end of the git commit 
message summary?

> Copy the code from s390x
> 
> Both powerpc and s390x use appended signature format (as opposed to EFI
> based patforms using PE format).

patforms → platforms

How can this be tested?

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v3: - Philipp Rudo <prudo@redhat.com>: Update the comit message with
>        explanation why the s390 code is usable on powerpc.
>      - Include correct header for mod_check_sig
>      - Nayna <nayna@linux.vnet.ibm.com>: Mention additional IMA features
>        in kconfig text
> ---
>   arch/powerpc/Kconfig        | 16 ++++++++++++++++
>   arch/powerpc/kexec/elf_64.c | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index dea74d7717c0..1cde9b6c5987 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -560,6 +560,22 @@ config KEXEC_FILE
>   config ARCH_HAS_KEXEC_PURGATORY
>   	def_bool KEXEC_FILE
>   
> +config KEXEC_SIG
> +	bool "Verify kernel signature during kexec_file_load() syscall"
> +	depends on KEXEC_FILE && MODULE_SIG_FORMAT
> +	help
> +	  This option makes kernel signature verification mandatory for
> +	  the kexec_file_load() syscall.
> +
> +	  In addition to that option, you need to enable signature
> +	  verification for the corresponding kernel image type being
> +	  loaded in order for this to work.
> +
> +	  Note: on powerpc IMA_ARCH_POLICY also implements kexec'ed kernel
> +	  verification. In addition IMA adds kernel hashes to the measurement
> +	  list, extends IMA PCR in the TPM, and implements kernel image
> +	  blacklist by hash.

So, what is the takeaway for the user? IMA_ARCH_POLICY is preferred? 
What is the disadvantage, and two implementations(?) needed then? More 
overhead?

> +
>   config RELOCATABLE
>   	bool "Build a relocatable kernel"
>   	depends on PPC64 || (FLATMEM && (44x || FSL_BOOKE))
> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
> index eeb258002d1e..98d1cb5135b4 100644
> --- a/arch/powerpc/kexec/elf_64.c
> +++ b/arch/powerpc/kexec/elf_64.c
> @@ -23,6 +23,7 @@
>   #include <linux/of_fdt.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
> +#include <linux/module_signature.h>
>   
>   static void *elf64_load(struct kimage *image, char *kernel_buf,
>   			unsigned long kernel_len, char *initrd,
> @@ -151,7 +152,42 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>   	return ret ? ERR_PTR(ret) : NULL;
>   }
>   
> +#ifdef CONFIG_KEXEC_SIG
> +int elf64_verify_sig(const char *kernel, unsigned long kernel_len)
> +{
> +	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
> +	struct module_signature *ms;
> +	unsigned long sig_len;

Use size_t to match the signature of `verify_pkcs7_signature()`?

> +	int ret;
> +
> +	if (marker_len > kernel_len)
> +		return -EKEYREJECTED;
> +
> +	if (memcmp(kernel + kernel_len - marker_len, MODULE_SIG_STRING,
> +		   marker_len))
> +		return -EKEYREJECTED;
> +	kernel_len -= marker_len;
> +
> +	ms = (void *)kernel + kernel_len - sizeof(*ms);
> +	ret = mod_check_sig(ms, kernel_len, "kexec");
> +	if (ret)
> +		return ret;
> +
> +	sig_len = be32_to_cpu(ms->sig_len);
> +	kernel_len -= sizeof(*ms) + sig_len;
> +
> +	return verify_pkcs7_signature(kernel, kernel_len,
> +				      kernel + kernel_len, sig_len,
> +				      VERIFY_USE_PLATFORM_KEYRING,
> +				      VERIFYING_MODULE_SIGNATURE,
> +				      NULL, NULL);
> +}
> +#endif /* CONFIG_KEXEC_SIG */
> +
>   const struct kexec_file_ops kexec_elf64_ops = {
>   	.probe = kexec_elf_probe,
>   	.load = elf64_load,
> +#ifdef CONFIG_KEXEC_SIG
> +	.verify_sig = elf64_verify_sig,
> +#endif
>   };


Kind regards,

Paul
