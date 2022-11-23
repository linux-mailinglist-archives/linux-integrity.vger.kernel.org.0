Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A74D635CEE
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Nov 2022 13:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbiKWMae (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Nov 2022 07:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbiKWMaM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Nov 2022 07:30:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E109A6035E;
        Wed, 23 Nov 2022 04:28:59 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANBIivN010202;
        Wed, 23 Nov 2022 12:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=z6Z//LUT0fOyn/j0x1lDLd1Mhd5eIGzmBSNnRr9ZuF8=;
 b=IqzRD4WR9jzHU0/inl9phbRdTIC68a/YMhn4PsPPnZjzrTYotc7UiHLU8znqVJO8yY8D
 QtmKtjYlGfrmqztS42seEwgmCxBbf5NVKXHnH0yLlOYg01btx/1d8lf+NWrT+kk+IEdz
 2rsnkXf3tf5qnMVDqft8/EXkLSjU4Qdrt2IDzqtz6VGi4WnaVW+u+IPOIbZqZya5h7l0
 EYl1pJ/5iYKpT12tX7krp+LgQdB8bJXfTIiPTBYIHGcy4f64BPGkC7QsshT5tvK23G25
 Ax6iaLX/lrtfmbd9QSfYGaufkDHF7SWqtnxuE46abOXjKzMwLz86iD8XRFhz9zDmS6vC pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10bmc6xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 12:28:24 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANCB7Rj000419;
        Wed, 23 Nov 2022 12:28:24 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10bmc6x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 12:28:24 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ANCKivp007274;
        Wed, 23 Nov 2022 12:28:22 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 3kxpsa2n9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 12:28:22 +0000
Received: from smtpav04.dal12v.mail.ibm.com ([9.208.128.131])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ANCSN0N15860336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 12:28:23 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66ED158062;
        Wed, 23 Nov 2022 12:28:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E822D58056;
        Wed, 23 Nov 2022 12:28:19 +0000 (GMT)
Received: from sig-9-77-136-225.ibm.com (unknown [9.77.136.225])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 23 Nov 2022 12:28:19 +0000 (GMT)
Message-ID: <ccf1937cfdcc5bb28dcc7a58785dd0c65d974597.camel@linux.ibm.com>
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
Date:   Wed, 23 Nov 2022 07:28:19 -0500
In-Reply-To: <20221123095202.599252-1-roberto.sassu@huaweicloud.com>
References: <20221123095202.599252-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oBm4YhWVDMgDFAsmIXTxmThFBoavwbiU
X-Proofpoint-GUID: ZMkr4dv6vUdyqaWwpUypXc6juADcdq3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_06,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=703 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211230090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Wed, 2022-11-23 at 10:51 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> One of the challenges that must be tackled to move IMA and EVM to the LSM
> infrastructure is to ensure that EVM is capable to correctly handle
> multiple stacked LSMs providing an xattr at file creation. At the moment,
> there are few issues that would prevent a correct integration. This patch
> set aims at solving them.

Let's take a step back and understand the purpose of this patch set. 
Regardless of whether IMA and EVM are moved to the "LSM
infrastructure", EVM needs to support per LSM xattrs.  A side affect is
the removal of the security_old_inode_init_security hook.  This patch
set cover letter and patch descriptions should be limited to EVM
support for per LSM (multiple) xattrs.  The motivation, concerns, and
problems of making IMA and EVM LSMs will be documented in the patch set
that actual makes them LSMs.  Please remove all references to "move IMA
and EVM to the LSM infrastructure".

When EVM was upstreamed, there were filesystem limitations on the
number and size of the extended attributes.  In addition there were
performance concerns, which resulted in staging the LSM, IMA and EVM
xattrs, before calling initxattrs to write them at the same time.  With
this patch set, not only are per LSM xattrs supported, but multiple per
LSM xattrs are supported as well.  Have the size limitation concerns
been addressed by the different filesystems?   If not, then at minimum
this patch set needs to at least mention it and the possible
ramifications.

-- 
thanks,

Mimi

