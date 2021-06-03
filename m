Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A85A39A157
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 14:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFCMqf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 08:46:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229966AbhFCMqe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 08:46:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 153Cb2UZ043771;
        Thu, 3 Jun 2021 08:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=oGrl/dxatTV8oTyTC4Z4yYBQXQWCw7AGoOuMKI4J2eE=;
 b=BQOpPFkDuot4FJ+wlGbim3wAZ84W+l+VFxYGGVzLr/Kkpr0sEH8ICnnTJgBnDY8XpXMa
 oCWG2SNCzgA1cTyEJVYhvxhiwOVOpKJzNXznf+YS2aaQ5ssDOUOTOCt8klTPD1Ahmf+X
 aGpCqFGohZthBYVWcXdXRulw0JHNQ6oq6J2FjniZvaNuFqSN2V8OcblUl5myNUaiHS0w
 LfNOuzDoI895/Z6ILwfSW2OhmohfP5o9LJd9desS6rcwtU6YCDshnRCCyAtWMc7rtYAi
 A5hUfjTGygQmIraJg9eDCrn4Q3/g59psuiP/lg3G+89ZFS/EHo6Z180z9w9OisLnEZI/ DA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38xy85872v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 08:44:42 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 153Cd6Sv012236;
        Thu, 3 Jun 2021 12:44:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 38ucvh9nbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 12:44:40 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 153Ci3dD33685930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Jun 2021 12:44:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E165611C058;
        Thu,  3 Jun 2021 12:44:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1312411C04A;
        Thu,  3 Jun 2021 12:44:36 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.13.122])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Jun 2021 12:44:35 +0000 (GMT)
Message-ID: <9e5f5ddca94fb1915fb15302e2b7b5f2bf4a68a7.camel@linux.ibm.com>
Subject: Re: [PATCH v2 6/7] ima: Define new template evm-sig
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@srcf.ucam.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 03 Jun 2021 08:44:35 -0400
In-Reply-To: <20210528073812.407936-7-roberto.sassu@huawei.com>
References: <20210528073812.407936-1-roberto.sassu@huawei.com>
         <20210528073812.407936-7-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K_vGcFicJc80uRntXPnB2i8tkMIQCBxf
X-Proofpoint-ORIG-GUID: K_vGcFicJc80uRntXPnB2i8tkMIQCBxf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-03_08:2021-06-02,2021-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030085
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-05-28 at 09:38 +0200, Roberto Sassu wrote:
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
> ---
>  Documentation/security/IMA-templates.rst | 1 +
>  security/integrity/ima/ima_template.c    | 3 +++
>  2 files changed, 4 insertions(+)
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
> index 159a31d2fcdf..be435efe6122 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -22,6 +22,9 @@ static struct ima_template_desc builtin_templates[] = {
>  	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
>  	{.name = "ima-buf", .fmt = "d-ng|n-ng|buf"},
>  	{.name = "ima-modsig", .fmt = "d-ng|n-ng|sig|d-modsig|modsig"},
> +	{.name = "evm-sig",
> +	 .fmt = "d-ng|n-ng|evmsig|"
> +		"xattrnames|xattrlengths|xattrvalues|iuid|igid|imode"},

checkpatch is complaining "WARNING: quoted string split across lines".

>  	{.name = "", .fmt = ""},	/* placeholder for a custom format */
>  };
>  

The MAX_TEMPLATE_NAME_LEN needs to be updated.

thanks,

Mimi

