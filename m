Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DC23C91CF
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jul 2021 22:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbhGNULa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jul 2021 16:11:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18236 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242870AbhGNUKH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 16:10:07 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EK3UYb002987;
        Wed, 14 Jul 2021 16:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=75BAgCkpbaqsgFksegPB+RJeo2T3YzRlTf+ER7Wuz4g=;
 b=F9wP0RQ8odNLTiaa2ix9PT/8A+YgSpe7XlGczaufzViAp4bXjEz/arfLw/PCESBbwFwH
 QfmKRYx7rZCQXr0SeY9HBel0ckWSuB35c1UoHW3EBPBsJs4TOspKiPFVybpZ3f/MGNER
 kzOttW2c4XqdVFIgViCuX3lCa4z4Xed223Ur/W3DgInrKr5YLnXuGq3R1BfZcOWLB7Df
 6iNOypHyGVRFW5bQDmHu607NxUfaeCIpZje5atmYCfMphyqMHPb+n7VUpQ39bl+NU+7x
 STExd+yao19jaPdc6RsiGu+WxdbWGXFDGv2Z27TT6XG8sWhenNV5ensoVscLkbGoao8V fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39stffef4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 16:07:10 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16EK4ZPE009979;
        Wed, 14 Jul 2021 16:07:09 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39stffef3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 16:07:09 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16EK2xic030342;
        Wed, 14 Jul 2021 20:07:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 39q3689x7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 20:07:07 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16EK4ulO26870172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 20:04:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E212111C04C;
        Wed, 14 Jul 2021 20:07:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D6F011C04A;
        Wed, 14 Jul 2021 20:07:03 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.127.85])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Jul 2021 20:07:02 +0000 (GMT)
Message-ID: <422b37b533ed6e24d783f323f7d4e22736f0e4bd.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v4] ima-evm-utils: Support SM2 algorithm
 for sign and verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Date:   Wed, 14 Jul 2021 16:07:02 -0400
In-Reply-To: <20210714130152.25751-1-tianjia.zhang@linux.alibaba.com>
References: <20210714130152.25751-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R_K88Vjw-fTWXiNS5C2hPQTAm8Wm75XI
X-Proofpoint-ORIG-GUID: 6xVsTJovEY3iwx_7Fe6301_81RIxcHuL
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_10:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140119
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia,

On Wed, 2021-07-14 at 21:01 +0800, Tianjia Zhang wrote:
> 
> index 5b07711..a0001b0 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -93,4 +93,4 @@ before_install:
>  script:
>      - INSTALL="${DISTRO%%:*}"
>      - INSTALL="${INSTALL%%/*}"
> -    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if
> [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi
> && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ !
> \"$VARIANT\" ]; then which tpm_server || which swtpm ||
> ./tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\"
> ./build.sh"
> +    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if
> [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi
> && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ !
> \"$VARIANT\" ]; then which tpm_server || which swtpm ||
> ./tests/install-swtpm.sh; fi && ./tests/install-openssl3.sh && 
> CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"

With "install-openssl3.sh", installing openssl 3.0 is being done for
every distro matrix rule.  This needs to be limited to a specific
instance.  Petr, please correct if I'm wrong, I assume a new variable
needs to be defined, similar to "TSS".

A similar change would need to be made in ci.yml.

> new file mode 100755
> index 0000000..21adb6f
> --- /dev/null
> +++ b/tests/install-openssl3.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +
> +set -ex
> +
> +# The latest version in July 2021
> +wget --no-check-certificate https://github.com/openssl/openssl/archive/refs/tags/openssl-3.0.0-beta1.tar.gz
> +tar --no-same-owner -xvzf openssl-3.0.0-beta1.tar.gz

Petr said,  "Although it appears there is no distro which would have
openssl 3.0 [1],
Debian actually have 3.0.0~~beta1-1 in experimental [2]. openSUSE has slightly
older version openssl-3.0.0-alpha16 [3]. I suppose we update soon to beta1 as
well.
Using distro packages would be probably faster to run in CI than install from git."
I guess, whether the openssl 3.0 source code is from the distro or from
openssl, it needs to be compiled from source.

Perhaps limiting compiling openssl 3.0 to those distros with the source
package is simpler than defining a new travis.yml variable, as
suggested above.  Petr?

thanks,

Mimi

> +cd openssl-openssl-3.0.0-beta1
> +
> +./Configure --prefix=/opt/openssl --openssldir=/opt/openssl/ssl
> +make -j$(nproc) && sudo make install
> +
> +cd ..
> +rm -rf openssl-3.0.0-beta1.tar.gz
> +rm -rf openssl-openssl-3.0.0-beta1

