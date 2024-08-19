Return-Path: <linux-integrity+bounces-3354-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD86956D77
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 16:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB361C22269
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54CD171E69;
	Mon, 19 Aug 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m4WeACVh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B704171E43;
	Mon, 19 Aug 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078293; cv=none; b=J8ZGip+GpWQ2/yT9MbXxwO1N0yR7r6gx4WhYxDYcsfNtBo1hCrkJ3P3cEoprTAibxv46qNDJ3QgbuDQjhm/thuCs64WeUujlRDoP/I5qu4ajYnJQ16fQsLaWounFxynoUw8CdhnOBzJjc1HYmqUJ2LcvG5kEKxn+NayK5KaBHT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078293; c=relaxed/simple;
	bh=DfepRMOLQFR3pquuCkwdVFj+pFZjc2mjw814VgMJy6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I8CmeoqhTcYpyAjHPJEqA7rVxedgiIlt8kcYSd04b5jadjtIvtMoWy3eLCXKqiheARPa9fC0cAVsG6/UAWCus8AnwdO0gbRKPJSWWN+eOAHfOck/gXe+h/M32+8+9DbpZYrQ/LeklrrX+mg7eO3Ko/nO6Sp2Voi3YBepuxEryYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m4WeACVh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JB1ckE009997;
	Mon, 19 Aug 2024 14:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DfepRMOLQFR3pquuCkwdVFj+pFZjc2mjw814VgMJy6Y=; b=m4WeACVhm7oGZmHL
	9YtRhDD4AerkjSdd6p9WFegNnE8LyjqUcdx0S9Cu26W/htT1h53MUXZmb+hdJDGG
	u89wExkum+1x8SvkXSZRCX4o8Ac8TLBHUQhM/75CiKjR3j7T0XGce1X9TFBybBMt
	0pgdbA0tsTslpCvIZgGUF86QhtQNdOADD7lBDwn3KvjmUG7U/CChfjc+PDs3MxWW
	FMhd82QxEFLjfJ+1il/OPyDAfsptHS11RHFNQ66NCR2q/7DcO3zSf0ylk9JUmtdP
	vSvf60BBogKh3MFOONk/E8h0dOyzTIb7p/cS0hWyN711IyfvWyCr3innZTd/B2Lw
	7WpjGg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412n584f5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:37:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47JEbsfO004333
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:37:54 GMT
Received: from [10.81.24.74] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 19 Aug
 2024 07:37:53 -0700
Message-ID: <350d17de-a669-4342-bc94-c86da4ef17db@quicinc.com>
Date: Mon, 19 Aug 2024 07:37:53 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] PGP: Provide a key type for testing PGP
 signatures
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, <dhowells@redhat.com>,
        <dwmw2@infradead.org>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <zohar@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
 <20240818165756.629203-13-roberto.sassu@huaweicloud.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240818165756.629203-13-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9pdj4De64koIkSl7Cqp5DR4V3OI8Qt9r
X-Proofpoint-ORIG-GUID: 9pdj4De64koIkSl7Cqp5DR4V3OI8Qt9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190097

On 8/18/24 09:57, Roberto Sassu wrote:
...
> diff --git a/crypto/asymmetric_keys/pgp_test_key.c b/crypto/asymmetric_keys/pgp_test_key.c
> new file mode 100644
> index 000000000000..e067dedf6ca0
> --- /dev/null
> +++ b/crypto/asymmetric_keys/pgp_test_key.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Testing module to load key from trusted PGP message
> + *
> + * Copyright (C) 2014 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#define pr_fmt(fmt) "PGPtest: "fmt
> +#include <linux/key.h>
> +#include <linux/key-type.h>
> +#include <linux/cred.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/verification.h>
> +#include <keys/user-type.h>
> +#include <keys/system_keyring.h>
> +#include <crypto/pgp.h>
> +
> +#include "pgp_parser.h"
> +
> +MODULE_LICENSE("GPL");

Missing MODULE_DESCRIPTION()


