Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D8269CABC
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Feb 2023 13:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjBTMVy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Feb 2023 07:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjBTMVw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Feb 2023 07:21:52 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C81A968;
        Mon, 20 Feb 2023 04:21:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PL1XW0wGwz9xtml;
        Mon, 20 Feb 2023 20:13:15 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHCgavZfNjaQo6AQ--.54254S2;
        Mon, 20 Feb 2023 13:21:15 +0100 (CET)
Message-ID: <70d079a7e8b2fa08683b68742a22ba2918765dfc.camel@huaweicloud.com>
Subject: Re: [PATCH v7 2/6] ocfs2: Switch to security_inode_init_security()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, mark@fasheh.com,
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
Date:   Mon, 20 Feb 2023 13:20:56 +0100
In-Reply-To: <1e93d7b299de3b6cf61b5a5c4be91eb47d864ac6.camel@linux.ibm.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
         <20221201104125.919483-3-roberto.sassu@huaweicloud.com>
         <a20a6d84d8e682fbff546b80eda75a1918d7c108.camel@linux.ibm.com>
         <aaeee7490cfee1b2163a3c9c894294aaf13e100c.camel@linux.ibm.com>
         <95f9b1dfca0cbff1c6a447dde45c2f835bc1a254.camel@huaweicloud.com>
         <1e93d7b299de3b6cf61b5a5c4be91eb47d864ac6.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCHCgavZfNjaQo6AQ--.54254S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1ruw1rZryrAr4DAr43ZFb_yoW8tr43pF
        W8tFyUKr15tFy5Cry0qa1Y9ws29FWfGrsrXwsxJr1DAF1qyrn7tr1Fyr1Uu3WrJr98JF10
        qr4UAF43uwn8ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj4maCAAAsh
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-02-20 at 06:08 -0500, Mimi Zohar wrote:
> > > > > diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> > > > > index 95d0611c5fc7..55699c573541 100644
> > > > > @@ -7277,13 +7289,23 @@ int ocfs2_init_security_get(struct inode *inode,
> > > > >  			    const struct qstr *qstr,
> > > > >  			    struct ocfs2_security_xattr_info *si)
> > > > >  {
> > > > > +	int ret;
> > > > > +
> > > > >  	/* check whether ocfs2 support feature xattr */
> > > > >  	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
> > > > >  		return -EOPNOTSUPP;
> > > > > -	if (si)
> > > > > -		return security_old_inode_init_security(inode, dir, qstr,
> > > > > -							&si->name, &si->value,
> > > > > -							&si->value_len);
> > > > > +	if (si) {
> > > > > +		ret = security_inode_init_security(inode, dir, qstr,
> > > > > +						   &ocfs2_initxattrs, si);
> > > > 
> > > > The "if (unlikely(IS_PRIVATE(inode))"  test exists in both
> > > > security_old_inode_init_security() and security_inode_init_security(),
> > > > but return different values.  In the former case, it returns
> > > > -EOPNOTSUPP.  In the latter case, it returns 0.  The question is
> > > > whether or not we need to be concerned about private inodes on ocfs2.  
> > > > If private inodes on ocfs2 are possible, then ocsf2_mknod() or
> > > > ocfs2_symlink() would fail to create the inode or symlink.
> > > 
> > > Correction, previously when returning -EOPNOTSUPP for private inodes,
> > > xattrs would not be wrriten.  By returning 0 without setting si->enable 
> > > to 0, xattrs will be written.
> > 
> > Ok, but if there is a private inode, we would be setting si->enable to
> > zero. Should be ok, I guess.
> 
> si->enable is being set to zero, below, but is conditional on !si-
> > name.
> 
> This is the last concern, otherwise the patch set looks good.

Uhm, if the inode is private, security_inode_init_security() will
immediately return. So, the condition !si->name should be always true.

Thanks

Roberto

> > > > > +		/*
> > > > > +		 * security_inode_init_security() does not return -EOPNOTSUPP,
> > > > > +		 * we have to check the xattr ourselves.
> > > > > +		 */
> > > > > +		if (!ret && !si->name)
> > > > > +			si->enable = 0;
> > > > > +
> > > > > +		return ret;
> > > > > +	}
> > > > >  
> > > > >  	return security_inode_init_security(inode, dir, qstr,
> > > > >  					    &ocfs2_initxattrs, NULL);

