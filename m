Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ECE6365A6
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Nov 2022 17:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbiKWQXj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Nov 2022 11:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbiKWQXh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Nov 2022 11:23:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B214788FA1;
        Wed, 23 Nov 2022 08:23:35 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANEf8LX026039;
        Wed, 23 Nov 2022 16:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=DGIE0IcQ/4Ob6lIB9Xu6gY2wRn88lzgW3JmHywvHzKA=;
 b=hKMi4em2yrex+9WFg6mkd4/u+MFEF25CWOax2DqMDNRabnG05st9JP2dlFR3UQPWS0iJ
 cReqe+AjYto7WBrqkhmsnD/iZOZTbxt3VRmWY574QVbpn0LInmZRjnfpfjZGInoUWQ/2
 uUmqcCwJI+y922b2xrmjR+cngRdBbqO6HLHFQdkF9h/WK93zqUaKst0LmWJrelPgAna3
 mH7jZzjJ5VUrPR4g9yKvD6VmrkBeX/vAMlKV96nA1AaPAds/elFZePuoX/RhqIlqzt41
 BbV9+w0pmwlxHepYFue1BcrWcFEN4vFxnH0LGlsk7kVI5VZ2Oo7+HM2dC3mReTa/A870 bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10bmjku9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:23:04 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANFg69c013438;
        Wed, 23 Nov 2022 16:23:04 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10bmjktb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:23:04 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ANGLBuu004741;
        Wed, 23 Nov 2022 16:23:02 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01wdc.us.ibm.com with ESMTP id 3kxps9ktwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 16:23:02 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ANGN1YO8651402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 16:23:01 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 730A95805D;
        Wed, 23 Nov 2022 16:23:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C0565804C;
        Wed, 23 Nov 2022 16:23:00 +0000 (GMT)
Received: from sig-9-77-136-225.ibm.com (unknown [9.77.136.225])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 23 Nov 2022 16:22:59 +0000 (GMT)
Message-ID: <33329a29d779096e043f53c681f26ef32b093e5c.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/6] evm: Do HMAC of multiple per LSM xattrs for new
 inodes
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
Date:   Wed, 23 Nov 2022 11:22:59 -0500
In-Reply-To: <20221123154712.752074-1-roberto.sassu@huaweicloud.com>
References: <20221123154712.752074-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gGxC9VOl9iTb8JqDCP4RJSooTQ4VCFwN
X-Proofpoint-GUID: rH_XQgNnZzUltVo6EvwgnVCTjKT_8wZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_09,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211230119
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
> The second problem this patch set addresses is the limitation of the
> call_int_hook() of stopping the loop when the return value from a hook
> implementation is not zero. Unfortunately, for the inode_init_security hook
> it is a legitimate case to return -EOPNOTSUPP, but this would not
> necessarily mean that there is an error to report to the LSM infrastructure
> but just that an LSM does not will to set an xattr. Other LSMs should be
> still consulted as well.

This is just a heads up.  In reviewing the ocfs2 v5 patch, I realized
the meaning of -EOPNOTSUPP is being overloaded to mean multiple things.
Originally, -EOPNOTSUPP meant that the file system didn't implement
xattr support.  Now, it is being used to also mean no LSM xattr.  In
the former case, none of the LSM xattrs would be written.  In the
latter case, some of them will be written.

I'm not convinced that overloading the -EOPNOTSUPP is a good idea.  
Still reviewing the patch set...

-- 
thanks,

Mimi

