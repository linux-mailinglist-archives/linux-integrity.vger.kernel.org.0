Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11855473667
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Dec 2021 22:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbhLMVLe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 16:11:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237803AbhLMVLd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 16:11:33 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDKEYpp014358;
        Mon, 13 Dec 2021 21:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cxglZ7/AwM4mImr+J8Y9KgqOLtRmaU0v6+QCAKtir84=;
 b=pkeFxYzcXYc9PKF0qDkCBQRKslxnE43g05QRkRgL98YPVFTZ4tduo4FmAm5IoHZuec8k
 f/UvXFtX13/B0kaDbZgy8yd5imxdMb/zOrvwj9aqVlQbtq8EyW9Tx4PwlqKuY/oKY6mB
 lfJrTn87DsQx4Y47bl4/I6IuwhkqkKHAIozKe7/mFuH535hv+41FTUKYekaaipVGs8aq
 CNtSNk1X5ue16FQnDnu4RlYuurBpJ4NwU5RIOjTwIEFJD8glweC9kOre35iQomPRg9MP
 o4S4Q2SQvnjojTGWSVqM2jvhusRqp+blpELvooXByVLgO1CUyDYGuepw7IX8OjkWo0YF Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx9r86udf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 21:11:21 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BDKgbv1012728;
        Mon, 13 Dec 2021 21:11:20 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx9r86ucr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 21:11:20 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BDL8BNH002690;
        Mon, 13 Dec 2021 21:11:19 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 3cvkma10pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 21:11:19 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BDLBIVo19267986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 21:11:18 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D0CB6A047;
        Mon, 13 Dec 2021 21:11:18 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEB486A064;
        Mon, 13 Dec 2021 21:11:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 13 Dec 2021 21:11:16 +0000 (GMT)
Message-ID: <b4249c5d-da3d-4306-8d9b-10f06ec80cba@linux.ibm.com>
Date:   Mon, 13 Dec 2021 16:11:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 01/17] ima: Add IMA namespace support
Content-Language: en-US
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
 <20211210194736.1538863-2-stefanb@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211210194736.1538863-2-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gl0VRmzp9YJ5KhbgF-xrGoeCYfy5bvkM
X-Proofpoint-ORIG-GUID: 1Da7rQz0f_76s6BMfzO3OG24C7Y4_6HE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_10,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130125
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/10/21 14:47, Stefan Berger wrote:
> Implement an IMA namespace data structure that gets created alongside a
> user namespace with CLONE_NEWUSER. This lays down the foundation for
> namespacing the different aspects of IMA (eg. IMA-audit, IMA-measurement,
> IMA-appraisal).
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>   include/linux/ima.h                      | 37 +++++++++++++
>   include/linux/user_namespace.h           |  4 ++
>   init/Kconfig                             | 10 ++++
>   kernel/user.c                            |  7 +++
>   kernel/user_namespace.c                  |  8 +++
>   security/integrity/ima/Makefile          |  3 +-
>   security/integrity/ima/ima.h             |  4 ++
>   security/integrity/ima/ima_init.c        |  4 ++
>   security/integrity/ima/ima_init_ima_ns.c | 32 +++++++++++
>   security/integrity/ima/ima_ns.c          | 69 ++++++++++++++++++++++++
>   10 files changed, 177 insertions(+), 1 deletion(-)
>   create mode 100644 security/integrity/ima/ima_init_ima_ns.c
>   create mode 100644 security/integrity/ima/ima_ns.c
>
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index b6ab66a546ae..f282e40c316c 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -11,6 +11,7 @@
>   #include <linux/fs.h>
>   #include <linux/security.h>
>   #include <linux/kexec.h>
> +#include <linux/user_namespace.h>
>   #include <crypto/hash_info.h>
>   struct linux_binprm;
>   
> @@ -210,6 +211,42 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
>   }
>   #endif /* CONFIG_IMA_APPRAISE */
>   
> +struct ima_namespace {
> +	int avoid_zero_size;
> +};


I moved the structure to security/integrity/ima/ima.h for v7 and added 
__randomize_layout to it.

   Stefan
