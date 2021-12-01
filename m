Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066A8465464
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 18:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352053AbhLASAi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 13:00:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237042AbhLASAY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 13:00:24 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Hbd34027473;
        Wed, 1 Dec 2021 17:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=RkEHMw1pKej6d7ydf2BctzJPQ0yScti/CYTjZ9XwGfM=;
 b=oOo5O0EBtFChCpLgGQZkhbTggg7YrXTd8iTlUJ5U0uNIRl48pQ0SzOtn02h8rz7vBxRH
 EEqqccY4sBGfATYNJBYXcaZPdgTSLQHJewe15oydHRyNQfwugINO8cTl6yFtxtV36lEz
 wNmLrvX4Lb1JLnqXXpeZnxJit/eSRsa3EV0qzhpW7UnI8onHtqRU8a0uAxdS9L6lTjn/
 H4qOM52Ltgeg9wQjjz06RxGg1XA0PEM8yMTPivfM/jwqShlvHDh9cHPuqEs3yjVXD0SM
 KNyHDpiV2AE4CLFVSt/o/1Nl6akvAxWA4F3vzvHQzSejs72giKIUN6NVEYC0IVkd5rqo Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpapgw4b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 17:56:35 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1HA3M9011106;
        Wed, 1 Dec 2021 17:56:35 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpapgw4aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 17:56:35 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Hqses016709;
        Wed, 1 Dec 2021 17:56:33 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 3cn5f0312n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 17:56:33 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1HuVPu9699934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 17:56:31 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99AD17805C;
        Wed,  1 Dec 2021 17:56:31 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31EA478064;
        Wed,  1 Dec 2021 17:56:29 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 17:56:28 +0000 (GMT)
Message-ID: <6599ac61289e3316bff53602a0bc5970133251aa.camel@linux.ibm.com>
Subject: Re: [RFC 20/20] ima: Setup securityfs_ns for IMA namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Wed, 01 Dec 2021 12:56:27 -0500
In-Reply-To: <20211130160654.1418231-21-stefanb@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
         <20211130160654.1418231-21-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iQJx7Y9ccJDUk7jNDu0YznNs7uhXMIhk
X-Proofpoint-ORIG-GUID: EuXuXc_EYI9NC8IJKA285PsL7SPlUDqS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010094
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-11-30 at 11:06 -0500, Stefan Berger wrote:
[...]
> +
> +/*
> + * Fix the ownership (uid/gid) of the dentry's that couldn't be set
> at the
> + * time of their creation because the user namespace wasn't
> configured, yet.
> + */
> +static void ima_fs_ns_fixup_uid_gid(struct ima_namespace *ns)
> +{
> +	struct inode *inode;
> +	size_t i;
> +
> +	if (ns->file_ownership_fixes_done ||
> +	    ns->user_ns->uid_map.nr_extents == 0)
> +		return;
> +
> +	ns->file_ownership_fixes_done = true;
> +	for (i = 0; i < IMAFS_DENTRY_LAST; i++) {
> +		if (!ns->dentry[i])
> +			continue;
> +		inode = ns->dentry[i]->d_inode;
> +		inode->i_uid = make_kuid(ns->user_ns, 0);
> +		inode->i_gid = make_kgid(ns->user_ns, 0);
> +	}
> +}
> +
> +/* Fix the permissions when a file is opened */
> +int ima_fs_ns_permission(struct user_namespace *mnt_userns, struct
> inode *inode,
> +			 int mask)
> +{
> +	ima_fs_ns_fixup_uid_gid(get_current_ns());
> +	return generic_permission(mnt_userns, inode, mask);
> +}
> +
> +const struct inode_operations ima_fs_ns_inode_operations = {
> +	.lookup		= simple_lookup,
> +	.permission	= ima_fs_ns_permission,
> +};
> +

In theory this uid/gid shifting should have already been done for you
and all of the above code should be unnecessary.  What is supposed to
happen is that the mount of securityfs_ns in the new user namespace
should pick up a superblock s_user_ns for that new user namespace.  Now
inode_alloc() uses i_uid_write(inode, 0) which maps back through the
s_user_ns to obtain the owner of the user namespace.

What can happen is that if you do the inode allocation before (or even
without) writing to the uid_map file, it maps back through an empty map
and ends up with -1 for i_uid ... is this what you're seeing?

James


