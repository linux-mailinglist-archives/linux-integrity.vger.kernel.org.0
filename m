Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB762F8EF
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 16:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbiKRPKn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Nov 2022 10:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiKRPKm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Nov 2022 10:10:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E1313CF1;
        Fri, 18 Nov 2022 07:10:41 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIE81CI028260;
        Fri, 18 Nov 2022 15:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Y2UvQmjEHBmBO9sNhKQBGwJHhJnDxOWzhbaj8DgVzWw=;
 b=nZRkLhWL+tNLuHdi1AtjFYR7UbvP8nnPXuv9JxAhmDbRRe6pqEFFb1Ou4J6hUD4KZ/Et
 Bvowt7EgaMvEnGCCDQ+I8MRdGNIgrcsodwdZj/136UfH2Kp74s9gm0hedfhspRzMOLDS
 7+y+joXnS52fQ2KSN04oK/jJPNnuMG69hGPxmvW8pvMsKnFO5Le80no1gh80zLAC4pVR
 p6ntQtu4RrQQUyWsWyQzPdaXI2UxpcWIxQUxggygr6GrGO8DPbcKx23Evx/uSOQaNa0I
 kaixdBbC6FcwXAUCAXDj8tUJGXssvUMaqOUwh1Rnp3km9tLMi6Bu4yZXulaO0UBbk/f9 ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx8w0wybt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:10:20 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIEFia3026902;
        Fri, 18 Nov 2022 15:10:19 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx8w0wyb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:10:19 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AIF6w3t003613;
        Fri, 18 Nov 2022 15:10:18 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 3kt34ar68j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:10:18 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AIFAH5h9110112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 15:10:18 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5781358054;
        Fri, 18 Nov 2022 15:10:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7559F58079;
        Fri, 18 Nov 2022 15:10:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.49.134])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Nov 2022 15:10:15 +0000 (GMT)
Message-ID: <3ffb9bb4ab203b5e0459c3892ded4ae0cd80458b.camel@linux.ibm.com>
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
Date:   Fri, 18 Nov 2022 10:10:14 -0500
In-Reply-To: <fe16a03a-102e-b3e1-cc3f-5bad3c28fad7@huaweicloud.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
         <20221110094639.3086409-4-roberto.sassu@huaweicloud.com>
         <4c1349f670dc3c23214a5a5036e43ddaa0a7bc89.camel@linux.ibm.com>
         <fe16a03a-102e-b3e1-cc3f-5bad3c28fad7@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UmGSvL3BqOwuSE5BIR2oIjtaeV8PYXZV
X-Proofpoint-GUID: pZ7kfLtNG94rZC55DpQEurav732-1LDM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_02,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211180084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-11-18 at 10:14 +0100, Roberto Sassu wrote:
> >> +static int security_check_compact_xattrs(struct xattr *xattrs,
> >> +                                     int num_xattrs, int *checked_xattrs)
> > 
> > Perhaps the variable naming is off, making it difficult to read.   So
> > although this is a static function, which normally doesn't require a
> > comment, it's definitely needs one.
> 
> Ok, will improve it.
> 
> >> +{
> >> +    int i;
> >> +
> >> +    for (i = *checked_xattrs; i < num_xattrs; i++) {
> > 
> > If the number of "checked" xattrs was kept up to date, removing the
> > empty xattr gaps wouldn't require a loop.  Is the purpose of this loop
> > to support multiple per LSM xattrs?
> 
> An LSM might reserve one or more xattrs, but not set it/them (for 
> example because it is not initialized). In this case, removing the gaps 
> is needed for all subsequent LSMs.

Including this sort of info in the function description or as a comment
in the code would definitely simplify review.

security_check_compact_xattrs() is called in the loop after getting
each LSM's xattr(s).  Only the current LSMs xattrs need to be
compressed, yet the loop goes to the maximum number of xattrs each
time. Just wondering if there is a way of improving it.

-- 
thanks,

Mimi

