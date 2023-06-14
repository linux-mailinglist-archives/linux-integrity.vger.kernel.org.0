Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2459373083D
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jun 2023 21:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFNTaD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jun 2023 15:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbjFNTaC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jun 2023 15:30:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8AA106
        for <linux-integrity@vger.kernel.org>; Wed, 14 Jun 2023 12:30:00 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EJMLtU026032;
        Wed, 14 Jun 2023 19:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=oMeWuIRb2v1Wtosju4lmEmLbi7qgDqAyKmleOPwDmgo=;
 b=lNe0AghXiQT/aOM5NfiTMhqPhz9qNJER+BSF5iMRKK17k3wzeBSpnSUIQd8VK2VSDBBS
 o2ok4FWoodxPwMs1/fkv14yb1ESvkgSkvMCa65MUUHBNRv+de5I82L9Q+0vGYCAbSHET
 UWnwZvs9nc7aNpBIZDBnq7LMykEevft2AUf3Zz+K4XuM1sxqbCO7tz6/8F46iR48P68I
 T/nJesrsUDrIxwjm+3l9zzJRO7Tr6mZd9YD1aCnBOHyD+RWzQt4qCjk4Z22p64uuIl1T
 M3uOVGo+4dD3Wdwvb14fbI6fl8rVYttqH9GFk5lHdcIG2ZbLPiA1XqdFqnF61MmKpnBp WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7kn0r3wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 19:29:36 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35EJQmBN007421;
        Wed, 14 Jun 2023 19:29:35 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7kn0r3wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 19:29:35 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35EGkAvl014145;
        Wed, 14 Jun 2023 19:29:35 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3r4gt5q723-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 19:29:35 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35EJTXUA3670732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 19:29:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8D955805A;
        Wed, 14 Jun 2023 19:29:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BF5858051;
        Wed, 14 Jun 2023 19:29:33 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.19.215])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 14 Jun 2023 19:29:33 +0000 (GMT)
Message-ID: <44039a0f827e23f5714ac2461c86af494510f81c.camel@linux.ibm.com>
Subject: Re: [PATCH v2 ima-evm-utils 0/4] Simple EVM HMAC calculation tests
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 14 Jun 2023 15:29:32 -0400
In-Reply-To: <20230605165554.1965238-1-roberto.sassu@huaweicloud.com>
References: <20230605165554.1965238-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9D2cv1F7rQ2pl_-bc0zRIY83FMyP3D8W
X-Proofpoint-GUID: Poim4t7pKNtLfFmpxbwi-hNM7uQ0vvIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 mlxlogscore=738 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306140167
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Mon, 2023-06-05 at 18:55 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add two simple tests to check whether or not the HMAC calculated by the
> kernel and evmctl matches. Do the tests for a regular file, and for a
> directory successfully transmuted with Smack.
> 
> Also add two bug fixes to include the filesystem UUID and the inode
> generation in the HMAC calculation, and the new option --hmackey to specify
> an alternate location of the HMAC key.

The main purpose for having a "Simple EVM HMAC" test is to ensure that
nothing breaks.

"evmctl --hmac" was only enabled in debug mode, since the hmac key was
not exposed to userspace.  It was never really used.  With the ability
of creating an encrypted key based  on user-provided decrypted data,
verifying the EVM hmac is now feasible.  This is the justification for
"Add --hmackey option for evmctl".

The initial test should work with either SELinux or smack extended
attributes.  None of the CI tests have SELinux or Smack enabled, except
for the UFI kernel.  Verifying the EVM hmac with an SELinux extended
attribute is not being tested.  On my local machine, the EVM HMAC with
SELinux xattr is failing.  Is this related to SELinux returning
different lengths in the kernel vs. userspace?  Whatever the reason, it
needs to be fixed.

The prereqs needed for running the Smack transmute test should not
prevent running the first test.

-- 
thanks,

Mimi

