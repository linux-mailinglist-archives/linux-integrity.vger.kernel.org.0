Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B6969C94C
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Feb 2023 12:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjBTLJo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Feb 2023 06:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjBTLJl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Feb 2023 06:09:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CC01A95B;
        Mon, 20 Feb 2023 03:09:33 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KAVTda004941;
        Mon, 20 Feb 2023 11:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=iaff3ymAW5HS/2O66xYNAHjFL1PE3JHi2WMFx/EOoTU=;
 b=gGXn0ElsRvpMwlsc3zR4Nb+UQaretD+157EGIQ4UtgX8oR3+XPvJmaaLtfm1fkNCRBlP
 Y2HcHjhzlbisyNy9PNLv+0B8uMss+3b0mFBtj8VOrAxzwimmsAXoEV551kvchJKSxjQQ
 G9R8W9PdBIECBY3PwwgSu5zR/vjucaQYfaKjiqZOBAh+DC+yZA5C8dWB+IlGlBzEpRyp
 R7Q3No76DQP3YYzofJEp24qBC6fViy2wyc1+AupZ1oZ8smXIkjpErQH4J0ZTjCf/Bofg
 CghLsHWLmdWovYY3T/A15rALxH+14Jyne0Etw5ttORvmKKoq0mWHw28RHuT/DSeqG3cq /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv76erudn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 11:09:06 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31KB9587025556;
        Mon, 20 Feb 2023 11:09:05 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv76erud8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 11:09:05 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31KAgax0003567;
        Mon, 20 Feb 2023 11:09:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3ntpa77ykv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 11:09:04 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KB93XW10486482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 11:09:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBBF6581EB;
        Mon, 20 Feb 2023 11:09:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0EC1581E9;
        Mon, 20 Feb 2023 11:09:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.169.160])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 11:09:00 +0000 (GMT)
Message-ID: <1e93d7b299de3b6cf61b5a5c4be91eb47d864ac6.camel@linux.ibm.com>
Subject: Re: [PATCH v7 2/6] ocfs2: Switch to security_inode_init_security()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 20 Feb 2023 06:08:59 -0500
In-Reply-To: <95f9b1dfca0cbff1c6a447dde45c2f835bc1a254.camel@huaweicloud.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
         <20221201104125.919483-3-roberto.sassu@huaweicloud.com>
         <a20a6d84d8e682fbff546b80eda75a1918d7c108.camel@linux.ibm.com>
         <aaeee7490cfee1b2163a3c9c894294aaf13e100c.camel@linux.ibm.com>
         <95f9b1dfca0cbff1c6a447dde45c2f835bc1a254.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6lNVikMS0SAUfWIDOH1uiyXIQ30K7aaL
X-Proofpoint-ORIG-GUID: pMFEojQ7-w5xpbKMvakwCAsqTV1HCPTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> > > > diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> > > > index 95d0611c5fc7..55699c573541 100644

> > > > @@ -7277,13 +7289,23 @@ int ocfs2_init_security_get(struct inode *inode,
> > > >  			    const struct qstr *qstr,
> > > >  			    struct ocfs2_security_xattr_info *si)
> > > >  {
> > > > +	int ret;
> > > > +
> > > >  	/* check whether ocfs2 support feature xattr */
> > > >  	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
> > > >  		return -EOPNOTSUPP;
> > > > -	if (si)
> > > > -		return security_old_inode_init_security(inode, dir, qstr,
> > > > -							&si->name, &si->value,
> > > > -							&si->value_len);
> > > > +	if (si) {
> > > > +		ret = security_inode_init_security(inode, dir, qstr,
> > > > +						   &ocfs2_initxattrs, si);
> > > 
> > > The "if (unlikely(IS_PRIVATE(inode))"  test exists in both
> > > security_old_inode_init_security() and security_inode_init_security(),
> > > but return different values.  In the former case, it returns
> > > -EOPNOTSUPP.  In the latter case, it returns 0.  The question is
> > > whether or not we need to be concerned about private inodes on ocfs2.  
> > > If private inodes on ocfs2 are possible, then ocsf2_mknod() or
> > > ocfs2_symlink() would fail to create the inode or symlink.
> > 
> > Correction, previously when returning -EOPNOTSUPP for private inodes,
> > xattrs would not be wrriten.  By returning 0 without setting si->enable 
> > to 0, xattrs will be written.
> 
> Ok, but if there is a private inode, we would be setting si->enable to
> zero. Should be ok, I guess.

si->enable is being set to zero, below, but is conditional on !si-
>name.

This is the last concern, otherwise the patch set looks good.

> > > > +		/*
> > > > +		 * security_inode_init_security() does not return -EOPNOTSUPP,
> > > > +		 * we have to check the xattr ourselves.
> > > > +		 */
> > > > +		if (!ret && !si->name)
> > > > +			si->enable = 0;
> > > > +
> > > > +		return ret;
> > > > +	}
> > > >  
> > > >  	return security_inode_init_security(inode, dir, qstr,
> > > >  					    &ocfs2_initxattrs, NULL);
> 
-- 
thanks,

Mimi

