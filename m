Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D77214D37E
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 00:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgA2XUR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jan 2020 18:20:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726618AbgA2XUR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jan 2020 18:20:17 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TN6ETd128879
        for <linux-integrity@vger.kernel.org>; Wed, 29 Jan 2020 18:20:15 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xtrmbvc7n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 29 Jan 2020 18:20:15 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 29 Jan 2020 23:20:13 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Jan 2020 23:20:09 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00TNK8ch51838980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 23:20:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B12B14204B;
        Wed, 29 Jan 2020 23:20:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D805742042;
        Wed, 29 Jan 2020 23:20:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.138.224])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jan 2020 23:20:07 +0000 (GMT)
Subject: Re: [PATCH 2/2] ima: support calculating the boot_aggregate based
 on different TPM banks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Wed, 29 Jan 2020 18:20:07 -0500
In-Reply-To: <1580226042.5088.90.camel@linux.ibm.com>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
         <1580140919-6127-2-git-send-email-zohar@linux.ibm.com>
         <465015d0c9ca4e278ed32f78eb3eb4a4@huawei.com>
         <1580226042.5088.90.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012923-0012-0000-0000-00000381E127
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012923-0013-0000-0000-000021BE39D1
Message-Id: <1580340007.4790.31.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_07:2020-01-28,2020-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001290178
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-01-28 at 10:40 -0500, Mimi Zohar wrote:
> > This code assumes that the algorithm used to calculate boot_aggregate and
> > the algorithm of the PCR bank can be different. I don't know if it is possible to
> > communicate to the verifier which bank has been selected (it depends on
> > the local configuration).
> 
> Agreed, but defaulting to the first bank would only happen if the IMA
> default hash algorithm is not a configured TPM algorithm.
> 
> > 
> > In my opinion the safest approach would be to use the same algorithm for the
> > digest and the PCR bank. If you agree to this, then the code above must be
> > moved to ima_calc_boot_aggregate() so that the algorithm of the selected
> > PCR bank can be passed to ima_alloc_tfm().
> 
> Using the same hash algorithm, preferably the IMA hash default
> algorithm, for reading the TPM PCR bank and calculating the
> boot_aggregate makes sense.
> 
> > 
> > The selected PCR bank might be not the first, if the algorithm is unknown to
> > the crypto subsystem.
> 
> It sounds like you're suggesting finding a common configured hash
> algorithm between the TPM and the kernel. 

I'd like to clarify the logic for the case when a common algorithm
does not exist.  None of the TPM allocated banks are known by the
kernel.  If the hash algorithm of the boot_aggregate represents not
only that of the digest included in the measurement list, but also of
the TPM PCR bank read, what should happen?  Should the boot aggregate
be 0's, like in the case when there isn't a TPM?

thanks,

Mimi

