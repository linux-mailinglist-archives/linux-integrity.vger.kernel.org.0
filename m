Return-Path: <linux-integrity+bounces-2905-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8AC912304
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 13:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0603284902
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56901495E5;
	Fri, 21 Jun 2024 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JZiAtixJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440EC82D72
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968135; cv=none; b=Op96gESeiJog2AMqlLeHkesCcPARTOWU/s0HepT6p0dwA/WR9y3tnAPZQ8PZjSoQ7kHqLfK0+P8djxGCPtyOQDLGR/fCQzu42+59o0bdxz6iK0pBpy8yu0s3dO+EXlU3WesJhTe++CuCj+tIZ6hEDdlisBkbPd5XAZsbaKWiVYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968135; c=relaxed/simple;
	bh=XcoPFfnvgOs1esOABax0TnIc2WaUy2DZXwtUOnKT3jo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=mTy9U14X7RrnR2mM9VVFx6T860Rz4FTnZ6A+v0mGI3lJuqf9HcOrIHUe75RrqqyYSr8n0ejP37/brmLw+gxJPYireRSCA+GxIJEerLmLxtpT6HdClmJ2UPk23vUThqhbnQ/IK6BdgWDaHj8e8Z6NfuZhGveCaVsMrgtaF14NtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JZiAtixJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LATZQK018220
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 11:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	gJDcsMTNtO8rVTuAVmvhvtOZevQrwQdMzh1dsWDMpDM=; b=JZiAtixJT/3Sg2lJ
	xWOxhpN0k5HD5D1XDB+6/nPnW+SmjfhnIvONpGZmo60Ks/jFlBPrTNEeoQFdnQ5Q
	7zGgazu8diZDB1xTRDvo7xo1C3Byv9dWm2OGfzkvAxU8Fy6+zbNz5Gp6VMN42IPA
	Lrf9RO3dIt2JMwLx9tcysXO1Y7oV3s13oAhBuJzo7Se9KmLu8gGiyRSh86CMvzCR
	FfRVvovc+8oFGhygZgLpVfvuRQVp5yIVZ6A6ntLeRKnClV09igro3kBJ1cW2187n
	33gPP+aaOTiB/iX+rcYilVwbDoTe6y0j4EdP2yxL6I8fzFMkeQEkO1eCZbO5a+aW
	/qygow==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw7t502e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 11:08:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L97Ruv025644
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 11:08:50 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrqv6sj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 11:08:50 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45LB8l1651380524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 11:08:49 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 159FD58146;
	Fri, 21 Jun 2024 11:08:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AC6658145;
	Fri, 21 Jun 2024 11:08:46 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.119.207])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 11:08:46 +0000 (GMT)
Message-ID: <9462094a628fd08a7d43679fb57d5827d9983492.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils][PATCH 3/3] CI/CD: Also enable Ubuntu 24.04
 (Noble) and run provider tests
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>
Date: Fri, 21 Jun 2024 07:08:46 -0400
In-Reply-To: <20240621005912.1365462-4-stefanb@linux.vnet.ibm.com>
References: <20240621005912.1365462-1-stefanb@linux.vnet.ibm.com>
	 <20240621005912.1365462-4-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R7AwzZJTWGwQi0UoFglMehKoIHKFtJSk
X-Proofpoint-GUID: R7AwzZJTWGwQi0UoFglMehKoIHKFtJSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210081

On Thu, 2024-06-20 at 20:59 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> With provider support fixed for Ubuntu 24.04 (Noble), enable testing with
> it. To test provider support on Ubuntu, make a copy of the debian.sh
> install file and enable the installation of provider support there.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  .github/workflows/ci.yml |  5 ++++
>  .travis.yml              |  4 +++
>  ci/ubuntu.sh             | 63 +++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 71 insertions(+), 1 deletion(-)
>  mode change 120000 => 100755 ci/ubuntu.sh
> 
> diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
> index 5d67c70..772eb34 100644
> --- a/.github/workflows/ci.yml
> +++ b/.github/workflows/ci.yml
> @@ -143,6 +143,11 @@ jobs:
>                CC: gcc
>                TSS: ibmtss
>  
> +          - container: "ubuntu:noble"
> +            env:
> +              CC: gcc
> +              TSS: ibmtss
> +
>            - container: "ubuntu:xenial"
>              env:
>                CC: clang
> diff --git a/.travis.yml b/.travis.yml
> index af82040..0c78958 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -43,6 +43,10 @@ matrix:
>            env: DISTRO=ubuntu:mantic TSS=ibmtss
>            compiler: gcc
>  
> +        - os: linux
> +          env: DISTRO=ubuntu:noble TSS=ibmtss
> +          compiler: gcc
> +

There needs to be a balance between testing all releases and a good subset. 
There's already 3 Ubuntu releases - jammy, mantic, xenial.  Please don't add
another release, but roll them - noble, mantic, xenial (or bionic).

>          - os: linux
>            env: DISTRO=ubuntu:jammy TSS=ibmtss COMPILE_SSL=openssl-3.0.5
>            compiler: gcc
> diff --git a/ci/ubuntu.sh b/ci/ubuntu.sh
> deleted file mode 120000
> index 0edcb8b..0000000
> --- a/ci/ubuntu.sh
> +++ /dev/null
> @@ -1 +0,0 @@
> -debian.sh
> \ No newline at end of file
> diff --git a/ci/ubuntu.sh b/ci/ubuntu.sh
> new file mode 100755
> index 0000000..e1bae43
> --- /dev/null
> +++ b/ci/ubuntu.sh
> @@ -0,0 +1,62 @@
> +#!/bin/sh
> +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +set -ex
> +
> +# workaround for Ubuntu impish asking to interactively configure tzdata
> +export DEBIAN_FRONTEND="noninteractive"
> +
> +if [ -z "$CC" ]; then
> +	echo "missing \$CC!" >&2
> +	exit 1
> +fi
> +
> +# debian.*.sh must be run first
> +if [ "$ARCH" ]; then
> +	ARCH=":$ARCH"
> +	unset CC
> +else
> +	apt update
> +fi
> +
> +# ibmswtpm2 requires gcc
> +[ "$CC" = "gcc" ] || CC="gcc $CC"
> +
> +case "$TSS" in
> +ibmtss) TSS="libtss-dev";;
> +tpm2-tss) TSS="libtss2-dev";;
> +'') echo "Missing TSS!" >&2; exit 1;;
> +*) [ "$TSS" ] && echo "Unsupported TSS: '$TSS'!" >&2; exit 1;;
> +esac
> +
> +apt="apt install -y --no-install-recommends"
> +
> +$apt \
> +	$CC $TSS \
> +	asciidoc \
> +	attr \
> +	autoconf \
> +	automake \
> +	diffutils \
> +	debianutils \
> +	docbook-xml \
> +	docbook-xsl \
> +	e2fsprogs \
> +	gzip \
> +	libattr1-dev$ARCH \
> +	libkeyutils-dev$ARCH \
> +	libssl-dev$ARCH \
> +	libtool \
> +	make \
> +	openssl \
> +	pkg-config \
> +	procps \
> +	sudo \
> +	util-linux \
> +	wget \
> +	xsltproc \
> +	gawk
> +
> +$apt xxd || $apt vim-common
> +$apt libengine-gost-openssl || true
> +$apt softhsm2 gnutls-bin libengine-pkcs11-openssl || true
> +$apt softhsm2 gnutls-bin pkcs11-provider || true


