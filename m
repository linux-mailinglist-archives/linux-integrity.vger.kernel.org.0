Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DE6C3770
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Mar 2023 17:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCUQyO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Mar 2023 12:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCUQyN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Mar 2023 12:54:13 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5293E7
        for <linux-integrity@vger.kernel.org>; Tue, 21 Mar 2023 09:54:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PgyBw13lKz9xFg3
        for <linux-integrity@vger.kernel.org>; Wed, 22 Mar 2023 00:45:12 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAn+V8h4Rlka_e3AQ--.49608S2;
        Tue, 21 Mar 2023 17:53:59 +0100 (CET)
Message-ID: <87e95bba5620dfdeda8a0bd2afa98007c14aa7f8.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils] Include the filesystem UUID in HMAC
 calculation
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 21 Mar 2023 17:53:51 +0100
In-Reply-To: <20230321164741.680916-1-roberto.sassu@huaweicloud.com>
References: <20230321164741.680916-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAn+V8h4Rlka_e3AQ--.49608S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWrZrW3ArWUJry5XF47Jwb_yoW8Zw1kpa
        9Yg34Yqa48tFyxKF13Aa1fuay8Jw40yr1Ygw47Zw13ZasxXFyUt3WfKF4Ygry7Wr1kAFWf
        Ww4a9FyF9ayDA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU189N3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj4rIaQAAsc
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-03-21 at 17:47 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Modify calc_evm_hmac() to include, similarly to calc_evm_hash(), the
> filesystem UUID in the HMAC calculation.
> 
> If the -u option is not specified in the evmctl command line, the UUID of
> the filesystem the input file resides on is taken for the calculation.
> 
> If a string is specified as a value for the -u option, that string is taken
> as UUID (assuming that it is formatted correctly).
> 
> If no value is specified for the -u option, the filesystem UUID is not
> included in the HMAC calculation.
> 
> Not including the filesystem UUID in the digest/HMAC calculation is needed
> for the case where the kernel is compiled with CONFIG_EVM_ATTR_FSUUID=n, or
> the digest/HMAC is not for an EVM portable signature.
> 

Fixes: 1d24a94bb556 ("added uuid support for EVM")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto

> ---
>  src/evmctl.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 6d2bb67427d..304b70de40f 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1199,6 +1199,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *s
>  	int keylen;
>  	unsigned char evmkey[MAX_KEY_SIZE];
>  	char list[1024];
> +	char uuid[16];
>  	ssize_t list_size;
>  	struct h_misc_64 hmac_misc;
>  	int hmac_size;
> @@ -1330,6 +1331,18 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *s
>  		log_err("EVP_DigestSignUpdate() failed\n");
>  		goto out_ctx_cleanup;
>  	}
> +	if (!(hmac_flags & HMAC_FLAG_NO_UUID)) {
> +		err = get_uuid(&st, uuid);
> +		if (err)
> +			goto out_ctx_cleanup;
> +
> +		err = EVP_DigestSignUpdate(pctx, (const unsigned char *)uuid,
> +					   sizeof(uuid));
> +		if (!err) {
> +			log_err("EVP_DigestSignUpdate() failed\n");
> +			goto out_ctx_cleanup;
> +		}
> +	}
>  	err = EVP_DigestSignFinal(pctx, sig, &siglen);
>  	if (err != 1)
>  		log_err("EVP_DigestSignFinal() failed\n");

