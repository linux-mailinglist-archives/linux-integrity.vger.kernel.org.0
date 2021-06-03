Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B670B39A333
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 16:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhFCOca (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 10:32:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64351 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230309AbhFCOc3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 10:32:29 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 153EThrh174432;
        Thu, 3 Jun 2021 10:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1aBilWL/FxXL3IiG6OCyb7k4hSRu+l/CTQhK7VJwYZk=;
 b=cjLvY+kRW0SGGduKOdOcGyOltrTVZmmRoAqXN1NA94aC4pZZFxh7RwG6afhRdJF+dR64
 LIbcfMDmmg/GXxRESA01D3A4Q7RhTvF9iRyVTWqWSFlOjHFRIwfntNwqw6WSmUhSTwdm
 6EAHaVvh0q9ipIpUkbpPNWQEnFvJuZsUC8Zi6TvW7k+Fgtgu+ZgwnxRl7lTm/1nsDHYc
 OLY2zbG94F1M9evl9WTXyFbvo+nasr2l1LUrmuNWWU01QCXOvQIkovjZEB8lBcc0asnJ
 zENuaqjcxxNGrHWXH2PIL47kJ1XcvCpdDuSQJVTQrN6dfM4qnMyXo20gwafCJsJW91z+ ag== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38xy3s3x31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 10:30:35 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 153EHhFP016836;
        Thu, 3 Jun 2021 14:30:33 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 38ud88b1ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 14:30:33 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 153EUVBo27656570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Jun 2021 14:30:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D2214204C;
        Thu,  3 Jun 2021 14:30:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F6B742041;
        Thu,  3 Jun 2021 14:30:30 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.13.122])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Jun 2021 14:30:29 +0000 (GMT)
Message-ID: <883d61fcbaf173759ca5674173c6b80ecd7d0b69.camel@linux.ibm.com>
Subject: Re: [RESEND][PATCH v2 6/7] ima: Define new template evm-sig
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@srcf.ucam.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 03 Jun 2021 10:30:29 -0400
In-Reply-To: <20210603131705.1426671-1-roberto.sassu@huawei.com>
References: <9e5f5ddca94fb1915fb15302e2b7b5f2bf4a68a7.camel@linux.ibm.com>
         <20210603131705.1426671-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uAraSaVHs9iDztWZUqJG-cHscB1hixpS
X-Proofpoint-ORIG-GUID: uAraSaVHs9iDztWZUqJG-cHscB1hixpS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-03_09:2021-06-02,2021-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030097
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-06-03 at 15:17 +0200, Roberto Sassu wrote:
> With the recent introduction of the evmsig template field, remote verifiers
> can obtain the EVM portable signature instead of the IMA signature, to
> verify file metadata.
> 
> After introducing the new fields to include file metadata in the
> measurement list, this patch finally defines the evm-sig template, whose
> format is:
> 
> d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode
> 
> xattrnames, xattrlengths and xattrvalues are populated only from defined
> EVM protected xattrs, i.e. the ones that EVM considers to verify the
> portable signature. xattrnames and xattrlengths are populated only if the
> xattr is present.
> 
> xattrnames and xattrlengths are not necessary for verifying the EVM
> portable signature, but they are included for completeness of information,
> if a remote verifier wants to infer more from file metadata.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  Documentation/security/IMA-templates.rst | 1 +
>  security/integrity/ima/ima_template.c    | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
> index 6a58760a0a35..5adc22f99496 100644
> --- a/Documentation/security/IMA-templates.rst
> +++ b/Documentation/security/IMA-templates.rst
> @@ -91,6 +91,7 @@ Below, there is the list of defined template descriptors:
>   - "ima-sig": its format is ``d-ng|n-ng|sig``;
>   - "ima-buf": its format is ``d-ng|n-ng|buf``;
>   - "ima-modsig": its format is ``d-ng|n-ng|sig|d-modsig|modsig``;
> + - "evm-sig": its format is ``d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode``;
>  
>  
>  Use
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> index 159a31d2fcdf..a85963853a91 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -22,6 +22,8 @@ static struct ima_template_desc builtin_templates[] = {
>  	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
>  	{.name = "ima-buf", .fmt = "d-ng|n-ng|buf"},
>  	{.name = "ima-modsig", .fmt = "d-ng|n-ng|sig|d-modsig|modsig"},
> +	{.name = "evm-sig",
> +	 .fmt = "d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode"},
>  	{.name = "", .fmt = ""},	/* placeholder for a custom format */
>  };
>  
> @@ -69,7 +71,8 @@ static const struct ima_template_field supported_fields[] = {
>   * need to be accounted for since they shouldn't be defined in the same template
>   * description as 'd-ng' and 'n-ng' respectively.
>   */
> -#define MAX_TEMPLATE_NAME_LEN sizeof("d-ng|n-ng|sig|buf|d-modisg|modsig")
> +#define MAX_TEMPLATE_NAME_LEN \
> +	sizeof("d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode")
>  
>  static struct ima_template_desc *ima_template;
>  static struct ima_template_desc *ima_buf_template;

Thanks, Roberto.

Updated and merged next-integrity-testing, next-integrity branches.

thanks,

Mimi


