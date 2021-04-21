Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F99367599
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Apr 2021 01:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343674AbhDUXMp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Apr 2021 19:12:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343618AbhDUXMo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Apr 2021 19:12:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LN4HUI043461;
        Wed, 21 Apr 2021 19:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HukO25WBoa6+3VpFRlnoB2ozqMqe9XYU+yPpXvRpiOY=;
 b=VSTrKQR5khI7ZagFWogMFrd2FtdaI8CVrTxZs0Kj7Fm+8pSLKzWJAQ8QXHCSl+Ve/dGA
 2/PKaQAU9v4owezqAJS7jJ9MobOxWmB521zWaHiaVd/6vyDN2QhJu2yRETIwaGXHp7kG
 mp+3CbTg4WLjI1+34hMk5x+1f9TuilvCG4lzR2trX0yrnGLtCDo6yI+0cJJL4MHmpej1
 EmcqQTvRkrIS1iAx0rj4c/eaLou65vA4enW3t6O7Ve7cne2bI7UpcNdVjovfpSzKwI7B
 LSXk7A4c21S/nx8Ho5x2k6LLLq+XabqyPs7rwc0Y+wQBrQUSfK6j2EesHiJOnbi9vCgS aA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382vd7hew7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 19:12:06 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13LNC2gD002586;
        Wed, 21 Apr 2021 23:12:04 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 37yt2rtg0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 23:12:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13LNC2Gi43123126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 23:12:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EB25A405C;
        Wed, 21 Apr 2021 23:12:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E129EA405B;
        Wed, 21 Apr 2021 23:12:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.157.65])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Apr 2021 23:12:00 +0000 (GMT)
Message-ID: <19b01258a143f0eae421f6500a739ec4a53b702e.camel@linux.ibm.com>
Subject: Re: [PATCH] KEYS: trusted: Fix TPM reservation for seal/unseal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     jarkko@kernel.org
Date:   Wed, 21 Apr 2021 19:11:59 -0400
In-Reply-To: <30acbe05a0569bd3b3a9f968c4863e1f42b6d320.camel@HansenPartnership.com>
References: <30acbe05a0569bd3b3a9f968c4863e1f42b6d320.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sy-pGGOVmNQc-2pSfcXs0ZqzMi9iCTNd
X-Proofpoint-ORIG-GUID: sy-pGGOVmNQc-2pSfcXs0ZqzMi9iCTNd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_06:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210152
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-04-21 at 15:42 -0700, James Bottomley wrote:
> The original patch 8c657a0590de ("KEYS: trusted: Reserve TPM for seal
> and unseal operations") was correct on the mailing list:
> 
> https://lore.kernel.org/linux-integrity/20210128235621.127925-4-jarkko@kernel.org/
> 
> But somehow got rebased so that the tpm_try_get_ops() in
> tpm2_seal_trusted() got lost.  This causes an imbalanced put of the
> TPM ops and causes oopses on TIS based hardware.
> 
> This fix puts back the lost tpm_try_get_ops()
> 
> Fixes: 8c657a0590de ("KEYS: trusted: Reserve TPM for seal and unseal operations")
> Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Thanks, James!

Acked-by: Mimi Zohar <zohar@linux.ibm.com>

Mimi

