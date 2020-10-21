Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFEC295093
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Oct 2020 18:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444408AbgJUQSm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Oct 2020 12:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408858AbgJUQSm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Oct 2020 12:18:42 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0457AC0613CE;
        Wed, 21 Oct 2020 09:18:42 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id h11so1390014qvq.7;
        Wed, 21 Oct 2020 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CzKXJwhnXsatpgfBxJJmFGrX5HyZBJEIKL9JIRR+g5s=;
        b=D8ukPSf8Haz92tkcD9xdLoxLf3cJdNLzLMe6/3OB3u8gOfhMvE3Qfo/S4qoj6CMwUB
         CZ8cDdHBYNIqhLqT+SRrsSnrd7VLJyYDNmeJmwJOBjquQ7OdjMayHLQxCv3aPOshtyQg
         8CQckWQP0EUILR7vVRBnUjoieuQmEnLULrV2pcGbc2r5Ht60jY3nAwU0sykPICIzI50w
         kjBO1cp7oSZG0DBPUSPHrkdqLgONIYnGzggt0nbs9cVkfszxI7NYzkmM0Qyl4aBZDyfN
         +TYNtEPGEYAm2dBVeIyNPBL9m7PxnHHamzpgXRubnVuKht1f+I1Ja6sO48zFoNt/b3C3
         3Qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CzKXJwhnXsatpgfBxJJmFGrX5HyZBJEIKL9JIRR+g5s=;
        b=VdmROmS8+R6YdIe7MLbPkUnby02CfTP7UxSK3zKLh3oFOSeEtLlhtxQnxiA8QpZNFV
         6ZMo0n6f3xV2XSfG0u5EUQ1ZQ0V+T+tm/8ordehQJxRMblThotQgBDv+S9jftSEAyenn
         vQhtrA8D6ZmPgA/7x3s2b5lLrP1dKfI56G4z8+bp5/CxxOppmLzbjouZMXF6NtU68RCJ
         suowD+LGkkAE/mJJ8SyjT3AqojKN7fOkg7Jjo8CeosFlLrWJ3rhd/qCw9qo1OH+dVhFX
         FgChJfysxF9H8XL0tkP3mzzKoWsFv6zO/RzmJUoQVhSddX3kLv9o0QUcXqaj2pgyiQlJ
         jitA==
X-Gm-Message-State: AOAM530RljS1j0hbiScnpfS/iit6sI5IH3yk4NdSdtgiuHjjhHIYSgkk
        CXRc1DGMZeKhhVk7EngV7qY=
X-Google-Smtp-Source: ABdhPJzm4IIsqPihxypdU/hDH0/eZnfjM/QkTB3wKz8f9F9sCQeav7NdGj1QDwMCoX+46WaJUl131A==
X-Received: by 2002:ad4:44b3:: with SMTP id n19mr3609929qvt.39.1603297121078;
        Wed, 21 Oct 2020 09:18:41 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m15sm1511256qtc.90.2020.10.21.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:18:39 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 21 Oct 2020 12:18:37 -0400
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20201021161837.GA3795579@rani.riverdale.lan>
References: <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
 <20201015182654.lgtht5fd2aaunczu@tomti.i.net-space.pl>
 <20201016205151.GA1618249@rani.riverdale.lan>
 <20201019145153.7b6cg3rzj7g4njz6@tomti.i.net-space.pl>
 <20201019171822.GD2701355@rani.riverdale.lan>
 <20201021152833.b3oys643ckcl5evq@tomti.i.net-space.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021152833.b3oys643ckcl5evq@tomti.i.net-space.pl>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 21, 2020 at 05:28:33PM +0200, Daniel Kiper wrote:
> On Mon, Oct 19, 2020 at 01:18:22PM -0400, Arvind Sankar wrote:
> > On Mon, Oct 19, 2020 at 04:51:53PM +0200, Daniel Kiper wrote:
> > > On Fri, Oct 16, 2020 at 04:51:51PM -0400, Arvind Sankar wrote:
> > > > On Thu, Oct 15, 2020 at 08:26:54PM +0200, Daniel Kiper wrote:
> > > > >
> > > > > I am discussing with Ross the other option. We can create
> > > > > .rodata.mle_header section and put it at fixed offset as
> > > > > kernel_info is. So, we would have, e.g.:
> > > > >
> > > > > arch/x86/boot/compressed/vmlinux.lds.S:
> > > > >         .rodata.kernel_info KERNEL_INFO_OFFSET : {
> > > > >                 *(.rodata.kernel_info)
> > > > >         }
> > > > >         ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
> > > > >
> > > > >         .rodata.mle_header MLE_HEADER_OFFSET : {
> > > > >                 *(.rodata.mle_header)
> > > > >         }
> > > > >         ASSERT(ABSOLUTE(mle_header) == MLE_HEADER_OFFSET, "mle_header at bad address!")
> > > > >
> > > > > arch/x86/boot/compressed/sl_stub.S:
> > > > > #define mleh_rva(X) (((X) - mle_header) + MLE_HEADER_OFFSET)
> > > > >
> > > > >         .section ".rodata.mle_header", "a"
> > > > >
> > > > > SYM_DATA_START(mle_header)
> > > > >         .long   0x9082ac5a    /* UUID0 */
> > > > >         .long   0x74a7476f    /* UUID1 */
> > > > >         .long   0xa2555c0f    /* UUID2 */
> > > > >         .long   0x42b651cb    /* UUID3 */
> > > > >         .long   0x00000034    /* MLE header size */
> > > > >         .long   0x00020002    /* MLE version 2.2 */
> > > > >         .long   mleh_rva(sl_stub_entry)    /* Linear entry point of MLE (virt. address) */
> > > > >         .long   0x00000000    /* First valid page of MLE */
> > > > >         .long   0x00000000    /* Offset within binary of first byte of MLE */
> > > > >         .long   0x00000000    /* Offset within binary of last byte + 1 of MLE */
> > > > >         .long   0x00000223    /* Bit vector of MLE-supported capabilities */
> > > > >         .long   0x00000000    /* Starting linear address of command line (unused) */
> > > > >         .long   0x00000000    /* Ending linear address of command line (unused) */
> > > > > SYM_DATA_END(mle_header)
> > > > >
> > > > > Of course MLE_HEADER_OFFSET has to be defined as a constant somewhere.
> > > > > Anyway, is it acceptable?
> > >
> > > What do you think about my MLE_HEADER_OFFSET and related stuff proposal?
> > >
> >
> > I'm wondering if it would be easier to just allow relocations in these
> > special "header" sections. I need to check how easy/hard it is to do
> > that without triggering linker warnings.
> 
> Ross and I still bouncing some ideas. We came to the conclusion that
> putting mle_header into kernel .rodata.kernel_info section or even
> arch/x86/boot/compressed/kernel_info.S file would be the easiest thing
> to do at this point. Of course I would suggest some renaming too. E.g.
> .rodata.kernel_info to .rodata.kernel_headers, etc. Does it make sense
> for you?
> 
> Daniel

I haven't been able to come up with any different options that don't
require post-processing of the kernel image. Allowing relocations in
specific sections seems to not be possible with lld, and anyway would
require the fields to be 64-bit sized so it doesn't really help.

Putting mle_header into kernel_info seems like a reasonable thing to me,
and if you do that, putting it into kernel_info.S would seem to be
necessary?  Would you also have a fixed field with the offset of the
mle_header from kernel_info?  That seems nicer than having the
bootloader scan the variable data for magic strings.
