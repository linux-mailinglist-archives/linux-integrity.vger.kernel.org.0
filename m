Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F5269CB2D
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Feb 2023 13:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjBTMlP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Feb 2023 07:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjBTMlO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Feb 2023 07:41:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD9F1631E;
        Mon, 20 Feb 2023 04:41:14 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KCUJIt009153;
        Mon, 20 Feb 2023 12:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=qxjSHyo5E64imuTsFy/ezo2VUmPD8jzVtZLiGDzw3yU=;
 b=AhZvWQA7BhS2bXr5Noa+8wFfd+PZVUIwU3PcO9q3YEHMQCxvCE6TkWbwxpVUZyhECAuc
 Ai41HXKXvvKRx3UZaFqRI0I9RVPhetl4/v1/i/x5f5SU119jiKDuDiVWGHS6QyIdbXXf
 Jw24Z3AjAGvo1/WJ8beIPZQhQo1nWcGxx2ioSdKqQvaVpAbCdVBaN9a07JcMqguCNoHp
 m1FRjLhnp+eOmOPFj13ext6oqonMGxJ7vtZe4Q94NUadZ8ls8F5M/lv5lqGKvYwqt9Su
 tXMqI2ZaqTZlnjoc0xxlg5eiMlVD0EhRo0DZKZcsqtil2tS4K+TGekK7IWYE+MPic6CU Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv1patqrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 12:40:42 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31KCUdvi013066;
        Mon, 20 Feb 2023 12:40:41 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv1patqqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 12:40:41 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31K9J4fO024854;
        Mon, 20 Feb 2023 12:40:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa6n688-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 12:40:40 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KCecRp55771644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 12:40:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAAFA5805D;
        Mon, 20 Feb 2023 12:40:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 965D85805A;
        Mon, 20 Feb 2023 12:40:36 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.169.160])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 12:40:36 +0000 (GMT)
Message-ID: <0e648efe4bc8028652a5d95ee4c3404bd4a91018.camel@linux.ibm.com>
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
Date:   Mon, 20 Feb 2023 07:40:36 -0500
In-Reply-To: <70d079a7e8b2fa08683b68742a22ba2918765dfc.camel@huaweicloud.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
         <20221201104125.919483-3-roberto.sassu@huaweicloud.com>
         <a20a6d84d8e682fbff546b80eda75a1918d7c108.camel@linux.ibm.com>
         <aaeee7490cfee1b2163a3c9c894294aaf13e100c.camel@linux.ibm.com>
         <95f9b1dfca0cbff1c6a447dde45c2f835bc1a254.camel@huaweicloud.com>
         <1e93d7b299de3b6cf61b5a5c4be91eb47d864ac6.camel@linux.ibm.com>
         <70d079a7e8b2fa08683b68742a22ba2918765dfc.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: upoWJtDa5WJlKxqWqu5n1jVFjvGbxTXT
X-Proofpoint-GUID: TnuWL-ynqdAgEYVRFK7skzSojbcvedFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_10,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-02-20 at 13:20 +0100, Roberto Sassu wrote:
> On Mon, 2023-02-20 at 06:08 -0500, Mimi Zohar wrote:
> > > > > > diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> > > > > > index 95d0611c5fc7..55699c573541 100644
> > > > > > @@ -7277,13 +7289,23 @@ int ocfs2_init_security_get(struct inode *inode,
> > > > > >  			    const struct qstr *qstr,
> > > > > >  			    struct ocfs2_security_xattr_info *si)
> > > > > >  {
> > > > > > +	int ret;
> > > > > > +
> > > > > >  	/* check whether ocfs2 support feature xattr */
> > > > > >  	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
> > > > > >  		return -EOPNOTSUPP;
> > > > > > -	if (si)
> > > > > > -		return security_old_inode_init_security(inode, dir, qstr,
> > > > > > -							&si->name, &si->value,
> > > > > > -							&si->value_len);
> > > > > > +	if (si) {
> > > > > > +		ret = security_inode_init_security(inode, dir, qstr,
> > > > > > +						   &ocfs2_initxattrs, si);
> > > > > 
> > > > > The "if (unlikely(IS_PRIVATE(inode))"  test exists in both
> > > > > security_old_inode_init_security() and security_inode_init_security(),
> > > > > but return different values.  In the former case, it returns
> > > > > -EOPNOTSUPP.  In the latter case, it returns 0.  The question is
> > > > > whether or not we need to be concerned about private inodes on ocfs2.  
> > > > > If private inodes on ocfs2 are possible, then ocsf2_mknod() or
> > > > > ocfs2_symlink() would fail to create the inode or symlink.
> > > > 
> > > > Correction, previously when returning -EOPNOTSUPP for private inodes,
> > > > xattrs would not be wrriten.  By returning 0 without setting si->enable 
> > > > to 0, xattrs will be written.
> > > 
> > > Ok, but if there is a private inode, we would be setting si->enable to
> > > zero. Should be ok, I guess.
> > 
> > si->enable is being set to zero, below, but is conditional on !si-
> > > name.
> > 
> > This is the last concern, otherwise the patch set looks good.
> 
> Uhm, if the inode is private, security_inode_init_security() will
> immediately return. So, the condition !si->name should be always true.

Ok, thanks for checking.

> 
> > > > > > +		/*
> > > > > > +		 * security_inode_init_security() does not return -EOPNOTSUPP,
> > > > > > +		 * we have to check the xattr ourselves.
> > > > > > +		 */
> > > > > > +		if (!ret && !si->name)
> > > > > > +			si->enable = 0;
> > > > > > +
> > > > > > +		return ret;
> > > > > > +	}
> > > > > >  
> > > > > >  	return security_inode_init_security(inode, dir, qstr,
> > > > > >  					    &ocfs2_initxattrs, NULL);
> 


