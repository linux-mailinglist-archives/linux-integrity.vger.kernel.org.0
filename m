Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B738C69DAB9
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Feb 2023 07:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjBUGqC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Feb 2023 01:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjBUGqB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Feb 2023 01:46:01 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A9724CAD;
        Mon, 20 Feb 2023 22:45:57 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VcB88ba_1676961950;
Received: from 30.221.129.126(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VcB88ba_1676961950)
          by smtp.aliyun-inc.com;
          Tue, 21 Feb 2023 14:45:51 +0800
Message-ID: <d5180ef2-70dc-0a43-3e1b-c04d9e14ab23@linux.alibaba.com>
Date:   Tue, 21 Feb 2023 14:45:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v7 2/6] ocfs2: Switch to security_inode_init_security()
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, mark@fasheh.com,
        jlbec@evilplan.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
 <20221201104125.919483-3-roberto.sassu@huaweicloud.com>
 <6905166125130c22c244ebf234723d1587a01ae8.camel@huaweicloud.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <6905166125130c22c244ebf234723d1587a01ae8.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Sorry for the late reply.

I don't have much background on this thread. It seems that we have to
check EOPNOTSUPP since ocfs2_init_security_get() may return EOPNOTSUPP
if it doesn't support extended attribute feature for backward
compatibility.

Other looks good. So with above comments addressed, you can add:
Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

On 1/10/23 4:55 PM, Roberto Sassu wrote:
> On Thu, 2022-12-01 at 11:41 +0100, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> In preparation for removing security_old_inode_init_security(), switch to
>> security_inode_init_security().
>>
>> Extend the existing ocfs2_initxattrs() to take the
>> ocfs2_security_xattr_info structure from fs_info, and populate the
>> name/value/len triple with the first xattr provided by LSMs.
> 
> Hi Mark, Joel, Joseph
> 
> some time ago I sent this patch set to switch to the newer
> function security_inode_init_security(). Almost all the other parts of
> this patch set have been reviewed, and the patch set itself should be
> ready to be merged.
> 
> I kindly ask if you could have a look at this patch and give your
> Reviewed-by, so that Paul could take the patch set.
> 
> Thanks a lot!
> 
> Roberto
> 
>> As fs_info was not used before, ocfs2_initxattrs() can now handle the case
>> of replicating the behavior of security_old_inode_init_security(), i.e.
>> just obtaining the xattr, in addition to setting all xattrs provided by
>> LSMs.
>>
>> Supporting multiple xattrs is not currently supported where
>> security_old_inode_init_security() was called (mknod, symlink), as it
>> requires non-trivial changes that can be done at a later time. Like for
>> reiserfs, even if EVM is invoked, it will not provide an xattr (if it is
>> not the first to set it, its xattr will be discarded; if it is the first,
>> it does not have xattrs to calculate the HMAC on).
>>
>> Finally, modify the handling of the return value from
>> ocfs2_init_security_get(). As security_inode_init_security() does not
>> return -EOPNOTSUPP, remove this case and directly handle the error if the
>> return value is not zero.
>>
>> However, the previous case of receiving -EOPNOTSUPP should be still
>> taken into account, as security_inode_init_security() could return zero
>> without setting xattrs and ocfs2 would consider it as if the xattr was set.
>>
>> Instead, if security_inode_init_security() returned zero, look at the xattr
>> if it was set, and behave accordingly, i.e. set si->enable to zero to
>> notify to the functions following ocfs2_init_security_get() that the xattr
>> is not available (same as if security_old_inode_init_security() returned
>> -EOPNOTSUPP).
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  fs/ocfs2/namei.c | 18 ++++++------------
>>  fs/ocfs2/xattr.c | 30 ++++++++++++++++++++++++++----
>>  2 files changed, 32 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
>> index 05f32989bad6..55fba81cd2d1 100644
>> --- a/fs/ocfs2/namei.c
>> +++ b/fs/ocfs2/namei.c
>> @@ -242,6 +242,7 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
>>  	int want_meta = 0;
>>  	int xattr_credits = 0;
>>  	struct ocfs2_security_xattr_info si = {
>> +		.name = NULL,
>>  		.enable = 1,
>>  	};
>>  	int did_quota_inode = 0;
>> @@ -315,12 +316,8 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
>>  	/* get security xattr */
>>  	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
>>  	if (status) {
>> -		if (status == -EOPNOTSUPP)
>> -			si.enable = 0;
>> -		else {
>> -			mlog_errno(status);
>> -			goto leave;
>> -		}
>> +		mlog_errno(status);
>> +		goto leave;
>>  	}
>>  
>>  	/* calculate meta data/clusters for setting security and acl xattr */
>> @@ -1805,6 +1802,7 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
>>  	int want_clusters = 0;
>>  	int xattr_credits = 0;
>>  	struct ocfs2_security_xattr_info si = {
>> +		.name = NULL,
>>  		.enable = 1,
>>  	};
>>  	int did_quota = 0, did_quota_inode = 0;
>> @@ -1875,12 +1873,8 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
>>  	/* get security xattr */
>>  	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
>>  	if (status) {
>> -		if (status == -EOPNOTSUPP)
>> -			si.enable = 0;
>> -		else {
>> -			mlog_errno(status);
>> -			goto bail;
>> -		}
>> +		mlog_errno(status);
>> +		goto bail;
>>  	}
>>  
>>  	/* calculate meta data/clusters for setting security xattr */
>> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
>> index 95d0611c5fc7..55699c573541 100644
>> --- a/fs/ocfs2/xattr.c
>> +++ b/fs/ocfs2/xattr.c
>> @@ -7259,9 +7259,21 @@ static int ocfs2_xattr_security_set(const struct xattr_handler *handler,
>>  static int ocfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array,
>>  		     void *fs_info)
>>  {
>> +	struct ocfs2_security_xattr_info *si = fs_info;
>>  	const struct xattr *xattr;
>>  	int err = 0;
>>  
>> +	if (si) {
>> +		si->value = kmemdup(xattr_array->value, xattr_array->value_len,
>> +				    GFP_KERNEL);
>> +		if (!si->value)
>> +			return -ENOMEM;
>> +
>> +		si->name = xattr_array->name;
>> +		si->value_len = xattr_array->value_len;
>> +		return 0;
>> +	}
>> +
>>  	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
>>  		err = ocfs2_xattr_set(inode, OCFS2_XATTR_INDEX_SECURITY,
>>  				      xattr->name, xattr->value,
>> @@ -7277,13 +7289,23 @@ int ocfs2_init_security_get(struct inode *inode,
>>  			    const struct qstr *qstr,
>>  			    struct ocfs2_security_xattr_info *si)
>>  {
>> +	int ret;
>> +
>>  	/* check whether ocfs2 support feature xattr */
>>  	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
>>  		return -EOPNOTSUPP;
>> -	if (si)
>> -		return security_old_inode_init_security(inode, dir, qstr,
>> -							&si->name, &si->value,
>> -							&si->value_len);
>> +	if (si) {
>> +		ret = security_inode_init_security(inode, dir, qstr,
>> +						   &ocfs2_initxattrs, si);
>> +		/*
>> +		 * security_inode_init_security() does not return -EOPNOTSUPP,
>> +		 * we have to check the xattr ourselves.
>> +		 */
>> +		if (!ret && !si->name)
>> +			si->enable = 0;
>> +
>> +		return ret;
>> +	}
>>  
>>  	return security_inode_init_security(inode, dir, qstr,
>>  					    &ocfs2_initxattrs, NULL);
