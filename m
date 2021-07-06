Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286853BDA98
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jul 2021 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhGFP4C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 11:56:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232013AbhGFPz7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 11:55:59 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 166FXGL1086570;
        Tue, 6 Jul 2021 11:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=aJC1/sGsY1TGwanbf3SokjSVWYLIKFl7102qB85v/YI=;
 b=mv+APkhQ9Kwhm+uwdgk77eNvBMMOray1ppeaKjCFcU/4v9UfUzwVHB+mues0ti0HUhIC
 txhguC87KhyZP26aHLMeDSbawyGk8jyoDFmzfBkzABCAXKZqHa3fQJQzAlodnd9/ZdFA
 +dcCNob++Dr84pcS1rybDWTGmJCwW0wrnxTOLITDL4evgSyF1sWbeKGtpyAuK7xQ24QC
 W8LuCmZUyCU2uzhaSk2d569R2XAaJO0i1kIjrdk2k7y8xoGSumUmTFgMnQOUfZLmhyK8
 BJYAmyDAqx2NcUgFVpCLerJDnpRUSQLtAXPBf7l5e0Y6/z0SPjHIHFFFDOoxrk7sDYWn zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39m8bmbmnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 11:53:16 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 166FXgFL088056;
        Tue, 6 Jul 2021 11:53:16 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39m8bmbmmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 11:53:16 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 166Fqjtm024878;
        Tue, 6 Jul 2021 15:53:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 39jfh88qby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 15:53:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 166FpMWQ36176128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Jul 2021 15:51:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95271A405C;
        Tue,  6 Jul 2021 15:53:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FE50A4054;
        Tue,  6 Jul 2021 15:53:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.34.2])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Jul 2021 15:53:10 +0000 (GMT)
Message-ID: <2c6df7edf61d2e694a2bbba964c5a2ae81b2b3be.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2 2/2] Add test for using sign_hash API
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Patrick Uiterwijk <patrick@puiterwijk.org>,
        linux-integrity@vger.kernel.org
Cc:     pbrobinson@redhat.com, Vitaly Chikunov <vt@altlinux.org>
Date:   Tue, 06 Jul 2021 11:53:09 -0400
In-Reply-To: <20210705154950.497359-3-patrick@puiterwijk.org>
References: <20210106094335.3178261-1-patrick@puiterwijk.org>
         <20210705154950.497359-1-patrick@puiterwijk.org>
         <20210705154950.497359-3-patrick@puiterwijk.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uoFI3wiFjQT2a5YFD1R1AjtjVrApJECB
X-Proofpoint-ORIG-GUID: geaQhOMouxENEZXslykEHedUK1CA7NoS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_07:2021-07-06,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107060071
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Patrick,

On Mon, 2021-07-05 at 17:49 +0200, Patrick Uiterwijk wrote:
> This adds a test with a small program that calls the sign_hash API, to
> ensure that that codepath works.
> 
> Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Somehow I missed that running the test without this patch the summary
"SKIP" info matches the "skipped" messages, but running with the patch
there's a discrepancy.

$ ./sign_verify.test &> /tmp/sign_verify.log
$ tail -5  /tmp/sign_verify.log
evmctl ima_sign failed properly with (1) 
  EVP_get_digestbyname(md_gost12_512) failed
  errno: No such file or directory (2)
PASS: 127 SKIP: 20 FAIL: 0

$ grep "skipped" /tmp/sign_verify.log | wc -l
20

$ tail -5  /tmp/sign_verify.log-api
evmctl ima_sign: no detached signature md_gost12_512.txt~.sig

rm: cannot remove 'md_gost12_512.txt~': No such file or directory
PASS: 175 SKIP: 32 FAIL: 0

$ grep "skipped" /tmp/sign_verify.log-api | wc -l
30

> diff --git a/tests/sign_verify.apitest.c b/tests/sign_verify.apitest.c
> new file mode 100644
> index 0000000..3fcd043
> --- /dev/null
> +++ b/tests/sign_verify.apitest.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * sign_verify.apitest: Test program for verifying sign_hash
> + *
> + * Copyright (C) 2021 Patrick Uiterwijk <patrick@puiterwijk.org>
> + * Copyright (C) 2013,2014 Samsung Electronics
> + * Copyright (C) 2011,2012,2013 Intel Corporation
> + * Copyright (C) 2011 Nokia Corporation
> + */

As this is a new file and test, the copyrights other than your own are
unnecessary.

> +
> +#include <assert.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/xattr.h>
> +
> +#include "../src/imaevm.h"
> +#include "../src/utils.h"
> +
> +int main(int argc, char **argv)
> +{
> +	unsigned char hash[MAX_DIGEST_SIZE];
> +	unsigned char sig[MAX_SIGNATURE_SIZE];
> +	int len, err;
> +	char *file = argv[1];
> +	char *key = argv[2];
> +	char *algo = argv[3];
> +	char *digest = argv[4];
> +

How about testing 'argc' before continuing?

> +	len = strlen(digest) / 2;
> +	if (hex2bin(hash, digest, len) != 0) {
> +		fprintf(stderr, "Error during hex2bin\n");
> +		return 1;
> +	}
> +
> +	len = sign_hash(algo, hash, len, key, NULL, sig + 1);
> +	if (len <= 1) {
> +		fprintf(stderr, "Error signing\n");
> +		return 1;
> +	}
> +
> +	/* add header */
> +	len++;
> +	sig[0] = EVM_IMA_XATTR_DIGSIG;
> +
> +	bin2file(file, "sig", sig, len);
> +
> +	err = lsetxattr(file, "user.ima", sig, len, 0);
> +	if (err < 0) {
> +		log_err("setxattr failed: %s\n", file);
> +		return 1;
> +	}
> +
> +	return 0;
> +}


> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> index 3d7aa51..6f92801 100755
> --- a/tests/sign_verify.test
> +++ b/tests/sign_verify.test

> @@ -125,12 +127,14 @@ _evmctl_sign() {
>  # Run and test {ima_,}sign operation
>  check_sign() {
>    # Arguments are passed via global vars:
> -  # TYPE (ima or evm),
> +  # TYPE (ima, ima_api or evm),

Similarly TYPE should be updated in verify_sign as well.

thanks,

Mimi

>    # KEY,
>    # ALG (hash algo),
>    # PREFIX (signature header prefix in hex),
>    # OPTS (additional options for evmctl),
>    # FILE (working file to sign).
> +  [ "$TYPE" = ima_api ] && [[ "$OPTS" =~ --rsa ]] && return "$SKIP"
> +
>    local "$@"
>    local KEY=${KEY%.*}.key
>    local FILE=${FILE:-$ALG.txt}
> @@ -268,6 +272,20 @@ sign_verify() {
>      # Multiple files and some don't verify
>      expect_fail check_verify FILE="/dev/null $file"
>  
> +    setfattr -x user.ima "$FILE"
> +    rm "$FILE.sig"
> +  fi
> +
> +  TYPE=ima_api
> +  if expect_pass check_sign; then
> +
> +    # Normal verify with proper key should pass
> +    expect_pass check_verify
> +    expect_pass check_verify OPTS="--sigfile"
> +
> +    # Multiple files and some don't verify
> +    expect_fail check_verify FILE="/dev/null $file"
> +
>      rm "$FILE.sig"
>    fi
>  

