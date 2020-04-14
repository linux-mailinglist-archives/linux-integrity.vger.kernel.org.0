Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A782A1A7A27
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 13:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439683AbgDNLzt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 07:55:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2050 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439662AbgDNLzs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 07:55:48 -0400
Received: from lhreml708-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 972136BC52AD3612480C;
        Tue, 14 Apr 2020 12:55:44 +0100 (IST)
Received: from fraeml706-chm.china.huawei.com (10.206.15.55) by
 lhreml708-chm.china.huawei.com (10.201.108.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 14 Apr 2020 12:55:44 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 14 Apr 2020 13:55:43 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Tue, 14 Apr 2020 13:55:43 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Silviu Vlasceanu" <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
Thread-Topic: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
Thread-Index: AQHWElHViMvwppAnhkyyxXpkQ/lFwqh4geGA
Date:   Tue, 14 Apr 2020 11:55:43 +0000
Message-ID: <76d46ffbad294a6385779c29c4e5cafd@huawei.com>
References: <20200414114226.96691-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200414114226.96691-1-tianjia.zhang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.19.203]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> -----Original Message-----
> From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> owner@vger.kernel.org] On Behalf Of Tianjia Zhang
> Sent: Tuesday, April 14, 2020 1:42 PM
> To: peterhuewe@gmx.de; jarkko.sakkinen@linux.intel.com; jgg@ziepe.ca;
> arnd@arndb.de; gregkh@linuxfoundation.org; zhang.jia@linux.alibaba.com
> Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
> tianjia.zhang@linux.alibaba.com
> Subject: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
> 
> For the algorithm that does not match the bank, a positive
> value EINVAL is returned here. I think this is a typo error.
> It is necessary to return an error value.

Yes, thanks.

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli


> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index a438b1206fcb..1621ce818705 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -323,7 +323,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32
> pcr_idx,
> 
>  	for (i = 0; i < chip->nr_allocated_banks; i++) {
>  		if (digests[i].alg_id != chip->allocated_banks[i].alg_id) {
> -			rc = EINVAL;
> +			rc = -EINVAL;
>  			goto out;
>  		}
>  	}
> --
> 2.17.1

