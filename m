Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EEE20BA6B
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 22:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgFZUkb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 16:40:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgFZUka (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 16:40:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05QKW88E134874;
        Fri, 26 Jun 2020 16:40:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31wkbgg7ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 16:40:30 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05QKW8A5134921;
        Fri, 26 Jun 2020 16:40:29 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31wkbgg7xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 16:40:29 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05QKZEcr024552;
        Fri, 26 Jun 2020 20:40:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31uus73ey5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 20:40:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05QKeO749240862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jun 2020 20:40:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7C1A42042;
        Fri, 26 Jun 2020 20:40:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE6AB42041;
        Fri, 26 Jun 2020 20:40:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.213.63])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Jun 2020 20:40:23 +0000 (GMT)
Message-ID: <1593204023.27152.476.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] ima: move APPRAISE_BOOTPARAM dependency on
 ARCH_POLICY to runtime
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     erichte@linux.ibm.com, nayna@linux.ibm.com
Date:   Fri, 26 Jun 2020 16:40:23 -0400
In-Reply-To: <20200623202640.4936-3-bmeneg@redhat.com>
References: <20200623202640.4936-1-bmeneg@redhat.com>
         <20200623202640.4936-3-bmeneg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_12:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 cotscore=-2147483648 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006260142
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-06-23 at 17:26 -0300, Bruno Meneguele wrote:
<snip>

> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index edde88dbe576..62dc11a5af01 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -232,7 +232,7 @@ config IMA_APPRAISE_REQUIRE_POLICY_SIGS
>  
>  config IMA_APPRAISE_BOOTPARAM
>  	bool "ima_appraise boot parameter"
> -	depends on IMA_APPRAISE && !IMA_ARCH_POLICY
> +	depends on IMA_APPRAISE

Ok

>  	default y
>  	help
>  	  This option enables the different "ima_appraise=" modes
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index e493063a3c34..6742f86b6c60 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -732,12 +732,20 @@ void __init ima_init_policy(void)
>  	 * and custom policies, prior to other appraise rules.
>  	 * (Highest priority)
>  	 */
> -	arch_entries = ima_init_arch_policy();
> -	if (!arch_entries)
> -		pr_info("No architecture policies found\n");
> -	else
> -		add_rules(arch_policy_entry, arch_entries,
> -			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
> +	if (arch_ima_secure_or_trusted_boot()) {

Today only "measure" and "appraise" rules are included in the arch
specific policy, but someone might decide they want to include "audit"
rules as well.

I'm not if the "secure_boot" flag is available prior to calling
default_appraise_setup(), but if it is, you could modify the test
there to also check if the system is booted in secure boot mode (eg.
IS_ENABLED(CONFIG_IMA_APPRAISE_BOOTPARAM) &&
!arch_ima_get_secureboot())

> +		/* In secure and/or trusted boot the appraisal must be
> +		 * enforced, regardless kernel parameters, preventing
> +		 * runtime changes */

Only "appraise" rules are enforced.

Mimi
