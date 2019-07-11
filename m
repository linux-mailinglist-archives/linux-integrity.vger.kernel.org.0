Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09BDB65DBC
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfGKQpJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 12:45:09 -0400
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:22396 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728274AbfGKQpJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 12:45:09 -0400
Received: from pps.filterd (m0048300.ppops.net [127.0.0.1])
        by m0048300.ppops.net-00176a03. (8.16.0.27/8.16.0.27) with SMTP id x6BGifrs037860
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 12:45:07 -0400
From:   "Safford, David (GE Global Research, US)" <david.safford@ge.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Thread-Topic: Re: [PATCH] tpm_crb - workaround broken ACPI tables
Thread-Index: AdU34krwvcnCVlC5RnKeY3i0fswIjwAOGIMAAAVMYtA=
Date:   Thu, 11 Jul 2019 16:44:59 +0000
Message-ID: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7C56@ALPMBAPA12.e2k.ad.ge.com>
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
 <20190711145850.GC25807@ziepe.ca>
In-Reply-To: <20190711145850.GC25807@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcMjEyNDczOTUwXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzcyZWViMGQtYTNmYi0xMWU5LThkZmQtYTRjM2YwYjU5OGE2XGFtZS10ZXN0XDM3MmVlYjBlLWEzZmItMTFlOS04ZGZkLWE0YzNmMGI1OThhNmJvZHkudHh0IiBzej0iMjQ2NSIgdD0iMTMyMDczMzcwOTgwMTg2NTcyIiBoPSJhR1RTZGtldFpWUGovck5WOThIc2ZHUnR6K289IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [3.159.19.191]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Subject: [PATCH] tpm_crb - workaround broken ACPI tables
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907110185
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, July 11, 2019 10:59 AM
> To: Safford, David (GE Global Research, US) <david.safford@ge.com>
> Cc: linux-integrity@vger.kernel.org; jarkko.sakkinen@linux.intel.com;
> Wiseman, Monty (GE Global Research, US) <monty.wiseman@ge.com>
> Subject: EXT: Re: [PATCH] tpm_crb - workaround broken ACPI tables
> 
> On Thu, Jul 11, 2019 at 12:29:30PM +0000, Safford, David (GE Global Research,
> US) wrote:
> > Most x86 desktops and laptops have firmware TPMs which support the CRB
> > interface. Unfortunately, the linux tpm_crb driver depends on
> > perfectly correct ACPI tables, and there are a *lot* of systems out
> > there with broken tpm_crb entries. (Not one of my five tpm_crb systems
> > works with the existing driver.) While it is good to encourage vendors
> > to fix their firmware, many refuse ("It works on Windows"), leaving
> > users in the lurch.
> >
> > This patch adds a kernel parameter "tpm_crb.force=1" that works around
> > the problem in every case I have tested so far. Basically it does two
> > things:
> > 	- it trusts the cmd and resp addresses in the CRB registers
> > 	- it ignores all alleged IO resource conflicts
> >
> > Both workarounds make sense. If there really were an address conflict,
> > or if the register values really were wrong, the device would not be
> > working at all. And testing with this patch has shown that in every
> > case (so far), the problem has been bogus ACPI entries.
> >
> > This patch is against the upstream 5.2 kernel.
> >
> > Signed-off-by: David Safford <david.safford@ge.com>
> 
> I think we need to ask the ioresource and ACPI people how to fix this
> properly and automatically. Maybe some ACPI quirk or maybe we try to
> resorve the resoruce and fall back to forcing or something
> 
> I don't think t a module parameter is the right answer
> 
> Jaason

I would argue that this is the right place to fix the problem, as only the 
tpm_crb driver has the semantic knowledge to get the valid addresses
and sizes from the tpm_crb device registers dynamically. I'm not sure how 
you would fix things in the ACPI subsystem, without a monstrous table for
all the broken systems, or duplicating the driver's code. And I think we
want a module parameter, both for safety, and to encourage vendors to
fix their tables.

dave
