Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81878672AC8
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Jan 2023 22:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjARVpX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 16:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjARVpW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 16:45:22 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E7710CC;
        Wed, 18 Jan 2023 13:45:21 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILSRgZ031782;
        Wed, 18 Jan 2023 21:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UzADFY1L/BfeucqpU0xMyyeXHhyIthrN7gMK7UVkCb8=;
 b=fKn02Sj9buheV6gLQVxSd0Rr1EcU0yDl3ubhyaIxSTxPWf9tBHr6s5Upwr0GZ3PN9u3+
 FMDpYwia+vrLhozvKCL2rtB++JNPLH7naf1uChsAnUSpBv+i4Tluq1Qqhs7roDor/mH3
 Yjhm62JuFsI4LEc9750Ga6YDISqqHw3zoDMxRhS7ZhUR3Hq5j7N4gPEQVTOFNRpel1Pg
 WbxX3HIiuVIhNroiYWQuSOLmMykxO+DeL4iQSf/8XqQWUJQk1y6DNzfo+xuAPtIIygU3
 gF4H9cch7yWI3jLlVKaS1IVp5X7h+Ie74WcReXrGD6UP8KMjotv8RxnULrIqCcC6p7UU Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6h5evf57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 21:45:05 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30ILj0YL005466;
        Wed, 18 Jan 2023 21:45:04 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6h5evf4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 21:45:04 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30IK4h9D022043;
        Wed, 18 Jan 2023 21:45:04 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3n3m17g5sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 21:45:03 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30ILj37U63308280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:45:03 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D8FC58052;
        Wed, 18 Jan 2023 21:45:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F3105805A;
        Wed, 18 Jan 2023 21:45:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.7.111])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 21:45:02 +0000 (GMT)
Message-ID: <3c34c1e8c74722110e5d7e87146b090791734916.camel@linux.ibm.com>
Subject: Re: [PATCH -next] evm: Use __vfs_setxattr() to update security.evm
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Jan 2023 16:45:02 -0500
In-Reply-To: <20221228030248.94285-1-xiujianfeng@huawei.com>
References: <20221228030248.94285-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zEE8R_E7ZXjdtyO48DZjtIZp6t3ze7zy
X-Proofpoint-ORIG-GUID: _FNfmYn35NGQBAGX_ShXks7MvFjettbF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180180
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-12-28 at 11:02 +0800, Xiu Jianfeng wrote:
> Currently it uses __vfs_setxattr_noperm() to update "security.evm",
> however there are two lsm hooks(inode_post_setxattr and inode_setsecurity)
> being called inside this function, which don't make any sense for xattr
> "security.evm", because the handlers of these two hooks, such as selinux
> and smack, only care about their own xattr.

Updating the security.ima hash triggers re-calculating and writing the
security.evm HMAC.  Refer to evm_inode_post_setxattr().

Mimi

> 
> On the other hand, there is a literally rather than actually cyclical
> callchain as follows:
> security_inode_post_setxattr
>   ->evm_inode_post_setxattr
>     ->evm_update_evmxattr
>       ->__vfs_setxattr_noperm
>         ->security_inode_post_setxattr
> 
> So use __vfs_setxattr() to update "security.evm".
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/integrity/evm/evm_crypto.c   | 7 +++----
>  security/integrity/ima/ima_appraise.c | 8 ++++----
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index fa5ff13fa8c9..d8275dfa49ef 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -376,10 +376,9 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
>  			   xattr_value_len, &data);
>  	if (rc == 0) {
>  		data.hdr.xattr.sha1.type = EVM_XATTR_HMAC;
> -		rc = __vfs_setxattr_noperm(&init_user_ns, dentry,
> -					   XATTR_NAME_EVM,
> -					   &data.hdr.xattr.data[1],
> -					   SHA1_DIGEST_SIZE + 1, 0);
> +		rc = __vfs_setxattr(&init_user_ns, dentry, d_inode(dentry),
> +				    XATTR_NAME_EVM, &data.hdr.xattr.data[1],
> +				    SHA1_DIGEST_SIZE + 1, 0);
>  	} else if (rc == -ENODATA && (inode->i_opflags & IOP_XATTR)) {
>  		rc = __vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_EVM);
>  	}
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index ee6f7e237f2e..d2de9dc6c345 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -98,10 +98,10 @@ static int ima_fix_xattr(struct dentry *dentry,
>  		iint->ima_hash->xattr.ng.type = IMA_XATTR_DIGEST_NG;
>  		iint->ima_hash->xattr.ng.algo = algo;
>  	}
> -	rc = __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_IMA,
> -				   &iint->ima_hash->xattr.data[offset],
> -				   (sizeof(iint->ima_hash->xattr) - offset) +
> -				   iint->ima_hash->length, 0);
> +	rc = __vfs_setxattr(&init_user_ns, dentry, d_inode(dentry),
> +			    XATTR_NAME_IMA, &iint->ima_hash->xattr.data[offset],
> +			    (sizeof(iint->ima_hash->xattr) - offset) +
> +			    iint->ima_hash->length, 0);
>  	return rc;
>  }
>  


