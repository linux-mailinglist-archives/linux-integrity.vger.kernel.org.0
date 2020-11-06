Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB9F2A9878
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Nov 2020 16:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgKFPYh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 10:24:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726812AbgKFPYh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 10:24:37 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6F3NAP056226;
        Fri, 6 Nov 2020 10:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KBbdnSiz3EXWnhfRMbhvejhr2vQ9k1ez+Tx9W+nIVrg=;
 b=SeSFoE3ZLmWoOCeSZKrKTM4Cc/LeywdLW6aPcK/QiWrDmjWo/DqyXxv1jsn6ZmgMnYzY
 npaIIaL6ZMkaLmAN1cNLCQbysemsixL0OOwfVp5OsyViRGScJIQRYCPOdNPMQWk/v3HC
 179cayvgqfqJFX1iEbf3r4rKUAzvJRLucCK5eRMmXvnys1Vi8H/UJdmieH/HUq21SMXi
 n2jkTHsTe8drlmtrShyz2S9HwYGWO+AGjsQJra4Kt0B1CWmeZfvvYpSGdcKrPCgP6k7V
 yQ1wjO2bDQJVDByFw3XNj0HRksHP9T7MeaETnOnQ5JCUU1y8twSv2rOpRF7uYlnE8sZV AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34n0vygnj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 10:24:33 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A6F3Sk9056743;
        Fri, 6 Nov 2020 10:24:32 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34n0vygngs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 10:24:32 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A6FCigg013609;
        Fri, 6 Nov 2020 15:24:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 34h01quduh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 15:24:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A6FORP05505684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 15:24:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F92DAE051;
        Fri,  6 Nov 2020 15:24:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B4A4AE045;
        Fri,  6 Nov 2020 15:24:24 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.77.67])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Nov 2020 15:24:23 +0000 (GMT)
Message-ID: <7219f4404bc1bed6eb090b94363c283ec3266a17.camel@linux.ibm.com>
Subject: Re: [PATCH v5 6/7] IMA: add critical_data to the built-in policy
 rules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Fri, 06 Nov 2020 10:24:23 -0500
In-Reply-To: <20201101222626.6111-7-tusharsu@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
         <20201101222626.6111-7-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060109
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi, Tushar,

This patch defines a new critical_data builtin policy.  Please update
the Subject line.

On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
> From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> The IMA hook to measure kernel critical data, namely
> ima_measure_critical_data(), could be called before a custom IMA policy
> is loaded. For example, SELinux calls ima_measure_critical_data() to
> measure its state and policy when they are initialized. This occurs
> before a custom IMA policy is loaded, and hence IMA hook will not
> measure the data. A built-in policy is therefore needed to measure
> critical data provided by callers before a custom IMA policy is loaded.

^Define a new critical data builtin policy to allow measuring early
kernel integrity critical data before a custom IMA policy is loaded.

Either remove the references to SELinux or move this patch after the
subsequent patch which measures SELinux critical data.

> 
> Add CRITICAL_DATA to built-in IMA rules if the kernel command line
> contains "ima_policy=critical_data". Set the IMA template for this rule
> to "ima-buf" since ima_measure_critical_data() measures a buffer.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

> ---
>  security/integrity/ima/ima_policy.c | 32 +++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index ec99e0bb6c6f..dc8fe969d3fe 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c

> @@ -875,6 +884,29 @@ void __init ima_init_policy(void)
>  			  ARRAY_SIZE(default_appraise_rules),
>  			  IMA_DEFAULT_POLICY);
>  
> +	if (ima_use_critical_data) {
> +		template = lookup_template_desc("ima-buf");
> +		if (!template) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		ret = template_desc_init_fields(template->fmt,
> +						&(template->fields),
> +						&(template->num_fields));

The default IMA template when measuring buffer data is "ima_buf".   Is
there a reason for allocating and initializing it here and not
deferring it until process_buffer_measurement()?

thanks,

Mimi

> +		if (ret)
> +			goto out;
> +
> +		critical_data_rules[0].template = template;
> +		add_rules(critical_data_rules,
> +			  ARRAY_SIZE(critical_data_rules),
> +			  IMA_DEFAULT_POLICY);
> +	}
> +
> +out:
> +	if (ret)
> +		pr_err("%s failed, result: %d\n", __func__, ret);
> +
>  	ima_update_policy_flag();
>  }
>  


