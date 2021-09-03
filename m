Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8805740058F
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Sep 2021 21:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350985AbhICTMk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Sep 2021 15:12:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350960AbhICTMk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Sep 2021 15:12:40 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183J3trI071529
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 15:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+VgDXynV7uTVZCAVGDMFPncgWaTy7oR5c3ycmq7yODM=;
 b=jAAoho7vNdz1eOlXuy22etSyE4NW6uC7MAN3swHVkScKUoprnr7aJqvX97HHy9xIr3Tj
 6riNOBREburEyT0NnLzHTfqMaCFcYPN49Jy9ZNbw6XAhRz3tFcEpY8umL1D4wABdsxnC
 geOko9ADVxw20QQ2Ui9cBdsqHM+exQ5yb1NS4CGaMR+l2ojH8hYoSG3BHXYjZY71rDBG
 drYM1Or5xAT262DCxnV0JwuXofi7gl5Sh2ROkImU3lqIcXi+LmFAprnsjVS8J2SKo0Z5
 QHirFbLNQYIGoxzjzwmsPiREGwXBEfIWgUDdifMzVR6wYpQhgPxFTMVTVgaJHbp0aJTy Kg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aurkf1dqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 15:11:33 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 183J34bV031981
        for <linux-integrity@vger.kernel.org>; Fri, 3 Sep 2021 19:11:31 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3au6pn3jwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Sep 2021 19:11:31 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 183JBROH54919646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Sep 2021 19:11:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1D49AE053;
        Fri,  3 Sep 2021 19:11:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6DAAAE045;
        Fri,  3 Sep 2021 19:11:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.70.237])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Sep 2021 19:11:26 +0000 (GMT)
Message-ID: <7a53fd3b1011c0a023ecbf8267db72d219442a53.camel@linux.ibm.com>
Subject: Re: [PATCH v2 7/8] tests: Extend sign_verify test with
 pkcs11-specific test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 03 Sep 2021 15:11:26 -0400
In-Reply-To: <20210810134557.2444863-8-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
         <20210810134557.2444863-8-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D1LZk_H3tQoDwsg7uS77VM-XXwZkIqn7
X-Proofpoint-ORIG-GUID: D1LZk_H3tQoDwsg7uS77VM-XXwZkIqn7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_07:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Tue, 2021-08-10 at 09:45 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Extend the sign_verify test with a pkcs11-specific test.
> Import softhsm_setup script from my swtpm project and contribute
> it to this porject under dual license BSD 3-clause and GLP 2.0.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Up to here, the patches were nicely split up.  Just from reading the
patch description, this patch needs to be split up.

> ---
>  tests/functions.sh     |  26 ++++
>  tests/sign_verify.test |  50 +++++--
>  tests/softhsm_setup    | 290 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 352 insertions(+), 14 deletions(-)
>  create mode 100755 tests/softhsm_setup
> 
> diff --git a/tests/functions.sh b/tests/functions.sh
> index 91cd5d9..cbb7ea4 100755
> --- a/tests/functions.sh
> +++ b/tests/functions.sh
> @@ -272,3 +272,29 @@ _report_exit() {
>    fi
>  }
>  
> +_at_exit() {
> +  _report_exit
> +  if [ -n "${WORKDIR}" ]; then
> +    rm -f "${WORKDIR}"
> +  fi
> +}
> +

It would be nice to have a function comment here.

> +_softhsm_setup() {
> +  local workdir="$1"
> +

${WORKDIR} is being passed as a parameter.  Why is a local environment
variable needed?

> +  local msg
> +
> +  export SOFTHSM_SETUP_CONFIGDIR="${workdir}"
> +  export SOFTHSM2_CONF="${workdir}/softhsm2.conf"
> +
> +  msg=$(./softhsm_setup setup 2>&1)
> +  if [ $? -eq 0 ]; then
> +    echo "softhsm_setup setup succeeded: $msg"
> +    PKCS11_KEYURI=$(echo $msg | sed -n 's|^keyuri: \(.*\)|\1|p')
> +
> +    export OPENSSL_ENGINE="-engine pkcs11"
> +    export OPENSSL_KEYFORM="-keyform engine"
> +  else
> +    echo "softhsm_setup setup failed: ${msg}"
> +  fi

Should there be a test checking that softhsm_setup is installed before
using it?   If it's not installed, then the test is "skipped".

> +}
> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> index 3b42eec..369765e 100755
> --- a/tests/sign_verify.test
> +++ b/tests/sign_verify.test
> @@ -28,7 +28,8 @@ fi
>  
>  ./gen-keys.sh >/dev/null 2>&1
>  
> -trap _report_exit EXIT
> +trap _at_exit EXIT
> +WORKDIR=$(mktemp -d)
>  set -f # disable globbing
>  
>  # Determine keyid from a cert
> @@ -132,11 +133,16 @@ check_sign() {
>    # OPTS (additional options for evmctl),
>    # FILE (working file to sign).
>    local "$@"
> -  local KEY=${KEY%.*}.key
> +  local key verifykey

Agreed, don't modify the global variable, use a local one.  Making this
a separate patch, would simplify review.

thanks,

Mimi

