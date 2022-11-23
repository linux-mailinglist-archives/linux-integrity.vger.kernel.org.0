Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65426635F86
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Nov 2022 14:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbiKWN2q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Nov 2022 08:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbiKWN2N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Nov 2022 08:28:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161B9CE6;
        Wed, 23 Nov 2022 05:07:27 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANBqfnO029536;
        Wed, 23 Nov 2022 13:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=vDySJw+RE1dcnmUvFnvraOg2YS5K9nq98jTHqlpHG18=;
 b=RczVDxgd1m7SeAvqgYnIhMYTied/i9m6YC+mlJUUMkN2R7PXui+VjLg8iYe06fhz515I
 OqGZrXAKGUKvZSfH4eRGeuL9BUr7vzUKvDPf7VLXmDGwxD/d7hDh8itl9rzs/V5VZBUY
 6xndXZOIMDiLX5xtX3up8kNWqtPJoFtkXjdw2ck5REJ5p5h3ovFUqtpk2ik/XFUfUkOI
 MsIEVYv/GJt6L3qSw1l+n3/uUBOjfoVuO/0XfaMfeeHDQn2Ae02cvsL7J9l+gXubmes1
 PrOli1HGa52SmNq7H4OIKo2oBqI62KMDF0OnwXbJSHjyoBP+Pa/i/kQUsabs8j8y5roN Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m100sx5u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 13:06:43 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANCMvBk019999;
        Wed, 23 Nov 2022 13:06:43 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m100sx5tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 13:06:42 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AND55os006704;
        Wed, 23 Nov 2022 13:06:42 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma05wdc.us.ibm.com with ESMTP id 3kxpsaatrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 13:06:41 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AND6e7462521762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 13:06:41 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEAAD5806A;
        Wed, 23 Nov 2022 13:06:40 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA81458068;
        Wed, 23 Nov 2022 13:06:38 +0000 (GMT)
Received: from sig-9-77-136-225.ibm.com (unknown [9.77.136.225])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 23 Nov 2022 13:06:38 +0000 (GMT)
Message-ID: <bddfe0f41b05dd8efd6991487ff2525a8503dd84.camel@linux.ibm.com>
Subject: Re: [PATCH v5 0/6] evm: Prepare for moving to the LSM infrastructure
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
Date:   Wed, 23 Nov 2022 08:06:38 -0500
In-Reply-To: <22f47b9d2cade322f9037133b0940640423f9590.camel@huaweicloud.com>
References: <20221123095202.599252-1-roberto.sassu@huaweicloud.com>
         <ccf1937cfdcc5bb28dcc7a58785dd0c65d974597.camel@linux.ibm.com>
         <22f47b9d2cade322f9037133b0940640423f9590.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g8iVzqKvqnZweL4uK7PVONw5TCHSZocC
X-Proofpoint-ORIG-GUID: ublx2DxYo-xcTO2ADIcDK12PkrS3VB67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_06,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=802 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-11-23 at 13:44 +0100, Roberto Sassu wrote:
> On Wed, 2022-11-23 at 07:28 -0500, Mimi Zohar wrote:
> > Hi Roberto,
> > 
> > On Wed, 2022-11-23 at 10:51 +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > One of the challenges that must be tackled to move IMA and EVM to the LSM
> > > infrastructure is to ensure that EVM is capable to correctly handle
> > > multiple stacked LSMs providing an xattr at file creation. At the moment,
> > > there are few issues that would prevent a correct integration. This patch
> > > set aims at solving them.
> > 
> > Let's take a step back and understand the purpose of this patch set. 
> > Regardless of whether IMA and EVM are moved to the "LSM
> > infrastructure", EVM needs to support per LSM xattrs.  A side affect is
> > the removal of the security_old_inode_init_security hook.  This patch
> > set cover letter and patch descriptions should be limited to EVM
> > support for per LSM (multiple) xattrs.  The motivation, concerns, and
> > problems of making IMA and EVM LSMs will be documented in the patch set
> > that actual makes them LSMs.  Please remove all references to "move IMA
> > and EVM to the LSM infrastructure".
> 
> Hi Mimi
> 
> ok, will do.
> 
> > When EVM was upstreamed, there were filesystem limitations on the
> > number and size of the extended attributes.  In addition there were
> > performance concerns, which resulted in staging the LSM, IMA and EVM
> > xattrs, before calling initxattrs to write them at the same time.  With
> > this patch set, not only are per LSM xattrs supported, but multiple per
> > LSM xattrs are supported as well.  Have the size limitation concerns
> > been addressed by the different filesystems?   If not, then at minimum
> > this patch set needs to at least mention it and the possible
> > ramifications.
> 
> With your patch, 9d8f13ba3f483 ("security: new
> security_inode_init_security API adds function callback") you made it
> possible to set multiple xattrs at inode creation time.

True, and even then there were concerns.

> This patch set pushes further to the limits, as there could be more
> xattrs to be added to the inode. I will mention that.

Thanks

> If there are too many xattrs, I guess the only solution would be to use
> less LSMs, or a different filesystem. The per filesystem limit could be
> increased separately case by case.

Agreed, but unless it is documented somewhere, nobody but us will know
there is a potential problem.  At least document it here in the cover
letter, which we'll include in the merge message.

FYI, the xattr.7 man page contains a section "Filesystem differences".

-- 
thanks,

Mimi

