Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDE66BA161
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 22:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCNVXj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 17:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCNVXi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 17:23:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8924FF26;
        Tue, 14 Mar 2023 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=gPFadQu3Ehoj1V6bs+RPJtYnKdX9YfE3DcFVCV27t40=; b=qopN2wrF0UFzVXcANib7yg4H4H
        mTjv0nzDn6RgoVoWo4Uj2+iyF0vGOJjpJBNhJcFCc30DFKDhViQZBZiFN6jv6LVISJTRDU6KmQXNf
        2RHYv2MEQ4uVocYL+D9FeV6d5nQZOVx1m0eQCNhtly9j/p5Y2oTSoebdKeIlHSQ2hX0BDTWj4b0C+
        KOOZVVz5DzBcsn6mz2xZqRAS4ZRoSCYYnzp2hAcVAvCs0xpC73YBHxCRVfjYIWpvRRXIG+dJ1nEE0
        v3yL0Qxil2l/E0LOnWrgJtilrhyiqNWH62MkHiEES07JPPllUOxSjlZ6yiIdJLUzNCi/n4KXhdmxI
        We3aJtIA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pcC7L-00BZu0-0e;
        Tue, 14 Mar 2023 21:23:35 +0000
Message-ID: <abf12edb-e541-adfc-1e5a-d06d9e1191aa@infradead.org>
Date:   Tue, 14 Mar 2023 14:23:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] IMA: allow/fix UML builds
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Rajiv Andrade <srajiv@linux.vnet.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
References: <20230224032703.7789-1-rdunlap@infradead.org>
 <ab1e29c1620ac492b9194b4c7a465b20cd39076a.camel@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ab1e29c1620ac492b9194b4c7a465b20cd39076a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 3/14/23 11:28, Mimi Zohar wrote:
> On Thu, 2023-02-23 at 19:27 -0800, Randy Dunlap wrote:
>> UML supports HAS_IOMEM since 0bbadafdc49d (um: allow disabling
>> NO_IOMEM).
>>
>> Current IMA build on UML fails on allmodconfig (with TCG_TPM=m):
>>
>> ld: security/integrity/ima/ima_queue.o: in function `ima_add_template_entry':
>> ima_queue.c:(.text+0x2d9): undefined reference to `tpm_pcr_extend'
>> ld: security/integrity/ima/ima_init.o: in function `ima_init':
>> ima_init.c:(.init.text+0x43f): undefined reference to `tpm_default_chip'
>> ld: security/integrity/ima/ima_crypto.o: in function `ima_calc_boot_aggregate_tfm':
>> ima_crypto.c:(.text+0x1044): undefined reference to `tpm_pcr_read'
>> ld: ima_crypto.c:(.text+0x10d8): undefined reference to `tpm_pcr_read'
>>
>> Modify the IMA Kconfig entry so that it selects TCG_TPM if HAS_IOMEM
>> is set, regardless of the UML Kconfig setting.
>> This updates TCG_TPM from =m to =y and fixes the linker errors.
>>
>> Fixes: f4a0391dfa91 ("ima: fix Kconfig dependencies")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Indicating this resolves a commit which was upstreamed in linux-3.4,
> while the fix for that commit 0bbadafdc49d ("um: allow disabling
> NO_IOMEM") was upstreamed only in linux-5.14, leaves out an important
> detail.
> 
> Is the proper way of indicating this disconnect by adding to the fixes
> line the kernel?
> Fixes: f4a0391dfa91 ("ima: fix Kconfig dependencies") # v5.14+

Yes, that is acceptable AFAIK. Also
Cc: stable@vger.kernel.org

or AUTOSEL would probably take care of this as it is.

-- 
~Randy
