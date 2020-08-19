Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F20024A22B
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 16:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgHSOzz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 10:55:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbgHSOzq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 10:55:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JEWsjp128415;
        Wed, 19 Aug 2020 10:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6B+LFb8crpO//4WHodglJNvi9Z3B8GrN5k189cDSQgo=;
 b=DU2ryMkrDzHKt20Ip6R0BSl+bM9aTKh9C9+QYyXrtzp8LgPIHonmAnP9dRUZgYMzcOMD
 5GHEpjfmhl+Q0FjbzkISEtzaz4ZAu1SAjP7Sk+2HyQmr8qpSFF21fhp4RKGaOTQ+aBtd
 drLO4pFph6mHwae34QvI3CxCIqFw71AjrYj8ZsKVCdGNNH+5CJ8OJ654XrDLwC2lG8EG
 ca7MRTYlwQsCuOawShNIqQXKs1WY3d7Dk2V4P0Z9ONDoHj6hjyWe0BPLVec46ZLNm11q
 2ZjOnYtdp+kYERqzvIjd35bKEfHM6OgP0XFYG082Z+uiwhLB3YOG0ilKUG/5BEOKhy+h Mg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 330ccb62bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 10:55:42 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07JEo7Fu027182;
        Wed, 19 Aug 2020 14:55:40 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3313xbg3cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 14:55:40 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07JEtcuJ24445334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 14:55:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47C6DAE051;
        Wed, 19 Aug 2020 14:55:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EEE5AE04D;
        Wed, 19 Aug 2020 14:55:37 +0000 (GMT)
Received: from sig-9-65-250-194.ibm.com (unknown [9.65.250.194])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Aug 2020 14:55:36 +0000 (GMT)
Message-ID: <2a44badc429cdca234a2813ec177926a816b0824.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 19 Aug 2020 10:55:36 -0400
In-Reply-To: <e33cca9a33a151cf35f12aca9dfd42378d632322.camel@linux.ibm.com>
References: <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
         <20200818161207.GC137138@linux.intel.com>
         <20200818161955.GD137138@linux.intel.com>
         <20200818162630.GE137138@linux.intel.com>
         <20200818164602.GZ1152540@nvidia.com>
         <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
         <20200818183603.GC1152540@nvidia.com>
         <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
         <20200819120238.GD1152540@nvidia.com>
         <59f983156fed466d568c324de72ef733c1a15d76.camel@linux.ibm.com>
         <20200819140943.GH1152540@nvidia.com>
         <e33cca9a33a151cf35f12aca9dfd42378d632322.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_07:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=3 impostorscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-19 at 10:53 -0400, Mimi Zohar wrote:
> On Wed, 2020-08-19 at 11:09 -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 19, 2020 at 09:27:33AM -0400, Mimi Zohar wrote:
> > > On Wed, 2020-08-19 at 09:02 -0300, Jason Gunthorpe wrote:
> > > > On Tue, Aug 18, 2020 at 02:55:50PM -0400, Mimi Zohar wrote:
> > > > 
> > > > > The problem is that there isn't just one single userspace library or
> > > > > application for reading PCRs.  So now not only is there the kernel
> > > > > "boot_aggregate" regression testing, but regression testing of the tool
> > > > > itself to support multiple methods of reading the PCRs.
> > > > 
> > > > I was thinking just open code 
> > > >   open("/dev/tpm")
> > > >   write(read_pcrs_cmd)
> > > >   read(read_pcrs_cmd)
> > > >  
> > > > It isn't particularly hard to retrive the PCRs, don't really need to
> > > > depend on a library.
> > > 
> > > Ok, do you want to contribute it to ima-evm-utils?  While you're at it,
> > > do you also have code to parse the TPM 2.0 event log that you could
> > > contribute?
> > > 
> > > Seriously, we shouldn't be (re-)writing code to do this.
> > 
> > The kernel should not be used a dumping ground to work around a
> > dysfunctional userspace either. :(
> > 
> > You've basicaly said you can't rely on a sane userspace library
> > because *reasons* so we need to dump stuff in the kernel instead.
> > 
> > It is not a good justification to add new uAPI.
> > 
> > James seems to have the same basic conclusion too, unfortunately.
> 
> "dysfunctional" is dropping existing TPM 1.2 sysfs support, which was

^not supporting existing TPM 1.2 sysfs for TPM 2.0

> done without consideration about existing applications/tools (e.g. ima-
> evm-utils, ltp) and without community input.  It's not only James that
> is advocating for exporting the TPM PCRs, but Jerry Snitselaar, who
> reviewed this patch and exported the TPM version, and Nayna Jain, who
> exported the TPM 2.0 event log.  I'm pretty sure there are a number of
> other people who would agree.
> 
> Mimi
> 


