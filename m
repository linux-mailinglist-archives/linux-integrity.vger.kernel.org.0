Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E970E4AF138
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Feb 2022 13:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiBIMRR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Feb 2022 07:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiBIMQA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Feb 2022 07:16:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCAAE00F7D0;
        Wed,  9 Feb 2022 04:01:59 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2A13E210F6;
        Wed,  9 Feb 2022 12:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644408118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbZCw5rIaTc581CofTm5RKNj168VfrUKC3PEf3yNJXc=;
        b=sdbcAuWyyIEpleCPbc7tCM4hFhjFye2d5v7LQDJSFpzC0JLPIccPCsBmkoLPWG8MAi7d77
        AOIur6RdFgAGxcXsRILphY4x1DVcn6X+GljqJZv4lN7zTIDpbrEDowthCl8BWuQKkr14+c
        z+6eeJ/LhcwOQSJsQYYg+/ynfNTSqdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644408118;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbZCw5rIaTc581CofTm5RKNj168VfrUKC3PEf3yNJXc=;
        b=Oo2ysnH3fNpE75SF4n4C4mpY2I+2zEnqyGx6eFv7xvIpxOb7pIZimrVVFgfInowC+MlQjL
        1bRbxBqEkgC+AJCQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 58DF0A3B88;
        Wed,  9 Feb 2022 12:01:55 +0000 (UTC)
Date:   Wed, 9 Feb 2022 13:01:54 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
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
Subject: Re: [PATCH v5 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
Message-ID: <20220209120154.GC3113@kunlun.suse.cz>
References: <cover.1641900831.git.msuchanek@suse.de>
 <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
 <b56fe3a2-b145-9d4e-acf2-4991204b3102@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b56fe3a2-b145-9d4e-acf2-4991204b3102@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

On Wed, Feb 09, 2022 at 07:44:15AM +0100, Paul Menzel wrote:
> Dear Michal,
> 
> 
> Thank you for the patch.
> 
> 
> Am 11.01.22 um 12:37 schrieb Michal Suchanek:
> 
> Could you please remove the dot/period at the end of the git commit message
> summary?

Sure

> > Copy the code from s390x
> > 
> > Both powerpc and s390x use appended signature format (as opposed to EFI
> > based patforms using PE format).
> 
> patforms → platforms

Thanks for noticing

> How can this be tested?

Apparently KEXEC_SIG_FORCE is x86 only although the use of the option is
arch neutral:

arch/x86/Kconfig:config KEXEC_SIG_FORCE
kernel/kexec_file.c:            if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE))
{

Maybe it should be moved?

I used a patched kernel that enables lockdown in secure boot, and then
verified that signed kernel can be loaded by kexec and unsigned not,
with KEXEC_SIG enabled and IMA_KEXEC disabled.

The lockdown support can be enabled on any platform, and although I
can't find it documented anywhere there appears to be code in kexec_file
to take it into account:
kernel/kexec.c: result = security_locked_down(LOCKDOWN_KEXEC);
kernel/kexec_file.c:                security_locked_down(LOCKDOWN_KEXEC))
kernel/module.c:        return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
kernel/params.c:            security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
and lockdown can be enabled with a buildtime option, a kernel parameter, or a
debugfs file.

Still for testing lifting KEXEC_SIG_FORCE to some arch-neutral Kconfig file is
probably the simplest option.

kexec -s option should be used to select kexec_file rather than the old
style kexec which would either fail always or succeed always regardelss
of signature.

> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v3: - Philipp Rudo <prudo@redhat.com>: Update the comit message with
> >        explanation why the s390 code is usable on powerpc.
> >      - Include correct header for mod_check_sig
> >      - Nayna <nayna@linux.vnet.ibm.com>: Mention additional IMA features
> >        in kconfig text
> > ---
> >   arch/powerpc/Kconfig        | 16 ++++++++++++++++
> >   arch/powerpc/kexec/elf_64.c | 36 ++++++++++++++++++++++++++++++++++++
> >   2 files changed, 52 insertions(+)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index dea74d7717c0..1cde9b6c5987 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -560,6 +560,22 @@ config KEXEC_FILE
> >   config ARCH_HAS_KEXEC_PURGATORY
> >   	def_bool KEXEC_FILE
> > +config KEXEC_SIG
> > +	bool "Verify kernel signature during kexec_file_load() syscall"
> > +	depends on KEXEC_FILE && MODULE_SIG_FORMAT
> > +	help
> > +	  This option makes kernel signature verification mandatory for
> > +	  the kexec_file_load() syscall.
> > +
> > +	  In addition to that option, you need to enable signature
> > +	  verification for the corresponding kernel image type being
> > +	  loaded in order for this to work.
> > +
> > +	  Note: on powerpc IMA_ARCH_POLICY also implements kexec'ed kernel
> > +	  verification. In addition IMA adds kernel hashes to the measurement
> > +	  list, extends IMA PCR in the TPM, and implements kernel image
> > +	  blacklist by hash.
> 
> So, what is the takeaway for the user? IMA_ARCH_POLICY is preferred? What is
> the disadvantage, and two implementations(?) needed then? More overhead?

IMA_KEXEC does more than KEXEC_SIG. The overhead is probably not big
unless you are trying to really minimize the kernel code size.

Arguably the simpler implementation hass less potential for bugs, too.
Both in code and in user configuration required to enable the feature.

Interestingly IMA_ARCH_POLICY depends on KEXEC_SIG rather than
IMA_KEXEC. Just mind-boggling.

The main problem with IMA_KEXEC from my point of view is it is not portable.
To record the measurements TPM support is requireed which is not available on
all platforms. It does not support PE so it cannot be used on platforms
that use PE kernel signature format.

> 
> > +
> >   config RELOCATABLE
> >   	bool "Build a relocatable kernel"
> >   	depends on PPC64 || (FLATMEM && (44x || FSL_BOOKE))
> > diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
> > index eeb258002d1e..98d1cb5135b4 100644
> > --- a/arch/powerpc/kexec/elf_64.c
> > +++ b/arch/powerpc/kexec/elf_64.c
> > @@ -23,6 +23,7 @@
> >   #include <linux/of_fdt.h>
> >   #include <linux/slab.h>
> >   #include <linux/types.h>
> > +#include <linux/module_signature.h>
> >   static void *elf64_load(struct kimage *image, char *kernel_buf,
> >   			unsigned long kernel_len, char *initrd,
> > @@ -151,7 +152,42 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
> >   	return ret ? ERR_PTR(ret) : NULL;
> >   }
> > +#ifdef CONFIG_KEXEC_SIG
> > +int elf64_verify_sig(const char *kernel, unsigned long kernel_len)
> > +{
> > +	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
> > +	struct module_signature *ms;
> > +	unsigned long sig_len;
> 
> Use size_t to match the signature of `verify_pkcs7_signature()`?

Nope. struct module_signature uses unsigned long, and this needs to be
matched to avoid type errors on 32bit.

Technically using size_t for in-memory buffers is misguided because
AFAICT no memory buffer can be bigger than ULONG_MAX, and size_t is
non-native type on 32bit.

Sure, the situation with ssize_t/int is different but that's not what we
are dealing with here.

Thanks

Michal
