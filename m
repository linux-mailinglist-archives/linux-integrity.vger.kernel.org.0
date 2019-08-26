Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2808B9CFC0
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Aug 2019 14:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbfHZMoF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Aug 2019 08:44:05 -0400
Received: from mx0a-00176a03.pphosted.com ([67.231.149.52]:65452 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730339AbfHZMoF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Aug 2019 08:44:05 -0400
X-Greylist: delayed 2407 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Aug 2019 08:44:04 EDT
Received: from pps.filterd (m0047962.ppops.net [127.0.0.1])
        by m0047962.ppops.net-00176a03. (8.16.0.42/8.16.0.42) with SMTP id x7QC3qAY043962;
        Mon, 26 Aug 2019 08:03:57 -0400
From:   "Safford, David (GE Global Research, US)" <david.safford@ge.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Seunghun Han <kkamagui@gmail.com>
CC:     Peter Huewe <peterhuewe@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Thread-Topic: Re: [PATCH] tpm: tpm_crb: Add an AMD fTPM support feature
Thread-Index: AQHVW2w9adn8CXNrxUe37sfJUFBZA6cNMu+AgAAc+0A=
Date:   Mon, 26 Aug 2019 11:58:40 +0000
Message-ID: <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1BAA7@ALPMBAPA12.e2k.ad.ge.com>
References: <20190825174019.5977-1-kkamagui@gmail.com>
 <20190826055903.5um5pfweoszibem3@linux.intel.com>
In-Reply-To: <20190826055903.5um5pfweoszibem3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcMjEyNDczOTUwXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZDZkMWNlNjUtYzdmOC0xMWU5LThlMmQtYTRjM2YwYjU5OGE2XGFtZS10ZXN0XGQ2ZDFjZTY3LWM3ZjgtMTFlOS04ZTJkLWE0YzNmMGI1OThhNmJvZHkudHh0IiBzej0iMzA0MSIgdD0iMTMyMTEyOTQzMTkxNzE0MTM2IiBoPSIyTzZNYkMxUktqdGtoVXBLd2tES29GVlc4U2c9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [3.159.19.191]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Subject: [PATCH] tpm: tpm_crb: Add an AMD fTPM support feature
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=827 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908260136
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: linux-integrity-owner@vger.kernel.org <linux-integrity-
> owner@vger.kernel.org> On Behalf Of Jarkko Sakkinen
> Sent: Monday, August 26, 2019 1:59 AM
> To: Seunghun Han <kkamagui@gmail.com>
> Cc: Peter Huewe <peterhuewe@gmx.de>; Thomas Gleixner
> <tglx@linutronix.de>; linux-kernel@vger.kernel.org; linux-
> integrity@vger.kernel.org
> Subject: EXT: Re: [PATCH] tpm: tpm_crb: Add an AMD fTPM support feature
> 
> On Mon, Aug 26, 2019 at 02:40:19AM +0900, Seunghun Han wrote:
> > I'm Seunghun Han and work at the Affiliated Institute of ETRI. I got
> > an AMD system which had a Ryzen Threadripper 1950X and MSI mainboard,
> > and I had a problem with AMD's fTPM. My machine showed an error
> > message below, and the fTPM didn't work because of it.
> >
> > [    5.732084] tpm_crb MSFT0101:00: can't request region for resource
> >                [mem 0x79b4f000-0x79b4ffff]
> > [    5.732089] tpm_crb: probe of MSFT0101:00 failed with error -16
> >
> > When I saw the iomem areas and found two TPM CRB regions were in the
> > ACPI NVS area.  The iomem regions are below.
> >
> > 79a39000-79b6afff : ACPI Non-volatile Storage
> >   79b4b000-79b4bfff : MSFT0101:00
> >   79b4f000-79b4ffff : MSFT0101:00
> >
> > After analyzing this issue, I found out that a busy bit was set to the
> > ACPI NVS area, and the current Linux kernel allowed nothing to be
> > assigned in it. I also found that the kernel couldn't calculate the
> > sizes of command and response buffers correctly when the TPM regions
> were two or more.
> >
> > To support AMD's fTPM, I removed the busy bit from the ACPI NVS area
> > so that AMD's fTPM regions could be assigned in it. I also fixed the
> > bug that did not calculate the sizes of command and response buffer
> correctly.

The problem is that the acpi tables are _wrong_ in this and other cases.
They not only incorrectly report the area as reserved, but also report
the command and response buffer sizes incorrectly. If you look at
the addresses for the buffers listed in the crb control area, the sizes
are correct (4Kbytes).  My patch uses the control area values, and
everything works. The remaining problem is that if acpi reports the
area as NVS, then the linux nvs driver will try to use the space.
I'm looking at how to fix that. I'm not sure, if simply removing
the busy bit is sufficient.
Dave

> >
> > Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> 
> You need to split this into multiple patches e.g. if you think you've fixed a
> bug, please write a patch with just the bug fix and nothing else.
> 
> For further information, read the section three of
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
> I'd also recommend to check out the earlier discussion on ACPI NVS:
> 
> https://lore.kernel.org/linux-
> integrity/BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e
> 2k.ad.ge.com/
> 
> /Jarkko
