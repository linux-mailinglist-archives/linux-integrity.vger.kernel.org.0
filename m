Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D016988D1
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 00:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBOXkS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Feb 2023 18:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBOXkR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Feb 2023 18:40:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98CF2ED45
        for <linux-integrity@vger.kernel.org>; Wed, 15 Feb 2023 15:40:16 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FNCIRl021180;
        Wed, 15 Feb 2023 23:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3lylpVDZ6zFIE93TWR6AvrVFAxJga/Tuybv0F76kmSU=;
 b=mDLXbz+5LV2zD0HqZX8eV+4DQJc0jRmztMA4IfgmpeiLXaynBEpfrFLdzNGRA0iKx/uU
 HJnM38RWsV2iKBa46bSVOCITMtG4iGHYW74oGP5X8zUsAxW/hx5hKrYk9l4FYELuohSX
 24h543MgAnr3QitdsSdTksF0QP9DJlLAImjmtAzb9lSZ4Xr3vrACQhR9Y9y7fWiO98my
 tp6KiFGGE6mXhpvJ2lxfaEwGnGqNqNScfPXwyiqUNA11NZQTPV2zc63Tg/7a3l8EjKEg
 yuBaCZN2LS7kqdt/tKjOKUI6ghb6vBJSaobMN8MHp+VFAGEfqWHWidYNAKAJmujmsz/D oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns8ur0e5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:39:57 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31FNOInF030593;
        Wed, 15 Feb 2023 23:39:56 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns8ur0e5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:39:56 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31FLAbc3009970;
        Wed, 15 Feb 2023 23:39:55 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3np2n7wkc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 23:39:55 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31FNdsk527394788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 23:39:54 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FCAF58050;
        Wed, 15 Feb 2023 23:39:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46DB958045;
        Wed, 15 Feb 2023 23:39:53 +0000 (GMT)
Received: from sig-9-65-193-223.ibm.com (unknown [9.65.193.223])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 23:39:53 +0000 (GMT)
Message-ID: <d09e5c3b35ff101a19598e73e65a623be484e147.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Add ima_policy_check.awk and
 ima_policy_check.test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 15 Feb 2023 18:39:52 -0500
In-Reply-To: <20230214152258.3553294-1-roberto.sassu@huaweicloud.com>
References: <20230214152258.3553294-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nw8Z-Y4N5Nx_ZDeYLXSeSVffIkWbOELm
X-Proofpoint-ORIG-GUID: mUfHUtHxsAojSy6zBMF-8d0iQz3Rj6UJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_14,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150200
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-02-14 at 16:22 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add ima_policy_check.awk to check for possible overlapping of a rule being
> added by a test with the existing IMA policy (policy replacement by IMA at
> the first policy load is not taken into account).
> 
> ima_policy_check.awk expects as input the rule to be added, followed by the
> IMA policy.
> 
> It returns a bit mask with the following values:
> - 1: invalid new rule;
> - 2: overlap of the new rule with an existing rule in the IMA policy;
> - 4: new rule exists in the IMA policy.
> 
> Values can be individually checked by the test executing the awk script, to
> determine what to do (abort loading, print a warning in case of overlap,
> avoid adding an existing rule).
> 
> The bit mask allows the test to see multiple statements regarding the new
> rule. For example, if the test added anyway an overlapping rule, it could
> also see that the policy already contains it at the next test execution,
> and does not add it again.
> 
> Since ima_policy_check.awk uses GNU extensions (such as the or() function,
> or the fourth argument of split()), add gawk as dependency for the CI.
> 
> Finally add ima_policy_check.test, to ensure that the awk script behaves as
> expected.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto, I dropped a couple of your patches from the "next-testing"
branch, assuming the "Introduce expect_pass_if() and expect_fail_if()" 
and this patch are prerequisites for the "Add tests for MMAP_CHECK and
MMAP_CHECK_REQPROT hooks" patch.

thanks,

Mimi

