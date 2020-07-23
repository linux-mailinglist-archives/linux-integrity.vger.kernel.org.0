Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02D722B55B
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jul 2020 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgGWSEw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jul 2020 14:04:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbgGWSEw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jul 2020 14:04:52 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NI3L2c074949;
        Thu, 23 Jul 2020 14:04:47 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32facj8y5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 14:04:46 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NI0Gup014937;
        Thu, 23 Jul 2020 18:04:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 32brq7wqca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 18:04:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NI3HwK55574952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 18:03:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47930A405C;
        Thu, 23 Jul 2020 18:04:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8653A406E;
        Thu, 23 Jul 2020 18:04:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.234])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 18:04:40 +0000 (GMT)
Message-ID: <1595527480.5211.185.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] release feature discussion [renamed from
 Drop empty NEWS file]
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Thu, 23 Jul 2020 14:04:40 -0400
In-Reply-To: <20200723170556.GA20782@dell5510>
References: <1595428021.5311.93.camel@linux.ibm.com>
         <20200722144510.l5qwn62dlanbuul4@altlinux.org>
         <20200722145047.GB18945@dell5510> <1595431869.5311.102.camel@linux.ibm.com>
         <1595503098.5211.85.camel@linux.ibm.com> <20200723115457.GA26679@dell5510>
         <1595506070.5211.103.camel@linux.ibm.com> <20200723122934.GA30011@dell5510>
         <20200723140420.jwz6rjwq5j2ouzzt@altlinux.org>
         <1595514618.5211.131.camel@linux.ibm.com> <20200723170556.GA20782@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230132
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-07-23 at 19:05 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> ...
> > > > Also, having docker based travis setup helps to test build against other distros
> > > > (we have it in LTP).
> 
> > The existing travis.yml is a first attempt at using travis.  (Hint:
> > help with cleaning it up would be much appreciated.)  Should this
> > travis.yml be included now in 1.3.1 or deferred to 1.3.2?  Let's sync
> > up on what should be included when.  Additional suggestions are
> > welcome.
> 
> > 1.3.1 release (~1 week):
> > - minor fixes
> 
> > Proposed 1.3.2 features (~3 months):
> > - Travis integration
> > - Support providing the TPM 2.0 PCRs as a file (--pcrs option).
> > - Walking the TPM 2.0 event log as the basis for calculating the
> > "boot_aggregate".
> 
> Thank you for sharing your roadmap. I'd vote for sooner include (it's not set
> in the stone, it can be changed later :)), but up to you.
> 
> Not sure if I have enough time to significantly help with Travis, I'll try.
> That docker based testing is nice, because it's a testing on real distro.

Thanks, Petr.  You've provided so much help, support, and guidance
already.  We know a lot of companies are using the Integrity
subsystem.  Some are even actively contributing to it.  They should
realize the more time I need to spend on ima-evm-utils, means the less
time I have for reviewing and upstreaming kernel patches.  Hopefully
they're listening and will step up to helping improve ima-evm-utils as
well.  I can't be any blunter than that.  Let's see what happens. :)

Mimi
