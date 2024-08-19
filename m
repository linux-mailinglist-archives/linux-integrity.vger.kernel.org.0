Return-Path: <linux-integrity+bounces-3353-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8774C956D6F
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 16:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446E428119F
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF83816D314;
	Mon, 19 Aug 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JKoOtn05"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BA725763;
	Mon, 19 Aug 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078229; cv=none; b=ewzw45ZwUyTXN+xskT4dstl1iNrtKGJY89hk/c0uDiHrz3ibSvDR+LhApjLacBYq3X6/8ubvGmhzx3saC8yS7Pz8mueFpM5maEduSAAOOCP8IFooSc9NkJy8dYGvEVJXA2+I/VP8pykAVcoQoMlukuZP8s9G9QQq/vb3Yh2U+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078229; c=relaxed/simple;
	bh=D34aUEVplVWbSVUxspPBx/hjlZG8P5NgEK4WBVoQAnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eTM6rKZ3Nn4GjZFQxp/H0EYd/FoV4biHlHgi34fIOqnk6E+oNNpjRgQjJ5pPyrP25YGJKYdlMakBcYfaIiTGBUYxf6wwiJf8ThhhGPJG4WTGe/spJ5GV1ArXfXqLnaF4gneVqJX0mOi2agb1vMMLxIKWNclywxSpEzRpImQzM4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JKoOtn05; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JBJKIm030786;
	Mon, 19 Aug 2024 14:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f2I9VnJLg09vMfui0oYKnkAiN0FjyP0W/1DM3xr+yrU=; b=JKoOtn05eJHa01r/
	cOO+5ZJQqghOj1SYgVvOla6TjkdWhkEdrf9icatO3iP1PWhUv18RMgZcQVG3qigv
	DT3Bl+8r7youJBqLCV5k+QUGNoMElqhaJrGKP5OpNDj6lnfFGchS70ErwMPfeThf
	f+oVR61x1n1SWEV5YQtuoXN/cwbd63OH7gaGFfvlg6Wm4ds+mnN+AC3dTzB3doeI
	ZdWegamtzRK1OHf/dxGq4BojP56ce/ashbUgJp9g/ZggtxMuvC0lREI4REiEm4em
	hzCGAbLbwp4Pqltnol1WUVLQ5XpOfKPtYVNh37myK7X9ErwgUV6rzu+yOMNiVLek
	4QAvWQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412hjdcpaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:36:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47JEae6n020052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:36:40 GMT
Received: from [10.81.24.74] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 19 Aug
 2024 07:36:39 -0700
Message-ID: <45accf08-bb98-4199-b0a0-a314f3d0574b@quicinc.com>
Date: Mon, 19 Aug 2024 07:36:39 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] KEYS: PGP data parser
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, <dhowells@redhat.com>,
        <dwmw2@infradead.org>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <zohar@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
 <20240818165756.629203-7-roberto.sassu@huaweicloud.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240818165756.629203-7-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bQBIRa2GbtTcjgxR3oFqm_nkP3gzxYyV
X-Proofpoint-ORIG-GUID: bQBIRa2GbtTcjgxR3oFqm_nkP3gzxYyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190097

On 8/18/24 09:57, Roberto Sassu wrote:
...
> diff --git a/crypto/asymmetric_keys/pgp_public_key.c b/crypto/asymmetric_keys/pgp_public_key.c
> new file mode 100644
> index 000000000000..cb399f5cdd3e
> --- /dev/null
> +++ b/crypto/asymmetric_keys/pgp_public_key.c
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Instantiate a public key crypto key from PGP format data [RFC 4880]
> + *
> + * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#define pr_fmt(fmt) "PGP: "fmt
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/mpi.h>
> +#include <keys/asymmetric-subtype.h>
> +#include <keys/asymmetric-parser.h>
> +#include <crypto/hash.h>
> +#include <crypto/public_key.h>
> +
> +#include "pgp_parser.h"
> +
> +#define MAX_MPI 5
> +#define KEYCTL_SUPPORTS_ENCDEC \
> +	(KEYCTL_SUPPORTS_ENCRYPT | KEYCTL_SUPPORTS_DECRYPT)
> +#define KEYCTL_SUPPORTS_SIGVER (KEYCTL_SUPPORTS_SIGN | KEYCTL_SUPPORTS_VERIFY)
> +
> +MODULE_LICENSE("GPL");

Missing MODULE_DESCRIPTION()


