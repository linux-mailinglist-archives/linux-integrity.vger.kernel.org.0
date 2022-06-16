Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F3D54D8B3
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jun 2022 04:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354878AbiFPC7i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 22:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350287AbiFPC7i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 22:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 725B55A151
        for <linux-integrity@vger.kernel.org>; Wed, 15 Jun 2022 19:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655348376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SyBYL1pY81YOYBd6hVWvRLbn1C7svVUvtneGDVFIWeM=;
        b=N1ekUpYOkbZnpHthobxo7TijCae/IuzIpd6MBeryTaYhQR498q14nBSVKWyKcZ2VieRC3p
        NJaTJz8KkGHMSn7iGPzkMHQr8JawB5h1gafkgaE+xA4B4DeIAuG8HKB8U5l8nVBw1804F1
        CCgPVNI0878kLnqCAUGhWzG44qcWr/8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-e7JYHVoOPaK7Uddguyd0jw-1; Wed, 15 Jun 2022 22:59:33 -0400
X-MC-Unique: e7JYHVoOPaK7Uddguyd0jw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5FE9802C17;
        Thu, 16 Jun 2022 02:59:32 +0000 (UTC)
Received: from localhost (ovpn-12-237.pek2.redhat.com [10.72.12.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B4881410DD8;
        Thu, 16 Jun 2022 02:59:31 +0000 (UTC)
Date:   Thu, 16 Jun 2022 10:59:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jonathan McDowell <noodles@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v5] x86/kexec: Carry forward IMA measurement log on kexec
Message-ID: <Yqqcj0/j+fC6/K5v@MiWiFi-R3L-srv>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <YqcRuQFq5fg1XhB/@noodles-fedora.dhcp.thefacebook.com>
 <60813f86e960d12ed3738531a14382769a061a02.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60813f86e960d12ed3738531a14382769a061a02.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 06/13/22 at 05:01pm, Mimi Zohar wrote:
> On Mon, 2022-06-13 at 10:30 +0000, Jonathan McDowell wrote:
> > On kexec file load Integrity Measurement Architecture (IMA) subsystem
> > may verify the IMA signature of the kernel and initramfs, and measure
> > it. The command line parameters passed to the kernel in the kexec call
> > may also be measured by IMA. A remote attestation service can verify
> > a TPM quote based on the TPM event log, the IMA measurement list, and
> > the TPM PCR data. This can be achieved only if the IMA measurement log
> > is carried over from the current kernel to the next kernel across
> > the kexec call.
> > 
> > powerpc and ARM64 both achieve this using device tree with a
> > "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> > device tree, so use the setup_data mechanism to pass the IMA buffer to
> > the new kernel.
> > 
> > (Mimi, Baoquan, I haven't included your reviewed-bys because this has
> >  changed the compile guards around the ima_(free|get)_kexec_buffer
> >  functions in order to fix the warning the kernel test robot found. I
> >  think this is the right thing to do and avoids us compiling them on
> >  platforms where they won't be used. The alternative would be to drop
> >  the guards in ima.h that Mimi requested for v4.)hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
> > 
> > Signed-off-by: Jonathan McDowell <noodles@fb.com>
> > ---
> > v5:
> >  - Guard ima_(free|get)_kexec_buffer functions with
> >    CONFIG_HAVE_IMA_KEXEC (kernel test robot)
> >  - Use setup_data_offset in setup_boot_parameters and update rather than
> >    calculating in call to setup_ima_state.
> > v4:
> >  - Guard ima.h function prototypes with CONFIG_HAVE_IMA_KEXEC
> 
> > diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> > index 8d374cc552be..42a6c5721a43 100644
> > --- a/drivers/of/kexec.c
> > +++ b/drivers/of/kexec.c
> > @@ -9,6 +9,7 @@
> >   *  Copyright (C) 2016  IBM Corporation
> >   */
> >  
> > +#include <linux/ima.h>
> >  #include <linux/kernel.h>
> >  #include <linux/kexec.h>
> >  #include <linux/memblock.h>
> > @@ -115,6 +116,7 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_HAVE_IMA_KEXEC
> >  /**
> >   * ima_get_kexec_buffer - get IMA buffer from the previous kernel
> >   * @addr:	On successful return, set to point to the buffer contents.
> > @@ -173,6 +175,7 @@ int ima_free_kexec_buffer(void)
> >  
> >  	return memblock_phys_free(addr, size);
> >  }
> > +#endif
> 
> Inside ima_{get,free}_kexec_buffer(), there's no need now to test
> whether CONFIG_HAVE_IMA_KEXEC is enabled.
> 
>         if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
>                 return -ENOTSUPP;

Indeed. The #ifdef added by Jonathan is redundant. Not sure if the
original IS_ENABLED(CONFIG_HAVE_IMA_KEXEC) checking inside
ima_{get,free}_kexec_buffer() is intended. I ever reviewed below patch,
the IS_ENABLED(CONFIG_XX) inside static function will make the function
compiled, and will be optimized out if the CONFIG_XX is not enabled.
However, it only has effect on static function. Here,
ima_{get,free}_kexec_buffer() is not static, likely we should remove the
inside IS_ENABLED() checking.

commit 4ece09be9913a87ff99ea347fd7e7adad5bdbc8f
Author: Jisheng Zhang <jszhang@kernel.org>
Date:   Wed Mar 23 16:06:39 2022 -0700

    x86/setup: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
    
    Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE" by a
    check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code and
    increase compile coverage.

Other than this one Mimi pointed out, this patch looks good to me, thx.

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> 
> >  
> >  /**
> >   * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> 
> 

