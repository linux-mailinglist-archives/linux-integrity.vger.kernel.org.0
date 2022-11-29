Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D391B63BED4
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Nov 2022 12:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiK2LXo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Nov 2022 06:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiK2LXo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Nov 2022 06:23:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FD3B4BB;
        Tue, 29 Nov 2022 03:23:43 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AT9sSRj007122;
        Tue, 29 Nov 2022 11:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/smMidFxcLEK4Y856DjTwLSzF8Q3YTSpTIA5p2GvUGU=;
 b=eRi59DIx2C4Ca4cE0OnoZVdlifqtjwY/MWyqfRlVN84SfXsstwm2/oYjWLk6E2/9rVxI
 FP/N7i6JJpYFLNu2orGqZ/YR/9CJsQJg/OyJqh3WfQxCal8ifCZ3D95scAy0lAeWjwTI
 4bhO9BjLF0jUzoren5m/XzUzZUyjyBTL6BUkNA8vIkbB3EvJ0MaC5u+URFNIg6Kz5RiT
 +fk7gy/HKc9FAdI5uLzl15jCo4NJcjzmjP2AuCQhxEn8jsMS+lCUo/mKeG7qyNiioAuf
 XIIqHHo5vKeHejKR6nS8fNTGHajPCa2cLbOker9afRlgGqI2kd0wzM+cB5gjP0OJBD/0 YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5djwnt6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:23:08 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ATATLta012268;
        Tue, 29 Nov 2022 11:23:08 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5djwnt67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:23:07 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ATBLSfQ030091;
        Tue, 29 Nov 2022 11:23:06 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 3m3ae9c5uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:23:06 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ATBN5tU11993706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 11:23:05 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F0175803F;
        Tue, 29 Nov 2022 11:23:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 384785804E;
        Tue, 29 Nov 2022 11:23:03 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.96.78])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Nov 2022 11:23:03 +0000 (GMT)
Message-ID: <9859294adb0a9b9587ea7fb70a836a312aaf3c69.camel@linux.ibm.com>
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
Date:   Tue, 29 Nov 2022 06:23:02 -0500
In-Reply-To: <bb63eba9a9f24558f4a1acd9bf012b59b5c6e98e.camel@huaweicloud.com>
References: <20221123154712.752074-1-roberto.sassu@huaweicloud.com>
         <20221123154712.752074-5-roberto.sassu@huaweicloud.com>
         <13350b79f708cb089e2ff2ee5cead52bafb10982.camel@linux.ibm.com>
         <bb63eba9a9f24558f4a1acd9bf012b59b5c6e98e.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YWJ0UkKGLkx-v1vHUCLv3jRvVEbAFJIi
X-Proofpoint-GUID: 1QSg_Kxvz3AePdR0NFcitQgRW4PGc6pb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_07,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-11-24 at 09:17 +0100, Roberto Sassu wrote:
> On Wed, 2022-11-23 at 20:14 -0500, Mimi Zohar wrote:
> > Hi Roberto,
> > 
> > On Wed, 2022-11-23 at 16:47 +0100, Roberto Sassu wrote:
> > >  int security_inode_init_security(struct inode *inode, struct inode *dir,
> > >                                  const struct qstr *qstr,
> > >                                  const initxattrs initxattrs, void *fs_data)
> > >  {
> > > -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> > > -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
> > > -       int ret;
> > > +       struct security_hook_list *P;
> > > +       struct xattr *new_xattrs;
> > > +       struct xattr *xattr;
> > > +       int ret = -EOPNOTSUPP, num_filled_xattrs = 0;
> > >  
> > >         if (unlikely(IS_PRIVATE(inode)))
> > >                 return 0;
> > >  
> > > +       if (!blob_sizes.lbs_xattr)
> > > +               return 0;
> > > +
> > >         if (!initxattrs)
> > >                 return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
> > > -                                    dir, qstr, NULL, NULL, NULL);
> > > -       memset(new_xattrs, 0, sizeof(new_xattrs));
> > > -       lsm_xattr = new_xattrs;
> > > -       ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> > > -                                               &lsm_xattr->name,
> > > -                                               &lsm_xattr->value,
> > > -                                               &lsm_xattr->value_len);
> > > -       if (ret)
> > > +                                   dir, qstr, NULL);
> > > +       /* Allocate +1 for EVM and +1 as terminator. */
> > > +       new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_xattrs),
> > > +                            GFP_NOFS);
> > > +       if (!new_xattrs)
> > > +               return -ENOMEM;
> > > +
> > > +       hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
> > > +                            list) {
> > > +               ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs);
> > > +               if (ret && ret != -EOPNOTSUPP)
> > > +                       goto out;
> > > +               if (ret == -EOPNOTSUPP)
> > > +                       continue;
> > 
> > In this context, -EOPNOTSUPP originally signified that the filesystem
> > does not support writing xattrs.  Writing any xattr would fail. 
> > Returning -ENODATA for no LSM xattr(s) data would seem to be more
> > appropriate than -EOPNOTSUPP.
> 
> Hi Mimi
> 
> I thought about adding new return values. Currently only -EOPNOTSUPP
> and -ENOMEM are expected as errors.
> 
> However, changing the conventions would mean revisiting the LSMs code
> and ensuring that they follow the new conventions.
> 
> I would be more in favor of not touching it.

Casey, Paul, any comment?

> > 
> > > +               /*
> > > +                * As the number of xattrs reserved by LSMs is not directly
> > > +                * available, directly use the total number blob_sizes.lbs_xattr
> > > +                * to keep the code simple, while being not the most efficient
> > > +                * way.
> > > +                */
> > > +               ret = security_check_compact_filled_xattrs(new_xattrs,
> > > +                                                          blob_sizes.lbs_xattr,
> > > +                                                          &num_filled_xattrs);
> > > +               if (ret < 0) {
> > > +                       ret = -ENOMEM;
> > > +                       goto out;
> > > +               }
> > > +       }
> > > +
> > > +       if (!num_filled_xattrs)
> > >                 goto out;
> > >  
> > > -       evm_xattr = lsm_xattr + 1;
> > > -       ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> > > +       ret = evm_inode_init_security(inode, new_xattrs,
> > > +                                     new_xattrs + num_filled_xattrs);
> > >         if (ret)
> > >                 goto out;
> > >         ret = initxattrs(inode, new_xattrs, fs_data);
> > >  out:
> > >         for (xattr = new_xattrs; xattr->value != NULL; xattr++)
> > >                 kfree(xattr->value);
> > > +       kfree(new_xattrs);
> > >         return (ret == -EOPNOTSUPP) ? 0 : ret;
> > >  }
> > b
> 


