Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F20667791
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 15:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbjALOpe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 09:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239959AbjALOov (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 09:44:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069C551D4
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 06:33:06 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CEK7P3027607;
        Thu, 12 Jan 2023 14:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=voRyZCXflP+9zzmoOnLus4UQaTWISfo/beMuPDesy0g=;
 b=Ciw7507amsUuS7ZUNMbrBta9JajPj2mL+QGFY5tlpZj9Z/4vohSY7tvTyI0VSTUs9VqE
 DWH0AuVn2B8kvkkjP0FzCuJistCQbhDgB50vzr46NXkxSe7DSFnhagqwd2ti0ZMtJ+RR
 HxS1pMfR8LIkF2v6S+l901dk0Etj6jeLAAW7r7QYCTrKAuVOeVRHbXt4ZFb6qzwtHn82
 TsSfEtfiTxNSZIm7zkv2I3pX9OfK5WVoFDxS5q5sqivA8hmVglXEgKgv4j4d6tLgAcfL
 h6ggVcNlX5kvFCAtyWPGwYLgVmEfJodizGhJ7tOdzvF+SspSyvYrhzdbPZthsEv8MY/b +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2kvmr9y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 14:32:37 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30CEM33N032698;
        Thu, 12 Jan 2023 14:32:37 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2kvmr9x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 14:32:37 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30CEC9IV018953;
        Thu, 12 Jan 2023 14:32:34 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3n1knv1pcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 14:32:34 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CEWXXS1311310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 14:32:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56FF958054;
        Thu, 12 Jan 2023 14:32:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2928C5805A;
        Thu, 12 Jan 2023 14:32:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.60.72])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jan 2023 14:32:32 +0000 (GMT)
Message-ID: <dea102f0039af12d3eb4f1e1961096c157624d7c.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2 0/9] Support testing with UML kernel
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 12 Jan 2023 09:32:31 -0500
In-Reply-To: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a4rKSubY1Wi5WD6OuOc2jK0PM4OxnTvE
X-Proofpoint-GUID: GSZcqK1Q52YWcphwTSwIJBjxpdbv6a6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-01-12 at 13:24 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> UML kernels differ from other kernels for the ability of being executed as
> processes in the current environment, without requirements such as
> virtualization. It is sufficient to execute the binary, like the other
> binaries.
> 
> In addition, UML kernels have the ability to see the host filesystem and
> thus they could for example run an executable from the host as init and
> have a fully working system without creating an image, as it would happen
> if a regular virtual machine is used.
> 
> These features make UML kernels very suitable for integration in existing
> test suites designed to perform the tests in the current environment such
> as ima-evm-utils. In the current environment, test suites cannot test new
> functionality not yet integrated in the host kernel, or with custom kernel
> configuration options not usually enabled in production. Also, test suites
> might not be able to set/reset kernel settings for security reasons.
> 
> With the ability to do kernel testing more in depth, ima-evm-utils might
> introduce specific tests for that, separated from the tests to verify the
> ima-evm-utils user space functionality. At the moment, there is no such
> distinction, existing tests verify both.
> 
> The goal of this patch set is to overcome the limitations by making the
> test suite in ima-evm-utils able to run in an environment created by the
> UML kernel, with minimal changes. At the same time, it will preserve the
> ability of the test suite to run in the current environment.
> 
> First, fix error messages and a variable in evmctl. Then, add the
> config-uml file with custom kernel configuration options for the tests, to
> be merged with the default configuration. Add a new job in the Github
> workflow to build the UML kernel from a repository and branch specified in
> the LINUX_URL and LINUX_BRANCH variables. Per Github documentation, these
> variables can be defined at organization, repository and environment level.
> 
> Introduce a new API for using UML kernels for existing and new test
> scripts. Unless the environment variable UML_MODE is set to 1, calling the
> API results in a nop, and tests are executed in the current environment.
> 
> Add the possibility to select individual tests to run in a test script,
> with the TST_LIST variable, so that the UML kernel can be launched multiple
> times with a subset of tests (useful if for example a test require kernel
> settings different from the previous test).
> 
> Add tests for EVM portable signatures supporting UML kernels and port
> fsverity.test to use UML kernels.
> 
> Finally, don't require making changes to the system to run fsverity.test
> and install a software dependency after the appropriate repository has been
> set up.

Thank you, Roberto!   The UML support should simplify testing new
kernel features before they are upstreamed and/or configured/enabled by
the distros.  Building a UML kernel is relatively quick (~8 minutes). 
With the UML kernel and image caching, the impact should be minimal.

Once everyone has had a chance to review, comment, and test this patch
set, we'll release a new version of ima-evm-utils.

thanks,

Mimi
> 
> Mimi Zohar (1):
>   ci: haveged requires EPEL on CentOS stream:8
> 
> Roberto Sassu (8):
>   Fix error messages and mdlen init in calc_evm_hmac()
>   Add config for UML kernel
>   Compile the UML kernel and download it in Github Actions
>   Add support for UML in functions.sh
>   Introduce TST_LIST variable to select a test to execute
>   Add tests for EVM portable signatures
>   Adapt fsverity.test to work with UML kernel
>   Use in-place built fsverity binary instead of installing it
> 
>  .github/workflows/ci.yml        |   96 ++-
>  build.sh                        |    5 +
>  ci/fedora.sh                    |   12 +-
>  config-uml                      |  235 +++++++
>  src/evmctl.c                    |    8 +-
>  tests/Makefile.am               |    2 +-
>  tests/fsverity.test             |   18 +-
>  tests/functions.sh              |   91 ++-
>  tests/install-fsverity.sh       |    2 +-
>  tests/install-mount-idmapped.sh |    7 +
>  tests/portable_signatures.test  | 1173 +++++++++++++++++++++++++++++++
>  11 files changed, 1637 insertions(+), 12 deletions(-)
>  create mode 100644 config-uml
>  create mode 100755 tests/install-mount-idmapped.sh
>  create mode 100755 tests/portable_signatures.test
> 


