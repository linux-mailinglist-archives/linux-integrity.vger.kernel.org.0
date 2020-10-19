Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D042929CD
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Oct 2020 16:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgJSOyZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 10:54:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45780 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgJSOyZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 10:54:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEmvoZ104602;
        Mon, 19 Oct 2020 14:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=TQ0JsZZ4AfiOpUOA+G8dEsL4WPds5Z81PFZwUH3rk/A=;
 b=W1T1+qvqb1pNQhTWMxTWAdv35cythKxpTqlFtvIcJFTehFP+BZKS4wOUK+oTjYS5m00+
 bZVAE7GINidii1X+bjxvMQVlDd32QYrvEU5Eri2zctsssskId3BVYkUsG1RCmb4p6XH0
 l5PU2qGpqFB1iiywqEYLhERb+wkTvnOZ4gcsLXUZzwKHNVFA17m4c1W54nd131FLXves
 RWrs35qYy5d/S60N9aA73hKCRac+LNWE1immIq35hsN0t3RvjY9FubdEQUkTga9cFpxV
 9VLODF5sIBTDGcFarST22JHD4B0XPnGWgBvTcomHRNjg3HhrzwW2FayHdaicER2b/jYP 1g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 347p4ap4gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 14:54:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEipcq092608;
        Mon, 19 Oct 2020 14:52:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 348ahv23ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Oct 2020 14:52:00 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09JEpw1p025443;
        Mon, 19 Oct 2020 14:51:58 GMT
Received: from tomti.i.net-space.pl (/10.175.216.157)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Oct 2020 07:51:58 -0700
Date:   Mon, 19 Oct 2020 16:51:53 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20201019145153.7b6cg3rzj7g4njz6@tomti.i.net-space.pl>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
 <20201015182654.lgtht5fd2aaunczu@tomti.i.net-space.pl>
 <20201016205151.GA1618249@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016205151.GA1618249@rani.riverdale.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010190103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010190103
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 16, 2020 at 04:51:51PM -0400, Arvind Sankar wrote:
> On Thu, Oct 15, 2020 at 08:26:54PM +0200, Daniel Kiper wrote:
> >
> > I am discussing with Ross the other option. We can create
> > .rodata.mle_header section and put it at fixed offset as
> > kernel_info is. So, we would have, e.g.:
> >
> > arch/x86/boot/compressed/vmlinux.lds.S:
> >         .rodata.kernel_info KERNEL_INFO_OFFSET : {
> >                 *(.rodata.kernel_info)
> >         }
> >         ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
> >
> >         .rodata.mle_header MLE_HEADER_OFFSET : {
> >                 *(.rodata.mle_header)
> >         }
> >         ASSERT(ABSOLUTE(mle_header) == MLE_HEADER_OFFSET, "mle_header at bad address!")
> >
> > arch/x86/boot/compressed/sl_stub.S:
> > #define mleh_rva(X) (((X) - mle_header) + MLE_HEADER_OFFSET)
> >
> >         .section ".rodata.mle_header", "a"
> >
> > SYM_DATA_START(mle_header)
> >         .long   0x9082ac5a    /* UUID0 */
> >         .long   0x74a7476f    /* UUID1 */
> >         .long   0xa2555c0f    /* UUID2 */
> >         .long   0x42b651cb    /* UUID3 */
> >         .long   0x00000034    /* MLE header size */
> >         .long   0x00020002    /* MLE version 2.2 */
> >         .long   mleh_rva(sl_stub_entry)    /* Linear entry point of MLE (virt. address) */
> >         .long   0x00000000    /* First valid page of MLE */
> >         .long   0x00000000    /* Offset within binary of first byte of MLE */
> >         .long   0x00000000    /* Offset within binary of last byte + 1 of MLE */
> >         .long   0x00000223    /* Bit vector of MLE-supported capabilities */
> >         .long   0x00000000    /* Starting linear address of command line (unused) */
> >         .long   0x00000000    /* Ending linear address of command line (unused) */
> > SYM_DATA_END(mle_header)
> >
> > Of course MLE_HEADER_OFFSET has to be defined as a constant somewhere.
> > Anyway, is it acceptable?

What do you think about my MLE_HEADER_OFFSET and related stuff proposal?

> > There is also another problem. We have to put into mle_header size of
> > the Linux kernel image. Currently it is done by the bootloader but
> > I think it is not a role of the bootloader. The kernel image should
> > provide all data describing its properties and do not rely on the
> > bootloader to do that. Ross and I investigated various options but we
> > did not find a good/simple way to do that. Could you suggest how we
> > should do that or at least where we should take a look to get some
> > ideas?
> >
> > Daniel
>
> What exactly is the size you need here? Is it just the size of the
> protected mode image, that's startup_32 to _edata. Or is it the size of
> the whole bzImage file, or something else? I guess the same question
> applies to "first valid page of MLE" and "first byte of MLE", and the
> linear entry point -- are those all relative to startup_32 or do they
> need to be relative to the start of the bzImage, i.e. you have to add
> the size of the real-mode boot stub?
>
> If you need to include the size of the bzImage file, that's not known
> when the files in boot/compressed are built. It's only known after the
> real-mode stub is linked. arch/x86/boot/tools/build.c fills in various
> details in the setup header and creates the bzImage file, but it does
> not currently modify anything in the protected-mode portion of the
> compressed kernel (i.e. arch/x86/boot/compressed/vmlinux, which then
> gets converted to binary format as arch/x86/boot/vmlinux.bin), so it
> would need to be extended if you need to modify the MLE header to
> include the bzImage size or anything depending on the size of the
> real-mode stub.

Ross clarified this. So, I not have to add much here.

Daniel
