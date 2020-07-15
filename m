Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D009C22152C
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 21:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgGOTef (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 15:34:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1160 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgGOTee (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 15:34:34 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FJXQor008347;
        Wed, 15 Jul 2020 15:34:31 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 327u1jxc32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 15:34:31 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FJQ1JY001379;
        Wed, 15 Jul 2020 19:34:29 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 329nmyh123-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 19:34:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FJX4wW60228078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 19:33:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 242C6A4054;
        Wed, 15 Jul 2020 19:34:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A703A405C;
        Wed, 15 Jul 2020 19:34:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 19:34:26 +0000 (GMT)
Message-ID: <1594841666.12900.335.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Check for tsspcrread in runtime
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Wed, 15 Jul 2020 15:34:26 -0400
In-Reply-To: <20200715133741.GB32201@dell5510>
References: <20200715132817.8529-1-pvorel@suse.cz>
         <20200715133741.GB32201@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150149
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-07-15 at 15:37 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> > instead of checking in build time as it's runtime dependency.
> > Also log when tsspcrread not found to make debugging easier.
> 
> > We search for tsspcrread unless there is tss2-esys with Esys_PCR_Read(),
> > thus pcr_none.c was dropped as unneeded.
> 
> > file_exist(), tst_get_path() and MIN() taken from LTP project.
> BTW these parts holds Cyril's copyright. If you ever add copyright to
> src/utils.[ch], please add it there.
> Copyright (C) 2010 Cyril Hrubis <chrubis@suse.cz>

Are you Ok with the following?

diff --git a/src/utils.c b/src/utils.c
index 416a88c6dbe4..a6ae08fa4d84 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -1,3 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * utils: set of common functions
+ *
+ * Copyright (C) 2020 Vitaly Chikunov <vt@altlinux.org>
+ * Copyright (C) 2010 Cyril Hrubis <chrubis@suse.cz>
+ */
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>

Mimi

