Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5090C632E48
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Nov 2022 21:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiKUU6a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Nov 2022 15:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUU62 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Nov 2022 15:58:28 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58B4CEBAD;
        Mon, 21 Nov 2022 12:58:27 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALK3lao029070;
        Mon, 21 Nov 2022 20:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yYc1UjR/X0mjO1Si4MpoQ9ZWzXiCM44IGVCFBM9HksM=;
 b=fHjSzlbvKCNmzvyWRhEFoCgf2kFmVcWJXPbWqTecv0fMIK82bWxcZ9T60FGJ4Kge14LT
 uNry1lRdag0s7wKlV2WF8JJ5HfaS6Tu7xpFOUUp9cip3XNY8DxOw9oURAPFQrXK5lSo/
 AubsE6A5VF9XJHCbKC8vcmx3Ij0aAaqbNYx58HGVpy8NcLGrNeq3s3m5rFp7ldkSO1In
 0kg4FW+6KBVcM0nfU2wi56MUsGg7jb/sDSBadvye/M5FUEgQM67EK7RJ7jjOMyh8vdP9
 iq58VqneeuRBHSqO6BAdBZwMAM3FEqTV41b7nF3zBAEzSLk4ukHsjyBRoONYc49L0yv5 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0cfxxfr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 20:58:09 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ALKqsWC022894;
        Mon, 21 Nov 2022 20:58:08 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0cfxxfqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 20:58:08 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ALKp4Pi014694;
        Mon, 21 Nov 2022 20:58:07 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 3kxps9fsdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 20:58:07 +0000
Received: from smtpav03.dal12v.mail.ibm.com ([9.208.128.129])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ALKw5FL34210120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 20:58:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C7D958060;
        Mon, 21 Nov 2022 20:58:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96CF55803F;
        Mon, 21 Nov 2022 20:58:05 +0000 (GMT)
Received: from sig-9-65-226-3.ibm.com (unknown [9.65.226.3])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 21 Nov 2022 20:58:05 +0000 (GMT)
Message-ID: <5e88d4bfae90d642fcf84a0c0937a9e4359ef4b2.camel@linux.ibm.com>
Subject: Re: [PATCH v4 3/5] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 21 Nov 2022 15:58:05 -0500
In-Reply-To: <ad7bfa59a3a89ccad52574e2f9fb8965dbaa1620.camel@huaweicloud.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
         <20221110094639.3086409-4-roberto.sassu@huaweicloud.com>
         <4c1349f670dc3c23214a5a5036e43ddaa0a7bc89.camel@linux.ibm.com>
         <fe16a03a-102e-b3e1-cc3f-5bad3c28fad7@huaweicloud.com>
         <3ffb9bb4ab203b5e0459c3892ded4ae0cd80458b.camel@linux.ibm.com>
         <fb3f423a-a56e-b6ed-d1e7-476605d607f8@schaufler-ca.com>
         <ad7bfa59a3a89ccad52574e2f9fb8965dbaa1620.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cw1OJWh_QF1SxB1kA5f_Qwm275_N0FeP
X-Proofpoint-ORIG-GUID: o0KtNVBV0hgf2nWi3TrF-p_qik3UvULx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_16,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-11-21 at 14:29 +0100, Roberto Sassu wrote:
> On Fri, 2022-11-18 at 09:31 -0800, Casey Schaufler wrote:
> > On 11/18/2022 7:10 AM, Mimi Zohar wrote:
> > > On Fri, 2022-11-18 at 10:14 +0100, Roberto Sassu wrote:
> > > > > > +static int security_check_compact_xattrs(struct xattr *xattrs,
> > > > > > +                                     int num_xattrs, int *checked_xattrs)
> > > > > Perhaps the variable naming is off, making it difficult to read.   So
> > > > > although this is a static function, which normally doesn't require a
> > > > > comment, it's definitely needs one.
> > > > Ok, will improve it.
> > > > 
> > > > > > +{
> > > > > > +    int i;
> > > > > > +
> > > > > > +    for (i = *checked_xattrs; i < num_xattrs; i++) {
> > > > > If the number of "checked" xattrs was kept up to date, removing the
> > > > > empty xattr gaps wouldn't require a loop.  Is the purpose of this loop
> > > > > to support multiple per LSM xattrs?
> > > > An LSM might reserve one or more xattrs, but not set it/them (for 
> > > > example because it is not initialized). In this case, removing the gaps 
> > > > is needed for all subsequent LSMs.
> > > Including this sort of info in the function description or as a comment
> > > in the code would definitely simplify review.
> > > 
> > > security_check_compact_xattrs() is called in the loop after getting
> > > each LSM's xattr(s).  Only the current LSMs xattrs need to be
> > > compressed, yet the loop goes to the maximum number of xattrs each
> > > time. Just wondering if there is a way of improving it.
> > 
> > At security module registration each module could identify how
> > many xattrs it uses. That number could be used to limit the range
> > of the loop. I have to do similar things for the forthcoming LSM
> > syscalls and module stacking beyond that.
> 
> Yes, blob_sizes.lbs_xattr contains the total number of xattrs requested
> by LSMs. To stop the loop earlier, at the offset of the next LSM, we
> would need to search the LSM's lsm_info, using the LSM name in
> the security_hook_list structure. Although it is not optimal, not doing
> it makes the code simpler. I could do that, if preferred.

Either way is fine, as long as the code is readable.  At minimum add a
comment.

-- 
thanks,

Mimi




