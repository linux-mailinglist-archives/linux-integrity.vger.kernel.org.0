Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4D722507
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jun 2023 13:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjFEL6E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 07:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjFEL6D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 07:58:03 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D15EDF;
        Mon,  5 Jun 2023 04:58:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QZWyp36jXz9yLnk;
        Mon,  5 Jun 2023 19:46:10 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDHeUC0zX1kx38JAw--.3850S2;
        Mon, 05 Jun 2023 12:57:48 +0100 (CET)
Message-ID: <c2b7b5531660befc66a25477abc0cc069d08926c.camel@huaweicloud.com>
Subject: Re: [PATCH] evm: Complete description of evm_inode_setattr()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 05 Jun 2023 13:57:37 +0200
In-Reply-To: <20230306104036.1298529-1-roberto.sassu@huaweicloud.com>
References: <20230306104036.1298529-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDHeUC0zX1kx38JAw--.3850S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWDJr4xKryrtr1kCw1kuFg_yoW8GF4kpa
        yrta48Jr1rtryI9F98Ga1xZFyFgrWUWr1j9ws8Aw40vFn8Gr4q9ryxK34fWr98Gr18Gr1f
        ta4av3W5Zw45ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
        xhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj4o5ewADsv
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-03-06 at 11:40 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add the description for missing parameters of evm_inode_setattr() to
> avoid the warning arising with W=n compile option.
> 
> Fixes: 817b54aa45db ("evm: add evm_inode_setattr to prevent updating an invalid security.evm")
> Fixes: c1632a0f1120 ("fs: port ->setattr() to pass mnt_idmap")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Hi Mimi

this probably got lost. It was also reviewed by Stefan:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Could you please take it?

Thanks

Roberto

> ---
>  security/integrity/evm/evm_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index cf24c525558..b1c2197473a 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -795,7 +795,9 @@ static int evm_attr_change(struct mnt_idmap *idmap,
>  
>  /**
>   * evm_inode_setattr - prevent updating an invalid EVM extended attribute
> + * @idmap: idmap of the mount
>   * @dentry: pointer to the affected dentry
> + * @attr: iattr structure containing the new file attributes
>   *
>   * Permit update of file attributes when files have a valid EVM signature,
>   * except in the case of them having an immutable portable signature.

