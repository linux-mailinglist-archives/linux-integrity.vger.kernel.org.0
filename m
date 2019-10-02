Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01CC88E0
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2019 14:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfJBMkf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Oct 2019 08:40:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727533AbfJBMkf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Oct 2019 08:40:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x92CdT7V106234
        for <linux-integrity@vger.kernel.org>; Wed, 2 Oct 2019 08:40:34 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vct5vbtch-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 Oct 2019 08:40:34 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 2 Oct 2019 13:40:31 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Oct 2019 13:40:27 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x92CeQAt44564610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Oct 2019 12:40:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55CCD52050;
        Wed,  2 Oct 2019 12:40:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.234.231])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F358452057;
        Wed,  2 Oct 2019 12:40:24 +0000 (GMT)
Subject: Re: [PATCH] tpm: Detach page allocation from tpm_buf
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 02 Oct 2019 08:40:24 -0400
In-Reply-To: <20190926131227.GA6582@linux.intel.com>
References: <20190925134842.19305-1-jarkko.sakkinen@linux.intel.com>
         <20190926124635.GA6040@linux.intel.com>
         <20190926131227.GA6582@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19100212-0016-0000-0000-000002B3574A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100212-0017-0000-0000-000033145B91
Message-Id: <1570020024.4999.104.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=873 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910020120
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-09-26 at 16:12 +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 26, 2019 at 03:46:35PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Sep 25, 2019 at 04:48:41PM +0300, Jarkko Sakkinen wrote:
> > > -		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
> > > +		tpm_buf_reset(&buf, data_ptr, PAGE_SIZE,
> > > +			      TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_EXTEND);
> > 
> > Oops.
> 
> Maybe we could use random as the probe for TPM version since we anyway
> send a TPM command as a probe for TPM version:
> 
> 1. Try TPM2 get random.
> 2. If fail, try TPM1 get random.
> 3. Output random number to klog.
> 
> Something like 8 bytes would be sufficient. This would make sure that
> no new change breaks tpm_get_random() and also this would give some
> feedback that TPM is at least somewhat working.

That involves sending 2 TPM commands.  At what point does this occur?
 On registration?  Whenever getting a random number?  Is the result
cached in chip->flags?

Will this delay the TPM initialization, causing IMA to go into "TPM
bypass mode"?

Mimi

