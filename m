Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C9E221546
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 21:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGOTlG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 15:41:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbgGOTlG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 15:41:06 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FJXbbx096489;
        Wed, 15 Jul 2020 15:40:59 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329uehsv6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 15:40:59 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FJc6qX024220;
        Wed, 15 Jul 2020 19:40:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3274pgvp0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 19:40:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FJesgI43843690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 19:40:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 924864C04A;
        Wed, 15 Jul 2020 19:40:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73CDA4C044;
        Wed, 15 Jul 2020 19:40:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 19:40:53 +0000 (GMT)
Message-ID: <1594842052.12900.337.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] IMA: Verify that the kernel cmdline is passed and
 measured correctly through the kexec barrier.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>, pvorel@suse.cz,
        ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Date:   Wed, 15 Jul 2020 15:40:52 -0400
In-Reply-To: <53323968-55b9-68ae-dc3f-de9cbd223ff1@linux.microsoft.com>
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
         <20200702153545.3126-2-t-josne@linux.microsoft.com>
         <1594774692.12900.220.camel@linux.ibm.com>
         <53323968-55b9-68ae-dc3f-de9cbd223ff1@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150147
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-07-15 at 15:38 -0400, Lachlan Sneff wrote:
> On 7/14/20 8:58 PM, Mimi Zohar wrote:
> > On Thu, 2020-07-02 at 11:35 -0400, Lachlan Sneff wrote:
> >> Add a testcase that verifies that kexec correctly logs the
> >> kernel command line to the IMA buffer and that the command
> >> line is then correctly measured.
> >>
> >> This test must be run standalone, since it runs kexec
> >> multiple times (and therefore reboots several times).
> > Verifying the kexec boot command line doesn't require rebooting.  Just
> > loading the kexec kernel image should be enough (kexec -s -l).
> >   Verifying that the measurement list, including the kexec boot command
> > line, is carried across kexec could be a separate test.
> 
> This is true. However, it only appends to the IMA log once, even if you 
> unload (`kexec -u`) the kexec kernel after `kexec -s -l ...`.
> 
> Therefore, the test would only be able to check kexec with the cmdline 
> supplied in one way.
> 
> I will have to check internally if that's the right way to go. If it 
> didn't need to reboot, then the test could be integrated into the normal 
> IMA tests,
> which would definitely be a good thing.

For files, there is a single measurement unless the file changes.  I
would assume that would be the same for the kexec command line as
well.  You could modify the command line a bit to force it to be re-
measured.

Mimi
