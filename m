Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69694C21AF
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Feb 2022 03:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiBXCWz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 21:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiBXCWp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 21:22:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B7B158E8D;
        Wed, 23 Feb 2022 18:22:16 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21O1a7uH031271;
        Thu, 24 Feb 2022 02:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3q7zwLWE1ercutw/dmhj/aMugDL63cQ8LbipLiTwsM8=;
 b=eAcKNM64rZhN5UezSLT8mRHz4fHhSYnnXXpmO7RHLKMYG0O3KNvUG1sUN2GVU8rmusur
 OWAnBcvxyi6/PEnIRgrjPMFCAI19dDlFrFwaAK2s/PbWXRmchv5sgvwgUtPbaKUlugx5
 NTDJ/OO80SdoPgGc2gyYivix9x/8QbMlJdMyz3IdaohSXnpc5D8IqWPrdpaRzZLDLDhb
 8afUy7K9zG00sxaQgirq9FUlukRIMnSfQTKzoeV0DC1CFZjpKNwUaQFbr4wo87loOMdn
 boPeF8z0OX7Nt+xa3R3+yivBSThK0QU0J392fzm6LBKj7yM7DV22/+nrpHH7gMzKFL1g Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edh6x5pw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 02:21:52 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21O2Lq90019699;
        Thu, 24 Feb 2022 02:21:52 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edh6x5pvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 02:21:51 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21O2IO0B016888;
        Thu, 24 Feb 2022 02:21:50 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 3ed22e80bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 02:21:50 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21O2Lnqj37028292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 02:21:49 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A7D828058;
        Thu, 24 Feb 2022 02:21:49 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E03D2805A;
        Thu, 24 Feb 2022 02:21:49 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 24 Feb 2022 02:21:49 +0000 (GMT)
Message-ID: <92e1fc33-b97f-b99e-4f28-1d05a07c2f2f@linux.ibm.com>
Date:   Wed, 23 Feb 2022 21:21:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 18/27] integrity/ima: Define ns_status for storing
 namespaced iint data
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-19-stefanb@linux.ibm.com>
 <d94928dcb87550b7d5cfe277eed8a195ad9c877c.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <d94928dcb87550b7d5cfe277eed8a195ad9c877c.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: idqeVqzuPaODlYUNNT5ujVzF4RqQknfn
X-Proofpoint-ORIG-GUID: pRCdLtyorOodBbbA56P-QIEZNCxOKYHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_09,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202240008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/23/22 11:12, Mimi Zohar wrote:
> On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
>> From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
>>
>> Add an rbtree to the IMA namespace structure that stores a namespaced
>> version of iint->flags in ns_status struct. Similar to the
>> integrity_iint_cache, both the iint and ns_status are looked up using the
>> inode pointer value. The lookup, allocate, and insertion code is also
>> similar.
>>
>> In subsequent patches we will have to find all ns_status entries an iint
>> is being used in and reset flags there. To do this, connect a list of
>> ns_status to the integrity_iint_cache and provide a reader-writer
>> lock in the integrity_iint_cache to lock access to the list.
>>
>> To simplify the code in the non-namespaces case embed an ns_status in
>> the integrity_iint_cache and have it linked into the iint's ns_status list
>> when calling ima_get_ns_status().
>>
>> When getting an ns_status first try to find it in the RB tree. Here we can
>> run into the situation that an ns_status found in the RB tree has a
>> different iint associated with it for the same inode. In this case we need
>> to delete the ns_status structure and get a new one.
>>
>> There are two cases for freeing:
>> - when the iint is freed (inode deletion): Walk the list of ns_status
>>    entries and disconnect each ns_status from the list; take the
>>    writer lock to protect access to the list; also, take the item off the
>>    per-namespace rbtree
>>
>> - when the ima_namepace is freed: While walking the rbtree, remove the
>>    ns_status from the list while also holding the iint's writer lock;
>>    to be able to grab the lock we have to have a pointer to the iint on
>>    the ns_status structure.
>>
>> To avoid an ns_status to be freed by the two cases concurrently, prevent
>> these two cases to run concurrently. Therefore, groups of threads
>> deleting either inodes or ima_namespaces are allowed to run concurrently
>> but no two threads may run and one delete an inode and the other an
>> ima_namespace.
> The locking involved here is really complex.  I'm sure you thought
> about it a lot, but isn't there a better alternative?

I am afraid this is a difficult question and a short and concise answer 
is not possible...

The complexity of the locking is driven by concurrency and the data 
structures that are involved. The data structures (existing global iint 
rbtree, ns_status structure, and per namespace rbtree for ns_status) and 
how they are organized and connected (via linked lists) are a 
consequence of the fact that we need to be able to handle files shared 
between IMA namespaces (and the host) so that re-auditing, re-measuring 
and re-appraisal of files after file modifications or modifications of 
the security.ima xattr (by any namespaces) can be done efficiently. 
Furthermore, it helps to efficiently remove all the status information 
that an IMA namespace has kept for files it audited/measured/appraised. 
The goal was to make this as scalable as possible by having each 
namespace get out of the way of other namespaces by preventing them from 
locking each other out too much. The single biggest problem are files 
shared between IMA namespaces.

The best argument for the design I can come up with is the 'Big O 
notation' describing the time complexity of operations.


The existing global iint rbtree maintains IMA status information for 
each inode. Lookup and insertion of data into the gloab iint rbtree  is 
O(log(n)), thus optimal.

