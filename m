Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8672272D
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jun 2023 15:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjFENQv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjFENOn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 09:14:43 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B5610D;
        Mon,  5 Jun 2023 06:14:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QZYhq5LLMz9y4yN;
        Mon,  5 Jun 2023 21:04:11 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHc+6p331kUnURAw--.3902S2;
        Mon, 05 Jun 2023 14:14:24 +0100 (CET)
Message-ID: <02a411f0b2cf4dd7908c8810035a166928870f3e.camel@huaweicloud.com>
Subject: Re: [PATCH] evm: Complete description of evm_inode_setattr()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 05 Jun 2023 15:14:14 +0200
In-Reply-To: <5560351701e78a0dfb9b7d2eef703395a0d531b0.camel@linux.ibm.com>
References: <20230306104036.1298529-1-roberto.sassu@huaweicloud.com>
         <c2b7b5531660befc66a25477abc0cc069d08926c.camel@huaweicloud.com>
         <5560351701e78a0dfb9b7d2eef703395a0d531b0.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAHc+6p331kUnURAw--.3902S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFWkXw1fCFW8Ar4rXryfCrg_yoWDCwb_ur
        1jyr1fu3yDXFs7GrZ0gFW7Wrs29ayFvr90gw4DGrnxZwsxG3srXFs7KFWFvw1kGF48Ar9x
        uFyftFZ8Cry2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbo8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
        xhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj4o68wABsm
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-06-05 at 09:12 -0400, Mimi Zohar wrote:
> On Mon, 2023-06-05 at 13:57 +0200, Roberto Sassu wrote:
> > On Mon, 2023-03-06 at 11:40 +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Add the description for missing parameters of evm_inode_setattr() to
> > > avoid the warning arising with W=n compile option.
> > > 
> > > Fixes: 817b54aa45db ("evm: add evm_inode_setattr to prevent updating an invalid security.evm")
> > > Fixes: c1632a0f1120 ("fs: port ->setattr() to pass mnt_idmap")
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Hi Mimi
> > 
> > this probably got lost. It was also reviewed by Stefan:
> > 
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > Could you please take it?
> 
> Thanks for the reminder.  In case kernel-doc changes are backported to
> stable, I've added # v3.2+ and # v6.3+ respectively to the Fixes lines.

Thanks!

> There are two other warnings in EVM.  Any chance you're planning on
> fixing them as well?

Yes, will do.

Roberto

