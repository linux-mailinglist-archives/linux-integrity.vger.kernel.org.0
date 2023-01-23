Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CB0677FCD
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Jan 2023 16:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjAWPcB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Jan 2023 10:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjAWPcA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jan 2023 10:32:00 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4855CF1
        for <linux-integrity@vger.kernel.org>; Mon, 23 Jan 2023 07:31:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P0v5R1lzKz9xFmc
        for <linux-integrity@vger.kernel.org>; Mon, 23 Jan 2023 23:23:55 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDnbAhaqM5jl82+AA--.11669S2;
        Mon, 23 Jan 2023 16:31:45 +0100 (CET)
Message-ID: <724585556e02178d0b9ce29af057a93ac72f0a87.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v2 6/9] Add tests for EVM portable
 signatures
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 23 Jan 2023 16:31:23 +0100
In-Reply-To: <4b39d880d2ddfec667608222d7ca7a0eed5fe28b.camel@linux.ibm.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
         <20230112122426.3759938-7-roberto.sassu@huaweicloud.com>
         <4b39d880d2ddfec667608222d7ca7a0eed5fe28b.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwDnbAhaqM5jl82+AA--.11669S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyfJF4UJry8WF1DCw15Arb_yoWxKwbE9F
        4DtFykuayfZa1DX39YkF4Uta1DCw4kJr4Yvr93ArW7A3909w13Aa97AryfuFykXryxAFZ8
        uryUKFy3K3W29jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbOAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBF1jj4fxuAAAs8
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-01-23 at 09:40 -0500, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Thu, 2023-01-12 at 13:24 +0100, Roberto Sassu wrote:
> > +
> > +key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
> > +if [ -f "$PWD/../signing_key.pem" ]; then
> > +       key_path=$PWD/../signing_key.pem
> > +fi
> > +
> 
> For testing locally, how about first checking the file exists, before
> setting key_path?  On not finding it, perhaps check whether
> "/lib/modules/$(uname -r)/build/certs/signing_key.pem" exists.

The precedence is:

TST_KEY_PATH -> ../signing_key.pem -> /lib/modules...

If TST_KEY_PATH is not found, probably it is a good idea to not
fallback to the other alternatives, as it is user input.

Roberto

