Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2191F6A87C5
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCBRVg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 12:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjCBRVd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 12:21:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDDE37B69
        for <linux-integrity@vger.kernel.org>; Thu,  2 Mar 2023 09:21:20 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322Gp92w025759;
        Thu, 2 Mar 2023 17:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=8XBIfcyhwxF4hxgfQQeHcqwqWkLKAavbD40X47eC4Gc=;
 b=Vh0mWbaoXpequQZIchpUfodFqR1ajRiW24EWzi1kM34uc02SSzzkJknxNfBnyFC90fqD
 TQ05vHE0/l1ZgPSvXRt6LDAk6uSEE0LNHm+DZOgatYuUHGDysjOCnJylqU2S7TZhIysb
 IqVReChkRzzrIXbI/ORE63VK45gl+KXtFcJPnzn7caFbLd5o6adqHsZx4BsdzjZyBJBx
 13wcBWOWu4AajWoaAvU9bBFPPONA1CJUZZs5wlOcO6daj36uEyebDdqduHe0ygr73iXE
 r8/zJGr3ElgxFWdHcNA/jNnB42zQY2jSVaI/sjOLrGL4vhKLe3ZpRpl9XovIimpkDmvT Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2ypdgsvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 17:21:03 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 322HF1Ua008862;
        Thu, 2 Mar 2023 17:21:03 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2ypdgsuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 17:21:03 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 322G0Y3D017420;
        Thu, 2 Mar 2023 17:21:02 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3nybchwgjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 17:21:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 322HL13955968058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Mar 2023 17:21:01 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15CBF5805D;
        Thu,  2 Mar 2023 17:21:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D65E5805A;
        Thu,  2 Mar 2023 17:21:00 +0000 (GMT)
Received: from sig-9-65-219-109.ibm.com (unknown [9.65.219.109])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Mar 2023 17:21:00 +0000 (GMT)
Message-ID: <0407924e1ad9223eed20c9cc1e3ccf685519656c.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v6] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 02 Mar 2023 12:20:59 -0500
In-Reply-To: <20230301100822.232187-1-roberto.sassu@huaweicloud.com>
References: <20230301100822.232187-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: txFu4AHprACb7ybmIcESggI8CRzEusQx
X-Proofpoint-ORIG-GUID: o1f945V6WRPe8kUV3hQC8lw1rPjzbmIp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_09,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303020144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

> diff --git a/tests/mmap_check.test b/tests/mmap_check.test
> new file mode 100755
> index 00000000000..3a42fec179e
> --- /dev/null
> +++ b/tests/mmap_check.test
> @@ -0,0 +1,407 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2022-2023 Roberto Sassu <roberto.sassu@huawei.com>
> +#
> +# Check the behavior of MMAP_CHECK and MMAP_CHECK_REQPROT
> +
> +trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM SIGSEGV EXIT
> +
> +PATCHES=(
> +'ima: Align ima_file_mmap() parameters with mmap_file LSM hook'
> +'ima: Introduce MMAP_CHECK_REQPROT hook'
> +)
> +
> +(( ret_invalid_rule=1 ))
> +(( ret_rule_overlap=2 ))
> +(( ret_same_rule_exists=4 ))

New to v6 is the defintiion of these variables.   Is there a reason for
defining them here as opposed to in check_load_ima_rule(), where they
could be defined as local?   Here they're global and should be in upper
case like the the variables below.  
> +
> +(( EVM_INIT_HMAC=0x0001 ))
> +(( EVM_INIT_X509=0x0002 ))

Is there a reason for initializing these variables differently than
those below?  For example, EVM_INIT_HMAC could be define as
EVM_INIT_HMAC=$((0x0001)).

+# Base VERBOSE on the environment variable, if set.
> +VERBOSE="${VERBOSE:-0}"
> +
> +# Errors defined in test_mmap
> +ERR_SETUP=1
> +ERR_TEST=2

-- 
thanks,

Mimi

