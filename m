Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE968CA11E
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 17:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfJCPYe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 11:24:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727302AbfJCPYe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 11:24:34 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x93FOFl4057500
        for <linux-integrity@vger.kernel.org>; Thu, 3 Oct 2019 11:24:33 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vdjx5sser-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 03 Oct 2019 11:24:32 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 3 Oct 2019 16:24:29 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 3 Oct 2019 16:24:24 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x93FNsFj39649716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Oct 2019 15:23:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD025A4062;
        Thu,  3 Oct 2019 15:24:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 289F5A405C;
        Thu,  3 Oct 2019 15:24:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.158])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Oct 2019 15:24:22 +0000 (GMT)
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
Date:   Thu, 03 Oct 2019 11:24:21 -0400
In-Reply-To: <20191003113313.GD8933@linux.intel.com>
References: <20190925134842.19305-1-jarkko.sakkinen@linux.intel.com>
         <20190926124635.GA6040@linux.intel.com>
         <20190926131227.GA6582@linux.intel.com>
         <1570020024.4999.104.camel@linux.ibm.com>
         <20191003113211.GC8933@linux.intel.com>
         <20191003113313.GD8933@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19100315-4275-0000-0000-0000036DB933
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100315-4276-0000-0000-00003880BFF0
Message-Id: <1570116261.4421.199.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=917 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910030142
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-10-03 at 14:33 +0300, Jarkko Sakkinen wrote:

> > > Will this delay the TPM initialization, causing IMA to go into "TPM
> > > bypass mode"?
> > 
> > Of course it will delay the init.
> > 
> > As I've stated before the real fix for the bypass issue would be
> > to make TPM as part of the core but this has not received much
> > appeal. I think I've sent patch for this once.

IMA initialization is way later than the TPM.  IMA is on the
late_initcall(), while the TPM is on the subsys_initcall().  I'm not
sure moving the TPM to core would make a difference.  There must be a
way of deferring IMA until after the TPM has been initialized.  Any
suggestions would be much appreciated.

(The TPM on the Pi still has a dependency on clock.) 

> It has been like that people reject a fix to a race condition and
> then I get complains on adding minor latency to the init because
> of the existing race. It is ridicilous, really.

I agree, but adding any latency will cause a regression.

Mimi

