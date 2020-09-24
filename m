Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6333B2777E5
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Sep 2020 19:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgIXRiG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Sep 2020 13:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXRiF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Sep 2020 13:38:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D62C0613CE;
        Thu, 24 Sep 2020 10:38:05 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q5so286891qkc.2;
        Thu, 24 Sep 2020 10:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5bhRjdNmwctA9bi8GxsYvmMwgzV/9dcdCn2Ip4F4euc=;
        b=cZOWGP+ALCi4vj4BHTzKgWDrtzwE4tF3jGNpkhuLUh6fG/k8zqpGq1Lo/0dcBLLoIi
         pPGI5IpS/OrzvOjkni8+1PZ149ujLT0LOP6DV/JchuR6Qm2t3wNtyHG6ve58+vpA1a+n
         vo9tdcnK4n/fTNOQCs55j4rhmmB4gid8Yk08zVDqQHhgx6gWFwcbAHR0ggH6v1Hu9XQg
         NWk8LyxkU2lLBfuX9c41Izqi6n4RXF8OzcYv/vBHceR4AQDOinz6HygZUKBdg1Ok6Fhz
         x7PDV/Kr3TTU4rGFdiyUzzj3q20kP8wByDlsqyrvCMsSIga89AVXjSHZt/HQ36A/Zqys
         Zm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5bhRjdNmwctA9bi8GxsYvmMwgzV/9dcdCn2Ip4F4euc=;
        b=EMrsNQXf4gCxtm1u3qeXqYCljaVzImbs5t2tgxVSEFEYnOYu141mHiKutlLC7bXHDY
         PlsQ+BMtUZUrg5Av+HOpRmViWVzCpsjUKDN5NDPG6eQQFFAUAXWh4I0pLqN+qu3eQ85p
         +/a1qG1jwVvoAcAFz+AVYHTzR49bQrMCei+XqMr/oAhCKBWOSxeFvMhLC0Zrg/7fQBd+
         XgxUwvS3VwhCb+pV2xBr6GEldGZLVLJD1TzfNQD0aD3zk0jjtKvQI6k54x43F9lCnDej
         ihhwfyoSUIYb09eXKLr17czvAdNv1W8UO3yx6rdb2iK9TYATNulfyq03oXhAzhJvoR1e
         AbbA==
X-Gm-Message-State: AOAM531+HhRlU4/fQPZZYI5GoKpHSJ03TR08FOwCyUnKS5M6A/gjbKmj
        gEedA1FF5YcL2pXQVhLCoFA=
X-Google-Smtp-Source: ABdhPJzvAQTyLYVuqTgONX5CqLnI4a7/K1S3m2ztmokOk/j35ocAhw/nB+FROtf10E9RL4+9MkjRSg==
X-Received: by 2002:a37:9c8:: with SMTP id 191mr213412qkj.292.1600969083722;
        Thu, 24 Sep 2020 10:38:03 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n136sm96584qkn.14.2020.09.24.10.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 10:38:03 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 24 Sep 2020 13:38:01 -0400
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20200924173801.GA103726@rani.riverdale.lan>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 24, 2020 at 10:58:35AM -0400, Ross Philipson wrote:
> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
> later AMD SKINIT) to vector to during the late launch. The symbol
> sl_stub_entry is that entry point and its offset into the kernel is
> conveyed to the launching code using the MLE (Measured Launch
> Environment) header in the structure named mle_header. The offset of the
> MLE header is set in the kernel_info. The routine sl_stub contains the
> very early late launch setup code responsible for setting up the basic
> environment to allow the normal kernel startup_32 code to proceed. It is
> also responsible for properly waking and handling the APs on Intel
> platforms. The routine sl_main which runs after entering 64b mode is
> responsible for measuring configuration and module information before
> it is used like the boot params, the kernel command line, the TXT heap,
> an external initramfs, etc.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Which version of the kernel is this based on?

> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 97d37f0..42043bf 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -279,6 +279,21 @@ SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
>  SYM_FUNC_END(efi32_stub_entry)
>  #endif
>  
> +#ifdef CONFIG_SECURE_LAUNCH
> +SYM_FUNC_START(sl_stub_entry)
> +	/*
> +	 * On entry, %ebx has the entry abs offset to sl_stub_entry. To
> +	 * find the beginning of where we are loaded, sub off from the
> +	 * beginning.
> +	 */

This requirement should be added to the documentation. Is it necessary
or can this stub just figure out the address the same way as the other
32-bit entry points, using the scratch space in bootparams as a little
stack?

> +	leal	(startup_32 - sl_stub_entry)(%ebx), %ebx
> +
> +	/* More room to work in sl_stub in the text section */
> +	jmp	sl_stub
> +
> +SYM_FUNC_END(sl_stub_entry)
> +#endif
> +
>  	.code64
>  	.org 0x200
>  SYM_CODE_START(startup_64)
> @@ -537,6 +552,25 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>  	shrq	$3, %rcx
>  	rep	stosq
>  
> +#ifdef CONFIG_SECURE_LAUNCH
> +	/*
> +	 * Have to do the final early sl stub work in 64b area.
> +	 *
> +	 * *********** NOTE ***********
> +	 *
> +	 * Several boot params get used before we get a chance to measure
> +	 * them in this call. This is a known issue and we currently don't
> +	 * have a solution. The scratch field doesn't matter and loadflags
> +	 * have KEEP_SEGMENTS set by the stub code. There is no obvious way
> +	 * to do anything about the use of kernel_alignment or init_size
> +	 * though these seem low risk.
> +	 */

There are various fields in bootparams that depend on where the
kernel/initrd and cmdline are loaded in memory. If the entire bootparams
page is getting measured, does that mean they all have to be at fixed
addresses on every boot?

Also KEEP_SEGMENTS support is gone from the kernel since v5.7, since it
was unused. startup_32 now always loads a GDT and then the segment
registers. I think this should be ok for you as the only thing the flag
used to do in the 64-bit kernel was to stop startup_32 from blindly
loading __BOOT_DS into the segment registers before it had setup its own
GDT.

For the 32-bit assembler code that's being added, tip/master now has
changes that prevent the compressed kernel from having any runtime
relocations.  You'll need to revise some of the code and the data
structures initial values to avoid creating relocations.

Thanks.
