Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446A63D3A7E
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jul 2021 14:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhGWMIt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jul 2021 08:08:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28754 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234853AbhGWMIt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jul 2021 08:08:49 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NCbtgS029851;
        Fri, 23 Jul 2021 08:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3F25Cp/BBTu4FvFQx+3kdA4ZNLHpZT3Aw62eqLBYjms=;
 b=YNA0SZHUUHbzYH6MSBueQVMzg3S3PK8FmGjrLvSiKjNRVe8LJEetWDZ1Lmv4vUET5V3k
 qdSstFR9Ecgad8s+5LZrIWOvnbYUz26lcr+1KyGBHArrdpQc17+gmxIppz9cBs7sQMp7
 MuCOP3S3I4BdsBHrJYE+1lCAuFYFpc696tQNM8fQ8CFPZ+CxBy74WARWgOwPxPayrPk1
 o3ludRmzv0CJgShdOOVGofM4FRNhhlKIyx/ohxWTvEBO0jCYQ5L+6SJeUJ9mtvhtKzZX
 OUXipsOEDmhxu8SWh1GxtgHgOaUf8lHXguHKeXq0jp3ANjlu4lXzj1SbQ90WwEV2CWrz Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39yvqvahc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 08:49:16 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16NCcvDe035223;
        Fri, 23 Jul 2021 08:49:15 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39yvqvahbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 08:49:15 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16NCnEIP030993;
        Fri, 23 Jul 2021 12:49:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 39vng72nq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 12:49:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16NCnB9I29360452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 12:49:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A33D6A4051;
        Fri, 23 Jul 2021 12:49:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9801CA4040;
        Fri, 23 Jul 2021 12:49:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.74.193])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Jul 2021 12:49:09 +0000 (GMT)
Message-ID: <676e9af54eb252c26410788e6105c149c57b2c15.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/3] ima: Introduce ima_get_current_hash_algo()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, prsriva02@gmail.com,
        tusharsu@linux.microsoft.com, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Date:   Fri, 23 Jul 2021 08:49:08 -0400
In-Reply-To: <20210723085304.1760138-2-roberto.sassu@huawei.com>
References: <20210723085304.1760138-1-roberto.sassu@huawei.com>
         <20210723085304.1760138-2-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QxEPAdLGUjAbAVlowediwrlJB-nBSBeE
X-Proofpoint-GUID: 7NUBRpYWJpG8rb7HwKkuwxv4SxsPPrRP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-23_05:2021-07-23,2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107230074
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-07-23 at 10:53 +0200, Roberto Sassu wrote:
> Buffer measurements, unlike file measurements, are not accessible after the
> measurement is done, as buffers are not suitable for use with the
> integrity_iint_cache structure (there is no index, for files it is the
> inode number). In the subsequent patches, the measurement (digest) will be
> returned directly by the functions that perform the buffer measurement,
> ima_measure_critical_data() and process_buffer_measurement().
> 
> A caller of those functions also needs to know the algorithm used to
> calculate the digest. Instead of adding the algorithm as a new parameter to
> the functions, this patch provides it separately with the new function
> ima_get_current_hash_algo().
> 
> Since the hash algorithm does not change after the IMA setup phase, there
> is no risk of races (obtaining a digest calculated with a different
> algorithm than the one returned).

Perfect explaination for annotating ima_hash_algo like:

int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;

Assuming you don't object, I'll include this change in this patch.

thanks,

Mimi

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

