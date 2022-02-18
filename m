Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8CC4BBD6F
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 17:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbiBRQ16 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 11:27:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiBRQ15 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 11:27:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA52613D;
        Fri, 18 Feb 2022 08:27:41 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFb8Kb008027;
        Fri, 18 Feb 2022 16:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=o3P1qYY1/ezBZqevShAswpwqky2qNsNP5MCpQ2s/wxs=;
 b=mqL5+oK1MGSarmGmr9UffCfoCDb/WSYytwyy7NrsSVjMJj64fvjwAeKXvqmY0MoZv3Tj
 Va1vdRlLrclYaPgmVsVQdPjFPAAhLeUwFwEwDw9UrfEufkSIxmdBakM+cy59TmjZjj+G
 yhjpEA0W+4PoszG1kvM32IJJMQ0bFlcT4LPKBI8Lm+wL9qxKL7BNubGsoY+4eARBdXlr
 0xPft25y3DhkGCUtUwj1GvyIiYRI6YhUMhWr2XRsBiPbAHQ3w2yWAa9NytSNTpViHngS
 7hdwSbB+0zeCDMF0WbXHhR6BVLtZIdCp6sK9NFdxuG7sXzb7+246hcFBNYIUI4WyvM0s wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eadenaf5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 16:27:29 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21IFdV6v018234;
        Fri, 18 Feb 2022 16:27:28 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eadenaf58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 16:27:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21IGK1Vg021864;
        Fri, 18 Feb 2022 16:27:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3e645kkbsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 16:27:25 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21IGRJr728311944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 16:27:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09866A4065;
        Fri, 18 Feb 2022 16:27:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D682A4060;
        Fri, 18 Feb 2022 16:27:16 +0000 (GMT)
Received: from sig-9-65-84-246.ibm.com (unknown [9.65.84.246])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Feb 2022 16:27:16 +0000 (GMT)
Message-ID: <618c3daf00b4a8d33fc251343c87b42984f2a8ce.camel@linux.ibm.com>
Subject: Re: [PATCH v10 15/27] ima: Implement hierarchical processing of
 file accesses
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
Date:   Fri, 18 Feb 2022 11:27:16 -0500
In-Reply-To: <20220201203735.164593-16-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-16-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CmIjsNYYqKg88BNWcAOaDKs1TgjFLP01
X-Proofpoint-ORIG-GUID: MRzSxA1Sdgf4n_is3-vfxgiwaFNAbMiu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_06,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180104
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
> Implement hierarchical processing of file accesses in IMA namespaces by
> walking the list of user namespaces towards the root. This way file
> accesses can be audited in an IMA namespace and also be evaluated against
> the IMA policies of parent IMA namespaces.
> 
> Pass the user_namespace into process_measurement since we will be walking
> the hierarchy of user_namespaces towards the init_user_ns and we can easily
> derive the ima_namespace from the user_namespace.
> 
> __process_measurement() returns either 0 or -EACCES. For hierarchical
> processing remember the -EACCES returned by this function but continue
> to the parent user namespace. At the end either return 0 or -EACCES
> if an error occurred in one of the IMA namespaces.
> 
> Currently the ima_ns pointer of the user_namespace is always NULL except
> at the init_user_ns, so test ima_ns for NULL pointer and skip the call to
> __process_measurement() if it is NULL. Once IMA namespacing is fully
> enabled, the pointer may still be NULL due to late initialization of the
> IMA namespace.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---
> 
> v10:
>   - Fixed compilation issue
> 
> v9:
>   - Switch callers to pass user_namespace rather than ima_namespace with
>     potential NULL pointer
>   - Add default case to switch statement and warn if this happens
>   - Implement ima_ns_from_user_ns() in this patch now
> ---
>  security/integrity/ima/ima.h      |  8 ++++
>  security/integrity/ima/ima_main.c | 76 +++++++++++++++++++++++--------
>  2 files changed, 65 insertions(+), 19 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 0057b1fd6c18..aea8fb8d2854 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -493,4 +493,12 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
>  	return file_inode(filp)->i_sb->s_user_ns;
>  }
>  
> +static inline struct ima_namespace
> +*ima_ns_from_user_ns(struct user_namespace *user_ns)
> +{
> +	if (user_ns == &init_user_ns)
> +		return &init_ima_ns;
> +	return NULL;
> +}
> +
>  #endif /* __LINUX_IMA_H */
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index ae0e9b14554a..917504319e7f 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -196,10 +196,10 @@ void ima_file_free(struct file *file)
>  	ima_check_last_writer(iint, inode, file);
>  }
>  
> -static int process_measurement(struct ima_namespace *ns,
> -			       struct file *file, const struct cred *cred,
> -			       u32 secid, char *buf, loff_t size, int mask,
> -			       enum ima_hooks func)
> +static int __process_measurement(struct ima_namespace *ns,
> +				 struct file *file, const struct cred *cred,
> +				 u32 secid, char *buf, loff_t size, int mask,
> +				 enum ima_hooks func)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct integrity_iint_cache *iint = NULL;
> @@ -391,6 +391,41 @@ static int process_measurement(struct ima_namespace *ns,
>  	return 0;
>  }
>  
> +static int process_measurement(struct user_namespace *user_ns,
> +			       struct file *file, const struct cred *cred,
> +			       u32 secid, char *buf, loff_t size, int mask,
> +			       enum ima_hooks func)
> +{
> +	struct ima_namespace *ns;
> +	int ret = 0;
> +
> +	while (user_ns) {
> +		ns = ima_ns_from_user_ns(user_ns);
> +		if (ns) {
> +			int rc;
> +
> +			rc = __process_measurement(ns, file, cred, secid, buf,
> +						   size, mask, func);
> +			switch (rc) {
> +			case 0:
> +				break;
> +			case -EACCES:
> +				/* return this error at the end but continue */
> +				ret = -EACCES;
> +				break;
> +			default:
> +				/* should not happen */
> +				ret = -EACCES;
> +				WARN_ON_ONCE(true);
> +			}
> +		}
> +
> +		user_ns = user_ns->parent;
> +	};
> +
> +	return ret;
> +}
> +

Very nice and concise!

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

-- 
thanks,

Mimi 

