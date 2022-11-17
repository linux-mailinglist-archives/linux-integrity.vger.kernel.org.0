Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416A762E0FF
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Nov 2022 17:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbiKQQGP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Nov 2022 11:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbiKQQGC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Nov 2022 11:06:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A37E78D61;
        Thu, 17 Nov 2022 08:06:01 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHFGDf7002804;
        Thu, 17 Nov 2022 16:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=tTEcBCbz3aJlG9REi58uqK3FZw6Nn6LvjN3SKsAJD84=;
 b=dvliZ2U2Wl/p4FrNQMGTi31CiCfy3Z9onLJ1WgRqSWaf3D57OzNlKg7RPlAb93tNSgNZ
 LF9Iqp0sYZSB2GZ4igfJmSkFC1fkbDx4QQIGwTx2qXDY6sH3VvvC26lPo19QOoSD7QSH
 J4U1DkCtGYN/rGcaQy9RROKX5MGcBaQrpVaA9cvapOS5vq9SX7KQQJMf7Z85hrkqo6UZ
 dNUrTlGKUzksTN7UQMpaxTiiDFp2p7Ck8DUEgNckOqStcfhYinRsN39B0O71H8M3CDaE
 632jV4LD/K8zyE7QFKFqdSUSVm5snHjujvbz5P+UhBIA1oZPzpYVxeSbn7yOCufU7EdV Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwp5uv120-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 16:05:33 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHDnU4D020977;
        Thu, 17 Nov 2022 16:05:32 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwp5uv10r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 16:05:32 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHFoRPb000939;
        Thu, 17 Nov 2022 16:05:30 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 3kt34a25je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 16:05:30 +0000
Received: from smtpav05.wdc07v.mail.ibm.com ([9.208.128.117])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHG5TtD23200328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 16:05:29 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E69B058077;
        Thu, 17 Nov 2022 16:05:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5655858066;
        Thu, 17 Nov 2022 16:05:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.98.240])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 16:05:27 +0000 (GMT)
Message-ID: <4c1349f670dc3c23214a5a5036e43ddaa0a7bc89.camel@linux.ibm.com>
Subject: Re: [PATCH v4 3/5] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 17 Nov 2022 11:05:26 -0500
In-Reply-To: <20221110094639.3086409-4-roberto.sassu@huaweicloud.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
         <20221110094639.3086409-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MYg69mpnuoG4ni9rpkt12W-g8c2E1r0E
X-Proofpoint-ORIG-GUID: R19mTbbsMD0xfFkMMvbR0lv7dd6wFfVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

hOn Thu, 2022-11-10 at 10:46 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Currently, security_inode_init_security() supports only one LSM providing
> an xattr and EVM calculating the HMAC on that xattr, plus other inode
> metadata.
> 
> Allow all LSMs to provide one or multiple xattrs, by extending the security
> blob reservation mechanism. Introduce the new lbs_xattr field of the
> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
> needs, and the LSM infrastructure knows how many xattr slots it should
> allocate.

Perhaps supporting per LSM multiple xattrs is a nice idea, but EVM
doesn't currently support it.  The LSM xattrs are hard coded in
evm_config_default_xattrnames[],  based on whether the LSM is
configured.  Additional security xattrs may be included in the
security.evm calculation, by extending the list via
security/integrity/evm/evm_xattrs.

> 
> Dynamically allocate the xattrs array to be populated by LSMs with the
> inode_init_security hook, and pass it to the latter instead of the
> name/value/len triple.
> 
> Since the LSM infrastructure, at initialization time, updates the number of
> the requested xattrs provided by each LSM with a corresponding offset in
> the security blob (in this case the xattr array), it makes straightforward
> for an LSM to access the right position in the xattr array.
> 
> There is still the issue that an LSM might not fill the xattr, even if it
> requests it (legitimate case, for example it might have been loaded but not
> initialized with a policy). Since users of the xattr array (e.g. the
> initxattrs() callbacks) detect the end of the xattr array by checking if
> the xattr name is NULL, not filling an xattr would cause those users to
> stop scanning xattrs prematurely.
> 
> Solve that issue by introducing security_check_compact_xattrs(), which does
> a basic check of the xattr array (if the xattr name is filled, the xattr
> value should be too, and viceversa), and compacts the xattr array by
> removing the holes.
> 
> An alternative solution would be to let users of the xattr array know the
> number of elements of the xattr array, so that they don't have to check the
> termination. However, this seems more invasive, compared to a simple move
> of few array elements.
> 
> Finally, adapt both SELinux and Smack to use the new definition of the
> inode_init_security hook, and to correctly fill the designated slots in the
> xattr array.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

