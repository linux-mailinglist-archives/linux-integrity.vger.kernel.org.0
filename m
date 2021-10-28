Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45B543E1A1
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Oct 2021 15:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhJ1NKt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Oct 2021 09:10:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229603AbhJ1NKt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Oct 2021 09:10:49 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SCnGYv016294;
        Thu, 28 Oct 2021 13:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=8fiPYKyw0EhWbEal4tnK6baVTfmvbJ8ImkJJsxDI9cM=;
 b=W8DVNNVEqayOpJIMfqMvblEkGSgR3F9Bg8XTzVObqD/Bdjgxn7H/I+MFqCROVRWtayZ/
 iM90MsGJlPf+JhYpQlB04dyDsz9+Oefjc1L8vtmqdI0ld+v7Y7AP/4okzJvyCjj0s707
 AONemM+DNsD3rBdhE+uOc16Bk5qenX4tS3XsKwYwjopXf4tRHFiJY2OiQ2mLOdpClf31
 b2JvOneB3BE3TVbRKhWsSHNVhV46Jq2tHcBhQPlELIO3yO3Tn1zsF0tz3g9xks5pLCSB
 jMbmDfCLMWUHm4zAVxE0M1683kIkgDxY7K2JL4Yq7kiTUjXv4v3/0sfivlze8MZHTvzb Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3byv6r0ebr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 13:08:11 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19SCnaA6016537;
        Thu, 28 Oct 2021 13:08:11 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3byv6r0eb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 13:08:10 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19SCvNEW020620;
        Thu, 28 Oct 2021 13:08:09 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 3bx4fn598y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 13:08:09 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19SD88Pd24183174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 13:08:08 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88DC378240;
        Thu, 28 Oct 2021 13:08:07 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3233D7807C;
        Thu, 28 Oct 2021 13:07:46 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.163.12.226])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Oct 2021 13:07:45 +0000 (GMT)
Message-ID: <ff3d1d11291b7e115317b06503f0ec52949122ca.camel@linux.ibm.com>
Subject: Re: [PATCH v3 0/2] use SM3 instead of SM3_256
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Ard Biesheuvel <ardb@kernel.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        keyrings@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Date:   Thu, 28 Oct 2021 09:07:43 -0400
In-Reply-To: <CAMj1kXGiC-LCc-50cfddJxJ-mezO=fcLqhJHiK110CgxKusy9w@mail.gmail.com>
References: <20211026075626.61975-1-tianjia.zhang@linux.alibaba.com>
         <CAMj1kXGiC-LCc-50cfddJxJ-mezO=fcLqhJHiK110CgxKusy9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KOLHtfetbXM2M_5ECkPDVsAXdzorivCz
X-Proofpoint-GUID: ThYkNwItNh-c7SaFT-nOwuL1brdOArJ_
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280073
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-10-26 at 18:08 +0200, Ard Biesheuvel wrote:
> On Tue, 26 Oct 2021 at 09:56, Tianjia Zhang
> <tianjia.zhang@linux.alibaba.com> wrote:
> > According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html
> > ,
> > SM3 always produces a 256-bit hash value and there are no plans for
> > other length development, so there is no ambiguity in the name of
> > sm3.
> > 
> 
> What is the point of these changes? Having '256' in the identifiers
> is merely redundant and not factually incorrect, so why can't we just
> leave these as they are?

Me too on this.  Plus the various standards bodies we follow are still
using the 256 suffix and it's not clear they'll change.

Finally, I'm not sure, given the confusion over sha256 and sha3-256,
that the IETF won't eventually decide that all hash algorithms should
be designated by <algorithm>-<bitlength> in which case this will get
churned again ...

James


