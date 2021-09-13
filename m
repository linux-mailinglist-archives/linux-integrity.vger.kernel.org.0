Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E5C409A19
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 18:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbhIMQzr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 12:55:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240610AbhIMQzr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 12:55:47 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DFc4Hn015875
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 12:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MLuMKjra1nL2Re0/md2o8ECqXFmYdIygYd6KSu+3MfE=;
 b=CTabpi0HUyeIn50BV5xv9qGPDNEYNzr8p//eSsFTprcc3HV+ecHDx2R9S29NvWjKb4lj
 1ueKiayCNxFfqutJwezA4ZUcv38VNCXceuT8Y0DDO6Fa5y9r0Ys0vIap3ydzTdv8Ot25
 1qNAOzWWe+BSFD3EWm1iblyNVhh/a3io0UU9+DBkb/uDkGuZJI2H7zU0McJYddQwK1/6
 HATgVbCz7cvTYmgCg5GwCc4YiFhioLPq77su1j9hfBkPVvQxN50qY2xbCfg7DdKNaE89
 8DLo2NYc4DB45T0ZnMdOlTbSumlKeSsxmx48tIHo6sDruJzOvhX2D38EBbZOPJ3tqelM fg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b24fvhvw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 12:54:30 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DGrQ9N025774
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 16:54:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3b0m39j8mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 16:54:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DGsQR143843976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 16:54:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA4D642049;
        Mon, 13 Sep 2021 16:54:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B9674203F;
        Mon, 13 Sep 2021 16:54:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.27.52])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 16:54:25 +0000 (GMT)
Message-ID: <17f51584e691195b044d176eae43b121b6cb4775.camel@linux.ibm.com>
Subject: Re: [PATCH v3 7/9] tests: Import softhsm_setup script to enable
 pkcs11 test case
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 13 Sep 2021 12:54:24 -0400
In-Reply-To: <20210908192343.4147739-8-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
         <20210908192343.4147739-8-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fBGrrU5gVkI0aFpfps1q5_cwZ18iac6p
X-Proofpoint-ORIG-GUID: fBGrrU5gVkI0aFpfps1q5_cwZ18iac6p
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxlogscore=991 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130063
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-09-08 at 15:23 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Import softhsm_setup script from my swtpm project and contribute
> it to this project under dual license BSD 3-clause and GLP 2.0.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Stefan, for splitting this out from the other changes, making
it a separate patch.
> ---
>  tests/softhsm_setup | 297 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 297 insertions(+)
>  create mode 100755 tests/softhsm_setup
> 
> diff --git a/tests/softhsm_setup b/tests/softhsm_setup
> new file mode 100755
> index 0000000..fe69a6e
> --- /dev/null
> +++ b/tests/softhsm_setup
> @@ -0,0 +1,297 @@
> +#!/usr/bin/env bash
> +
> +# This program originates from 'swtpm' project (https://github.com/stefanberger/swtpm/)
> +# and is provided to ima-evm-utils under a dual license:
> +# - BSD 3-clause
> +# - GPL-2.0

The newer code includes an SPDX line.  Is there a reason for not
including it/them here?

thanks,

Mimi

