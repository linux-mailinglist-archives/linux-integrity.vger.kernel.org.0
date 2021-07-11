Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A403C3F8C
	for <lists+linux-integrity@lfdr.de>; Sun, 11 Jul 2021 23:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhGKVqA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 11 Jul 2021 17:46:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230318AbhGKVp7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Jul 2021 17:45:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16BLYWXB138719;
        Sun, 11 Jul 2021 17:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=S6J4+nx37KmdHM+knflgS1KM5Bv/HOs3ET/qPI2DijE=;
 b=tRdkKOwTPQuWQfr1KoFHouc9HfteCIdjZPKM+t6cAPHBtmKaisZGf2On5zZ0ewdcaGcg
 8sN3IGyXs2G+xSHy3phi0u6LBpRS3uobPlJvu3QdyTCWfCm8sbC6YiJd7lYEq4mIBFQe
 2ldgNdFVMozRHl8LRx/xLUQwLff+fDc2WGZEX2qSWcHC8wRNvg3TJ63VD9JECRIVlr39
 JLeEnYFxRis2sg7jh7Dy5S9p8z2WNW1MptmhF7v7uZuUYRTyT68j7krZ8idsgAVVopLI
 7YuUHL7+GsEW4BKddkvTW8SH62tQjaCJ1Cd15gV9pj+Ml1XxCdowkAx1/2zkXHq7ZeQp vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39qrmcpnrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jul 2021 17:43:09 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16BLYtLG139521;
        Sun, 11 Jul 2021 17:43:08 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39qrmcpnrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jul 2021 17:43:08 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16BLg1wA028060;
        Sun, 11 Jul 2021 21:43:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 39q368884v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jul 2021 21:43:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16BLh4HX31850758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Jul 2021 21:43:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 580C8AE051;
        Sun, 11 Jul 2021 21:43:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FEBEAE04D;
        Sun, 11 Jul 2021 21:43:03 +0000 (GMT)
Received: from sig-9-65-201-16.ibm.com (unknown [9.65.201.16])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 11 Jul 2021 21:43:02 +0000 (GMT)
Message-ID: <4ad9dc3fbff20046edaced106f3e1624bc13b09c.camel@linux.ibm.com>
Subject: Re: [PATCH] CI: Add GitHub Actions for ALT Linux
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Sun, 11 Jul 2021 17:43:02 -0400
In-Reply-To: <20210711115539.2400162-1-vt@altlinux.org>
References: <20210711115539.2400162-1-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6Rmpkar-MXT-I01RlzqGEOWyd_U0XPpu
X-Proofpoint-GUID: 2AxdWivKFkcmpuVAMe52nw-hpyXUGr2L
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-11_14:2021-07-09,2021-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107110176
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

For now Travis is still being supported.  Perhaps the subject could be
"CI: add support for ALT linux".

On Sun, 2021-07-11 at 14:55 +0300, Vitaly Chikunov wrote:
> Build on Sisyphus branch which is bleeding edge repo.
> Package manager is apt-rpm (not APT as it may look from the scripts).
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  .github/workflows/ci.yml | 13 ++++++++++++-
>  ci/alt.sh                | 24 ++++++++++++++++++++++++
>  tests/install-swtpm.sh   | 14 +++++++++++---
>  3 files changed, 47 insertions(+), 4 deletions(-)
>  create mode 100755 ci/alt.sh
> 
> diff --git .github/workflows/ci.yml .github/workflows/ci.yml
> index f08733a..088c041 100644
> --- .github/workflows/ci.yml
> +++ .github/workflows/ci.yml
> @@ -92,6 +92,11 @@ jobs:
>                CC: clang
>                TSS: ibmtss
> 
> +          - container: "alt:sisyphus"
> +            env:
> +              CC: gcc
> +              TSS: libtpm2-tss-devel
> +
>      container:
>        image: ${{ matrix.container }}
>        env: ${{ matrix.env }}
> @@ -112,7 +117,13 @@ jobs:
>          ARCH="$ARCH" CC="$CC" TSS="$TSS" ./ci/$INSTALL.sh
> 
>      - name: Build swtpm
> -      run: if [ ! "$VARIANT" ]; then which tpm_server || which swtpm || ./tests/install-swtpm.sh; fi
> +      run: |
> +        if [ ! "$VARIANT" ]; then
> +          which tpm_server || which swtpm || \
> +            if which tssstartup; then
> +              ./tests/install-swtpm.sh;
> +            fi
> +        fi

This change isn't specific to ALT Linus.   Could you separate this out
please?

> 
>      - name: Compiler version
>        run: $CC --version
> diff --git ci/alt.sh ci/alt.sh
> new file mode 100755
> index 0000000..4996890
> --- /dev/null
> +++ ci/alt.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh -ex
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Build env install script for ALT Linux.
> +
> +apt-get update -y
> +
> +# rpm-build brings basic build envirenment with gcc, make, autotools, etc.
> +apt-get install -y \
> +	$CC \
> +	$TSS \
> +	asciidoc \
> +	attr \
> +	docbook-style-xsl \
> +	libattr-devel \
> +	libkeyutils-devel \
> +	libssl-devel \
> +	openssl \
> +	openssl-gost-engine \
> +	rpm-build \
> +	wget \
> +	xsltproc \
> +	xxd
> +
> diff --git tests/install-swtpm.sh tests/install-swtpm.sh
> index 2666748..b344a69 100755
> --- tests/install-swtpm.sh
> +++ tests/install-swtpm.sh
> @@ -1,5 +1,13 @@
> -#!/bin/sh
> -set -ex
> +#!/bin/sh -ex
> +
> +# No need to run via sudo if we already have permissions, such as in Docker.
> +# Some distros do not have sudo configured for root:
> +#   `root is not in the sudoers file.  This incident will be reported.'
> +if [ -w /usr/local/bin ]; then
> +	SUDO=
> +else
> +	SUDO=sudo
> +fi
> 

ditto

thanks,

Mimi

>  version=1637
> 
> @@ -9,5 +17,5 @@ cd ibmtpm$version
>  tar --no-same-owner -xvzf ../download
>  cd src
>  make -j$(nproc)
> -sudo cp tpm_server /usr/local/bin/
> +$SUDO cp tpm_server /usr/local/bin/
>  cd ../..