To accommodate re-auditing/re-measurement/re-appraisal, which is driven 
by resetting status flags, I connected a list of ns_status structures, 
in which each namespace maintains its status information for each inode, 
to the iint maintained in that global rbtree. The resetting of status 
flags is fast because traversing the list after a lookup in the tree is 
O(n). Lookup + resetting the flags therefore is O(log(n) + n). If the 
list didn't exist we would have to search all IMA namespaces for the 
inode to be able to reset the flags, resulting in O(n * log(n)) time 
complexity, which is of course much worse. So, the list of ns_status 
linked to an iint has a good reason: better time complexity to traverse 
the list and reset status flags. Beside  that it also supports fast 
handling of deletion of files where the iint has to be delete from the 
global rbtree and the ns_status list it holds must also be deleted (each 
ns_status also needs to be delete from a per IMA-namespace rbtree then)


There's also a per-IMA namespace rbtree for each inode that serves two 
purposes:

a) Fast lookup of ns_status (O(log(n)) for an IMA namespace; at least to 
insert an ns_status into this tree we need not write-lock the iint tree 
but the initial iint creation required the write-locking of the iint tree

b) Maintaining a collection of inodes that the namespace has 
audited/measured/appraised for efficient deletion upon IMA namespace 
teardown: We can traverse this tree in O(n) time and determine which 
iints have no more namespace users and delete them from the iint tree.


Now the dilemma with this is that an ns_status structure is connected to 
a list hanging off the iint and on top of this it is part of an rbtree. 
And this is where the 'group locking' is coming from. What we need to 
prevent is that an ns_status is deleted from its iint list (when a file 
is deleted) while it is also deleted from the per-IMA namespace rbtree 
(when the namespace is deleted). Both must not be done concurrently. 
What is possible is that a group of threads may tear down namespaces and 
the other group may act on file deletion, but threads from both groups 
must not run concurrently.


Now we can at least look at two alternatives for the per-IMA namespace 
rbtree.

1) One alternative is to use a list instead of an rbtree. We would loose 
the fast lookup via the per IMA namespace tree and get O(n) lookup times 
but quick insertion into the list [O(1)]. We still would have the 
collection of inodes. And we would still have the dilemma that an 
ns_status would be connected to two lists, thus requiring the group 
locking. I don't think using a list instead of an rbtree is a solution.

2) We could try to get rid of the per-IMA namespace rbtree altogether 
and just use the global iint rbtree that exists today with a list of 
ns_status connected to its iints. If we do this we would loose the 
knowledge of which inodes a namespace has an ns_status structure for. 
The only way we would find this is by traversing the global iint tree 
(O(n)) and follow each iint list (O(m)) to see whether we find an 
ns_status holding information about the iint. The time complexity for 
this would be O(n*m) but much less than O(n^2). A downside would also be 
that we would have to keep a lock on the global iint rbtree while 
traversing it, thus locking out those that want to add inodes to the 
tree. On the upside it would allow us to get rid of the group locking. 
Lookup of an ns_status in the global iint tree would be O(n) + O(m) and 
insertion would be O(n) + O(1).


Certainly, the alternative is 2) with its own trade-offs. My guess is 
some sort of yielding could probably also be helpful there then to avoid 
blocking higher priority operations than deleting of a namespace.


>> +/*
>> + * ima_free_ns_status_tree - free all items on the ns_status_tree and take each
>> + *                           one off the list; yield to ns_list free'ers
>> + *
>> + * This function is called when an ima_namespace is freed. All entries in the
>> + * rbtree will be taken off their list and collected in a garbage collection
>> + * list and freed at the end. This allows to walk the rbtree again.
>> + */
>> +void ima_free_ns_status_tree(struct ima_namespace *ns)
>> +{
>> +	struct ns_status *ns_status, *next;
>> +	struct llist_node *node;
>> +	LLIST_HEAD(garbage);
>> +	unsigned int ctr;
>> +	bool restart;
>> +
>> +	do {
>> +		ctr = 0;
>> +		restart = false;
>> +
>> +		lock_group(GRP_NS_STATUS_TREE);
>> +		write_lock(&ns->ns_tree_lock);
>> +
>> +		rbtree_postorder_for_each_entry_safe(ns_status, next,
>> +						     &ns->ns_status_tree,
>> +						     rb_node) {
>> +			write_lock(&ns_status->iint->ns_list_lock);
>> +			if (!list_empty(&ns_status->ns_next)) {
>> +				list_del_init(&ns_status->ns_next);
>> +				llist_add(&ns_status->gc_llist, &garbage);
>> +				ctr++;
>> +			}
> At this point when the namespace is being deleted, no entries are being
> added to the rbtree, so it is safe to remove the nodes here.  There's
> no need to first create a list and then remove them.


We are traversing the per-namespace rbtree here and later on in this 
series (21/27) we try to determine which iints are now unused in the 
global iint tree and delete the iints there. Due to the locking that's 
necessary to remove the iint from the global rbtree all the ns_status 
are collected in this list here already now. True, in this patch here it 
is not necessary but in 21/27 it will be necessary to have them on this 
list. I had thought about merging the patches but its complex enough as-is.


    Stefan


>
>> +			write_unlock(&ns_status->iint->ns_list_lock);
>> +
>> +			/*
>> +			 * After some progress yield to any waiting ns_list
>> +			 * free'ers.
>> +			 */
>> +			if (atomic_read(&ns_list_waiters) > 0 && ctr >= 5) {
>> +				restart = true;
>> +				break;
>> +			}
> Giving priority to removing entries in the iint cache is important, but
> I wish there was a better alternative.
>
>> +		}
>> +
>> +		write_unlock(&ns->ns_tree_lock);
>> +		unlock_group(GRP_NS_STATUS_TREE);
>> +	} while (restart);
>> +
>> +	node = llist_del_all(&garbage);
>> +	llist_for_each_entry_safe(ns_status, next, node, gc_llist)
>> +		ns_status_free(ns, ns_status);
>> +
>> +	kmem_cache_destroy(ns->ns_status_cache);
>> +}
