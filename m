Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5614D33B
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2020 23:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgA2Wv0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jan 2020 17:51:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgA2Wv0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jan 2020 17:51:26 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TMmddX074391
        for <linux-integrity@vger.kernel.org>; Wed, 29 Jan 2020 17:51:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xttw7pcu7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 29 Jan 2020 17:51:24 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 29 Jan 2020 22:51:22 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Jan 2020 22:51:19 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00TMpI8Y58720354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 22:51:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E9FAA4072;
        Wed, 29 Jan 2020 22:51:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62A9FA407C;
        Wed, 29 Jan 2020 22:51:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.138.224])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jan 2020 22:51:17 +0000 (GMT)
Subject: Re: [PATCH 1/2] ima: use the IMA configured hash algo to calculate
 the boot aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 29 Jan 2020 17:51:16 -0500
In-Reply-To: <20200129083034.GA387@dell5510>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
         <20200127204941.2ewman4y5nzvkjqe@cantor>
         <1580160699.5088.64.camel@linux.ibm.com> <20200129083034.GA387@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012922-0020-0000-0000-000003A53179
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012922-0021-0000-0000-000021FCE41A
Message-Id: <1580338276.4790.8.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_07:2020-01-28,2020-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=961 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001290176
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-01-29 at 09:30 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> > The original LTP ima_boot_aggregate.c test needed to be updated to
> > support TPM 2.0 before this change.  For TPM 2.0, the PCRs are not
> > exported.  With this change, the kernel could be reading PCRs from a
> > TPM bank other than SHA1 and calculating the boot_aggregate based on a
> > different hash algorithm as well.  I'm not sure how a remote verifier
> > would know which TPM bank was read, when calculating the boot-
> > aggregate.
> Mimi, do you plan to do update LTP test?

In order to test Roberto's patches that calculates and extends the
different TPM banks with the appropriate hashes, we'll need some test
to verify that it is working properly.  As to whether this will be in
LTP or ima-evm-utils, I'm not sure.

Mimi

