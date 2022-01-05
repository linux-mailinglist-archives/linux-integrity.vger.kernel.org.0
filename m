Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D444855BC
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jan 2022 16:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbiAEPV5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jan 2022 10:21:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241379AbiAEPV4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jan 2022 10:21:56 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205FCUei028696;
        Wed, 5 Jan 2022 15:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IL2jSP9Vg3TpO3ICs4O5w7nfz0/LY4RrW+pXipkAW6k=;
 b=Pv1zF576AyppYfoXZKSa+28m3bP25uRMud9Q5fgL1u3Tv9OjPReYMh0q96krXTV8AQk1
 BJHNFuGi2hFffgUnT1LFdM2bVX3S4wSS9X16Bna58Fkwq7/6zWooCnATmqEwG+NB/eEh
 mPnLJejGOuMecEu99GefZ7aVb7E+VoBaGEsSFa/Qi9zmfWdNQw8SKBRAfO6epiuho9Fr
 JX3QXMgCvW4qJRaQDvq9qYon4rqWC7AZd599b+GevNeu9PS/HVMdkqJ+1ylYk7d+TRDp
 CXQNTgJ5Jg3JmO9Rf7lAZoLn42CRPzB5TC6YFJBIwT16gzDUgTOEp/4Yuec8TEUjMzgq ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dckxt4b9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 15:21:42 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 205FLg4E005222;
        Wed, 5 Jan 2022 15:21:42 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dckxt4b93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 15:21:41 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 205FHoRp016459;
        Wed, 5 Jan 2022 15:21:40 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 3daekb0brt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 15:21:40 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 205FLdja30015872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jan 2022 15:21:39 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 692E7AC059;
        Wed,  5 Jan 2022 15:21:39 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ED7EAC068;
        Wed,  5 Jan 2022 15:21:39 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jan 2022 15:21:39 +0000 (GMT)
Message-ID: <be083959-b1ef-9de7-0ea6-71ab36596523@linux.ibm.com>
Date:   Wed, 5 Jan 2022 10:21:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8 16/19] ima: Enable re-auditing of modified files
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-17-stefanb@linux.vnet.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220104170416.1923685-17-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F_Gdp9N4kKwEw1OpLBvo5xXZSEq7xmxR
X-Proofpoint-ORIG-GUID: jlDsoTM9MXXwXsJFKLLPsK585uGTjnzQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_03,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/4/22 12:04, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Walk the list of ns_status associated with an iint if the file has
> changed and reset the IMA_AUDITED flag, which is part of the
> IMA_DONE_MASK. This causes a new audit message to be emitted when the
> file is again accessed on either the host or in an IMA namespace.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   security/integrity/ima/ima_main.c | 33 ++++++++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 99dc984b49c9..bc3ab08f39c6 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -153,6 +153,35 @@ static void ima_rdwr_violation_check(struct ima_namespace *ns,
>   				  "invalid_pcr", "open_writers");
>   }
>   
> +#ifdef CONFIG_IMA_NS
> +
> +static void mask_iint_ns_status_flags(struct integrity_iint_cache *iint,
> +				      unsigned long mask)
> +{
> +	struct ns_status *status;
> +	unsigned long flags;
> +
> +	read_lock(&iint->ns_list_lock);
> +	list_for_each_entry(status, &iint->ns_list, ns_next) {
> +		flags = iint_flags(iint, status) & mask;
> +		set_iint_flags(iint, status, flags);
> +	}
> +	read_unlock(&iint->ns_list_lock);
> +}
> +
> +#else
> +
> +static void mask_iint_ns_status_flags(struct integrity_iint_cache *iint,
> +				      unsigned long mask)
> +{
> +	unsigned long flags;
> +
> +	flags = iint_flags(iint, NULL) & mask;
> +	set_iint_flags(iint, NULL, flags);
> +}
> +
> +#endif
> +

The above two cases are due to this here:

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..201a9d46d6e1 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -138,6 +138,10 @@ struct integrity_iint_cache {
  	enum integrity_status ima_creds_status:4;
  	enum integrity_status evm_status:4;
  	struct ima_digest_data *ima_hash;
+#ifdef CONFIG_IMA_NS
+	rwlock_t ns_list_lock;
+	struct list_head ns_list;
+#endif
  };

Ideally namespaced and non-namespaced code cases would share the code and to be able to share it the above #ifdef CONFIG_IMA_NS  in integrity.hshouldn't be there but we would have the lock and list in IMA namespacing and non-namespacing case. The above two code cases shown above are just the beginning and as more variables are moved from the iint into the ns_status these types of 'two cases of code' would show up in more places. So I think we should prevent this already now.

To be able to share the code we need an ns_status on a list in the non-namespacing case as well. In the non-namespacing case it would always be a single ns_status on the list. What is worth a decision is how to get the ns_status on the list. One idea would be to conditionally embed it into the integrity_iint_cache like this:

/* integrity data associated with an inode */
struct integrity_iint_cache {
         struct rb_node rb_node; /* rooted in integrity_iint_tree */
         struct mutex mutex;     /* protects: version, flags, digest */
         struct inode *inode;    /* back pointer to inode in question */
         u64 version;            /* track inode changes */
         unsigned long flags;
         unsigned long atomic_flags;
         enum integrity_status ima_file_status:4;
         enum integrity_status ima_mmap_status:4;
         enum integrity_status ima_bprm_status:4;
         enum integrity_status ima_read_status:4;
         enum integrity_status ima_creds_status:4;
         enum integrity_status evm_status:4;
         struct ima_digest_data *ima_hash;
         rwlock_t ns_list_lock;
         struct list_head ns_list;
#ifndef CONFIG_IMA_NS
	struct ns_status status;
#endif
};

This would prevent a 2nd cache just for allocation of ns_status in the 
non-namespacing case and getting the  embedded ns_status onto the list 
would also be like this:

     INIT_LIST_HEAD(&iint->ns_list);

#ifndef CONFIG_IMA_NS

     INIT_LIST_HEAD(&iint->status.ns_next);

     list_add_tail(&iint->status.ns_next, &iint->ns_list);

#endif

The other option is to allocated the ns_status via a minimal 
implementation of ima_ns_status.c for the non-namespaced case using 
kmalloc's from a cache for ns_status structures.


Also, the new 'rwlock_t ns_list_lock' in the iint would really only be 
necessary for locking in the namespacing case. However, to be able to 
share the code we would need to keep this lock around for the 
non-namespacing case as well so that we can call read_lock() in both 
cases. An option would be to introduce a macro for the locking that is a 
no-op in the non-namespacing case and does the actual locking in the 
namespacing case. I am not sure what would be better. I would prefer to 
explicitly see the read_lock()...



>   static void ima_check_last_writer(struct integrity_iint_cache *iint,
>   				  struct inode *inode, struct file *file)
>   {
> @@ -169,8 +198,10 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
>   		if (!IS_I_VERSION(inode) ||
>   		    !inode_eq_iversion(inode, iint->version) ||
>   		    (iint->flags & IMA_NEW_FILE)) {
> -			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
> +			mask_iint_ns_status_flags(iint,
> +					~(IMA_DONE_MASK | IMA_NEW_FILE));
>   			iint->measured_pcrs = 0;
> +
>   			if (update)
>   				ima_update_xattr(iint, file);
>   		}
