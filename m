Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337BD2215AE
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 22:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgGOUCs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 16:02:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbgGOUCr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 16:02:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FK2elO095892;
        Wed, 15 Jul 2020 16:02:42 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 329r1j6sht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 16:02:41 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FK1ama014866;
        Wed, 15 Jul 2020 20:02:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3274pgvpf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 20:02:12 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FK2AFL66715856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 20:02:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E93C44C040;
        Wed, 15 Jul 2020 20:02:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3709A4C046;
        Wed, 15 Jul 2020 20:02:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 20:02:09 +0000 (GMT)
Message-ID: <1594843328.12900.342.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Check for tsspcrread in runtime
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Date:   Wed, 15 Jul 2020 16:02:08 -0400
In-Reply-To: <20200715195728.w3nysi73nkeuu3qv@altlinux.org>
References: <20200715132817.8529-1-pvorel@suse.cz>
         <20200715133741.GB32201@dell5510>
         <1594841666.12900.335.camel@linux.ibm.com>
         <20200715195728.w3nysi73nkeuu3qv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=973 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150149
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Patrick Uiterwijk]

On Wed, 2020-07-15 at 22:57 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Wed, Jul 15, 2020 at 03:34:26PM -0400, Mimi Zohar wrote:
> > On Wed, 2020-07-15 at 15:37 +0200, Petr Vorel wrote:
> > > Hi Mimi,
> > > 
> > > > instead of checking in build time as it's runtime dependency.
> > > > Also log when tsspcrread not found to make debugging easier.
> > > 
> > > > We search for tsspcrread unless there is tss2-esys with Esys_PCR_Read(),
> > > > thus pcr_none.c was dropped as unneeded.
> > > 
> > > > file_exist(), tst_get_path() and MIN() taken from LTP project.
> > > BTW these parts holds Cyril's copyright. If you ever add copyright to
> > > src/utils.[ch], please add it there.
> > > Copyright (C) 2010 Cyril Hrubis <chrubis@suse.cz>
> > 
> > Are you Ok with the following?
> > 
> > diff --git a/src/utils.c b/src/utils.c
> 
> I don't remember me authoring anything in src/utils.c

Thank you for catching that!  The new file came from Patrick.


> > index 416a88c6dbe4..a6ae08fa4d84 100644
> > --- a/src/utils.c
> > +++ b/src/utils.c
> > @@ -1,3 +1,10 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * utils: set of common functions
> > + *
> > + * Copyright (C) 2020 Vitaly Chikunov <vt@altlinux.org>

Copyright (C) 2020 Patrick Uiterwijk <patrick@puiterwijk.org>

> > + * Copyright (C) 2010 Cyril Hrubis <chrubis@suse.cz>
> > + */
> >  #include <stdint.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>

