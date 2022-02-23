Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393B64C1843
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 17:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiBWQNF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 11:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242447AbiBWQMz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 11:12:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9961275608;
        Wed, 23 Feb 2022 08:12:27 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NFJ31c007698;
        Wed, 23 Feb 2022 16:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=tM6CYaafv6levPFQZwnS+tS3XywolFy28ZPi68FuYXQ=;
 b=bjse8YTEUfsjJVYwcKQYmlWCp+aSwWSDNE71bzqsCVTfx+ty8WhXdN9IGO9YI7JsRlDO
 ib1aY7G8j6NZmt0UMrEU28YWHQmTDB5/UcLETeAzhjcgtd+8q0bOpZQRd+u2qcq9uuWM
 7S1FYWY7ETjyyTpfT4cTBzoMGzMf+1aQ/97kvKgxFVr2Qo32UCToZMQVr2MrSONR8bKG
 jTLxLTFGd05xdesQFncAuyYd3sePWMuu0PIBpeN9yyE6Ztd4vy8wrezPFOINusaJVKQ6
 qQgF1CfaTU4PHk7J878EhCXT2umiiAK2qVw0O0wzcWPv9liA4WPUJBSOP3BiWr+aBSsL zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edqf3h99a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 16:12:11 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NG960a016764;
        Wed, 23 Feb 2022 16:12:11 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edqf3h98q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 16:12:11 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NG8aeu004810;
        Wed, 23 Feb 2022 16:12:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3eaqtjst78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 16:12:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NGC5f153412176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 16:12:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8656AE056;
        Wed, 23 Feb 2022 16:12:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68BB8AE051;
        Wed, 23 Feb 2022 16:12:03 +0000 (GMT)
Received: from sig-9-65-80-154.ibm.com (unknown [9.65.80.154])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 16:12:03 +0000 (GMT)
Message-ID: <d94928dcb87550b7d5cfe277eed8a195ad9c877c.camel@linux.ibm.com>
Subject: Re: [PATCH v10 18/27] integrity/ima: Define ns_status for storing
 namespaced iint data
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
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Date:   Wed, 23 Feb 2022 11:12:01 -0500
In-Reply-To: <20220201203735.164593-19-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-19-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zK4eRAEmR0O6iAS1Os9DjhSEXCSTitaD
X-Proofpoint-GUID: sjk5Ffb0PBuQMenBjcLb4EhkwPAcNysM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_07,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230091
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
> From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
> 
> Add an rbtree to the IMA namespace structure that stores a namespaced
> version of iint->flags in ns_status struct. Similar to the
> integrity_iint_cache, both the iint and ns_status are looked up using the
> inode pointer value. The lookup, allocate, and insertion code is also
> similar.
> 
> In subsequent patches we will have to find all ns_status entries an iint
> is being used in and reset flags there. To do this, connect a list of
> ns_status to the integrity_iint_cache and provide a reader-writer
> lock in the integrity_iint_cache to lock access to the list.
> 
> To simplify the code in the non-namespaces case embed an ns_status in
> the integrity_iint_cache and have it linked into the iint's ns_status list
> when calling ima_get_ns_status().
> 
> When getting an ns_status first try to find it in the RB tree. Here we can
> run into the situation that an ns_status found in the RB tree has a
> different iint associated with it for the same inode. In this case we need
> to delete the ns_status structure and get a new one.
> 
> There are two cases for freeing:
> - when the iint is freed (inode deletion): Walk the list of ns_status
>   entries and disconnect each ns_status from the list; take the
>   writer lock to protect access to the list; also, take the item off the
>   per-namespace rbtree
> 
> - when the ima_namepace is freed: While walking the rbtree, remove the
>   ns_status from the list while also holding the iint's writer lock;
>   to be able to grab the lock we have to have a pointer to the iint on
>   the ns_status structure.
> 
> To avoid an ns_status to be freed by the two cases concurrently, prevent
> these two cases to run concurrently. Therefore, groups of threads
> deleting either inodes or ima_namespaces are allowed to run concurrently
> but no two threads may run and one delete an inode and the other an
> ima_namespace.

The locking involved here is really complex.  I'm sure you thought
about it a lot, but isn't there a better alternative?

> 
> Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---
> v9:
>  - Move ns_status into integrity.h and embedded it into integrity_iint_cache
>    for the non-CONFIG_IMA_NS case

<snip>

>  
> +/*
> + * ima_free_ns_status_tree - free all items on the ns_status_tree and take each
> + *                           one off the list; yield to ns_list free'ers
> + *
> + * This function is called when an ima_namespace is freed. All entries in the
> + * rbtree will be taken off their list and collected in a garbage collection
> + * list and freed at the end. This allows to walk the rbtree again.
> + */
> +void ima_free_ns_status_tree(struct ima_namespace *ns)
> +{
> +	struct ns_status *ns_status, *next;
> +	struct llist_node *node;
> +	LLIST_HEAD(garbage);
> +	unsigned int ctr;
> +	bool restart;
> +
> +	do {
> +		ctr = 0;
> +		restart = false;
> +
> +		lock_group(GRP_NS_STATUS_TREE);
> +		write_lock(&ns->ns_tree_lock);
> +
> +		rbtree_postorder_for_each_entry_safe(ns_status, next,
> +						     &ns->ns_status_tree,
> +						     rb_node) {
> +			write_lock(&ns_status->iint->ns_list_lock);
> +			if (!list_empty(&ns_status->ns_next)) {
> +				list_del_init(&ns_status->ns_next);
> +				llist_add(&ns_status->gc_llist, &garbage);
> +				ctr++;
> +			}

At this point when the namespace is being deleted, no entries are being
added to the rbtree, so it is safe to remove the nodes here.  There's
no need to first create a list and then remove them.

> +			write_unlock(&ns_status->iint->ns_list_lock);
> +
> +			/*
> +			 * After some progress yield to any waiting ns_list
> +			 * free'ers.
> +			 */
> +			if (atomic_read(&ns_list_waiters) > 0 && ctr >= 5) {
> +				restart = true;
> +				break;
> +			}

Giving priority to removing entries in the iint cache is important, but
I wish there was a better alternative.

> +		}
> +
> +		write_unlock(&ns->ns_tree_lock);
> +		unlock_group(GRP_NS_STATUS_TREE);
> +	} while (restart);
> +
> +	node = llist_del_all(&garbage);
> +	llist_for_each_entry_safe(ns_status, next, node, gc_llist)
> +		ns_status_free(ns, ns_status);
> +
> +	kmem_cache_destroy(ns->ns_status_cache);
> +}

-- 
thanks,

Mimi

