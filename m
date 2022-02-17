Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809194BAB17
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Feb 2022 21:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbiBQUbq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Feb 2022 15:31:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343695AbiBQUbp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Feb 2022 15:31:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600B164C9;
        Thu, 17 Feb 2022 12:31:30 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HKCC0D002979;
        Thu, 17 Feb 2022 20:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1cNKu373K9QrDP5uFf81HeBMrMVHHj3RvBwV8CXX4eI=;
 b=mm+ILmZEHhlc3KPaZxEtVAF3B8LCJ/Ezwi7qCvkB9MRhZcs+qd8fMRqLo2dkG9ITsgLQ
 L0YHEDZ8lntrawxnfGu91JcntALWtiL5NHCZEmjGXRKJbGlZEMuONymnLb31FHnLwDvf
 5HNNhzCXoNk8VM9tM42zNnRtJzZm++m+b1LjLhVyi5pnL6PvjB2B3KNOMYW1n6anP5hj
 wmGgmM56UYDOjx4w2r//ZH8Q04zQJm85d60iHyRXHgHeYWGmFLVKgjMV7PXHfr3+TMAn
 Pf49GcWIswpuIKAwzest2x0VMdtjKLB10WY8AyjVFF8/ej3Wza1W30PmngAl08hEs29d mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e9w6cgea5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 20:31:02 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21HKNZeF019907;
        Thu, 17 Feb 2022 20:31:02 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e9w6cge9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 20:31:02 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21HKNl9R012114;
        Thu, 17 Feb 2022 20:31:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3e645kdnjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 20:31:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21HKUti643647294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 20:30:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D320E4C040;
        Thu, 17 Feb 2022 20:30:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AE7B4C04E;
        Thu, 17 Feb 2022 20:30:53 +0000 (GMT)
Received: from sig-9-65-72-122.ibm.com (unknown [9.65.72.122])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Feb 2022 20:30:53 +0000 (GMT)
Message-ID: <62f946ec160296b6b20bee98986b2bafb8427718.camel@linux.ibm.com>
Subject: Re: [PATCH v10 11/27] ima: Move ima_lsm_policy_notifier into
 ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Thu, 17 Feb 2022 15:30:53 -0500
In-Reply-To: <20220201203735.164593-12-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-12-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hYURi_08e0k4PCpSSqaxX4XO40MB33V0
X-Proofpoint-ORIG-GUID: gFJlp_3Q_y27hH9Ws4Oqaip2-C-C4dgF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_07,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:

The builtin IMA policy rules are broad and may be constrained by
loading a custom policy, which could be defined in terms of LSM labels.
When an LSM policy is loaded, existing LSM labels might be affected or
even removed.  In either case, IMA policy rules based on LSM
labels, need to reflect these changes.  If an LSM label is removed,
instead of deleting the IMA policy rule based on the LSM label, the IMA
policy rule is made inactive.

> Move the ima_lsm_policy_notifier into the ima_namespace. Each IMA
> namespace can now register its own LSM policy change notifier callback.
> The policy change notifier for the init_ima_ns still remains in init_ima()
> and therefore handle the registration of the callback for all other
> namespaces in init_ima_namespace().
> 
> Suppress the kernel warning 'rule for LSM <label> is undefined` for all
> other IMA namespaces than the init_ima_ns.

Instead of ignoring the warnings totally, perhaps use either the
"ratelimited" or "once" function options for non init_ima_ns.  It would
be nice if these functions could be namespace aware, so that each
affected IMA namespace would contain at least one warning.

> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> 
> ---
> v10:
>  - Only call pr_warn('rule for LSM <label> is undefined`) for init_ima_ns
> ---
>  security/integrity/ima/ima.h             |  2 ++
>  security/integrity/ima/ima_init_ima_ns.c | 14 ++++++++++++++
>  security/integrity/ima/ima_main.c        |  6 +-----
>  security/integrity/ima/ima_policy.c      | 16 ++++++++++------
>  4 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 94c6e3a4d666..fb6bd054d899 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -144,6 +144,8 @@ struct ima_namespace {
>  	int valid_policy;
>  
>  	struct dentry *ima_policy;
> +
> +	struct notifier_block ima_lsm_policy_notifier;
>  } __randomize_layout;
>  extern struct ima_namespace init_ima_ns;
>  
> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> index 425eed1c6838..1cba545ae477 100644
> --- a/security/integrity/ima/ima_init_ima_ns.c
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -10,6 +10,8 @@
>  
>  static int ima_init_namespace(struct ima_namespace *ns)
>  {
> +	int rc;
> +

There's no right or wrong, but the newer IMA code uses 'ret'.

>  	INIT_LIST_HEAD(&ns->ima_default_rules);
>  	INIT_LIST_HEAD(&ns->ima_policy_rules);
>  	INIT_LIST_HEAD(&ns->ima_temp_rules);

