Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A215292C86
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Oct 2020 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbgJSRS0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 13:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbgJSRS0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 13:18:26 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A76C0613CE;
        Mon, 19 Oct 2020 10:18:26 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z5so594302iob.1;
        Mon, 19 Oct 2020 10:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wFuBir/YvHjP7d2gN79CK1W0plZCBLGLO37M7axrAJc=;
        b=tom0/k4WXXuhLo9fMXkhcwJVWFLlbOfwy2ZDKO4pDqlJVTyW1mnvMTOMF7xBkhJLMH
         XA2ExSpeqrzTa6TrxCwNy0PFe+VjVkthpJM8r1Jcj45808b/ux+rxZuU+vbQ2jXPw46X
         vLdtSYXw2+SeECTEfH9cr0Urx/hryhDXIxCCM6mf/4tSz/VgtKqOcdcG911xC2RjCN/A
         R7ojbOrOpkfNDDNAvcXwlEpwai2K1pXxuuRXN+IyQUij71ZGr6xsDQVoYqBh1eg8xSwC
         5oFly5kXdA3kocrOdFTUms29scmU0N8OcGup+zr3+iQox9+N9Ha+t5cI9LNmvtfFaOtz
         eg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wFuBir/YvHjP7d2gN79CK1W0plZCBLGLO37M7axrAJc=;
        b=l/iI9q1n5MmcP2iNyh2AQh8z02ZPKOUv05aw/Tl7a4BWWI+3PBllD9pQdR67tpfFaE
         462NyRkicM3X15FfhACek8Gz4Fc+Jj0p4C4N2lMX729VnEy4sSvTmfOWNALW6Tibo8Zg
         L7Hkl1A6T2FfHxe/0LbI8IYDOEfTjYUcvKGeE7/FqLCtwbnwSkAvXCr8C9BKtYPjOKZl
         ShDgTqKVM0ECPr/TZR7CWk9RTpBBhTKR3FDvnJaAbtZFQydB8lGVdhvnwODHBZMWBRTA
         v8rBDWUHyDzdYM49HiDjWnE15J/ua27jWuqGJChaYXEZDFq5W13Tbaub+sVzvens3iYg
         rSRQ==
X-Gm-Message-State: AOAM533CpFxVhqIKIFLyXnqeN3rPRwCs5XEysKevt0eob0TOfi9SHyyp
        NJ4fz9bx/hjciiqV5jrnKbHuXSU9FkSHhw==
X-Google-Smtp-Source: ABdhPJwGkQyTAlZd6nur7A0Kug/p2kDbfsOyLBxur0jlqp1BYwHJi529A04rqSuOEM5tnJ1DDP+BSA==
X-Received: by 2002:a6b:144e:: with SMTP id 75mr381758iou.39.1603127905681;
        Mon, 19 Oct 2020 10:18:25 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v1sm396600ioe.0.2020.10.19.10.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:18:25 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 19 Oct 2020 13:18:22 -0400
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20201019171822.GD2701355@rani.riverdale.lan>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
 <20201015182654.lgtht5fd2aaunczu@tomti.i.net-space.pl>
 <20201016205151.GA1618249@rani.riverdale.lan>
 <20201019145153.7b6cg3rzj7g4njz6@tomti.i.net-space.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019145153.7b6cg3rzj7g4njz6@tomti.i.net-space.pl>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 19, 2020 at 04:51:53PM +0200, Daniel Kiper wrote:
> On Fri, Oct 16, 2020 at 04:51:51PM -0400, Arvind Sankar wrote:
> > On Thu, Oct 15, 2020 at 08:26:54PM +0200, Daniel Kiper wrote:
> > >
> > > I am discussing with Ross the other option. We can create
> > > .rodata.mle_header section and put it at fixed offset as
> > > kernel_info is. So, we would have, e.g.:
> > >
> > > arch/x86/boot/compressed/vmlinux.lds.S:
> > >         .rodata.kernel_info KERNEL_INFO_OFFSET : {
> > >                 *(.rodata.kernel_info)
> > >         }
> > >         ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
> > >
> > >         .rodata.mle_header MLE_HEADER_OFFSET : {
> > >                 *(.rodata.mle_header)
> > >         }
> > >         ASSERT(ABSOLUTE(mle_header) == MLE_HEADER_OFFSET, "mle_header at bad address!")
> > >
> > > arch/x86/boot/compressed/sl_stub.S:
> > > #define mleh_rva(X) (((X) - mle_header) + MLE_HEADER_OFFSET)
> > >
> > >         .section ".rodata.mle_header", "a"
> > >
> > > SYM_DATA_START(mle_header)
> > >         .long   0x9082ac5a    /* UUID0 */
> > >         .long   0x74a7476f    /* UUID1 */
> > >         .long   0xa2555c0f    /* UUID2 */
> > >         .long   0x42b651cb    /* UUID3 */
> > >         .long   0x00000034    /* MLE header size */
> > >         .long   0x00020002    /* MLE version 2.2 */
> > >         .long   mleh_rva(sl_stub_entry)    /* Linear entry point of MLE (virt. address) */
> > >         .long   0x00000000    /* First valid page of MLE */
> > >         .long   0x00000000    /* Offset within binary of first byte of MLE */
> > >         .long   0x00000000    /* Offset within binary of last byte + 1 of MLE */
> > >         .long   0x00000223    /* Bit vector of MLE-supported capabilities */
> > >         .long   0x00000000    /* Starting linear address of command line (unused) */
> > >         .long   0x00000000    /* Ending linear address of command line (unused) */
> > > SYM_DATA_END(mle_header)
> > >
> > > Of course MLE_HEADER_OFFSET has to be defined as a constant somewhere.
> > > Anyway, is it acceptable?
> 
> What do you think about my MLE_HEADER_OFFSET and related stuff proposal?
> 

I'm wondering if it would be easier to just allow relocations in these
special "header" sections. I need to check how easy/hard it is to do
that without triggering linker warnings.

Thanks.
