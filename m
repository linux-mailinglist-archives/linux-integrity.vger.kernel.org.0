Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92681476452
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Dec 2021 22:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhLOVK7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 16:10:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhLOVK7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 16:10:59 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFIFOwT006516;
        Wed, 15 Dec 2021 21:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0H21dSWks6lfyzIA33adcnIvPkdeT84cDPY1BPRGV2k=;
 b=n/W/vOSJtXI2Uk9JudUWHoIN6QrLwRfi2sOR80VUdotUNJPA24xqsl24W0/STrtFvEQT
 WW3WTHcoyfBBvLp/W2uFtftkhgraTrGMICHicGig83kpE1MZN7ZOpIucWTppQEwR8F4g
 wIxsxnAh6AiBCRLnnsvaKXw1x6KckAwYeTiSfwSOvnuNdFnbsRwlYuezRqZ49Q6LmKrw
 AOJHDktX3aU4IGu4VOkV6FL+RVoAsu7nj2GN3dBXclvpXd9aebOCRyUH1flTGwuQxJ/I
 fxFWn3ZuV+VG/QMnF+4Cvi6t67uu5BeZUf2MihqB2PtjBzM71knj4lTEZHBHKSBbPPbk tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cynfvufrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 21:10:32 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BFLAW12012765;
        Wed, 15 Dec 2021 21:10:32 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cynfvufqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 21:10:31 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BFL3IEF001970;
        Wed, 15 Dec 2021 21:10:29 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3cy77p8rmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 21:10:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BFLAQOD37552580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 21:10:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FEF55204E;
        Wed, 15 Dec 2021 21:10:26 +0000 (GMT)
Received: from sig-9-65-74-182.ibm.com (unknown [9.65.74.182])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2CC7C52057;
        Wed, 15 Dec 2021 21:10:23 +0000 (GMT)
Message-ID: <004908152121f617497a71ce3602a70cb25d5a38.camel@linux.ibm.com>
Subject: Re: [PATCH v6 01/17] ima: Add IMA namespace support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Date:   Wed, 15 Dec 2021 16:10:22 -0500
In-Reply-To: <20211210194736.1538863-2-stefanb@linux.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
         <20211210194736.1538863-2-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wdhGOcRm93yZVojXRKgJt-RC8mg6YyA2
X-Proofpoint-ORIG-GUID: tPua4oCeCeXDqJqB0JqY-lXZonMETbrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_12,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=992 malwarescore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112150116
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Fri, 2021-12-10 at 14:47 -0500, Stefan Berger wrote:
> Implement an IMA namespace data structure that gets created alongside a
> user namespace with CLONE_NEWUSER. This lays down the foundation for
> namespacing the different aspects of IMA (eg. IMA-audit, IMA-measurement,
> IMA-appraisal).
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Thanks, this patch set is looking a lot better.  Hopefully it isn't
premature for generic comments:

- With the SPDX line, the license info should be removed.

thanks,

Mimi

