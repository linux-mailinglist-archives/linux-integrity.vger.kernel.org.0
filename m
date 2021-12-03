Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29E9467A05
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 16:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381700AbhLCPLc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Dec 2021 10:11:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64034 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352696AbhLCPL2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Dec 2021 10:11:28 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3DLuQA028047;
        Fri, 3 Dec 2021 15:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2cFXAN/l2/UYLKSPX5qWLC5W2UyGkAz8pCnKz/9jRxI=;
 b=QTNAeUxZBIvsO570s2V4u/sJGmTOaWVAm987zZzFjCGX3ZmVYrhmgF78RMUz+EfTiHlg
 KlEXwKmSs3x5cHAhfI9EvjW0n6sAPvUdIlsiCdqP66hn0GO/wBx6LrPRfu7KP2x7jk3o
 UIfVe2MfaKkwNrDte8NPDXJcuG5j09WSv7amLCK27A4o5P/cDJuXJzWisVxXS1nOr7Wc
 feg88Qn5T7FdGb1JfwlyFEhFEvRe7epbrC1Ou0ua4j0qLR3UHcltKx2ebwwg4KOXFZQx
 gfmcotMBBkBQbDm4w1PUQ6iIYaSTjIW7ht7A8cHlMuN3bWWP4sCbPvwEKI/3+TxYL3+q Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cqm2cabd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 15:07:50 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B3EYBHc015114;
        Fri, 3 Dec 2021 15:07:49 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cqm2cabcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 15:07:49 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B3F7gtA013345;
        Fri, 3 Dec 2021 15:07:48 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 3cnne41vuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 15:07:48 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B3F7i6616843562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 15:07:45 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E24A6AC065;
        Fri,  3 Dec 2021 15:07:44 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A541DAC06D;
        Fri,  3 Dec 2021 15:07:44 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 15:07:44 +0000 (GMT)
Message-ID: <61a268d1-2832-5ea7-d37f-b491800b2813@linux.ibm.com>
Date:   Fri, 3 Dec 2021 10:07:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
Content-Language: en-US
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
 <20211203023118.1447229-20-stefanb@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211203023118.1447229-20-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8skYYLs1AkXf7gIzZ4OWcZ4tjQJfvLH7
X-Proofpoint-GUID: OHVMqdw48kmosppt0WX7g4q3htEPmx3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030095
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/2/21 21:31, Stefan Berger wrote:
>   extern struct ima_namespace init_ima_ns;
> diff --git a/security/inode.c b/security/inode.c
> index 2738a7b31469..6223f1d838f6 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -22,6 +22,7 @@
>   #include <linux/lsm_hooks.h>
>   #include <linux/magic.h>
>   #include <linux/user_namespace.h>
> +#include <linux/ima.h>
>   
>   static struct vfsmount *securityfs_mount;
>   static int securityfs_mount_count;
> @@ -63,6 +64,13 @@ static const struct fs_context_operations securityfs_context_ops = {
>   
>   static int securityfs_init_fs_context(struct fs_context *fc)
>   {
> +	int rc;
> +
> +	if (fc->user_ns->ima_ns->late_fs_init) {
> +		rc = fc->user_ns->ima_ns->late_fs_init(fc->user_ns);
> +		if (rc)
> +			return rc;
> +	}
>   	fc->ops = &securityfs_context_ops;
>   	return 0;
>   }


Kernel test robot made me change it to this here:

static int securityfs_init_fs_context(struct fs_context *fc)
{
         fc->ops = &securityfs_context_ops;

         return ima_ns_late_fs_init(fc->user_ns);
}

With this here when CONFIG_IMA_NS is defined:

static inline int ima_ns_late_fs_init(struct user_namespace *user_ns)
{
         struct ima_namespace *ns = user_ns->ima_ns;

         if (ns->late_fs_init)
                 return ns->late_fs_init(ns);

         return 0;
}

    Stefan


