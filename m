Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435E2326B66
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Feb 2021 04:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhB0DgL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Feb 2021 22:36:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12213 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhB0DgL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Feb 2021 22:36:11 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DnXDN4xGGzlNm5;
        Sat, 27 Feb 2021 11:33:24 +0800 (CST)
Received: from [10.67.103.10] (10.67.103.10) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Feb 2021
 11:35:25 +0800
Subject: Re: [PATCH v9 9/9] certs: Add support for using elliptic curve keys
 for signing modules
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        <dhowells@redhat.com>, <zohar@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <patrick@puiterwijk.org>,
        <linux-integrity@vger.kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
References: <20210225160802.2478700-1-stefanb@linux.vnet.ibm.com>
 <20210225160802.2478700-10-stefanb@linux.vnet.ibm.com>
From:   yumeng <yumeng18@huawei.com>
Message-ID: <ce098224-893c-fba8-5995-a7bac90f82c2@huawei.com>
Date:   Sat, 27 Feb 2021 11:35:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210225160802.2478700-10-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.10]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


ÔÚ 2021/2/26 0:08, Stefan Berger Ð´µÀ:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 

> diff --git a/certs/Makefile b/certs/Makefile
> index 3fe6b73786fa..c487d7021c54 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -69,6 +69,18 @@ else
>   SIGNER = -signkey $(obj)/signing_key.key
>   endif # CONFIG_IMA_APPRAISE_MODSIG
>   

Is there anything wrong in this patch?
I can't apply it when I use 'git am '.
errors like below:

error: certs/Kconfig: does not match index
error: patch failed: certs/Makefile:69
error: certs/Makefile: patch does not apply

Thanks
