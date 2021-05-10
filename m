Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E879379003
	for <lists+linux-integrity@lfdr.de>; Mon, 10 May 2021 16:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbhEJN6q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 May 2021 09:58:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244102AbhEJN4g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 May 2021 09:56:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ADXJqx154680
        for <linux-integrity@vger.kernel.org>; Mon, 10 May 2021 09:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2ARlfodn+/148kjUH89DjNnQdRVXIE995CiC2CslLJI=;
 b=jg6/FLV+HvPJWNGXH+VPAc8l+6yq+uVfai1syqxGpIMz4BRPXBFvKmk19mLtDj0Ms0XR
 TJ+gbpRRh7s/wJCcn5Sv7zsoF4aUy3ckXVGKLNmmE0CpyLqxhK1LwSpNliVv+XvraIFJ
 W8tisCeb+tValhmAVJ+4n4cD37G4D3W88eAhAwtrhXYHynFE4LlLN1fnuy84+/L/xQ4q
 Y2OtKWhQ07FZn+BPBYXdNHPFMMk/w6d/dx9DOqOvkN7ASctttdJMUG68G2Z0KrznhlUE
 IQ8A5Bc/HMReKhrrvwOkBc9LEa7k0aqHQiiE1JjUQJLRwgpAASVmQsOoRlBoOe3K4KXM mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38f3scw2vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 10 May 2021 09:55:31 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14ADXoQ9158608
        for <linux-integrity@vger.kernel.org>; Mon, 10 May 2021 09:55:31 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38f3scw2vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 09:55:31 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14ADq4Ge021167;
        Mon, 10 May 2021 13:55:30 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 38dj99a785-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 13:55:30 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14ADtTxG22413610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 13:55:29 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A43A112067;
        Mon, 10 May 2021 13:55:29 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DDB5112066;
        Mon, 10 May 2021 13:55:29 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 10 May 2021 13:55:29 +0000 (GMT)
Subject: Re: [PATCH v2 0/3] ima-evm-utils: Implement function to only create
 IMA signature
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
References: <20210427193133.1718367-1-stefanb@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <94771a1d-c48e-3773-8f1f-282519648a73@linux.ibm.com>
Date:   Mon, 10 May 2021 09:55:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427193133.1718367-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3i9T5NHUbpGOCD5rqkG7Uw9m8gBBxL_u
X-Proofpoint-GUID: JNXdf0H1iUrG7jf9DPvCy9SpQ8a2zLgE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_07:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105100096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I will rebase this series of patches on Vitaly's keyid-related changes, 
which are good to have 'underneath'.

   Stefan


On 4/27/21 3:31 PM, Stefan Berger wrote:
> This series of patches implements imaevm_create_ima_signature, a function that
> only creates an IMA v2 signature but does not write it into an xattr. This API
> fullfills a requirement of rpm-ostree where a tool is being built to sign all
> files from something similar to a tar byte stream, though where files are written
> to temporary files for signing purpose but the signature itself should not be
> written into the filesystem's xattr but simply returned via the API.
>
>    Stefan
>
> v2:
>   - use imaevm_calc_hash to also cover hash calculations of links,
>     directories etc.
>    
> Stefan Berger (3):
>    libimaevm: Implement imaevm_create_ima_signature
>    tests: Add program to create IMA signature with new API call
>    libimaevm: Have sign_hash_v2 call sign_hash_v2_pkey after reading key
>      file
>
>   src/imaevm.h                 |   2 +
>   src/libimaevm.c              | 148 ++++++++++++++++++++++++++++-------
>   tests/Makefile.am            |   6 ++
>   tests/create_ima_signature.c | 111 ++++++++++++++++++++++++++
>   tests/sign_verify.test       |  21 ++++-
>   5 files changed, 257 insertions(+), 31 deletions(-)
>   create mode 100644 tests/create_ima_signature.c
>
