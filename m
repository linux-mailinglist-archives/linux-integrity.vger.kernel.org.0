Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D784636FA8
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 02:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKXBOg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Nov 2022 20:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiKXBOf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Nov 2022 20:14:35 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C69DFDD9A;
        Wed, 23 Nov 2022 17:14:34 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANM15kF030673;
        Thu, 24 Nov 2022 01:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KNq219/5AVdZrleS+HirjEBdvGLdqbdgtgWzIWGXyCk=;
 b=Uj3CEeSyH9PbA/ailDEEdrVjqprldCjGRbSvnLejn7XsSbLCT1pWWu2LHwuUqLq0lfiy
 7xzqseFXrouvygarEDI2CVuckpDJ+Y+ISFXAWIjMrAM0FQWCfzcwouzrfBirQsNjC0Mh
 6Dw6n+XoSf0iyai1DEb5kbTj2HAtjqtltRG9HG0Ar1+/6e5TG04N+T4f2cOkKjpJiCpC
 +0Zwsl55eFpfoOUlIhHGdSCkUGiGwYkNPrpY/pFzuSWProxIme9MAAB14Rxng/EPUMS2
 5Wzl7ydcPK47hh5WqtlH/RGemLRIwN5/gb5MKXzK3N2KblIdoGc+SHjV8Rvq2o5X6Eys Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0x81ace5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 01:14:06 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AO1BoYe004560;
        Thu, 24 Nov 2022 01:14:05 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0x81acds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 01:14:05 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AO1536D022755;
        Thu, 24 Nov 2022 01:14:04 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 3kxpsafkt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 01:14:04 +0000
Received: from smtpav03.dal12v.mail.ibm.com ([9.208.128.129])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AO1E8YB46072168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Nov 2022 01:14:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D62C058063;
        Thu, 24 Nov 2022 01:14:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 699AE5803F;
        Thu, 24 Nov 2022 01:14:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.101.232])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 24 Nov 2022 01:14:01 +0000 (GMT)
Message-ID: <13350b79f708cb089e2ff2ee5cead52bafb10982.camel@linux.ibm.com>
Subject: Re: [PATCH v6 4/6] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
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
Date:   Wed, 23 Nov 2022 20:14:01 -0500
In-Reply-To: <20221123154712.752074-5-roberto.sassu@huaweicloud.com>
References: <20221123154712.752074-1-roberto.sassu@huaweicloud.com>
         <20221123154712.752074-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fUsiWD_L9co63XKlkMcookDkMS_RvTrX
X-Proofpoint-ORIG-GUID: slNL7hiw8nwoTRLrZnEqIE5i5-tx6EkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_13,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211240006
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Wed, 2022-11-23 at 16:47 +0100, Roberto Sassu wrote:
>  int security_inode_init_security(struct inode *inode, struct inode *dir,
>                                  const struct qstr *qstr,
>                                  const initxattrs initxattrs, void *fs_data)
>  {
> -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
> -       int ret;
> +       struct security_hook_list *P;
> +       struct xattr *new_xattrs;
> +       struct xattr *xattr;
> +       int ret = -EOPNOTSUPP, num_filled_xattrs = 0;
>  
>         if (unlikely(IS_PRIVATE(inode)))
>                 return 0;
>  
> +       if (!blob_sizes.lbs_xattr)
> +               return 0;
> +
>         if (!initxattrs)
>                 return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
> -                                    dir, qstr, NULL, NULL, NULL);
> -       memset(new_xattrs, 0, sizeof(new_xattrs));
> -       lsm_xattr = new_xattrs;
> -       ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> -                                               &lsm_xattr->name,
> -                                               &lsm_xattr->value,
> -                                               &lsm_xattr->value_len);
> -       if (ret)
> +                                   dir, qstr, NULL);
> +       /* Allocate +1 for EVM and +1 as terminator. */
> +       new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_xattrs),
> +                            GFP_NOFS);
> +       if (!new_xattrs)
> +               return -ENOMEM;
> +
> +       hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
> +                            list) {
> +               ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs);
> +               if (ret && ret != -EOPNOTSUPP)
> +                       goto out;
> +               if (ret == -EOPNOTSUPP)
> +                       continue;

In this context, -EOPNOTSUPP originally signified that the filesystem
does not support writing xattrs.  Writing any xattr would fail. 
Returning -ENODATA for no LSM xattr(s) data would seem to be more
appropriate than -EOPNOTSUPP.

thanks,

Mimi

> +               /*
> +                * As the number of xattrs reserved by LSMs is not directly
> +                * available, directly use the total number blob_sizes.lbs_xattr
> +                * to keep the code simple, while being not the most efficient
> +                * way.
> +                */
> +               ret = security_check_compact_filled_xattrs(new_xattrs,
> +                                                          blob_sizes.lbs_xattr,
> +                                                          &num_filled_xattrs);
> +               if (ret < 0) {
> +                       ret = -ENOMEM;
> +                       goto out;
> +               }
> +       }
> +
> +       if (!num_filled_xattrs)
>                 goto out;
>  
> -       evm_xattr = lsm_xattr + 1;
> -       ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> +       ret = evm_inode_init_security(inode, new_xattrs,
> +                                     new_xattrs + num_filled_xattrs);
>         if (ret)
>                 goto out;
>         ret = initxattrs(inode, new_xattrs, fs_data);
>  out:
>         for (xattr = new_xattrs; xattr->value != NULL; xattr++)
>                 kfree(xattr->value);
> +       kfree(new_xattrs);
>         return (ret == -EOPNOTSUPP) ? 0 : ret;
>  }
b

