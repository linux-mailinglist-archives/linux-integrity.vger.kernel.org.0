Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A79128F87E
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Oct 2020 20:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391022AbgJOS1k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Oct 2020 14:27:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48750 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbgJOS1j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Oct 2020 14:27:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FIAcSn042985;
        Thu, 15 Oct 2020 18:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Pbs6sItLT9P+3Wm5yB8xeVF+/nDCCHUlx/SaWc5x4sg=;
 b=JZXLPH0mKC0PI23vZ1Iqc+DNQYsGy3+c+GwqGykt5CrjdOAdRt6900nobqgBNZ1sDloy
 FaYL2ywwpq2BjO/iYj7bdbv3xO9R7JfUjA47DdEHY/SfvvdYSYwQ8X9MpPwlL2tvZLB6
 rmOH0KoBNvylaCLh/+taYfR+dEjCEYJLZBMTtM1IcR2vPDdE4DF9pRb6v9Bi6N0zJkU+
 kZqD32+SRIks2+hBUBlLmZ+fT28/OevDGRhNSRurHiudag8cuzv2/j6dFs41vDElf5aM
 TIJfPwIJxUtw7nDG3hmkmFd5QC7p8zMXwh4iVKvLqv5ly6i0dF58/YRgbYFy1igvc+CR fQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3434wkxant-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 18:27:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FIAeTR018733;
        Thu, 15 Oct 2020 18:27:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 343pw0r6uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 18:27:07 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09FIR0l0029619;
        Thu, 15 Oct 2020 18:27:00 GMT
Received: from tomti.i.net-space.pl (/10.175.198.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Oct 2020 11:27:00 -0700
Date:   Thu, 15 Oct 2020 20:26:54 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20201015182654.lgtht5fd2aaunczu@tomti.i.net-space.pl>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150122
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 29, 2020 at 10:03:47AM -0400, Ross Philipson wrote:
> On 9/25/20 3:18 PM, Arvind Sankar wrote:

[...]

> > You should see them if you do
> > 	readelf -r arch/x86/boot/compressed/vmlinux
> >
> > In terms of the code, things like:
> >
> > 	addl    %ebx, (sl_gdt_desc + 2)(%ebx)
> >
> > will create a relocation, because the linker interprets this as wanting
> > the runtime address of sl_gdt_desc, rather than just the offset from
> > startup_32.
> >
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/arch/x86/boot/compressed/head_64.S*n48__;Iw!!GqivPVa7Brio!JpZWv1cCPZdjD2jbCCGT7P9UIVl_lhX7YjckAnUcvi927jwZI7X3nX0MpIAZOyktJds$
> >
> > has a comment with some explanation and a macro that the 32-bit code in
> > startup_32 uses to avoid creating relocations.
> >
> > Since the SL code is in a different assembler file (and a different
> > section), you can't directly use the same macro. I would suggest getting
> > rid of sl_stub_entry and entering directly at sl_stub, and then the code
> > in sl_stub.S can use sl_stub for the base address, defining the rva()
> > macro there as
> >
> > 	#define rva(X) ((X) - sl_stub)
> >
> > You will also need to avoid initializing data with symbol addresses.
> >
> > 	.long mle_header
> > 	.long sl_stub_entry
> > 	.long sl_gdt
> >
> > will create relocations. The third one is easy, just replace it with
> > sl_gdt - sl_gdt_desc and initialize it at runtime with
> >
> > 	leal	rva(sl_gdt_desc)(%ebx), %eax
> > 	addl	%eax, 2(%eax)
> > 	lgdt	(%eax)
> >
> > The other two are more messy, unfortunately there is no easy way to tell
> > the linker what we want here. The other entry point addresses (for the
> > EFI stub) are populated in a post-processing step after the compressed
> > kernel has been linked, we could teach it to also update kernel_info.
> >
> > Without that, for kernel_info, you could change it to store the offset
> > of the MLE header from kernel_info, instead of from the start of the
> > image.
> >
> > For the MLE header, it could be moved to .head.text in head_64.S, and
> > initialized with
> > 	.long rva(sl_stub)
> > This will also let it be placed at a fixed offset from startup_32, so
> > that kernel_info can just be populated with a constant.

I am discussing with Ross the other option. We can create
.rodata.mle_header section and put it at fixed offset as
kernel_info is. So, we would have, e.g.:

arch/x86/boot/compressed/vmlinux.lds.S:
        .rodata.kernel_info KERNEL_INFO_OFFSET : {
                *(.rodata.kernel_info)
        }
        ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")

        .rodata.mle_header MLE_HEADER_OFFSET : {
                *(.rodata.mle_header)
        }
        ASSERT(ABSOLUTE(mle_header) == MLE_HEADER_OFFSET, "mle_header at bad address!")

arch/x86/boot/compressed/sl_stub.S:
#define mleh_rva(X) (((X) - mle_header) + MLE_HEADER_OFFSET)

        .section ".rodata.mle_header", "a"

SYM_DATA_START(mle_header)
        .long   0x9082ac5a    /* UUID0 */
        .long   0x74a7476f    /* UUID1 */
        .long   0xa2555c0f    /* UUID2 */
        .long   0x42b651cb    /* UUID3 */
        .long   0x00000034    /* MLE header size */
        .long   0x00020002    /* MLE version 2.2 */
        .long   mleh_rva(sl_stub_entry)    /* Linear entry point of MLE (virt. address) */
        .long   0x00000000    /* First valid page of MLE */
        .long   0x00000000    /* Offset within binary of first byte of MLE */
        .long   0x00000000    /* Offset within binary of last byte + 1 of MLE */
        .long   0x00000223    /* Bit vector of MLE-supported capabilities */
        .long   0x00000000    /* Starting linear address of command line (unused) */
        .long   0x00000000    /* Ending linear address of command line (unused) */
SYM_DATA_END(mle_header)

Of course MLE_HEADER_OFFSET has to be defined as a constant somewhere.
Anyway, is it acceptable?

There is also another problem. We have to put into mle_header size of
the Linux kernel image. Currently it is done by the bootloader but
I think it is not a role of the bootloader. The kernel image should
provide all data describing its properties and do not rely on the
bootloader to do that. Ross and I investigated various options but we
did not find a good/simple way to do that. Could you suggest how we
should do that or at least where we should take a look to get some
ideas?

Daniel
