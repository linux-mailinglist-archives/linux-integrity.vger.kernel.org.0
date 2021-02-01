Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C4130A2A1
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 08:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBAHZj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 02:25:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11662 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhBAHZM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 02:25:12 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DTfY32nbvzlDjj;
        Mon,  1 Feb 2021 15:22:47 +0800 (CST)
Received: from [10.67.103.10] (10.67.103.10) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 15:24:23 +0800
Subject: Re: [PATCH v6 1/4] crypto: Add support for ECDSA signature
 verification
To:     Stefan Berger <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <patrick@puiterwijk.org>,
        <linux-integrity@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20210131233301.1301787-1-stefanb@linux.ibm.com>
 <20210131233301.1301787-2-stefanb@linux.ibm.com>
From:   yumeng <yumeng18@huawei.com>
Message-ID: <289ef2ac-d653-47b3-7771-5d8a7342ad21@huawei.com>
Date:   Mon, 1 Feb 2021 15:24:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210131233301.1301787-2-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.10]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



ÔÚ 2021/2/1 7:32, Stefan Berger Ð´µÀ:
> +/**
> + * ecc_get_curve()  - Get a curve given its curve_id
> + *
> + * @curve_id:  Id of the curve
> + *
> + * Returns pointer to the curve data, NULL if curve is not available
> + */
> +const struct ecc_curve *ecc_get_curve(unsigned int curve_id);
> +
>   /**
>    * ecc_is_key_valid() - Validate a given ECDH private key


Shall we move this definition to 'include/crypto'? Other drivers may 
also want to use it.
