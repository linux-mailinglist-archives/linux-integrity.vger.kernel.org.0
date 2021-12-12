Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2446471A95
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Dec 2021 15:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhLLONf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Dec 2021 09:13:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230031AbhLLONf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Dec 2021 09:13:35 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BCAvmWX023404;
        Sun, 12 Dec 2021 14:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=zz+7EQX/yR912zBj1Ap6jnqdFxMhKtRzZX2+xD3wEhY=;
 b=m3I8V/AFUdNwxFRMT004zKUJz4yW7eKGlGohDOAvtQqeBvJ8tQyTw4FGduJ1CYQHn9o2
 ShuASAWwY/zoHilJDmxe6cVmAKN786fdU9BpdoxQhJ5ZlAOAtqaN1akwjlLS7ZxXW6C2
 MSWDSKeCR7iZ6zJCifb15TyFTWOv1LhYXEjhtsr6ds1cJgGdpd8rGpTSJZXp9IjvTkn3
 wDmVw5uE03wAcSSAUZJQW5LoiXk6W6jqg9iM5BE9iUFfJ7srz37/g9ZI0C8hCSlwFMmr
 2n4IKAM0apwwy7kwDM6QOJplIIRJ7fj8yg2xJL4hq8d5+6Alp0smOxRZpob0/gIhTx/D zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cwfspa404-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Dec 2021 14:13:19 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BCDjt7M025071;
        Sun, 12 Dec 2021 14:13:19 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cwfspa3yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Dec 2021 14:13:19 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BCE8JT8011132;
        Sun, 12 Dec 2021 14:13:18 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 3cvkm9jsym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Dec 2021 14:13:18 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BCEDGHG29950428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Dec 2021 14:13:16 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 975DA78064;
        Sun, 12 Dec 2021 14:13:16 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ED167805F;
        Sun, 12 Dec 2021 14:13:14 +0000 (GMT)
Received: from [IPv6:2601:5c4:4300:c551::c447] (unknown [9.211.97.102])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 12 Dec 2021 14:13:13 +0000 (GMT)
Message-ID: <e72104c480c2c7f5c29f80b72d2a597a50ef9fae.camel@linux.ibm.com>
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Sun, 12 Dec 2021 09:13:12 -0500
In-Reply-To: <20211210114934.tacjnwryihrsx6ln@wittgenstein>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
         <20211208221818.1519628-16-stefanb@linux.ibm.com>
         <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
         <20211209143749.wk4agkynfqdzftbl@wittgenstein>
         <fb99af21f029b8072435e35731b919f4ec98f89d.camel@linux.ibm.com>
         <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
         <20211210114934.tacjnwryihrsx6ln@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fAh9BOZMrTezWMxvjyrb9G_Fo9kdxXSc
X-Proofpoint-GUID: wSxZLv_S19gi7vRgusRJuGaG2TbTaHiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-12_05,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=832
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112120086
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-12-10 at 12:49 +0100, Christian Brauner wrote:
> On Thu, Dec 09, 2021 at 02:38:13PM -0500, James Bottomley wrote:
[...]
> > @@ -317,21 +315,15 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
> >  void securityfs_remove(struct dentry *dentry)
> >  {
> >  	struct user_namespace *ns = dentry->d_sb->s_user_ns;
> > -	struct inode *dir;
> >  
> >  	if (!dentry || IS_ERR(dentry))
> >  		return;
> >  
> > -	dir = d_inode(dentry->d_parent);
> > -	inode_lock(dir);
> >  	if (simple_positive(dentry)) {
> > -		if (d_is_dir(dentry))
> > -			simple_rmdir(dir, dentry);
> > -		else
> > -			simple_unlink(dir, dentry);
> > +		d_delete(dentry);
> 
> Not, that doesn't work. You can't just call d_delete() and dput() and
> even if I wouldn't advise it. And you also can't do this without
> taking the inode lock on the directory.

Agreed on that

> simple_rmdir()/simple_unlink() take care to update various inode
> fields in the parent dir and handle link counts. This really wants to
> be sm like
> 
> 	struct inode *parent_inode;
> 
> 	parent_inode = d_inode(dentry->d_parent);
> 	inode_lock(parent_inode);
> 	if (simple_positive(dentry)) {
> 		dget(dentry);
> 		if (d_is_dir(dentry)
> 			simple_unlink(parent_inode, dentry);
> 		else
> 			simple_unlink(parent_inode, dentry);
> 		d_delete(dentry);
> 		dput(dentry);
> 	}
> 	inode_unlock(parent_inode);

It just slightly annoys me how the simple_ functions change fields in
an inode that is about to be evicted ... it seems redundant; plus we
shouldn't care if the object we're deleting is a directory or file.  I
also don't think we need the additional dget because the only consumer
is policy file removal and the opener of that file will have done a
dget.  The inode lock now prevents us racing with another remove in the
case of two simultaneous writes.

How about

        struct inode *parent_inode;

        parent_inode = d_inode(dentry->d_parent);
        inode_lock(parent_inode);
        if (simple_positive(dentry)) {
		drop_nlink(parent_inode);
                d_delete(dentry);
                dput(dentry);
        }
        inode_unlock(parent_inode);

James


