Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8722AEAE
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jul 2020 14:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgGWMH7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jul 2020 08:07:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64722 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbgGWMH7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jul 2020 08:07:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NC1suL099214;
        Thu, 23 Jul 2020 08:07:55 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32f1pn5s82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 08:07:55 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NC4i6e018770;
        Thu, 23 Jul 2020 12:07:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 32brq8656y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 12:07:53 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NC7pI331523232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 12:07:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82D0FA405C;
        Thu, 23 Jul 2020 12:07:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4B78A405F;
        Thu, 23 Jul 2020 12:07:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.234])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 12:07:50 +0000 (GMT)
Message-ID: <1595506070.5211.103.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Drop empty NEWS file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>
Date:   Thu, 23 Jul 2020 08:07:50 -0400
In-Reply-To: <20200723115457.GA26679@dell5510>
References: <20200722114729.4210-1-pvorel@suse.cz>
         <1595428021.5311.93.camel@linux.ibm.com>
         <20200722144510.l5qwn62dlanbuul4@altlinux.org>
         <20200722145047.GB18945@dell5510> <1595431869.5311.102.camel@linux.ibm.com>
         <1595503098.5211.85.camel@linux.ibm.com> <20200723115457.GA26679@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230087
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-07-23 at 13:54 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> ...
> > After renaming "ChangeLog" to "NEWS" as discussed, autotools now
> > complains about the missing "ChangeLog" file.
> 
> > automake has a number of flavors[1][2].  The "foreign" flavor, which
> > can be supplied as an option to AM_INIT_AUTOMAKE, doesn't require the
> > NEWS, COPYING, AUTHORS, ChangeLog, or README files to exist.
> 
> > Although renaming the files didn't help, it makes sense.  The patch
> > does both - renames ChangeLog and uses the "foreign" option.
> 
> Thanks for fixing it. foreign flavor fits our needs better than gnu.
> Autotools "features" like this (having strange gnu flavor as the default)
> explain why people keep introducing new build systems like Meson (which brings
> other problems).

Changing the autotools flavor solved the problem, but I wasn't sure
that it was the correct solution.  Thank you for validating the flavor
change.

Mimi
