Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E0156A35
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Feb 2020 13:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgBIM5P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 9 Feb 2020 07:57:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727514AbgBIM5P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 9 Feb 2020 07:57:15 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 019Ct6O9088187
        for <linux-integrity@vger.kernel.org>; Sun, 9 Feb 2020 07:57:13 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u196wxy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 09 Feb 2020 07:57:13 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 9 Feb 2020 12:57:12 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 9 Feb 2020 12:57:09 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 019CuEPY20054478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 9 Feb 2020 12:56:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7571DA4040;
        Sun,  9 Feb 2020 12:57:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3D7BA4053;
        Sun,  9 Feb 2020 12:57:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.161.21])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  9 Feb 2020 12:57:07 +0000 (GMT)
Subject: Re: [PATCH] IMA: Add log statements for failure conditions.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Date:   Sun, 09 Feb 2020 07:57:07 -0500
In-Reply-To: <20200207195346.4017-2-tusharsu@linux.microsoft.com>
References: <20200207195346.4017-1-tusharsu@linux.microsoft.com>
         <20200207195346.4017-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020912-0008-0000-0000-0000035139C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020912-0009-0000-0000-00004A71D49E
Message-Id: <1581253027.5585.671.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-09_03:2020-02-07,2020-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 suspectscore=2 impostorscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002090108
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Fri, 2020-02-07 at 11:53 -0800, Tushar Sugandhi wrote:
> process_buffer_measurement() and ima_alloc_key_entry()
> functions do not have log messages for failure conditions.
> 
> This change adds log statements in the above functions. 
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

The two patches you posted are related.  Please group them as a patch
set, making this patch 2/2.

In addition, as Shuah Khan suggested for the security/integrity/
directory, "there is an opportunity here to add #define pr_fmt(fmt)
KBUILD_MODNAME ": " fmt to integrity.h and get rid of duplicate
defines."  With Joe Perches patch (waiting for it to be re-posted),
are all the pr_fmt definitions needed in each file in the
integrity/ima directory?

> ---
>  security/integrity/ima/ima_main.c       | 4 ++++
>  security/integrity/ima/ima_queue_keys.c | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 9fe949c6a530..afab796fb765 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -757,6 +757,10 @@ void process_buffer_measurement(const void *buf, int size,
>  		ima_free_template_entry(entry);
>  
>  out:
> +	if (ret < 0)
> +		pr_err("Process buffer measurement failed, result: %d\n",
> +			ret);

There's no reason to split the statement like this.  The joined line
is less than 80 characters.

> +
>  	return;
>  }
>  
> diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> index c87c72299191..2cc52f17ea81 100644
> --- a/security/integrity/ima/ima_queue_keys.c
> +++ b/security/integrity/ima/ima_queue_keys.c
> @@ -90,6 +90,8 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
>  
>  out:
>  	if (rc) {
> +		pr_err("Key entry allocation failed, result: %d\n",
> +			rc);

ditto

>  		ima_free_key_entry(entry);
>  		entry = NULL;
>  	}

thanks,

Mimi

