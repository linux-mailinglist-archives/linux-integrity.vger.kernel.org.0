Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F3C1B3136
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2020 22:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDUUbJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 16:31:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgDUUbJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 16:31:09 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LK3FOM020019
        for <linux-integrity@vger.kernel.org>; Tue, 21 Apr 2020 16:31:08 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gfebxnbq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 21 Apr 2020 16:31:08 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 21 Apr 2020 21:30:21 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Apr 2020 21:30:18 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03LKV2Md59900056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 20:31:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 400CEA405F;
        Tue, 21 Apr 2020 20:31:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06083A4054;
        Tue, 21 Apr 2020 20:31:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.193.120])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Apr 2020 20:31:00 +0000 (GMT)
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Omar Sandoval <osandov@osandov.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Date:   Tue, 21 Apr 2020 16:31:00 -0400
In-Reply-To: <20200421202520.GD46589@linux.intel.com>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
         <1586994699.3931.18.camel@HansenPartnership.com>
         <20200416001605.GA673482@vader> <20200416002442.GB673482@vader>
         <1587060171.15329.7.camel@HansenPartnership.com>
         <20200417235527.GB85230@linux.intel.com>
         <1587168748.5867.2.camel@HansenPartnership.com>
         <20200420204641.GA14637@linux.intel.com>
         <1587421686.3493.2.camel@HansenPartnership.com>
         <1587479764.5149.27.camel@linux.ibm.com>
         <20200421202520.GD46589@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042120-4275-0000-0000-000003C4257D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042120-4276-0000-0000-000038D9AB2A
Message-Id: <1587501060.5118.5.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_08:2020-04-21,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210150
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-04-21 at 23:25 +0300, Jarkko Sakkinen wrote:
> On Tue, Apr 21, 2020 at 10:36:04AM -0400, Mimi Zohar wrote:
> > On Mon, 2020-04-20 at 15:28 -0700, James Bottomley wrote:
> > > On Mon, 2020-04-20 at 23:46 +0300, Jarkko Sakkinen wrote:
> > 
> > <snip>
> > 
> > > But more seriously: Nayna Jain did a series of patches improving the
> > > time it takes to poll the TPM for operations precisely because the TPM
> > > PCR extend was going so slowly:
> > > 
> > > https://lore.kernel.org/linux-integrity/20180516055125.5685-1-nayna@linux.vnet.ibm.com/
> > 
> > The original reason for us needing to improve the TPM performance was
> > due to the kernel scheduler change.  Refer to commit a233a0289cf9
> > ("tpm: msleep() delays - replace with usleep_range() in i2c nuvoton
> > driver").  That scheduler change prevented systems from booting.
> >  Bisecting the kernel to figure out the problem wasn't very
> > productive.
> > 
> > At least any TPM changes that affect the TPM performance really need
> > to take into account IMA requirements.
> 
> Thanks Mimi.
> 
> With my dynamic proposal it would work as it works now for system
> where it worked anyway, and would fix the systems where timeouts
> were too short.

Sure, but please remember this thread started out addressing an STM
TPM bug, not James' timeouts.  This part of the thread should be re-
named.

Mimi

