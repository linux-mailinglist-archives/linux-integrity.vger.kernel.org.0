Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A3E2BABE2
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 15:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgKTOaS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Nov 2020 09:30:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727740AbgKTOaR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Nov 2020 09:30:17 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AKE3U9B040412;
        Fri, 20 Nov 2020 09:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=JZPHYx+6W4w8WOG3lRJPtgP3mZ8e+VXBMIW7EBpKJSQ=;
 b=rDaBKqueYW8UgRgk+ixhhk0btgA1A8TcGdpJvgn6VFAuXA1mvVp+VgATbJ6ZHsrYLPUV
 n/abyS+USjWjB6XT6OQxj9KaNYW2uVbTS2TPCs0yFDzdFck5U6S1szXvF8zCncdY6TS+
 CtAwArd2PQy8mJZckd33i+82dXtxvrxhxOufItIY6ZaRRgmbMDPmJT0khYia7hg8Kv0v
 uInFPC0lKAD+c+D+DMcEhY9GttnM88ndznX+7kmkXYz9igRpdhcjHU7uo6souKoRTEDw
 peOFNZCk72RJpK9JrQO2Xs7PgVYFpnhV6axa9SME8l8SPCoZD8daADXOhS0k2O7kUpaB jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34xe6b37fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 09:30:11 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AKE3mQu045247;
        Fri, 20 Nov 2020 09:30:11 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34xe6b37dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 09:30:11 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AKESVLD021127;
        Fri, 20 Nov 2020 14:30:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 34t6ghba1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 14:30:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AKEU6sv44368354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 14:30:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3414A42049;
        Fri, 20 Nov 2020 14:30:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D55F4204C;
        Fri, 20 Nov 2020 14:30:03 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.96.125])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Nov 2020 14:30:03 +0000 (GMT)
Message-ID: <e151e67e0749766c1b501ecc54dbeb0450c0cea2.camel@linux.ibm.com>
Subject: Re: [PATCH v6 7/8] IMA: add a built-in policy rule for critical
 data measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Fri, 20 Nov 2020 09:30:02 -0500
In-Reply-To: <20201119232611.30114-8-tusharsu@linux.microsoft.com>
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
         <20201119232611.30114-8-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_07:2020-11-20,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Thu, 2020-11-19 at 15:26 -0800, Tushar Sugandhi wrote:
> From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> The IMA hook to measure kernel critical data, namely
> ima_measure_critical_data(), could be called before a custom IMA policy
> is loaded.
> Define a new critical data builtin policy to allow measuring
> early kernel integrity critical data before a custom IMA policy is
> loaded.

Everything needing to be said seems to be included in the second
sentence.  Does the first sentence add anything?  "Define a new
critical data builtin policy" makes for a good Subject line.

> 
> Add critical data to built-in IMA rules if the kernel command line
> contains "ima_policy=critical_data".

The boot command line parameters are defined in Documentation/admin-
guide/kernel-parameters.txt.  Please update "ima_policy".

> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_policy.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index c9e52dab0638..119604a3efa0 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -206,6 +206,10 @@ static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
>  	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
>  };
> 
> +static struct ima_rule_entry critical_data_rules[] __ro_after_init = {
> +	{.action = MEASURE, .func = CRITICAL_DATA, .flags = IMA_FUNC},
> +};
> +
>  /* An array of architecture specific rules */
>  static struct ima_rule_entry *arch_policy_entry __ro_after_init;
>  
> @@ -228,6 +232,7 @@ __setup("ima_tcb", default_measure_policy_setup);
>  
>  static bool ima_use_appraise_tcb __initdata;
>  static bool ima_use_secure_boot __initdata;
> +static bool ima_use_critical_data __ro_after_init;

Unlike ima_fail_unverifiable_sigs, ima_use_critical_data is only used
during __init.  Please change "__ro_after_init" to "__initdata".  (The
critical data policy itself is defined properly as __ro_after_init.)

>  static bool ima_fail_unverifiable_sigs __ro_after_init;
>  static int __init policy_setup(char *str)
>  {
> @@ -242,6 +247,8 @@ static int __init policy_setup(char *str)
>  			ima_use_appraise_tcb = true;
>  		else if (strcmp(p, "secure_boot") == 0)
>  			ima_use_secure_boot = true;
> +		else if (strcmp(p, "critical_data") == 0)
> +			ima_use_critical_data = true;
>  		else if (strcmp(p, "fail_securely") == 0)
>  			ima_fail_unverifiable_sigs = true;
>  		else
> @@ -875,6 +882,11 @@ void __init ima_init_policy(void)
>  			  ARRAY_SIZE(default_appraise_rules),
>  			  IMA_DEFAULT_POLICY);
>  
> +	if (ima_use_critical_data)
> +		add_rules(critical_data_rules,
> +			  ARRAY_SIZE(critical_data_rules),
> +			  IMA_DEFAULT_POLICY);
> +
>  	ima_update_policy_flag();
>  }
>  


