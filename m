Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F76726DE34
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 16:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgIQO1W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 10:27:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727470AbgIQOZs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 10:25:48 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HEKOow088363;
        Thu, 17 Sep 2020 10:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6ux8W4aMaDCbaNX+eSW+989K6Uhm9qqViIHvfk7gyPE=;
 b=R9MCMKO/d+GBH3F9fKieIvs7PSFjlbMZq9knUd51rzHjx0Unhg0VR4zutu4G/AEQAUlR
 dhq7Cto+6JagzepUzUZqypRZm7GnRoSykhi7S70x7pKnAmwtV//d0SfoG1rI8JnwBJoR
 uFxySYVQKrUlZJxD3V9mMA4Ks6rAK7MkTQgdoQ+0feock7lFGWgA37Zv0Vm79dqb/GsT
 KEAnc65fq8imr2RI6LZqI5vOJtqz3eDAnlCDFqscx5vW6SS7aAHHrHg6SxhByMntkiur
 In7Uo55bBpquaPRb7kMRDS5VIgZ4rIddgSaI/7kAQNrK20shIloBoe3YyyPWfWx0QP6v Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m9fmr3g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 10:25:16 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08HEKZo1089837;
        Thu, 17 Sep 2020 10:25:16 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m9fmr3ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 10:25:16 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08HEHZZ9015305;
        Thu, 17 Sep 2020 14:25:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 33k6f2h4jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 14:25:13 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08HEPBpW23790008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 14:25:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2D074C059;
        Thu, 17 Sep 2020 14:25:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B10144C04A;
        Thu, 17 Sep 2020 14:25:09 +0000 (GMT)
Received: from sig-9-65-208-105.ibm.com (unknown [9.65.208.105])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Sep 2020 14:25:09 +0000 (GMT)
Message-ID: <c8d3c70e74e607a4b73239bef1e9db0d304200fc.camel@linux.ibm.com>
Subject: Re: [PATCH v2 11/12] ima: Introduce template field evmsig and write
 to field sig as fallback
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Thu, 17 Sep 2020 10:25:08 -0400
In-Reply-To: <20200904092643.20013-7-roberto.sassu@huawei.com>
References: <20200904092339.19598-1-roberto.sassu@huawei.com>
         <20200904092643.20013-7-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_09:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=3 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Fri, 2020-09-04 at 11:26 +0200, Roberto Sassu wrote:
> With the patch to accept EVM portable signatures when the
> appraise_type=imasig requirement is specified in the policy, appraisal can
> be successfully done even if the file does not have an IMA signature.
> 
> However, remote attestation would not see that a different signature type
> was used, as only IMA signatures can be included in the measurement list.
> This patch solves the issue by introducing the new template field 'evmsig'
> to show EVM portable signatures and by including its value in the existing
> field 'sig' if the IMA signature is not found.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>

Thank you!   Just a minor comment below.

<snip>

> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index c022ee9e2a4e..2c596c2a89cc 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> 
> @@ -438,7 +439,7 @@ int ima_eventsig_init(struct ima_event_data *event_data,
>  	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
>  
>  	if ((!xattr_value) || (xattr_value->type != EVM_IMA_XATTR_DIGSIG))
> -		return 0;
> +		return ima_eventevmsig_init(event_data, field_data);
>  
>  	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
>  					     DATA_FMT_HEX, field_data);
> @@ -484,3 +485,39 @@ int ima_eventmodsig_init(struct ima_event_data *event_data,
>  	return ima_write_template_field_data(data, data_len, DATA_FMT_HEX,
>  					     field_data);
>  }
> +
> +/*
> + *  ima_eventevmsig_init - include the EVM portable signature as part of the
> + *  template data
> + */
> +int ima_eventevmsig_init(struct ima_event_data *event_data,
> +			 struct ima_field_data *field_data)
> +{
> +	struct evm_ima_xattr_data *xattr_data = NULL;
> +	int rc = 0;
> +
> +	if (!event_data->file)
> +		return 0;
> +
> +	if (!(file_inode(event_data->file)->i_opflags & IOP_XATTR))
> +		return 0;
> +
> +	rc = vfs_getxattr_alloc(file_dentry(event_data->file), XATTR_NAME_EVM,
> +				(char **)&xattr_data, 0, GFP_NOFS);
> +	if (rc <= 0) {
> +		if (!rc || rc == -ENODATA)
> +			return 0;
> +
> +		return rc;

We're including the EVM signature on a best effort basis to help with
attestation.  Do we really care why it failed?   Are we going to act on
it?

Mimi

> +	}
> +
> +	if (xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG) {
> +		kfree(xattr_data);
> +		return 0;
> +	}
> +
> +	rc = ima_write_template_field_data((char *)xattr_data, rc, DATA_FMT_HEX,
> +					   field_data);
> +	kfree(xattr_data);
> +	return rc;
> +}


