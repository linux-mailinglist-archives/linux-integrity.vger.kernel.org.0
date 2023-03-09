Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7E6B1D2B
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Mar 2023 08:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCIH5P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Mar 2023 02:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCIH4w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Mar 2023 02:56:52 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48172DDF1F;
        Wed,  8 Mar 2023 23:55:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PXLq30TqLz9v7c5;
        Thu,  9 Mar 2023 15:46:39 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBnNl32kAlk6WSBAQ--.23696S2;
        Thu, 09 Mar 2023 08:55:40 +0100 (CET)
Message-ID: <070d4006cd7d0ee1b2cf4e0dd7e4d5c7be2bcb65.camel@huaweicloud.com>
Subject: Re: [PATCH v2] security: Introduce LSM_ORDER_LAST and set it for
 the integrity LSM
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 09 Mar 2023 08:55:33 +0100
In-Reply-To: <b8ed9f24e051158580c561a8d8863622ba2f4c8e.camel@linux.ibm.com>
References: <20230308171119.1784326-1-roberto.sassu@huaweicloud.com>
         <b8ed9f24e051158580c561a8d8863622ba2f4c8e.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBnNl32kAlk6WSBAQ--.23696S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr18Gw47uw18tr47uw43trb_yoWkCFbE9r
        409r48Gws5GrZ29a4Iy3sFvr4xKa18AFn5Gw43tw1ayrWfXFs7ta95Xa4fXr1rCws7Zr93
        WryrZFW7tw1IgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj4Zd2wAAs8
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-03-08 at 19:23 -0500, Mimi Zohar wrote:
> On Wed, 2023-03-08 at 18:11 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs willing to be
> > the last, e.g. the 'integrity' LSM, without changing the kernel command
> > line or configuration.
> 
> ^needing to be last

Ok.

> > Also, set this order for the 'integrity' LSM. While not enforced, this is
> > the only LSM expected to use it.
> > 
> > Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled
> > and put at the end of the LSM list.
> > 
> > Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true if an
> > LSM is found, regardless of its order. In this way, the kernel would not
> > wrongly report that the LSM is not built-in in the kernel if its order is
> > LSM_ORDER_LAST.
> > 
> > Fixes: 79f7865d844c ("LSM: Introduce "lsm=" for boottime LSM selection")
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Thanks, Roberto.  With this patch, 'integrity' can be safely removed
> from CONFIG_LSM definitions.

Perfect, will add the new patch.

Thanks

Roberto

