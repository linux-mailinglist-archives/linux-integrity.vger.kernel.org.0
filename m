Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD3F22B161
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jul 2020 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgGWOa2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jul 2020 10:30:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726715AbgGWOa2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jul 2020 10:30:28 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NE2Sbw181916;
        Thu, 23 Jul 2020 10:30:24 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fadf4acg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 10:30:24 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NEOi2K002119;
        Thu, 23 Jul 2020 14:30:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 32dbmn21qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 14:30:22 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NEUJ1j12058926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 14:30:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81BD9A4068;
        Thu, 23 Jul 2020 14:30:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7F8CA405F;
        Thu, 23 Jul 2020 14:30:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.234])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 14:30:18 +0000 (GMT)
Message-ID: <1595514618.5211.131.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] release feature discussion [renamed from
 Drop empty NEWS file]
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>, Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Thu, 23 Jul 2020 10:30:18 -0400
In-Reply-To: <20200723140420.jwz6rjwq5j2ouzzt@altlinux.org>
References: <20200722114729.4210-1-pvorel@suse.cz>
         <1595428021.5311.93.camel@linux.ibm.com>
         <20200722144510.l5qwn62dlanbuul4@altlinux.org>
         <20200722145047.GB18945@dell5510> <1595431869.5311.102.camel@linux.ibm.com>
         <1595503098.5211.85.camel@linux.ibm.com> <20200723115457.GA26679@dell5510>
         <1595506070.5211.103.camel@linux.ibm.com> <20200723122934.GA30011@dell5510>
         <20200723140420.jwz6rjwq5j2ouzzt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_05:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007230102
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-07-23 at 17:04 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Thu, Jul 23, 2020 at 02:29:34PM +0200, Petr Vorel wrote:
> > Hi Mimi,
> > 
> > ...
> > > > Thanks for fixing it. foreign flavor fits our needs better than gnu.
> > > > Autotools "features" like this (having strange gnu flavor as the default)
> > > > explain why people keep introducing new build systems like Meson (which brings
> > > > other problems).
> > 
> > > Changing the autotools flavor solved the problem, but I wasn't sure
> > > that it was the correct solution.  Thank you for validating the flavor
> > > change.
> > yw :).
> > 
> > BTW could you also merge your .travis.yml from next-testing-travis to next (and
> > preferably also to master)? Even if you have no way to setup automatic mirror to
> > some travis account, it help to run it sometimes or at least before release.
> 
> Also, it's useful to packagers to see that there is tests and how to run
> them.
> 
> Thanks,
> 
> > 
> > Also, having docker based travis setup helps to test build against other distros
> > (we have it in LTP).

The existing travis.yml is a first attempt at using travis.  (Hint:
help with cleaning it up would be much appreciated.)  Should this
travis.yml be included now in 1.3.1 or deferred to 1.3.2?  Let's sync
up on what should be included when.  Additional suggestions are
welcome.

1.3.1 release (~1 week):
- minor fixes

Proposed 1.3.2 features (~3 months):
- Travis integration
- Support providing the TPM 2.0 PCRs as a file (--pcrs option).
- Walking the TPM 2.0 event log as the basis for calculating the
"boot_aggregate".

thanks,

Mimi
