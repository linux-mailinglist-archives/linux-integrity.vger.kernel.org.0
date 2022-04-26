Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4039051069D
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Apr 2022 20:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350189AbiDZSVp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Apr 2022 14:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353692AbiDZSVo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Apr 2022 14:21:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DBB11C9B6;
        Tue, 26 Apr 2022 11:18:34 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QHFaUs023109;
        Tue, 26 Apr 2022 18:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=pZNsKJEhbuvfZEbC4Yw2eoCMWOlmwWXFqFlNgeOEvH8=;
 b=Aat9CsB4Zz7VpTOSk2Sx3PqLAZgS0h+W6JfSIVOwvpKgZ8r4JdmeweRvMSQEy7QrVJT/
 scPrajPLt9PYHVq0iFb9bgAvyu5SO7AY9xG2RuYrW9c0MY4EqFvPSrHhUg1cn82t1u18
 5UODCRknt6bbhVpbWbv3FEA3U2txebZrpclbKabuKuobOpgvAvnlaEkodY7/ZNg7PE6i
 Op3Iw2XUxSV+DRxLs/bGpmSO+eRwyt547mZHHU9HhNjLbteJ1YthjBc6QQaXF6/Fpp3i
 ByMcoYL2A/df5Oi8w14lRJhkF3lepQDSU65fhB7QDiwX94F/DD9vIh07hmwImLtluRpX 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpgn7ywh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 18:18:22 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23QIFNL1019974;
        Tue, 26 Apr 2022 18:18:22 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpgn7ywgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 18:18:21 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QICdD9023025;
        Tue, 26 Apr 2022 18:18:19 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm938vsn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 18:18:19 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QI5FKa44761510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 18:05:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 168614C044;
        Tue, 26 Apr 2022 18:18:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C3154C040;
        Tue, 26 Apr 2022 18:18:16 +0000 (GMT)
Received: from sig-9-65-87-209.ibm.com (unknown [9.65.87.209])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 18:18:15 +0000 (GMT)
Message-ID: <d7ba004bd2ce2a8ce2ff0601b4bca921a5301ece.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: Allow ima_appraise bootparam to be set when
 SB is enabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 26 Apr 2022 14:18:15 -0400
In-Reply-To: <20220425222120.1998888-1-eric.snowberg@oracle.com>
References: <20220425222120.1998888-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qgcs47RawS7I43byRURuSWH7aUfJD9rQ
X-Proofpoint-ORIG-GUID: a7vf_X9dZCdjVbQBPkNl3f4VL_56TnG7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-04-25 at 18:21 -0400, Eric Snowberg wrote:
> The IMA_APPRAISE_BOOTPARM config allows enabling different "ima_appraise="
> modes (log, fix, enforce) to be configured at boot time.  When booting
> with Secure Boot enabled, all modes are ignored except enforce.  To use
> log or fix, Secure Boot must be disabled.
> 
> With a policy such as:
> 
> appraise func=BPRM_CHECK appraise_type=imasig
> 
> A user may just want to audit signature validation. Not all users
> are interested in full enforcement and find the audit log appropriate
> for their use case.
> 
> Add a new IMA_APPRAISE_SB_BOOTPARAM config allowing "ima_appraise="
> to work when Secure Boot is enabled.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Since the IMA architecture specific policy rules were first
upstreamed, either enabling IMA_APPRAISE_BOOTPARAM or IMA_ARCH_POLICY
was permitted, but not both.  This Kconfig negates the assumptions on
which the CONFIG_IMA_ARCH_POLICY and the ima_appraise_signature() are
based without any indication of the ramifications.   This impacts the
kexec file syscall lockdown LSM assumptions as well.

A fuller, more complete explanation for needing "log" mode when secure
boot is enabled is required.

thanks,

Mimi

> ---
>  security/integrity/ima/Kconfig        | 9 +++++++++
>  security/integrity/ima/ima_appraise.c | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index f3a9cc201c8c..66d25345e478 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -237,6 +237,15 @@ config IMA_APPRAISE_BOOTPARAM
>  	  This option enables the different "ima_appraise=" modes
>  	  (eg. fix, log) from the boot command line.
>  
> +config IMA_APPRAISE_SB_BOOTPARAM
> +	bool "ima_appraise secure boot parameter"
> +	depends on IMA_APPRAISE_BOOTPARAM
> +	default n
> +	help
> +	  This option enables the different "ima_appraise=" modes
> +	  (eg. fix, log) from the boot command line when booting
> +	  with Secure Boot enabled.
> +
>  config IMA_APPRAISE_MODSIG
>  	bool "Support module-style signatures for appraisal"
>  	depends on IMA_APPRAISE
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 17232bbfb9f9..a66b1e271806 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -43,7 +43,7 @@ void __init ima_appraise_parse_cmdline(void)
>  
>  	/* If appraisal state was changed, but secure boot is enabled,
>  	 * keep its default */
> -	if (sb_state) {
> +	if (sb_state && !IS_ENABLED(CONFIG_IMA_APPRAISE_SB_BOOTPARAM)) {
>  		if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
>  			pr_info("Secure boot enabled: ignoring ima_appraise=%s option",
>  				str);


