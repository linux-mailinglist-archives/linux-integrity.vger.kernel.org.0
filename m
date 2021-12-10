Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC10470B79
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 21:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhLJUMR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 15:12:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232906AbhLJUMR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 15:12:17 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJRiBp021062;
        Fri, 10 Dec 2021 20:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ogkJ3lXGwhQIYiOFOEOgjHKquhZLwTAW9+pxfmkSEpk=;
 b=nXm75KoUj8iHLIq2FHWzO3/3h9nuJuYWl9ET2b1Am9imf5X71KbGXEcYHeerw3a3GjLk
 fiOdJPAzO+sPhQohGGY1xNOY2zusHZGTjXDl9ZN22nJzSGJ2ou0k+safFRdb9Gxs/h/R
 hXNAi874WQFZk5Ea8jOczORFFOdpUMkn11iIXsdllAcMdAZcZ0YfWIp3fD0SJc9RTjQ3
 RMiAqvx78queE7zShA4qR/tAIn0X/h5E0F8ufnuKnaxjkbQ+R/swSkABUCQjFgbOS5vk
 XD6i9cF6rYhwMkl11AgJ164HLsharZEi6FVKQCbzaqEkrTxpeXZGp9jQUwxsgCU7631y mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cvd2u8p0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 20:08:32 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAJifMF026703;
        Fri, 10 Dec 2021 20:08:31 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cvd2u8p05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 20:08:31 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAK3wSx006265;
        Fri, 10 Dec 2021 20:08:30 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 3cqyycp6q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 20:08:30 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAK8TMe32440758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 20:08:29 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42B336A051;
        Fri, 10 Dec 2021 20:08:29 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA7B26A054;
        Fri, 10 Dec 2021 20:08:27 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 20:08:27 +0000 (GMT)
Message-ID: <8b5eaf38-2e7b-1c82-a715-50f0ffd4d1ff@linux.ibm.com>
Date:   Fri, 10 Dec 2021 15:08:27 -0500
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
 <0ab33fbc-8438-27b6-ff4c-0321bfc73855@linux.ibm.com>
 <20211210113244.odv2ibrifz2jzft5@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211210113244.odv2ibrifz2jzft5@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CIZ0onRIN-GaxJLQEESf7-o55-uuOpHn
X-Proofpoint-ORIG-GUID: hWpn7xvf4NgfNIlu6iOyhji_I49YfGYG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_08,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/10/21 06:32, Christian Brauner wrote:
>  From ecf25d6b2b5895005d4103169bdb55d970e7a865 Mon Sep 17 00:00:00 2001
> From: Christian Brauner<christian.brauner@ubuntu.com>
> Date: Fri, 10 Dec 2021 11:56:25 +0100
> Subject: [PATCH 2/2] !!!! HERE BE DRAGONS - COMPLETELY UNTESTED !!!!
>
> securityfs: don't allow mounting from outside the filesystem's userns
>
> If we ever need to allow that we should revisit the semantics.
> ---
>   security/inode.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/security/inode.c b/security/inode.c
> index eaccba7017d9..71f9634228f3 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -43,7 +43,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
>   {
>   	static const struct tree_descr files[] = {{""}};
>   	struct user_namespace *ns = fc->user_ns;
> -	int error;
> +	int error = -EINVAL;
> +
> +	if (WARN_ON(ns != current_user_ns()))
> +		return error;
>   
>   	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
>   	if (error)


Oops, I hadn't seen this patch. How can one 'mount from outside the 
filesystem's userns'?


