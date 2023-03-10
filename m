Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C086B510A
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 20:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCJTiY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 14:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCJTiX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 14:38:23 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CF5CDC0
        for <linux-integrity@vger.kernel.org>; Fri, 10 Mar 2023 11:38:21 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AIYSaE026425;
        Fri, 10 Mar 2023 19:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=ucp0WTqS3CXn/BP3sltHvorA32lfOhDq4gCG85+aRp8=;
 b=l2JiS2lFimWIv27FbEq3S4BhlIHYiTVEJ6EW4FQvUNaqgU4hKSOzc2knayU61JebV2E2
 kRGI4LaJVfJH85YYELpZfZ3zbeCJPx71GZcXIs78cMCwzmV4KiD/HdZfEGS/w8twR2iI
 m3q/NjoWltWTurzjNdckjwBoEaRRmI6GBnYrDnYPKiK5JkRZFZsnTlEGL42ACT/pcnR3
 bJTqO39bTjma5pxSiW63wL6werO/3bHkJ3HivJcBfZQj6SacFJHDIGr3CGXo57bIRmoB
 M0ViiTCLrQM71KitAT9o2eyQ7FnPOKxF6zA/BR5uaqL3SU26rbJ9KT2EIMhq8Di2TOVA Wg== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p89xv9asr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 19:38:18 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32AHk2I6022860;
        Fri, 10 Mar 2023 19:38:17 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3p6fky4sh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 19:38:17 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32AJcG8Y40436200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 19:38:16 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E79CE5804E;
        Fri, 10 Mar 2023 19:38:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 484F35803F;
        Fri, 10 Mar 2023 19:38:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.71.208])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 19:38:15 +0000 (GMT)
Message-ID: <fee39e794cec39474b54d5a3da3a79e40acdce47.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] fsverity.test: Add /usr/sbin into $PATH
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Date:   Fri, 10 Mar 2023 14:38:14 -0500
In-Reply-To: <20230310104729.32078-1-pvorel@suse.cz>
References: <20230310104729.32078-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Roe1m8IyRRHWuS-FG2u6jicS2gDvLtyn
X-Proofpoint-GUID: Roe1m8IyRRHWuS-FG2u6jicS2gDvLtyn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-03-10 at 11:47 +0100, Petr Vorel wrote:
> Unlike GitHub CI, tests which run by packaging tools often run as non-root,
> thus required tools aren't visible:
> 
> ./functions.sh: line 45: type: mkfs: not found
> mkfs is required for test
> ./functions.sh: line 45: type: blkid: not found
> blkid is required for test
> ./functions.sh: line 45: type: e2fsck: not found
> e2fsck is required for test
> ./functions.sh: line 45: type: tune2fs: not found
> tune2fs is required for test
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Mimi,
> 
> some would maybe appreciate option to skip all tests,
> but this is enough for me.

Hi Petr,

Thank you for the patch.  It's now queued in next-testing.

The UML kernel opens up a lot of options going forward.  For now all
the tests are lumped together, but they should be separated based on
ima-evm-utils selftests vs. the kernel tests.  Even that might not be
granular enough.

For now from the command line, the environment variable "TESTS"
overrides the set of tests as defined in the Makefile to execute.  For
example, "export TESTS="ima_sign.test sign_verify.test"; make -e check"
executes just the two tests.

Also commit b573b7d4a186 ("Introduce TST_LIST variable to select a test
to execute")  can define the set of tests to execute.

-- 
thanks,

Mimi

