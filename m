Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09BC4C14CE
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 14:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiBWNzo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 08:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiBWNzn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 08:55:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12211B0A6E;
        Wed, 23 Feb 2022 05:55:15 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NCIjuM022970;
        Wed, 23 Feb 2022 13:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/0ph7D9yuIiQ3EQYTSolEoufpWrl82Nyycdl4KJnS20=;
 b=o4RU6E4RSjwibtiWxHmWvy3qRdqenFcyaFiUDkCQbJfV+zwKeJsc2sMN8EbqESyUntdw
 j3uXw4VIFcJzDNBjvPiW3WgR+/ZONegVMCMs915Ib0gL5AaFLyZeh3WotaOYPEsxj9JM
 4/KYAMQZe4tmAsVamy3cqC5GEry73L46Kj3ZCN1Lxim+6bVwLLwJm0W09gw9h+hHvo4y
 EOfUHoELniSBgCMDgHHJxeKiZNiT2WWOUwo6jLpA4dG2m+sYetugCvNFoowMf9CJrms8
 Auy+AbrBoHIHTauhFUoyHG4KKN/86KfNFnmTr9XgdUd1j+MZ1ObgWJE93Y53wpWlaZ8p kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edmtet06c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 13:54:43 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NDrvT0017020;
        Wed, 23 Feb 2022 13:54:43 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edmtet05x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 13:54:43 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NDmXTA008381;
        Wed, 23 Feb 2022 13:54:41 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3ear698ttr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 13:54:41 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NDsclj52429156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 13:54:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2031CAE04D;
        Wed, 23 Feb 2022 13:54:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8175AE055;
        Wed, 23 Feb 2022 13:54:35 +0000 (GMT)
Received: from sig-9-65-80-154.ibm.com (unknown [9.65.80.154])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 13:54:35 +0000 (GMT)
Message-ID: <9a720bf5928151a0cbc7994ee498a1c3ca779c56.camel@linux.ibm.com>
Subject: Re: [PATCH v10 24/27] ima: Introduce securityfs file to activate an
 IMA namespace
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
Date:   Wed, 23 Feb 2022 08:54:35 -0500
In-Reply-To: <20220201203735.164593-25-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-25-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gLVbcJsnTR4RZgWZdZDqeCMykakZCDa1
X-Proofpoint-ORIG-GUID: nxR5c6ouX-XuWzMUH-IpcpR9n8m9fY7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_06,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230077
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
> Introduce securityfs file 'active' that allows a user to activate an IMA
> namespace by writing a "1" (precisely a '1\0' or '1\n') to it. When
> reading from the file, it shows either '0' or '1'.

A patch description should start with the motivation for the change
being introduced.  The last paragraph mentions "why" it will be needed
in the future, but there are other reasons for explicitly requiring
activation.   Probably something along the lines of not every user
namespace requires an active IMA namespace.  Please include those
reasons here.

> 
> Also, introduce ns_is_active() to be used in those places where the
> ima_namespace pointer may either be NULL or where the active field may not
> have been set to '1', yet. An inactive IMA namespace should never be
> accessed since it has not been initialized, yet.
> 
> Set the init_ima_ns's active field to '1' since it is considered active
> right from the beginning.
> 
> The rationale for introducing a file to activate an IMA namespace is that
> subsequent support for IMA-measurement and IMA-appraisal will add
> configuration files for selecting for example the template that an IMA
> namespace is supposed to use for logging measurements, which will add
> an IMA namespace configuration stage (using securityfs files) before its
> activation.

This could be included at the beginning, as part of the motivation for
the patch, but it shouldn't be the only reason.

> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---
>  v10:
>  - use memdup_user_nul to copy input from user
>  - propagating error returned from ima_fs_add_ns_files()
> ---
>  security/integrity/ima/ima.h             |  7 +++
>  security/integrity/ima/ima_fs.c          | 71 ++++++++++++++++++++++++
>  security/integrity/ima/ima_init_ima_ns.c |  1 +
>  security/integrity/ima/ima_main.c        |  2 +-
>  4 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 1e3f9dda218d..05e2de7697da 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -123,6 +123,8 @@ struct ima_h_table {
>  };
>  
>  struct ima_namespace {
> +	atomic_t active;		/* whether namespace is active */
> +
>  	struct rb_root ns_status_tree;
>  	rwlock_t ns_tree_lock;
>  	struct kmem_cache *ns_status_cache;
> @@ -154,6 +156,11 @@ struct ima_namespace {
>  } __randomize_layout;
>  extern struct ima_namespace init_ima_ns;
>  
> +static inline bool ns_is_active(struct ima_namespace *ns)
> +{
> +	return (ns && atomic_read(&ns->active));
> +}
> +
>  extern const int read_idmap[];
>  
>  #ifdef CONFIG_HAVE_IMA_KEXEC
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 84cd02a9e19b..58d80884880f 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -451,6 +451,71 @@ static const struct file_operations ima_measure_policy_ops = {
>  	.llseek = generic_file_llseek,
>  };
>  
> +static ssize_t ima_show_active(struct file *filp,
> +			       char __user *buf,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct ima_namespace *ns = &init_ima_ns;
> +	char tmpbuf[2];
> +	ssize_t len;
> +
> +	len = scnprintf(tmpbuf, sizeof(tmpbuf),
> +			"%d\n", atomic_read(&ns->active));
> +	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
> +}
> +
> +static ssize_t ima_write_active(struct file *filp,
> +				const char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct ima_namespace *ns = &init_ima_ns;
> +	unsigned int active;
> +	char *kbuf;
> +	int err;
> +
> +	if (ns_is_active(ns))
> +		return -EBUSY;
> +
> +	/* accepting '1\n' and '1\0' and no partial writes */
> +	if (count >= 3 || *ppos != 0)
> +		return -EINVAL;
> +
> +	kbuf = memdup_user_nul(buf, count);
> +	if (IS_ERR(kbuf))
> +		return PTR_ERR(kbuf);
> +
> +	err = kstrtouint(kbuf, 10, &active);
> +	kfree(kbuf);
> +	if (err)
> +		return err;
> +
> +	if (active != 1)
> +		return -EINVAL;
> +
> +	atomic_set(&ns->active, 1);
> +
> +	return count;
> +}
> +
> +static const struct file_operations ima_active_ops = {
> +	.read = ima_show_active,
> +	.write = ima_write_active,
> +};
> +
> +static int ima_fs_add_ns_files(struct dentry *ima_dir)
> +{
> +	struct dentry *active;
> +
> +	active =
> +	    securityfs_create_file("active",
> +				   S_IRUSR | S_IWUSR | S_IRGRP, ima_dir, NULL,
> +				   &ima_active_ops);
> +	if (IS_ERR(active))
> +		return PTR_ERR(active);
> +
> +	return 0;
> +}
> +
>  int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>  {
>  	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
> @@ -531,6 +596,12 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>  		}
>  	}
>  
> +	if (ns != &init_ima_ns) {
> +		ret = ima_fs_add_ns_files(ima_dir);
> +		if (ret)
> +			goto out;
> +	}
> +

In all other cases, the securityfs files are directly created in
ima_fs_ns_init().   What is different about "active" that a new
function is defined?

thanks,

Mimi

>  	return 0;
>  out:
>  	securityfs_remove(ns->ima_policy);
> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> index d4ddfd1de60b..39ee0c2477a6 100644
> --- a/security/integrity/ima/ima_init_ima_ns.c
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -58,5 +58,6 @@ struct ima_namespace init_ima_ns = {
>  	.ima_lsm_policy_notifier = {
>  		.notifier_call = ima_lsm_policy_change,
>  	},
> +	.active = ATOMIC_INIT(1),
>  };
>  EXPORT_SYMBOL(init_ima_ns);
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 1dee8cb5afa2..9ca9223bbcf6 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -441,7 +441,7 @@ static int process_measurement(struct user_namespace *user_ns,
>  
>  	while (user_ns) {
>  		ns = ima_ns_from_user_ns(user_ns);
> -		if (ns) {
> +		if (ns_is_active(ns)) {
>  			int rc;
>  
>  			rc = __process_measurement(ns, file, cred, secid, buf,


