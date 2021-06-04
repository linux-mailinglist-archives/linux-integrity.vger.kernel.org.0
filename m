Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4271D39B2B6
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jun 2021 08:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFDGjE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Jun 2021 02:39:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3152 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFDGjD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Jun 2021 02:39:03 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FxCZB5g6kz6F84K;
        Fri,  4 Jun 2021 14:30:42 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 08:37:16 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Fri, 4 Jun 2021 08:37:16 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     Stefan Berger <stefanb@linux.ibm.com>,
        Russell Coker <russell@coker.com.au>
Subject: RE: [RFC PATCH 1/2] ima: differentiate between EVM failures in the
 audit log
Thread-Topic: [RFC PATCH 1/2] ima: differentiate between EVM failures in the
 audit log
Thread-Index: AQHXWIvE7svTuhbfo0y1Vg5X80B3bqsDZmSg
Date:   Fri, 4 Jun 2021 06:37:16 +0000
Message-ID: <9b88066d72c64117a923acafca62db72@huawei.com>
References: <20210603151819.242247-1-zohar@linux.ibm.com>
 <20210603151819.242247-2-zohar@linux.ibm.com>
In-Reply-To: <20210603151819.242247-2-zohar@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.212.129]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> Sent: Thursday, June 3, 2021 5:18 PM
> Differenatiate between an invalid EVM portable signature failure

Typo.

> from other EVM HMAC/signature failures.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks, looks good.

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> ---
>  security/integrity/ima/ima_appraise.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c
> b/security/integrity/ima/ima_appraise.c
> index 940695e7b535..ef9dcfce45d4 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -422,7 +422,8 @@ int ima_appraise_measurement(enum ima_hooks
> func,
>  		goto out;
>  	case INTEGRITY_FAIL_IMMUTABLE:
>  		set_bit(IMA_DIGSIG, &iint->atomic_flags);
> -		fallthrough;
> +		cause = "invalid-fail-immutable";
> +		goto out;
>  	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
>  		cause = "invalid-HMAC";
>  		goto out;
> --
> 2.27.0

