Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA7B248E4C
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 20:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHRS4A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 14:56:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbgHRSz7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 14:55:59 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07IIXd08108216;
        Tue, 18 Aug 2020 14:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=aHO7qIRjypWw2vJ93c6cqA7QMMOxI17E0H0Ea9SMZG0=;
 b=pAMNzl+hL8arsBEA9mlSbA6LnnmgrwvNp2pCD2kcAnhEJwWIb3xmz+NBcCWE5THmlh6z
 PyjbkSeocqGaKRdi5tJ3IFsE2P5+qRvEC6Sitcsb4k0xkCtt1TGB/rVl432FPCroospi
 zk1yNMHmsH8MH8kId84vzg1ov48RIvJRtfYxunjGQulAwzyBWcZf8uDh443exnbNGts+
 pjxNOSvbpvoIlqbAYzWOFr4I6VV+TiBnG6jxz2DCxEjqhRqFu15QysjtQEGGMDFxai3D
 u3yby6pN8DVN7d6N8rsUFD2HTHX+jbLKSvWwhzsdPz1voMuIWzamCqWWYFfHLBT84JQP eA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3304r3k9uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 14:55:56 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07IIonJ6003196;
        Tue, 18 Aug 2020 18:55:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3304ujrk97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 18:55:54 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07IItqms12124638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 18:55:52 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3776BAE055;
        Tue, 18 Aug 2020 18:55:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CB89AE04D;
        Tue, 18 Aug 2020 18:55:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.9.198])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Aug 2020 18:55:51 +0000 (GMT)
Message-ID: <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 18 Aug 2020 14:55:50 -0400
In-Reply-To: <20200818183603.GC1152540@nvidia.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
         <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
         <20200818161207.GC137138@linux.intel.com>
         <20200818161955.GD137138@linux.intel.com>
         <20200818162630.GE137138@linux.intel.com>
         <20200818164602.GZ1152540@nvidia.com>
         <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
         <20200818183603.GC1152540@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_12:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180127
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-08-18 at 15:36 -0300, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2020 at 02:26:04PM -0400, Mimi Zohar wrote:
> > On Tue, 2020-08-18 at 13:46 -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 18, 2020 at 07:26:30PM +0300, Jarkko Sakkinen wrote:
> > > > On Tue, Aug 18, 2020 at 07:19:57PM +0300, Jarkko Sakkinen wrote:
> > > > > On Tue, Aug 18, 2020 at 07:12:09PM +0300, Jarkko Sakkinen wrote:
> > > > > > On Mon, Aug 17, 2020 at 02:35:06PM -0700, James Bottomley wrote:
> > > > > > > Create sysfs per hash groups with 24 PCR files in them one group,
> > > > > > > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > > > > > > plugged in to a PCR read function which is TPM version agnostic, so
> > > > > > > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > > > > > > 
> > > > > > > Note: the macros used to create the hashes emit spurious checkpatch
> > > > > > > warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> > > > > > > they'll break.
> > > > > > > 
> > > > > > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > > > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > > > > 
> > > > > > I have hard time understanding why this is required.
> > > > > > 
> > > > > > You can grab the information through /dev/tpm0 just fine.
> > > > > 
> > > > > I just think it is principally wrong to add sysfs files if they don't
> > > > > have any measurable value other than perhaps some convenience.
> > > > > 
> > > > > It is trival to write only a libc dependent program that outputs PCRs.
> > > > > 
> > > > > I think this is essentially an user space problem that is getting sorted
> > > > > out with kernel code.
> > > > 
> > > > Jason, what do you make of this? I recall that it was you who I
> > > > discussed with about this topic when TPM 2.0 support was first
> > > > upstreamed.
> > > 
> > > TPM 2.0 broke all the userspace so it made sense to get rid of the
> > > non-conforming sysfs files from TPM v1.x time as part of the userspace
> > > API. That was the main reason to not continue forward with PCR in
> > > userspace.
> > > 
> > > As far as doing it properly as this patch does.. I agree with you that
> > > sysfs files should have some reason to be added, espcially if it
> > > causes quite big code cost as this does. eg to drive a udev rule
> > > decision.
> > > 
> > > Why is PCRs so special it needs to be in sysfs? What is userspace
> > > going to do with this information?
> > 
> > The original IMA LTP "boot_aggregate" regression test is dependent on
> > the exported TPM event log and PCRs.  Similar support is needed for TPM
> > 2.0.  There isn't just a single userspace application for reading
> > PCRs.  As soon as we add support for one userspace
> > application,  support for the other applications is requested.  So
> > instead of a having a simple regression test with a single method of
> > reading PCRs, we're now required to support multiple userspace
> > applications.
> 
> But this test already has a C program as part of the boot aggregate
> test, why is it such a problem to use a C program to also read the
> PCRs?
> 
> As Jarkko says it is not so hard

The problem is that there isn't just one single userspace library or
application for reading PCRs.  So now not only is there the kernel
"boot_aggregate" regression testing, but regression testing of the tool
itself to support multiple methods of reading the PCRs.

Mimi


