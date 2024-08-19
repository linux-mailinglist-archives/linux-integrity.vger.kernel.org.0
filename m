Return-Path: <linux-integrity+bounces-3356-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D66956D83
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 16:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E4B1C22547
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C21A17334E;
	Mon, 19 Aug 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GaCCa29D"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007E3172BDC;
	Mon, 19 Aug 2024 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078403; cv=none; b=aJI1vn6Cu+W12WRFZ1LNY6j1goPgfqHrEW/mzpIOBn6TswC0oygvQDAWfa1DMf7oYlYmUu35tSjThUpepc757Wsvyg/WN7yP/8mNWOhrc81nD0F+lrw2Dm9V6AMqb3EjNpI3WaoSRRrLSjp8wPB6EbxZn6GtGeF7Zhnmj3JqTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078403; c=relaxed/simple;
	bh=gUF3ERCTX5uqyQyYbzFQu+PY5KkzZ7VKjMcrKhHQ2/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EdiE7WmOuFDREJf+Ip/aLDQcgZxPXct+qiM3+WOVKYVvkbz3+eDOwUGcRRysEJTaXShDkomG1dyIOWNwyWTJSBsT7qPiaFaJtoLwy+2MBt2/0c8Wrtrm9I3ML/sE8FzY7hyMoB/OIJISaICe9Rhs5w7Xoo1FmZeEfTOVFA2s/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GaCCa29D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JCLLIk000780;
	Mon, 19 Aug 2024 14:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gUF3ERCTX5uqyQyYbzFQu+PY5KkzZ7VKjMcrKhHQ2/4=; b=GaCCa29DV/IBosot
	7hnJnBt22VNe4uyJSSMiD6pdW97Af5EBRhFya/YJh4TgX/vI3Wk1rKzS/GYMKOST
	q9cj5032IWBhygOpiwnoFCPoBrWbyfE3jax42/zmDaTXq9WbNR69LyrHtiMjljK+
	3IkWE8eBW8ekW0KrDw97/mtu8+/z4Ocf8cP/Bqd3rW4RFq0vFxrzg5VwT9K2uV7m
	y7/i0Bng+pm5eQjjaFX3w4tVJnaLg6JbVRoG5n8ZnP++fFZVI2Ys+DKBGew1+M/D
	p3cjmWDDcFj6A95TsD0aIss+6jlOx4DqjhkE+98mBCLaEo6IobXV8f66LL0Btzjx
	uOzVDg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4145yw89xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:34:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47JEYfZq009223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:34:41 GMT
Received: from [10.81.24.74] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 19 Aug
 2024 07:34:40 -0700
Message-ID: <fafa64ff-63ee-4af1-b669-939dc1933012@quicinc.com>
Date: Mon, 19 Aug 2024 07:34:40 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] PGPLIB: Basic packet parser
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, <dhowells@redhat.com>,
        <dwmw2@infradead.org>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <zohar@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
 <20240818165756.629203-5-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240818165756.629203-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LFD3j4ArA-wnAkMZ6iTuxsk2fbFhuNSp
X-Proofpoint-GUID: LFD3j4ArA-wnAkMZ6iTuxsk2fbFhuNSp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408190096

On 8/18/24 09:57, Roberto Sassu wrote:
...
> diff --git a/crypto/asymmetric_keys/pgp_library.c b/crypto/asymmetric_keys/pgp_library.c
> new file mode 100644
> index 000000000000..33ed01f67654
> --- /dev/null
> +++ b/crypto/asymmetric_keys/pgp_library.c
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* PGP packet parser (RFC 4880)
> + *
> + * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#define pr_fmt(fmt) "PGPL: "fmt
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include "pgplib.h"
> +
> +MODULE_LICENSE("GPL");

Missing MODULE_DESCRIPTION()

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Recently, multiple
developers have been eradicating these warnings treewide, and very few
are left, so please don't introduce a new one :)

/jeff

