Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91EB294FFE
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Oct 2020 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502498AbgJUP3V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Oct 2020 11:29:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44872 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502354AbgJUP3U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Oct 2020 11:29:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LF8qWh058622;
        Wed, 21 Oct 2020 15:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=B7vBvfn8227zOvfWtf1187wJychX5h3pcBxw5mG5iYY=;
 b=X6zMf9Xi2Nhtuztf53wsLdasGvRSaNrdSwtdk0H5jxCIp7uGXo5xlPJWX1r7M4AuZuLD
 Iqyx98UMniAE5riHIMSf59eu/Im4D4CEVKzGyvFzCO3nbqaIc5/z0kxzbB3JUbOe+eoP
 52fCf1sMcPZojl3fU4aVvno8NFXr+lbkxH0wsSGtSqeiuCQfsrzqEPljqHKjA5HR5dDR
 1fztRgqDS/MrP4K1UMRheNCz8ggVQiMt5SC+hbIrgj3+xn7GnRmb7IDtYVylS7MEF5Fq
 9G1xpuUENS4IlNSoXuRgw3gJ+7YAHFiLNgLSR/r+gB4K75agxGEVmLGVmWSK7/Rg5BFn sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 349jrps9ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Oct 2020 15:28:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LF9u6s011436;
        Wed, 21 Oct 2020 15:28:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34ak18syk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Oct 2020 15:28:53 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09LFSdnw002429;
        Wed, 21 Oct 2020 15:28:39 GMT
Received: from tomti.i.net-space.pl (/10.175.162.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Oct 2020 08:28:38 -0700
Date:   Wed, 21 Oct 2020 17:28:33 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20201021152833.b3oys643ckcl5evq@tomti.i.net-space.pl>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
 <20201015182654.lgtht5fd2aaunczu@tomti.i.net-space.pl>
 <20201016205151.GA1618249@rani.riverdale.lan>
 <20201019145153.7b6cg3rzj7g4njz6@tomti.i.net-space.pl>
 <20201019171822.GD2701355@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019171822.GD2701355@rani.riverdale.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 19, 2020 at 01:18:22PM -0400, Arvind Sankar wrote:
> On Mon, Oct 19, 2020 at 04:51:53PM +0200, Daniel Kiper wrote:
> > On Fri, Oct 16, 2020 at 04:51:51PM -0400, Arvind Sankar wrote:
> > > On Thu, Oct 15, 2020 at 08:26:54PM +0200, Daniel Kiper wrote:
> > > >
> > > > I am discussing with Ross the other option. We can create
> > > > .rodata.mle_header section and put it at fixed offset as
> > > > kernel_info is. So, we would have, e.g.:
> > > >
> > > > arch/x86/boot/compressed/vmlinux.lds.S:
> > > >         .rodata.kernel_info KERNEL_INFO_OFFSET : {
> > > >                 *(.rodata.kernel_info)
> > > >         }
> > > >         ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
> > > >
> > > >         .rodata.mle_header MLE_HEADER_OFFSET : {
> > > >                 *(.rodata.mle_header)
> > > >         }
> > > >         ASSERT(ABSOLUTE(mle_header) == MLE_HEADER_OFFSET, "mle_header at bad address!")
> > > >
> > > > arch/x86/boot/compressed/sl_stub.S:
> > > > #define mleh_rva(X) (((X) - mle_header) + MLE_HEADER_OFFSET)
> > > >
> > > >         .section ".rodata.mle_header", "a"
> > > >
> > > > SYM_DATA_START(mle_header)
> > > >         .long   0x9082ac5a    /* UUID0 */
> > > >         .long   0x74a7476f    /* UUID1 */
> > > >         .long   0xa2555c0f    /* UUID2 */
> > > >         .long   0x42b651cb    /* UUID3 */
> > > >         .long   0x00000034    /* MLE header size */
> > > >         .long   0x00020002    /* MLE version 2.2 */
> > > >         .long   mleh_rva(sl_stub_entry)    /* Linear entry point of MLE (virt. address) */
> > > >         .long   0x00000000    /* First valid page of MLE */
> > > >         .long   0x00000000    /* Offset within binary of first byte of MLE */
> > > >         .long   0x00000000    /* Offset within binary of last byte + 1 of MLE */
> > > >         .long   0x00000223    /* Bit vector of MLE-supported capabilities */
> > > >         .long   0x00000000    /* Starting linear address of command line (unused) */
> > > >         .long   0x00000000    /* Ending linear address of command line (unused) */
> > > > SYM_DATA_END(mle_header)
> > > >
> > > > Of course MLE_HEADER_OFFSET has to be defined as a constant somewhere.
> > > > Anyway, is it acceptable?
> >
> > What do you think about my MLE_HEADER_OFFSET and related stuff proposal?
> >
>
> I'm wondering if it would be easier to just allow relocations in these
> special "header" sections. I need to check how easy/hard it is to do
> that without triggering linker warnings.

Ross and I still bouncing some ideas. We came to the conclusion that
putting mle_header into kernel .rodata.kernel_info section or even
arch/x86/boot/compressed/kernel_info.S file would be the easiest thing
to do at this point. Of course I would suggest some renaming too. E.g.
.rodata.kernel_info to .rodata.kernel_headers, etc. Does it make sense
for you?

Daniel
