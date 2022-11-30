Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503C863E2A3
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Nov 2022 22:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiK3VYc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Nov 2022 16:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiK3VYb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Nov 2022 16:24:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453358D67F;
        Wed, 30 Nov 2022 13:24:30 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AULDSbv004773;
        Wed, 30 Nov 2022 21:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yifZRjcnME4KdiCrx4XAH30YdBt6VKv7hfRn0v4FRuc=;
 b=l1XUiN1rW6f+ee6TrpN9jk5ssoNSaDOiPcxMdZauO8mKygmAxvaRnHoG31vayk9PgxHr
 bnrusCji3tMF8gNxXVxyKptv/w6DBipSxA+jUHZPaKQlnX1VA6veuNfnO4T0U9hHUmjT
 Y8LtbWrLuqkjh12fLywGfGt8FtkeENfaXiLvCKlhTB3SHROi0j4psDHZlDj/cvAHjVuj
 NL1hijVMJJh4dHNqKg7eBrzLejruYTDP006FlqAY4ckD2FnyWxCDyzWIQDFmuEpogPXV
 5szbiEKjhNrPIFvt8pvIUWohtN6IFLNqUliTFjBXXkHzaJ4/+uucgc8gQi22pUqMQ2ZO ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6ewd86mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 21:23:48 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AULHKau018482;
        Wed, 30 Nov 2022 21:23:47 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6ewd86kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 21:23:47 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AULKxnj005739;
        Wed, 30 Nov 2022 21:23:45 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma02wdc.us.ibm.com with ESMTP id 3m3aea6hkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 21:23:45 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AULNj8B37618096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Nov 2022 21:23:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEA2E5803F;
        Wed, 30 Nov 2022 21:23:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5AA458056;
        Wed, 30 Nov 2022 21:23:43 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.97.169])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 30 Nov 2022 21:23:43 +0000 (GMT)
Message-ID: <b929e0c597161fd5be79c18163a11649dd7f237f.camel@linux.ibm.com>
Subject: Re: [PATCH v6 4/6] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 30 Nov 2022 16:23:43 -0500
In-Reply-To: <50232f2b-d5ce-1e5a-3f5b-8d3eb53fe1ec@schaufler-ca.com>
References: <20221123154712.752074-1-roberto.sassu@huaweicloud.com>
         <20221123154712.752074-5-roberto.sassu@huaweicloud.com>
         <13350b79f708cb089e2ff2ee5cead52bafb10982.camel@linux.ibm.com>
         <bb63eba9a9f24558f4a1acd9bf012b59b5c6e98e.camel@huaweicloud.com>
         <9859294adb0a9b9587ea7fb70a836a312aaf3c69.camel@linux.ibm.com>
         <50232f2b-d5ce-1e5a-3f5b-8d3eb53fe1ec@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RFYdom96nPEAcgZBzGdM3xm3tZ0uHlwx
X-Proofpoint-GUID: gNLYuWXFEUBW_-uMEoVK_Brk6AGGQYmE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300148
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-11-29 at 07:39 -0800, Casey Schaufler wrote:
> On 11/29/2022 3:23 AM, Mimi Zohar wrote:
> > On Thu, 2022-11-24 at 09:17 +0100, Roberto Sassu wrote:
> >> On Wed, 2022-11-23 at 20:14 -0500, Mimi Zohar wrote:
> >>> Hi Roberto,
> >>>
> >>> On Wed, 2022-11-23 at 16:47 +0100, Roberto Sassu wrote:
> >>>>  int security_inode_init_security(struct inode *inode, struct inode *dir,
> >>>>                                  const struct qstr *qstr,
> >>>>                                  const initxattrs initxattrs, void *fs_data)
> >>>>  {
> >>>> -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> >>>> -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
> >>>> -       int ret;
> >>>> +       struct security_hook_list *P;
> >>>> +       struct xattr *new_xattrs;
> >>>> +       struct xattr *xattr;
> >>>> +       int ret = -EOPNOTSUPP, num_filled_xattrs = 0;
> >>>>  
> >>>>         if (unlikely(IS_PRIVATE(inode)))
> >>>>                 return 0;
> >>>>  
> >>>> +       if (!blob_sizes.lbs_xattr)
> >>>> +               return 0;
> >>>> +
> >>>>         if (!initxattrs)
> >>>>                 return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
> >>>> -                                    dir, qstr, NULL, NULL, NULL);
> >>>> -       memset(new_xattrs, 0, sizeof(new_xattrs));
> >>>> -       lsm_xattr = new_xattrs;
> >>>> -       ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> >>>> -                                               &lsm_xattr->name,
> >>>> -                                               &lsm_xattr->value,
> >>>> -                                               &lsm_xattr->value_len);
> >>>> -       if (ret)
> >>>> +                                   dir, qstr, NULL);
> >>>> +       /* Allocate +1 for EVM and +1 as terminator. */
> >>>> +       new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_xattrs),
> >>>> +                            GFP_NOFS);
> >>>> +       if (!new_xattrs)
> >>>> +               return -ENOMEM;
> >>>> +
> >>>> +       hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
> >>>> +                            list) {
> >>>> +               ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs);
> >>>> +               if (ret && ret != -EOPNOTSUPP)
> >>>> +                       goto out;
> >>>> +               if (ret == -EOPNOTSUPP)
> >>>> +                       continue;
> >>> In this context, -EOPNOTSUPP originally signified that the filesystem
> >>> does not support writing xattrs.  Writing any xattr would fail. 
> >>> Returning -ENODATA for no LSM xattr(s) data would seem to be more
> >>> appropriate than -EOPNOTSUPP.
> >> Hi Mimi
> >>
> >> I thought about adding new return values. Currently only -EOPNOTSUPP
> >> and -ENOMEM are expected as errors.
> >>
> >> However, changing the conventions would mean revisiting the LSMs code
> >> and ensuring that they follow the new conventions.
> >>
> >> I would be more in favor of not touching it.
> > Casey, Paul, any comment?
> 
> I don't see value in adding -ENODATA as a value special to
> the infrastructure. What would the infrastructure do differently?
> The use of -EOPNOTSUPP isn't consistent throughout, and the amount
> of "correctness" you get by returning -ENODATA is really small.

Agreed, it isn't worthwhile for this case.  Roberto, to ease code
review, could you document the overloading of the -EOPNOTSUPP meaning,
which results in the loop continuing?

thanks,

Mimi

