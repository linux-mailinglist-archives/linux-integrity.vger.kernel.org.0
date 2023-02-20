Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214B869C91D
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Feb 2023 11:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjBTK54 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Feb 2023 05:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjBTK5w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Feb 2023 05:57:52 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D532125A3;
        Mon, 20 Feb 2023 02:57:27 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KAnoC2022110;
        Mon, 20 Feb 2023 10:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=RuzZ1LW5t4JYUC60YV0IWi615mVUaWtO9PEMu1O1wdg=;
 b=ecqfE4SNr0Wg0hXNLh+6ZHNcFWlPtdeHf4BVtHEoDppk5NJSfiup/odQYO7Cm3P0b0eV
 h+lMgrztrCDCJMeqRDVkqF469WINMOV22NAfcJsplA9tXZ8wXJntHRusjalRGGfPGNQw
 sYv/uFheiKjGarQWmCNPPNEOgCw71qseA8zF7NtEYvvT8kPNshURsnE7xyL3VpAPu4+r
 IoEk4dd1Mnp1diHNr9kE13cjVrJNMhhKilGL7/gjoFXMNWt2a9mzAtm1o+ebumCcJafh
 uIuxZR0DwPiZMucrlo1ir5YfvkByErYgTTK8RxSdkkAsL62MfLXu2pTMmrdbO2WGYtB7 LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv7f1r3a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 10:57:00 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31KAuRoK012669;
        Mon, 20 Feb 2023 10:56:59 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv7f1r3a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 10:56:59 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31K9AdM3024314;
        Mon, 20 Feb 2023 10:56:58 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa6mrr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 10:56:58 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KAuvY311797204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 10:56:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6579958059;
        Mon, 20 Feb 2023 10:56:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85BD75805D;
        Mon, 20 Feb 2023 10:56:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.169.160])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 10:56:55 +0000 (GMT)
Message-ID: <7bea1e47e85f8cb340a6ec4f7c04bc5e17c31b99.camel@linux.ibm.com>
Subject: Re: [PATCH v7 6/6] evm: Support multiple LSMs providing an xattr
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
Date:   Mon, 20 Feb 2023 05:56:54 -0500
In-Reply-To: <ab9245bfb43b96fd8eded8a4ca25f5cae20b9f04.camel@huaweicloud.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
         <20221201104125.919483-7-roberto.sassu@huaweicloud.com>
         <1f252850086a39e3c15736f252600d388f6b9c24.camel@linux.ibm.com>
         <ab9245bfb43b96fd8eded8a4ca25f5cae20b9f04.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 82NZwVk2ZQX5HCqamBiCfh7AF6WB6sOR
X-Proofpoint-GUID: 00LUT_URR8UL6-6HlIeAEramnBEQD5Rg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-02-20 at 10:49 +0100, Roberto Sassu wrote:
> On Sun, 2023-02-19 at 14:42 -0500, Mimi Zohar wrote:
> > On Thu, 2022-12-01 at 11:41 +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Currently, evm_inode_init_security() processes a single LSM xattr from
> > > the array passed by security_inode_init_security(), and calculates the
> > > HMAC on it and other inode metadata.
> > > 
> > > Given that initxattrs() callbacks, called by
> > > security_inode_init_security(), expect that this array is terminated when
> > > the xattr name is set to NULL, reuse the same assumption to scan all xattrs
> > > and to calculate the HMAC on all of them.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > 
> > Normally changing the contents of the EVM HMAC calculation would break
> > existing systems.  Assuming for the time being this is safe, at what
> > point will it affect backwards compatability?  Should it be documented
> > now or then?
> 
> Actually, the current patch set continues to fullfill user space
> expectation on the EVM behavior. If the LSM infrastructure created more
> xattrs and EVM calculated the HMAC on just one, there would be a
> problem on subsequent xattr operations and on IMA verification.
> 
> By updating both the LSM infrastructure and EVM to support multiple
> xattrs, everything will continue to work.

Agreed.  Thank you for the reminder of the bug report being addressed
by this patch set.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

-- 
thanks,

Mimi

