Return-Path: <linux-integrity+bounces-2906-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C83F291230D
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 13:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54DDDB224B0
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D92495E5;
	Fri, 21 Jun 2024 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FlSAePEI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58127171679
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968219; cv=none; b=RPps4COe+vZuUCho7F2XCBMpGzK50bgBb3gDXS6xeABijptfYJlbuilCHUB3Hf9KLUAqNrEivw75C5tqeVIaAV3n4/j/wKbq52IJoB4Lw13tDVCClY7MsO/qy6nnkKCYlPhzY03TAesT1O9So7/KcRcjbcv/DFB8rkZmlV5Y0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968219; c=relaxed/simple;
	bh=trUlsLw+XcXRIHsTyiVAIEEt2OFwnYCYTf/MQ9OvKY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=WNMaUKWJYufZW9Ba9Xx9SyQbBSGqIZbb5f2xJl4WZfgmEtVJVJC7VGqqkC0fQPsktFhVuG6/CLRXhXXrZnkLSjhssEe870HQhiKhZto7bWqF0CY6/PomHmLBFygRbnMpjf49ASDe2Cu2QdfXFjDHr0C5DFtoUEUtCGYIXzx7WcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FlSAePEI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LASVAA027179;
	Fri, 21 Jun 2024 11:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	2ZSVUWsmaGwBCOSsLeV/mUwqVUu2sgBop/m0Fwb0PKk=; b=FlSAePEI7lnbhZbo
	2DGfgfZDeLPpn33WCiIp6fXPUUroQdGCGmiH04pJ+Hao39KcG8Veec6kdpKPSJIX
	qymzjqmYYMaznQ+a93A7RRuU66MjN9chGxlZs+5lsjk9qXuK7HLzLzZW8q0/aliO
	UVsX3GId3ZT7ozlngThydEye9ucYZx0ZRIt9HHx1LqySOdbVp5h7cY6JyXkQc+x+
	LFcYC9FRKtT23ZAKggQzeuRxeXoyg6VLYyXsWcZWwwQny6HugW2am7n0VySsWC1c
	L5P+TD4aCYiFafdWm3CBzYGBUwbQOTrNj2AXlYbdjAXrzr/xpj+DImMyn26wY0x7
	ZWjYYQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw7sv82px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:10:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L97RvL025644;
	Fri, 21 Jun 2024 11:10:13 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrqv6sqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 11:10:13 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45LBABjr44368486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 11:10:13 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B0DD58071;
	Fri, 21 Jun 2024 11:10:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F343C58064;
	Fri, 21 Jun 2024 11:10:08 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.119.207])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 11:10:08 +0000 (GMT)
Message-ID: <ae72040018219b13f0c97c4bf66d96ebda2dc8b4.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils][PATCH 2/3] CI/CD: Disable pkcs11 providers for
 Debian and AltLinux
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Vitaly Chikunov <vt@altlinux.org>
Date: Fri, 21 Jun 2024 07:10:08 -0400
In-Reply-To: <20240621005912.1365462-3-stefanb@linux.vnet.ibm.com>
References: <20240621005912.1365462-1-stefanb@linux.vnet.ibm.com>
	 <20240621005912.1365462-3-stefanb@linux.vnet.ibm.com>
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
X-Proofpoint-ORIG-GUID: G0NeDNOAU2zz2R4vIMqlpMgD_qK8r6Hp
X-Proofpoint-GUID: G0NeDNOAU2zz2R4vIMqlpMgD_qK8r6Hp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=901
 adultscore=0 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210081

[Cc: Vitaly for AltLinux]

On Thu, 2024-06-20 at 20:59 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Disable testing provider support on Debian:latest and AltLinux:sisyphus
> since both now get stuck while running OpenSSL provider-related tests.
> This is most likely due to an update in a dependency (OpenSSL, libp11,
> softhsm,  or others).
> 
> On AltLinux the issues is related to a pthread_mutex_lock() down the
> C_Login -> C_OpenSession callpath that blocks forever.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  ci/alt.sh    | 2 +-
>  ci/debian.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ci/alt.sh b/ci/alt.sh
> index f86dcec..f1eefbf 100755
> --- a/ci/alt.sh
> +++ b/ci/alt.sh
> @@ -28,4 +28,4 @@ apt-get install -y \
>  		xxd \
>  	&& control openssl-gost enabled
>  
> -apt-get install -y pkcs11-provider || true
> +# apt-get install -y pkcs11-provider || true
> diff --git a/ci/debian.sh b/ci/debian.sh
> index e1bae43..34125d4 100755
> --- a/ci/debian.sh
> +++ b/ci/debian.sh
> @@ -59,4 +59,4 @@ $apt \
>  $apt xxd || $apt vim-common
>  $apt libengine-gost-openssl || true
>  $apt softhsm2 gnutls-bin libengine-pkcs11-openssl || true
> -$apt softhsm2 gnutls-bin pkcs11-provider || true
> +# $apt softhsm2 gnutls-bin pkcs11-provider || true


