Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D601173BA36
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jun 2023 16:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjFWObM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jun 2023 10:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjFWOas (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jun 2023 10:30:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FC5271F
        for <linux-integrity@vger.kernel.org>; Fri, 23 Jun 2023 07:30:39 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NEC4mE015374;
        Fri, 23 Jun 2023 14:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=PU9NOrXfsn17oMAxzbm3e8tk78+vX8e9W88WCs+NdBs=;
 b=iv6gJ7QbQaTzhEnMUSpd/hARX/6eALTGis54YUUN1LZBfHlIYh2dT7Rzyhlsb4tC+yqK
 x4eCTKmYqo7DTsVUbp0mxloXRD5e9dOlr7T0IoVLAlgnabN+4HD7kI5IhuN0oaVVnCP9
 a6w7a8DKpJFneA/hIvI2YCEdjNlJMbvD5yoq5iEqIBHypybbkWVbZqa0OU0GW2hMmFOO
 nfNKwTgcgZ0zMW1ym1Tyf5pht2Sr/NJfm3/jI9XMLI69fH5WrQfpXI1zX658CsHUstD4
 y1PNX4/6yqUqsVxTo5aKFhlz2GJ2t8D+tnbMBQTXC2rW4qnwE44I9C8vaDuHmM3Uc18b Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rdcxtggdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:30:19 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35NEEPTi023841;
        Fri, 23 Jun 2023 14:30:18 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rdcxtggdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:30:18 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35N4bcdw005581;
        Fri, 23 Jun 2023 14:30:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3r94f5jqvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:30:17 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35NEUG3x60948980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 14:30:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9424B5805E;
        Fri, 23 Jun 2023 14:30:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10A1158055;
        Fri, 23 Jun 2023 14:30:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.58.24])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 23 Jun 2023 14:30:15 +0000 (GMT)
Message-ID: <06d377cb2be8a23140c9f78c2d4dbf1bbcbef692.camel@linux.ibm.com>
Subject: Re: [PATCH v3 ima-evm-utils 4/4] Add simple tests to check EVM HMAC
 calculation
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 23 Jun 2023 10:30:15 -0400
In-Reply-To: <01135b4f26d4460179f3b7981d4736f73fa889ba.camel@huaweicloud.com>
References: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
         <20230616192358.314906-5-roberto.sassu@huaweicloud.com>
         <1f125e9153369f757749f0825e41a4685b9fe005.camel@linux.ibm.com>
         <01135b4f26d4460179f3b7981d4736f73fa889ba.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2bRk0QnwKnKcji5DfhFRWSn4KglmbCUF
X-Proofpoint-GUID: NH1ZCW3b4kYR4x6hiGGhwF_VZC5q31Z0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306230128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-06-23 at 13:45 +0200, Roberto Sassu wrote:
> On Fri, 2023-06-23 at 07:42 -0400, Mimi Zohar wrote:
> > Hi Roberto,
> > 
> > On Fri, 2023-06-16 at 21:23 +0200, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Add a simple test to ensure that the kernel and evmctl provide the same
> > > result for the HMAC calculation. Do it with SELinux or Smack, whichever is
> > > available (if the UML kernel is used, the test is done with both LSMs).
> > > 
> > > Also add another test to evaluate the HMAC on a directory for which Smack
> > > added the SMACK64TRANSMUTE xattr.
> > > 
> > > The second test fails without the kernel patch 'smack: Set the
> > > SMACK64TRANSMUTE xattr in smack_inode_init_security()', as Smack uses
> > > __vfs_setxattr() to set SMACK64TRANSMUTE, which does not go through EVM,
> > > and makes the HMAC invalid.
> > > 
> > > Require (unless the UML kernel is used) that the TST_EVM_CHANGE_MODE
> > > environment variable is set to 1, so that users acknowledge that they are
> > > initializing EVM with a well-known HMAC key, which can introduce obvious
> > > security concerns.
> > > 
> > > Finally, enable SELinux, the EVM additional xattrs, and encrypted keys with
> > > user-decrypted data in the kernel configuration for CI, and set
> > > TST_EVM_CHANGE_MODE to 1 in the Github Action workflow.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > The simple SELinux and Smack tests are working properly without kernel
> > changes.  Even the Smack transmute test is working is proplery
> > returning an error message, but is followed by a kernel panic.
> > 
> > Possibly missing patches:
> >  - smack: Set the SMACK64TRANSMUTE xattr in smack_inode_init_security
> 
> Hi Mimi
> 
> that means that the test is failing.
> 
> A UML kernel panic is used to signal to the caller that a test in that
> environment failed.

Thank you for the clarification.  That explains why I couldn't
reproduce it locally.  Including a traceback like this though is kind
of ugly.

-- 
thanks,

Mimi

