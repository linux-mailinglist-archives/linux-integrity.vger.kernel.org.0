Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731BF427A9E
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Oct 2021 15:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhJINcr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 9 Oct 2021 09:32:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233209AbhJINcq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 9 Oct 2021 09:32:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 199BVVke007307;
        Sat, 9 Oct 2021 09:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4Cro3IpcEkZeGz4yDmnXZpwZJa3Nd2CCDYW1ytGiNbw=;
 b=kJ7qtltQ0cYEWq9Lsxp0UM1v5srrA8BPAPXxyvYye4whtqVWi3TgImbPmsfmprD86HXF
 iM12jbOG82a13N1wuYMU/e6kvgisuf284d/QN2GNfh5qqGPXXPx8ZOBZmA/Wn30IsUC1
 ofOJpzLxywpXCtcesGvjZZNj7EuGGjSWX156V7h7F0tLkzwAIu8Qfc9Rr6s+ceM+Mxwo
 UtqUvIR4UWeEnl+Bwf1D/EE7Q16y1uXFweOztbcFgMDy51D/NNSfEFSh52tzKUUPpN2I
 ckOIexRjkrTrYbu5qNA3tEfLjKrJfEayKnEsPqY/7YiNrQq0xW0VVZ+9zAy3zZV8xbKh uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bka9ksax0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 09:30:00 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 199DPc6I032508;
        Sat, 9 Oct 2021 09:29:59 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bka9ksawm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 09:29:59 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 199DMVM5028876;
        Sat, 9 Oct 2021 13:29:58 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 3bk2q9mj6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 13:29:57 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 199DTuDp35717580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Oct 2021 13:29:57 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D67417806B;
        Sat,  9 Oct 2021 13:29:56 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1127778060;
        Sat,  9 Oct 2021 13:29:53 +0000 (GMT)
Received: from [172.17.101.49] (unknown [9.211.116.119])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat,  9 Oct 2021 13:29:53 +0000 (GMT)
Message-ID: <1749e7c3b528d361c09b40e5758b92c7386ffe1f.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] tpm: use SM3 instead of SM3_256
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Sat, 09 Oct 2021 08:29:52 -0500
In-Reply-To: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
References: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WI7fZO2iFMsMT2VYtdPhk3sDP0oOa09u
X-Proofpoint-ORIG-GUID: 55pBK2apPaN51qGasERyyQnEDHOUSIei
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-09_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110090093
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-10-09 at 21:08 +0800, Tianjia Zhang wrote:
> According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
> SM3 always produces a 256-bit hash value and there are no plans for
> other length development, so there is no ambiguity in the name of
> sm3.

For the TPM we're following the TPM Library specification

https://trustedcomputinggroup.org/resource/tpm-library-specification/

Which is very clear: the algorithm name is TPM_ALG_SM3_256

We're using sm3 as our exposed name because that's what linux crypto
uses, so there should be no problem in what the end user sees, but
changing to non standard TPM definitions is only going to cause
confusion at the kernel level.

James


