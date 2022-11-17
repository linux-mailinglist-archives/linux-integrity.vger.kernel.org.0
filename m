Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883F62DC35
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Nov 2022 14:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbiKQNEX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Nov 2022 08:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKQNEW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Nov 2022 08:04:22 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C972B197;
        Thu, 17 Nov 2022 05:04:21 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHCibq1021045;
        Thu, 17 Nov 2022 13:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=cjadO755ktE+yKQ9dqvEyND9KuoTueb/HI0lzO/4C98=;
 b=YvHMKRCrogST5xyWZfYmlYwkwLW6HQs/viZTSN08nBx2m82E2YquWuJwq9pgWx+/4R6u
 TBjMNPTSafdvsijI0SG41foyzEzF5cw0qoEpR/7XU76HJ+AGGbEIhQeBlqI89yBFniEx
 sgRQxyPA7ipIonISh6ZbmR8LgcIMPHanioK+NnLkbFUmOkJd9kTl58Pd1V+thq7d6RZ0
 T2q7vwXZgaImkqCpt3yAWUrh47sYev/YXFfvDnhKyURB6tYnPeYbzw3MeRa2GiWP4Tew
 z+HwHnVVGonTYxXhKYqV9sC+CTmxBnTs4vonUfENrUGXTCJX3o3vdiGBZcPT/ESSrDis bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwn7vgg9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 13:03:40 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHCrlkl027571;
        Thu, 17 Nov 2022 13:03:39 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwn7vgg94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 13:03:39 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHCpPYx002703;
        Thu, 17 Nov 2022 13:03:38 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 3kt34a9hb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 13:03:38 +0000
Received: from smtpav02.wdc07v.mail.ibm.com ([9.208.128.114])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHD3b37721436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 13:03:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C6235805B;
        Thu, 17 Nov 2022 13:03:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EF1058059;
        Thu, 17 Nov 2022 13:03:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.98.240])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 13:03:35 +0000 (GMT)
Message-ID: <3dc4f389ead98972cb7d09ef285a0065decb0ad0.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/5] security: Rewrite
 security_old_inode_init_security()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        ocfs2-devel@oss.oracle.com
Date:   Thu, 17 Nov 2022 08:03:23 -0500
In-Reply-To: <20221110094639.3086409-3-roberto.sassu@huaweicloud.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
         <20221110094639.3086409-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WMqKO59AnhuMpzL2Nr3S2KehvV3tLQpl
X-Proofpoint-ORIG-GUID: pHWVY-EOF1k4f1Oiw57AU2E65yMhP3d_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=776 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Thu, 2022-11-10 at 10:46 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Rewrite security_old_inode_init_security() to call
> security_inode_init_security() before making changes to support multiple
> LSMs providing xattrs. Do it so that the required changes are done only in
> one place.

Only security_inode_init_security() has support for EVM.   Making
security_old_inode_init_security() a wrapper for
security_inode_init_security() could result in security.evm extended
attributes being created that previously weren't created.

In fact ocfs2 defines ocfs2_init_security_get() as a wrapper for both
the old and new inode_init_security calls based on the caller's
preference.   Only mknod and symlink seem to use the old function. 
Wondering why do they differentiate between callers?  (Cc'ing the ocfs2
mailing list as they're affected by this change.)

"[PATCH v4 1/5] reiserfs: Add missing calls to
reiserfs_security_free()"  fixed a memory leak.  I couldn't tell if
there was a similar memory leak in ocfs2, the only other user of
security_old_inode_init_security().

As ocfs2 already defines initxattrs, that leaves only reiserfs missing
initxattrs().  A better, cleaner solution would be to define one.

thanks,

Mimi

> 
> Define the security_initxattrs() callback and pass it to
> security_inode_init_security() as argument, to obtain the first xattr
> provided by LSMs.
> 
> This behavior is a bit different from the current one. Before this patch
> calling call_int_hook() could cause multiple LSMs to provide an xattr,
> since call_int_hook() does not stop when an LSM returns zero. The caller of
> security_old_inode_init_security() receives the last xattr set. The pointer
> of the xattr value of previous LSMs is lost, causing memory leaks.
> 
> However, in practice, this scenario does not happen as the only in-tree
> LSMs providing an xattr at inode creation time are SELinux and Smack, which
> are mutually exclusive.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>b