> diff --git a/security/security.c b/security/security.c
> index a0e9b4ce2341..b62f192de6da 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -30,8 +30,6 @@
>  #include <linux/msg.h>
>  #include <net/flow.h>
>  
> -#define MAX_LSM_EVM_XATTR	2
> -
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
>  
> @@ -210,6 +208,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>  	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
>  	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
>  	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
> +	lsm_set_blob_size(&needed->lbs_xattr, &blob_sizes.lbs_xattr);
>  }
>  
>  /* Prepare LSM for initialization. */
> @@ -346,6 +345,7 @@ static void __init ordered_lsm_init(void)
>  	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
>  	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
>  	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
> +	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr);
>  
>  	/*
>  	 * Create any kmem_caches needed for blobs
> @@ -1100,34 +1100,78 @@ static int security_initxattrs(struct inode *inode, const struct xattr *xattrs,
>  	return 0;
>  }

> +static int security_check_compact_xattrs(struct xattr *xattrs,
> +					 int num_xattrs, int *checked_xattrs)

Perhaps the variable naming is off, making it difficult to read.   So
although this is a static function, which normally doesn't require a
comment, it's definitely needs one.

> +{
> +	int i;
> +
> +	for (i = *checked_xattrs; i < num_xattrs; i++) {

If the number of "checked" xattrs was kept up to date, removing the
empty xattr gaps wouldn't require a loop.  Is the purpose of this loop
to support multiple per LSM xattrs?

> +		if ((!xattrs[i].name && xattrs[i].value) ||
> +		    (xattrs[i].name && !xattrs[i].value))
> +			return -EINVAL;
> +
> +		if (!xattrs[i].name)
> +			continue;
> +
> +		if (i == *checked_xattrs) {
> +			(*checked_xattrs)++;
> +			continue;
> +		}
> +
> +		memcpy(xattrs + (*checked_xattrs)++, xattrs + i,
> +		       sizeof(*xattrs));
> +		memset(xattrs + i, 0, sizeof(*xattrs));
> +	}
> +
> +	return 0;
> +}
> +
>  int security_inode_init_security(struct inode *inode, struct inode *dir,
>  				 const struct qstr *qstr,
>  				 const initxattrs initxattrs, void *fs_data)
>  {
> -	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> -	struct xattr *lsm_xattr, *evm_xattr, *xattr;
> -	int ret = -EOPNOTSUPP;
> +	struct security_hook_list *P;
> +	struct xattr *new_xattrs;
> +	struct xattr *xattr;
> +	int ret = -EOPNOTSUPP, cur_xattrs = 0;
>  
>  	if (unlikely(IS_PRIVATE(inode)))
>  		goto out_exit;
>  
> +	if (!blob_sizes.lbs_xattr)
> +		goto out_exit;
> +
>  	if (!initxattrs ||
>  	    (initxattrs == &security_initxattrs && !fs_data)) {
>  		ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
> -				    dir, qstr, NULL, NULL, NULL);
> +				    dir, qstr, NULL);
>  		goto out_exit;
>  	}
> -	memset(new_xattrs, 0, sizeof(new_xattrs));
> -	lsm_xattr = new_xattrs;
> -	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> -						&lsm_xattr->name,
> -						&lsm_xattr->value,
> -						&lsm_xattr->value_len);
> -	if (ret)
> -		goto out;
> +	/* Allocate +1 for EVM and +1 as terminator. */
> +	new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_xattrs),
> +			     GFP_NOFS);
> +	if (!new_xattrs) {
> +		ret = -ENOMEM;
> +		goto out_exit;
> +	}
> +	hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
> +			     list) {
> +		ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs);
> +		if (ret && ret != -EOPNOTSUPP)
> +			goto out;
> +		if (ret == -EOPNOTSUPP)
> +			continue;
> +		ret = security_check_compact_xattrs(new_xattrs,
> +						    blob_sizes.lbs_xattr,
> +						    &cur_xattrs);

Defining a variable named "cur_xattrs" to indicate the number of xattrs
compressed is off.  Perhaps use cur_num_xattrs?   Similarly,
"checked_xattrs" should be num_checked_xattrs.  Or change the existing
num_xattrs to max_num_xattrs and rename checked_xattrs to num_xattrs.

thanks,

Mimi

> +		if (ret < 0) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +	}
>  
> -	evm_xattr = lsm_xattr + 1;
> -	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> +	ret = evm_inode_init_security(inode, new_xattrs,
> +				      new_xattrs + cur_xattrs);
>  	if (ret)
>  		goto out;
>  	ret = initxattrs(inode, new_xattrs, fs_data);
> @@ -1142,6 +1186,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  			continue;
>  		kfree(xattr->value);
>  	}
> +	kfree(new_xattrs);
>  out_exit:
>  	if (initxattrs == &security_initxattrs)
>  		return ret;

