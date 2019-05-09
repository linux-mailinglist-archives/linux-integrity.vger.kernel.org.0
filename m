Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E322018D4B
	for <lists+linux-integrity@lfdr.de>; Thu,  9 May 2019 17:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfEIPqp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 May 2019 11:46:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbfEIPqo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 May 2019 11:46:44 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49FcS8Z091626
        for <linux-integrity@vger.kernel.org>; Thu, 9 May 2019 11:46:43 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2scpj91xsq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 09 May 2019 11:46:43 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 9 May 2019 16:46:40 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 May 2019 16:46:34 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x49FkX0Q36700272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 May 2019 15:46:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 859404C04A;
        Thu,  9 May 2019 15:46:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A6A54C04E;
        Thu,  9 May 2019 15:46:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.107])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 May 2019 15:46:31 +0000 (GMT)
Subject: Re: [PATCH v10 06/12] ima: Use designated initializers for struct
 ima_event_data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date:   Thu, 09 May 2019 11:46:20 -0400
In-Reply-To: <20190418035120.2354-7-bauerman@linux.ibm.com>
References: <20190418035120.2354-1-bauerman@linux.ibm.com>
         <20190418035120.2354-7-bauerman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050915-0020-0000-0000-0000033AFAC4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050915-0021-0000-0000-0000218DA29E
Message-Id: <1557416780.10635.66.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905090090
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
> Designated initializers allow specifying only the members of the struct
> that need initialization. Non-mentioned members are initialized to zero.
> 
> This makes the code a bit clearer (particularly in ima_add_boot_aggregate()
> and also allows adding a new member to the struct without having to update
> all struct initializations.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/integrity/ima/ima_api.c  | 11 +++++++----
>  security/integrity/ima/ima_init.c |  4 ++--
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index c7505fb122d4..0639d0631f2c 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -133,8 +133,9 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>  {
>  	struct ima_template_entry *entry;
>  	struct inode *inode = file_inode(file);
> -	struct ima_event_data event_data = {iint, file, filename, NULL, 0,
> -					    cause};
> +	struct ima_event_data event_data = { .iint = iint, .file = file,
> +					     .filename = filename,
> +					     .violation = cause };
>  	int violation = 1;
>  	int result;
>  
> @@ -284,8 +285,10 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
>  	int result = -ENOMEM;
>  	struct inode *inode = file_inode(file);
>  	struct ima_template_entry *entry;
> -	struct ima_event_data event_data = {iint, file, filename, xattr_value,
> -					    xattr_len, NULL};
> +	struct ima_event_data event_data = { .iint = iint, .file = file,
> +					     .filename = filename,
> +					     .xattr_value = xattr_value,
> +					     .xattr_len = xattr_len };
>  	int violation = 0;
>  
>  	if (iint->measured_pcrs & (0x1 << pcr))
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 6c9295449751..ef6c3a26296e 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -49,8 +49,8 @@ static int __init ima_add_boot_aggregate(void)
>  	const char *audit_cause = "ENOMEM";
>  	struct ima_template_entry *entry;
>  	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> -	struct ima_event_data event_data = {iint, NULL, boot_aggregate_name,
> -					    NULL, 0, NULL};
> +	struct ima_event_data event_data = { .iint = iint,
> +					     .filename = boot_aggregate_name };
>  	int result = -ENOMEM;
>  	int violation = 0;
>  	struct {

