Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E8C292C4E
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Oct 2020 19:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbgJSRGV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 13:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbgJSRGT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 13:06:19 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE73C0613CE;
        Mon, 19 Oct 2020 10:06:18 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z33so316501qth.8;
        Mon, 19 Oct 2020 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QlZ9jQiPI8wiI9R/8Eu0+GjPBdTOfIetM3KH+KtgMXI=;
        b=TSfCaGE5nALMYvm6jXC7miu7tdEMeBbQ/oo3OvVvTIzuhQs5UqEpBSvY5xi8Zva1Or
         OEmq6yA8Xwttc6yR4yh/GzBqDWS/8vZ3OcawGCl2JSSGA5gmjBcBPOQKJ/l6phRk5knh
         bZrFVjTIQoVxXaD/4aONZoqa0BchWNbGQ3vHn6IzPxldgquacqdFtfT06wDMoNJybhmx
         xPmSczVEDJjvs4T8ePUIE79ol1KcwWM1r7inus1jwbZ3OuU2qM9o2IZgDfQspyVEGjGY
         IG+D8+VldXK00eD5H9N2rSitkxqWC0fjHNr3zM6elj0WNiqh0gePl/DqLCMcfgLOO93L
         JsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QlZ9jQiPI8wiI9R/8Eu0+GjPBdTOfIetM3KH+KtgMXI=;
        b=kamfaFVZbuLLWSLcIHliyvBudZzIObnuOSTs3KDL67Z+O31uR5S4iJjFK6wx6wh+8l
         OkrAtfQOwk0IVI3yuN099MYKy8C1n9+YaEwUMmHZx/E9zMMA+6rUv+D75iq8Zx+5h0Yp
         4NLf7Vi/iUTpwjlaNpAWyn/bKkknc+r+SQoz9vNpnymaxT2XH1dl6HIMN8lyQeJ9B0Va
         LFNq3alKAxVRv/jVY/U4wIQrpScBnXsoGQAagOryb+AjMMxxcBGx2iaKGwArNGp6oMq2
         RPjtzBpeGsGIrf3rghmFyC+JDo+fPUqotCuH9Y3ez6puCA5uuAcon5cMgVh5x4BIu8kd
         uhMA==
X-Gm-Message-State: AOAM532W5V1oN9P/fPC4bqinxCIu+p+IpuGT4xHnNB+2km481nYHaAKq
        hW6a5s/DhY2lvEw6Hu4MfTQ=
X-Google-Smtp-Source: ABdhPJwoZOuQWDFVA3DgogqmZ+TbE08fVV8ZWC3ILvYzlMSC4BsTgymar/lGVLzLn2+P+AQ6+IEIsA==
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr424004qta.176.1603127177979;
        Mon, 19 Oct 2020 10:06:17 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v14sm180923qta.44.2020.10.19.10.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:06:16 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 19 Oct 2020 13:06:15 -0400
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20201019170615.GB2701355@rani.riverdale.lan>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
 <20201015182654.lgtht5fd2aaunczu@tomti.i.net-space.pl>
 <20201016205151.GA1618249@rani.riverdale.lan>
 <7529a1e7-4dd6-ab3a-6363-23fd2de6c338@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7529a1e7-4dd6-ab3a-6363-23fd2de6c338@oracle.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 19, 2020 at 10:38:08AM -0400, Ross Philipson wrote:
> On 10/16/20 4:51 PM, Arvind Sankar wrote:
> > On Thu, Oct 15, 2020 at 08:26:54PM +0200, Daniel Kiper wrote:
> >>
> >> I am discussing with Ross the other option. We can create
> >> .rodata.mle_header section and put it at fixed offset as
> >> kernel_info is. So, we would have, e.g.:
> >>
> >> arch/x86/boot/compressed/vmlinux.lds.S:
> >>         .rodata.kernel_info KERNEL_INFO_OFFSET : {
> >>                 *(.rodata.kernel_info)
> >>         }
> >>         ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
> >>
> >>         .rodata.mle_header MLE_HEADER_OFFSET : {
> >>                 *(.rodata.mle_header)
> >>         }
> >>         ASSERT(ABSOLUTE(mle_header) == MLE_HEADER_OFFSET, "mle_header at bad address!")
> >>
> >> arch/x86/boot/compressed/sl_stub.S:
> >> #define mleh_rva(X) (((X) - mle_header) + MLE_HEADER_OFFSET)
> >>
> >>         .section ".rodata.mle_header", "a"
> >>
> >> SYM_DATA_START(mle_header)
> >>         .long   0x9082ac5a    /* UUID0 */
> >>         .long   0x74a7476f    /* UUID1 */
> >>         .long   0xa2555c0f    /* UUID2 */
> >>         .long   0x42b651cb    /* UUID3 */
> >>         .long   0x00000034    /* MLE header size */
> >>         .long   0x00020002    /* MLE version 2.2 */
> >>         .long   mleh_rva(sl_stub_entry)    /* Linear entry point of MLE (virt. address) */
> >>         .long   0x00000000    /* First valid page of MLE */
> >>         .long   0x00000000    /* Offset within binary of first byte of MLE */
> >>         .long   0x00000000    /* Offset within binary of last byte + 1 of MLE */
> >>         .long   0x00000223    /* Bit vector of MLE-supported capabilities */
> >>         .long   0x00000000    /* Starting linear address of command line (unused) */
> >>         .long   0x00000000    /* Ending linear address of command line (unused) */
> >> SYM_DATA_END(mle_header)
> >>
> >> Of course MLE_HEADER_OFFSET has to be defined as a constant somewhere.
> >> Anyway, is it acceptable?
> >>
> >> There is also another problem. We have to put into mle_header size of
> >> the Linux kernel image. Currently it is done by the bootloader but
> >> I think it is not a role of the bootloader. The kernel image should
> >> provide all data describing its properties and do not rely on the
> >> bootloader to do that. Ross and I investigated various options but we
> >> did not find a good/simple way to do that. Could you suggest how we
> >> should do that or at least where we should take a look to get some
> >> ideas?
> >>
> >> Daniel
> > 
> > What exactly is the size you need here? Is it just the size of the
> > protected mode image, that's startup_32 to _edata. Or is it the size of
> 
> It is the size of the protected mode image. Though how to reference
> those symbols to get the size might all more relocation issues.
> 

Ok, then I think mleh_rva(_edata) should get you that -- I assume you
don't want to include the uninitialized data in the size? The kernel
will access memory beyond _edata (upto the init_size in the setup
header), but that's not part of the image itself.
