Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A100122AD78
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jul 2020 13:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGWLS2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jul 2020 07:18:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727828AbgGWLS1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jul 2020 07:18:27 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NB4L4d039784;
        Thu, 23 Jul 2020 07:18:23 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32f1vm3kmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 07:18:23 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NBFja8026779;
        Thu, 23 Jul 2020 11:18:21 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 32brq7p3qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 11:18:21 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NBIJb362521520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 11:18:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8281F4C04E;
        Thu, 23 Jul 2020 11:18:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7F164C044;
        Thu, 23 Jul 2020 11:18:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.234])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 11:18:18 +0000 (GMT)
Message-ID: <1595503098.5211.85.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Drop empty NEWS file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>
Date:   Thu, 23 Jul 2020 07:18:18 -0400
In-Reply-To: <1595431869.5311.102.camel@linux.ibm.com>
References: <20200722114729.4210-1-pvorel@suse.cz>
         <1595428021.5311.93.camel@linux.ibm.com>
         <20200722144510.l5qwn62dlanbuul4@altlinux.org>
         <20200722145047.GB18945@dell5510> <1595431869.5311.102.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230081
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-07-22 at 11:31 -0400, Mimi Zohar wrote:
> On Wed, 2020-07-22 at 16:50 +0200, Petr Vorel wrote:
> > Hi,
> > 
> > ...
> > > > Really annoying having to include an empty file, but without it,
> > > > autoconf fails with:
> > 
> > > > Makefile.am: error: required file './NEWS' not found
> > > > src/Makefile.am: installing './depcomp'
> > > > autoreconf: automake failed with exit status: 1
> > 
> > > Maybe current ChangeLog should be renamed to NEWS?
> > 
> > > git log is better changelog, and ChangeLog is really condensed and
> > > suitable to be NEWS.
> > +1, good idea.
> 
> Sure, thank you for the suggestion.  I'll queue this change and any
> other change(s) in the "next" branch for a minor release.

After renaming "ChangeLog" to "NEWS" as discussed, autotools now
complains about the missing "ChangeLog" file.

automake has a number of flavors[1][2].  The "foreign" flavor, which
can be supplied as an option to AM_INIT_AUTOMAKE, doesn't require the
NEWS, COPYING, AUTHORS, ChangeLog, or README files to exist.

Although renaming the files didn't help, it makes sense.  The patch
does both - renames ChangeLog and uses the "foreign" option.

Mimi

[1] https://www.gnu.org/software/automake/manual/automake.html#index-a
utomake-options
[2] https://autotools.io/automake/options.html
