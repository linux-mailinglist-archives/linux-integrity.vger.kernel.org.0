Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC00E46F82E
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 01:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhLJBA4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 20:00:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230506AbhLJBAz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 20:00:55 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9MSYlJ028194;
        Fri, 10 Dec 2021 00:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bYl6OXKjNhwkrKbObOa7WeUgWt4eULrYYuSW1M5WMkc=;
 b=TcmzgoUPSB0Oxr43xX5qWPh3YfgsGa5EDZ/ZBZ4OpVEA3uAWPiK1mCPzk8mDBRkEJ4b0
 bwpMtMxfx4eW03X0wQy6KQHNCJmGzeCBam7aSx4W2GMPhykddk86loAiJFXaLqTtIzcT
 NGTRgKGM8q1e3BBzLeCWSopZXF87kjGvT2yjJZNVcdzmDv+rTQJ/nXqE35OShDNXFfmQ
 GNaTw3bC0Q/rs13kAuLDzE9YK13s7WzTJEm5teiMvNPjKNVjbWIUTaw1pSjTvXqc4nhv
 pXwoVbh2rkapJvSN9NahhDy5FxSiyWSO2Vh9ttm4HLrV9jA/A53GQ74QifoqI9t8SPtS yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cutmjj8t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 00:57:07 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BA0v6CS025861;
        Fri, 10 Dec 2021 00:57:06 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cutmjj8ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 00:57:06 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BA0qI2s005029;
        Fri, 10 Dec 2021 00:57:05 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3cqyycqkc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 00:57:05 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BA0v4k421954888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 00:57:04 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 208FD78068;
        Fri, 10 Dec 2021 00:57:04 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BD3E7805E;
        Fri, 10 Dec 2021 00:57:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 00:57:02 +0000 (GMT)
Message-ID: <0ab33fbc-8438-27b6-ff4c-0321bfc73855@linux.ibm.com>
Date:   Thu, 9 Dec 2021 19:57:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 13/16] ima: Move some IMA policy and filesystem related
 variables into ima_namespace
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-14-stefanb@linux.ibm.com>
 <20211209191109.o3x7nynnm52zhygz@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211209191109.o3x7nynnm52zhygz@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: symyAyegdhTQxTtL2MgyzkzvjLhsszWr
X-Proofpoint-ORIG-GUID: zN6DzbJMsFFbMYqjPokhmKfyYqgJy7v6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_09,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100001
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/9/21 14:11, Christian Brauner wrote:
>
>  From 1f03dc427c583d5e9ebc9ebe9de77c3c535bbebe Mon Sep 17 00:00:00 2001
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Thu, 9 Dec 2021 20:07:02 +0100
> Subject: [PATCH] !!!! HERE BE DRAGONS - UNTESTED !!!!
>
> ---
>   security/integrity/ima/ima_fs.c | 43 +++++++++++++++++++++++++++++----
>   1 file changed, 38 insertions(+), 5 deletions(-)
>
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 583462b29cb5..d5b302b925b8 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -317,10 +317,14 @@ static ssize_t ima_read_policy(char *path)
>   static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>   				size_t datalen, loff_t *ppos)
>   {
> -	struct ima_namespace *ns = get_current_ns();
> +	struct ima_namespace *ns;
> +	struct user_namespace *user_ns;
>   	char *data;
>   	ssize_t result;
>   
> +	user_ns = ima_filp_private(filp);
> +	ns = user_ns->ima_ns
> +
>   	if (datalen >= PAGE_SIZE)
>   		datalen = PAGE_SIZE - 1;
>   
> @@ -373,26 +377,51 @@ static const struct seq_operations ima_policy_seqops = {
>   };
>   #endif
>   
> +static struct user_namespace *ima_filp_private(struct file *filp)
> +{
> +	if (!(filp->f_flags & O_WRONLY)) {
> +#ifdef CONFIG_IMA_READ_POLICY
> +		struct seq_file *seq;
> +
> +		seq = filp->private_data;
> +		return seq->private;
> +#endif
> +	}
> +	return filp->private_data;
> +}
> +
>   /*
>    * ima_open_policy: sequentialize access to the policy file
>    */
>   static int ima_open_policy(struct inode *inode, struct file *filp)
>   {
> -	struct ima_namespace *ns = get_current_ns();
> +	struct user_namespace *user_ns = current_user_ns();


Do we have to take a reference on the user namespace assuming one can 
open the file, pass the fd down the hierarchy, and then the user 
namespace with the opened file goes away? Or is there anything else that 
keeps the user namespace alive?


