Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100B0683170
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 16:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjAaPZN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 10:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjAaPY6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 10:24:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0191715B
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 07:23:46 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VETxI8011337;
        Tue, 31 Jan 2023 15:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1JdKjjjp81vRUoPhwGMAsmrU9pGDWxQxODF3t8wa61Y=;
 b=bMvlYLxYuiZRmmA1tI87aTgAgQFc2RbRWZbyp7LWtG+LGwc43mLN5zccnd27A5zRGkH4
 jUbcSt9wlIW7R6V+Vg8+i3nf7MQpET1fXP/yEOEuzyIDWgN/EO7kZVfCIjmaee7J6fQk
 E+ZM1o6T410+Hb7Fdw5Z8lRJrPuV7S+awzKz/mlAqeEfloMFrME9bg/S58H5iMd4ObVr
 7rs+lsosoD1cbyyMlYdTwWkf1nX7tEYe5K69iMOWtBrCL5r+hqPBpY5dhVD7oRYZFkpb
 +GGVJNWX2NqRBl6mYrfxxE1FisRjETAChmIzN+wBUDcGvZYXajEofelQnFeQ8zGV4K6q pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf4t99fyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:23:01 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VFG2XF005138;
        Tue, 31 Jan 2023 15:23:01 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf4t99fxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:23:01 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VDW0RS006481;
        Tue, 31 Jan 2023 15:23:00 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3ncvtmcrcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:23:00 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VFMwGt65405438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 15:22:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 829B158058;
        Tue, 31 Jan 2023 15:22:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBD1E58054;
        Tue, 31 Jan 2023 15:22:57 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.114.140])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 15:22:57 +0000 (GMT)
Message-ID: <720bce89d29c3be648ef5acce3e6181c210381fd.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Introduce expect_pass_if() and
 expect_fail_if()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 31 Jan 2023 10:22:55 -0500
In-Reply-To: <20230131085955.2312243-1-roberto.sassu@huaweicloud.com>
References: <20230131085955.2312243-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LxuAnnpky7txwk6LRYIDL93x8y54JsOX
X-Proofpoint-GUID: ES1RPCF3jHPaQYlzK2XUs6SI3YLaZLCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=831 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-01-31 at 09:59 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Introduce these functions to let the developer specify which kernel patches
> are required for the tests to be successful (either pass or fail). If a
> test is not successful, print those patches in the test result summary.
> 
> First, the developer should declare an array, named PATCHES, with the list
> of all kernel patches that are required by the tests. For example:
> 
> PATCHES=(
> 'patch 1 title'
> ...
> 'patch N title'
> )
> 
> Second, the developer could replace the existing expect_pass() and
> expect_fail() respectively with expect_pass_if() and expect_fail_if(), and
> add the indexes in the PATCHES array as the first argument, enclosed with
> quotes. The other parameters of expect_pass() and expect_fail() remain the
> same.
> 
> In the following example, the PATCHES array has been added to a new test
> script, tests/mmap_check.test:
> 
> PATCHES=(
> 'ima: Align ima_file_mmap() parameters with mmap_file LSM hook'
> 'ima: Introduce MMAP_CHECK_REQPROT hook'
> )
> 
> Then, expect_pass() has been replaced with expect_pass_if():
> 
> expect_pass_if '0' check_mmap "MMAP_CHECK" "read_implies_exec"
> 
> The resulting output when a test fails (if the required patch is not
> applied) is:
> 
> Test: check_mmap (hook="MMAP_CHECK", test_mmap arg: "read_implies_exec")
> Result (expect found): not found
> Possibly missing patches:
>  - ima: Align ima_file_mmap() parameters with mmap_file LSM hook
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Keeping it simple like this works for now.   Based on Stefan's previous
comments, the variable 'idx' should probably be defined as local.

Otherwise,
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

