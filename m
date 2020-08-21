Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1622424DFE4
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Aug 2020 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHUSpa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Aug 2020 14:45:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbgHUSp0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Aug 2020 14:45:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LIX9jP063691;
        Fri, 21 Aug 2020 14:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=vSOS4YCf0VCleD8hfNfex3HRQvYcTP2XxAkZXGq19qo=;
 b=UBn8tYSNsfkoeSxiwg1bdoiR5tPseLBd+3251b7x4IA0t5Jl+pg3+Q4anG7vQMnY28yr
 Xs80SUKuGV3yOLVdUP+yGlJszJAny6J15bM8AeXcIPvSTouS6uVtCWiW5pBgPOrTbFid
 0Ef2yBJ9AkBRAIy5naK+A+FJhtay4SgxplmuyCTm/+54oNi38sFZwLmWTr8x0oaZewta
 6PX3YP/2bCPhhiwD4NNbic3kfDZq9OjJArQuWAjW7TfgxF7lNfFu4e5JhRgKnv2E3ZPy
 gSWa2Py8f52MAErMHw4HerdgxXRQPBzlfNjFOj3CfVZCdRBeu1accV2zF7l88J5rRmDE Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 332hdd45c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 14:45:22 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07LIY2gc066917;
        Fri, 21 Aug 2020 14:45:22 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 332hdd45b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 14:45:21 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07LIjJGL012179;
        Fri, 21 Aug 2020 18:45:19 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3304ujtud6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 18:45:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07LIjHTD21823964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 18:45:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 429D0A4053;
        Fri, 21 Aug 2020 18:45:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBFDAA4057;
        Fri, 21 Aug 2020 18:45:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.65.240])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Aug 2020 18:45:15 +0000 (GMT)
Message-ID: <8a1773d7707639d275fff138736d57472e26ade5.camel@linux.ibm.com>
Subject: Re: [PATCH 02/11] evm: Load EVM key in ima_load_x509() to avoid
 appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 21 Aug 2020 14:45:14 -0400
In-Reply-To: <20200618160133.937-2-roberto.sassu@huawei.com>
References: <20200618160133.937-1-roberto.sassu@huawei.com>
         <20200618160133.937-2-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210175
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-18 at 18:01 +0200, Roberto Sassu wrote:
> Public keys do not need to be appraised by IMA as the restriction on the
> IMA/EVM keyrings ensures that a key is loaded only if it is signed with a
> key in the primary or secondary keyring.
> 
> However, when evm_load_x509() is loaded, appraisal is already enabled and
> a valid IMA signature must be added to the EVM key to pass verification.
> 
> Since the restriction is applied on both IMA and EVM keyrings, it is safe
> to disable appraisal also when the EVM key is loaded. This patch calls
> evm_load_x509() inside ima_load_x509() if CONFIG_IMA_LOAD_X509 is defined.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/iint.c         | 2 ++
>  security/integrity/ima/ima_init.c | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index e12c4900510f..4765a266ba96 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -212,7 +212,9 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>  void __init integrity_load_keys(void)
>  {
>  	ima_load_x509();
> +#ifndef CONFIG_IMA_LOAD_X509
>  	evm_load_x509();
> +#endif
>  }
>  
>  static int __init integrity_fs_init(void)
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 4902fe7bd570..9d29a1680da8 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -106,6 +106,10 @@ void __init ima_load_x509(void)
>  
>  	ima_policy_flag &= ~unset_flags;
>  	integrity_load_x509(INTEGRITY_KEYRING_IMA, CONFIG_IMA_X509_PATH);
> +
> +	/* load also EVM key to avoid appraisal */
> +	evm_load_x509();
> +
>  	ima_policy_flag |= unset_flags;
>  }
>  #endif

As much as possible IMA and EVM should remain independent of each
other.   Modifying integrity_load_x509() doesn't help.  This looks like
a good reason for calling another EVM function from within IMA.

Mimi


