Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDD730B99
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jun 2023 01:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbjFNXez (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jun 2023 19:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjFNXey (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jun 2023 19:34:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0991FDD
        for <linux-integrity@vger.kernel.org>; Wed, 14 Jun 2023 16:34:53 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ENXXIJ031179;
        Wed, 14 Jun 2023 23:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=OnpVTnoibSiypFogderHrj6rS1cTeSb28X2QhzoNgwg=;
 b=bl80pq1G8d2VoH9cItEzZchYbtcannuHR8IGVQB58aJu4u323AoovenlK8vCHQr0qRVu
 rDzKyMQa/iLVwnQxNu4xp0aB3tHrmHq+I6ja6EGLY+6kZLl3Av+6ZeAGsW4DyzxfSsqm
 tzSmMjbb/gHWBQ39njtgej1i9djbrTZiGwuLfttQkKVcx1XwkFnLp+qsV7TvzHNPx6Cf
 2TCQ8/rXwZgX1GHK60KdUK9mVZwgoOwHyehbbdGiYA/UxOBd7JVCTnQTOYaRm5ifBYDG
 cXtPeTgVx5+wTyaTeuqJ+OaX/a57IUYHF6YvV9IIMU2Kkgi7Rxg2mjPWKIg3Kyv6sanU uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7qb280uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 23:34:34 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35ENYXmm001636;
        Wed, 14 Jun 2023 23:34:33 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7qb280ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 23:34:33 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35EKrE2n002806;
        Wed, 14 Jun 2023 23:34:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3r4gt5r1tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 23:34:33 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35ENYWcd64291110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 23:34:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BB0258059;
        Wed, 14 Jun 2023 23:34:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2FCA58055;
        Wed, 14 Jun 2023 23:34:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.19.215])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 14 Jun 2023 23:34:31 +0000 (GMT)
Message-ID: <6687f854b892aa697d3c25284074d0821f0fc81f.camel@linux.ibm.com>
Subject: Re: [PATCH v2 ima-evm-utils 0/4] Simple EVM HMAC calculation tests
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 14 Jun 2023 19:34:31 -0400
In-Reply-To: <44039a0f827e23f5714ac2461c86af494510f81c.camel@linux.ibm.com>
References: <20230605165554.1965238-1-roberto.sassu@huaweicloud.com>
         <44039a0f827e23f5714ac2461c86af494510f81c.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VkKvXrrefnkZgKNyzl_J0BF_1ynbKh0h
X-Proofpoint-GUID: MyzYB-zERWtH8N4daefR_4ZVPlcZAHum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=621 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140206
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-06-14 at 15:29 -0400, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Mon, 2023-06-05 at 18:55 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add two simple tests to check whether or not the HMAC calculated by the
> > kernel and evmctl matches. Do the tests for a regular file, and for a
> > directory successfully transmuted with Smack.
> > 
> > Also add two bug fixes to include the filesystem UUID and the inode
> > generation in the HMAC calculation, and the new option --hmackey to specify
> > an alternate location of the HMAC key.
> 
> The main purpose for having a "Simple EVM HMAC" test is to ensure that
> nothing breaks.
> 
> "evmctl --hmac" was only enabled in debug mode, since the hmac key was
> not exposed to userspace.  It was never really used.  With the ability
> of creating an encrypted key based  on user-provided decrypted data,
> verifying the EVM hmac is now feasible.  This is the justification for
> "Add --hmackey option for evmctl".
> 
> The initial test should work with either SELinux or smack extended
> attributes.  None of the CI tests have SELinux or Smack enabled, except
> for the UFI kernel.  Verifying the EVM hmac with an SELinux extended
> attribute is not being tested.  On my local machine, the EVM HMAC with
> SELinux xattr is failing.  Is this related to SELinux returning
> different lengths in the kernel vs. userspace?  Whatever the reason, it
> needs to be fixed.

Testing the EVM hmac w/SELinux xattr is now working properly on a test
system, both with and without the "evm: Do HMAC of multiple per LSM
xattrs for new inodes" patch set.

> 
> The prereqs needed for running the Smack transmute test should not
> prevent running the first test.
> 

-- 
thanks,

Mimi

