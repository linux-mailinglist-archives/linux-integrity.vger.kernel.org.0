Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C52B2C9EAB
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfJCMjV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 08:39:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728944AbfJCMjV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 08:39:21 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x93CbcjV082056
        for <linux-integrity@vger.kernel.org>; Thu, 3 Oct 2019 08:39:19 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vdea6x4q5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 03 Oct 2019 08:39:19 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 3 Oct 2019 13:39:17 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 3 Oct 2019 13:39:13 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x93CdCTH28115388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Oct 2019 12:39:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B94F111C05E;
        Thu,  3 Oct 2019 12:39:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F8F511C04A;
        Thu,  3 Oct 2019 12:39:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.158])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Oct 2019 12:39:11 +0000 (GMT)
Subject: Re: [PATCH] tpm: Detach page allocation from tpm_buf
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 03 Oct 2019 08:39:10 -0400
In-Reply-To: <20191003113211.GC8933@linux.intel.com>
References: <20190925134842.19305-1-jarkko.sakkinen@linux.intel.com>
         <20190926124635.GA6040@linux.intel.com>
         <20190926131227.GA6582@linux.intel.com>
         <1570020024.4999.104.camel@linux.ibm.com>
         <20191003113211.GC8933@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19100312-4275-0000-0000-0000036DAE14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100312-4276-0000-0000-00003880B43C
Message-Id: <1570106350.4421.166.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910030117
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-10-03 at 14:32 +0300, Jarkko Sakkinen wrote:
> On Wed, Oct 02, 2019 at 08:40:24AM -0400, Mimi Zohar wrote:
> > On Thu, 2019-09-26 at 16:12 +0300, Jarkko Sakkinen wrote:
> > > On Thu, Sep 26, 2019 at 03:46:35PM +0300, Jarkko Sakkinen wrote:
> > > > On Wed, Sep 25, 2019 at 04:48:41PM +0300, Jarkko Sakkinen wrote:
> > > > > -		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
> > > > > +		tpm_buf_reset(&buf, data_ptr, PAGE_SIZE,
> > > > > +			      TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_EXTEND);
> > > > 
> > > > Oops.
> > > 
> > > Maybe we could use random as the probe for TPM version since we anyway
> > > send a TPM command as a probe for TPM version:
> > > 
> > > 1. Try TPM2 get random.
> > > 2. If fail, try TPM1 get random.
> > > 3. Output random number to klog.
> > > 
> > > Something like 8 bytes would be sufficient. This would make sure that
> > > no new change breaks tpm_get_random() and also this would give some
> > > feedback that TPM is at least somewhat working.
> > 
> > That involves sending 2 TPM commands.  At what point does this occur?
> >  On registration?  Whenever getting a random number?  Is the result
> > cached in chip->flags?
> 
> On registeration. It is just printed to klog.

What sets "TPM_CHIP_FLAG_TPM2" in chip->flags?  And when?

> 
> > Will this delay the TPM initialization, causing IMA to go into "TPM
> > bypass mode"?
> 
> Of course it will delay the init.

Delaying the init will most likely cause regressions on systems with
TPM 1.2 systems.

Instead of sending the TPM 2.0 command and on failure sending the TPM
1.2 version of the command, could chip->flags be tested?  And if not
chip->flags, then provide the TPM version as part of registration.

> 
> As I've stated before the real fix for the bypass issue would be
> to make TPM as part of the core but this has not received much
> appeal. I think I've sent patch for this once.

I must have missed this discussion.

Mimi

