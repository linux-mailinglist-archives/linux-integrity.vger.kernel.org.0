Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 879D4160412
	for <lists+linux-integrity@lfdr.de>; Sun, 16 Feb 2020 13:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgBPMmp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 16 Feb 2020 07:42:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728054AbgBPMmp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Feb 2020 07:42:45 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01GCXm0D132975
        for <linux-integrity@vger.kernel.org>; Sun, 16 Feb 2020 07:42:44 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6cu0p8mr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 16 Feb 2020 07:42:44 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 16 Feb 2020 12:42:42 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 16 Feb 2020 12:42:38 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01GCgb0P48889918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Feb 2020 12:42:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6A42A4054;
        Sun, 16 Feb 2020 12:42:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8881A405B;
        Sun, 16 Feb 2020 12:42:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.138.53])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 16 Feb 2020 12:42:36 +0000 (GMT)
Subject: Re: [PATCH v4 2/3]  IMA: Add log statements for failure conditions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, joe@perches.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Sun, 16 Feb 2020 07:42:36 -0500
In-Reply-To: <20200215014709.3006-3-tusharsu@linux.microsoft.com>
References: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
         <20200215014709.3006-3-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021612-4275-0000-0000-000003A277FF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021612-4276-0000-0000-000038B67A0A
Message-Id: <1581856956.8515.170.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-16_02:2020-02-14,2020-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=2 bulkscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002160115
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-02-14 at 17:47 -0800, Tushar Sugandhi wrote:
> process_buffer_measurement() does not have log messages for failure
> conditions.
> 
> This change adds a log statement in the above function. 
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Joe Perches <joe@perches.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/integrity/ima/ima_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 9fe949c6a530..aac1c44fb11b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -757,6 +757,9 @@ void process_buffer_measurement(const void *buf, int size,
>  		ima_free_template_entry(entry);
>  
>  out:
> +	if (ret < 0)
> +		pr_devel("%s: failed, result: %d\n", __func__, ret);
> +
>  	return;
>  }
>  

