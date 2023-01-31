Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B01C682B8A
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 12:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjAaLdO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 06:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjAaLdM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 06:33:12 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B594AA7F;
        Tue, 31 Jan 2023 03:32:28 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VARSXR031547;
        Tue, 31 Jan 2023 11:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=QDH1LT0pPC43JQfZiLTfm89mEd2bhyJeJF13YAeb7qk=;
 b=MMxnz7oBOiJTG6usma+/4pO0r6W+YhG547qXCNfjA8UhvnJtiyzvYqF5n6FJ1+7styDT
 zGPwMUryFlhHT6mSPEkVWn6WKcaQ4gSplbA52YxfDxc0FBWND8i9Ofcd5hykrDE74nAT
 uukVmj99qe96oYMq4HNuYF5gRXvLOT9gtbtvXI0pcZ0lCCdJ1eaf9hL936U6IiRajiYl
 5eRK4phya5BO2TaLijbm18JqJNFGeuvAK8LIb5JNBQNMtC/oBTKmuMBx0oassYFIwK0F
 z7uk2HFZ1tp85bgVzqaYc5sy+JJVpP9mQJfceP6hsz1thPbMS3o4NBVMRh5M9MQzBQUS Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf18k9h2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 11:32:09 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VAuU25001653;
        Tue, 31 Jan 2023 11:32:05 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf18k9h13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 11:32:05 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VA7aQ7008390;
        Tue, 31 Jan 2023 11:31:58 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ncvw2kpf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 11:31:58 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VBVvPG28377788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 11:31:57 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 765D058043;
        Tue, 31 Jan 2023 11:31:57 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F99058053;
        Tue, 31 Jan 2023 11:31:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.114.140])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 11:31:56 +0000 (GMT)
Message-ID: <1c7d861a143106e56cfe382d1ab6c293fa43aff1.camel@linux.ibm.com>
Subject: Re: [PATCH -next] evm: Use __vfs_setxattr() to update security.evm
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 31 Jan 2023 06:31:55 -0500
In-Reply-To: <f90bd732-a3a0-80b5-07ce-386500b12968@huawei.com>
References: <20221228030248.94285-1-xiujianfeng@huawei.com>
         <3c34c1e8c74722110e5d7e87146b090791734916.camel@linux.ibm.com>
         <f90bd732-a3a0-80b5-07ce-386500b12968@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k1J4jdshPFAghjaFNQUhFJk--GXo2MFR
X-Proofpoint-ORIG-GUID: e4R8ym3jzWQSeWxpdSHIOD22Jn58m8re
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_05,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-01-30 at 09:53 +0800, Guozihua (Scott) wrote:
> On 2023/1/19 5:45, Mimi Zohar wrote:
> > On Wed, 2022-12-28 at 11:02 +0800, Xiu Jianfeng wrote:
> >> Currently it uses __vfs_setxattr_noperm() to update "security.evm",
> >> however there are two lsm hooks(inode_post_setxattr and inode_setsecurity)
> >> being called inside this function, which don't make any sense for xattr
> >> "security.evm", because the handlers of these two hooks, such as selinux
> >> and smack, only care about their own xattr.
> > 
> > Updating the security.ima hash triggers re-calculating and writing the
> > security.evm HMAC.  Refer to evm_inode_post_setxattr().
> 
> Hi Mimi,
> 
> I believe what Jianfeng is trying to do is to avoid re-triggering
> security_inode_post_setxattr if we are updating security.evm. I can't
> think of any other xattr that could "absorb" security.evm.

I understand.  Comments below ...
> > 
> >>
> >> On the other hand, there is a literally rather than actually cyclical
> >> callchain as follows:
> >> security_inode_post_setxattr
> >>   ->evm_inode_post_setxattr
> >>     ->evm_update_evmxattr
> >>       ->__vfs_setxattr_noperm
> >>         ->security_inode_post_setxattr
> >>
> >> So use __vfs_setxattr() to update "security.evm".
> >>
> >> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> >> ---
> >>  security/integrity/evm/evm_crypto.c   | 7 +++----
> >>  security/integrity/ima/ima_appraise.c | 8 ++++----
> >>  2 files changed, 7 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> >> index fa5ff13fa8c9..d8275dfa49ef 100644
> >> --- a/security/integrity/evm/evm_crypto.c
> >> +++ b/security/integrity/evm/evm_crypto.c
> >> @@ -376,10 +376,9 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
> >>  			   xattr_value_len, &data);
> >>  	if (rc == 0) {
> >>  		data.hdr.xattr.sha1.type = EVM_XATTR_HMAC;
> >> -		rc = __vfs_setxattr_noperm(&init_user_ns, dentry,
> >> -					   XATTR_NAME_EVM,
> >> -					   &data.hdr.xattr.data[1],
> >> -					   SHA1_DIGEST_SIZE + 1, 0);
> >> +		rc = __vfs_setxattr(&init_user_ns, dentry, d_inode(dentry),
> >> +				    XATTR_NAME_EVM, &data.hdr.xattr.data[1],
> >> +				    SHA1_DIGEST_SIZE + 1, 0);

Although __vfs_setxattr_noperm() doesn't do any permission checking, it
does other things - make sure the filesystem supports writing xattrs,
calls fsnotify_xattr().

> >>  	} else if (rc == -ENODATA && (inode->i_opflags & IOP_XATTR)) {
> >>  		rc = __vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_EVM);
> >>  	}
> >> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> >> index ee6f7e237f2e..d2de9dc6c345 100644
> >> --- a/security/integrity/ima/ima_appraise.c
> >> +++ b/security/integrity/ima/ima_appraise.c
> >> @@ -98,10 +98,10 @@ static int ima_fix_xattr(struct dentry *dentry,
> >>  		iint->ima_hash->xattr.ng.type = IMA_XATTR_DIGEST_NG;
> >>  		iint->ima_hash->xattr.ng.algo = algo;
> >>  	}
> >> -	rc = __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_IMA,
> >> -				   &iint->ima_hash->xattr.data[offset],
> >> -				   (sizeof(iint->ima_hash->xattr) - offset) +
> >> -				   iint->ima_hash->length, 0);
> >> +	rc = __vfs_setxattr(&init_user_ns, dentry, d_inode(dentry),
> >> +			    XATTR_NAME_IMA, &iint->ima_hash->xattr.data[offset],
> >> +			    (sizeof(iint->ima_hash->xattr) - offset) +
> >> +			    iint->ima_hash->length, 0);

To clarify, ima_fix_xattr() is either directly called when in "fix"
mode or from ima_update_xattr().  With this change, the recalculated
file hash would be written to security.ima, but security.evm would not
be updated.

> >>  	return rc;
> >>  }

-- 
thanks,

Mimi

