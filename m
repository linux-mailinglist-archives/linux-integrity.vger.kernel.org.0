Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A706B1D1B
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Mar 2023 08:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCIHzs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Mar 2023 02:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjCIHyi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Mar 2023 02:54:38 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512311CBCD;
        Wed,  8 Mar 2023 23:54:30 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PXLnx0YDyz9xHvy;
        Thu,  9 Mar 2023 15:45:41 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwB3Rl2OkAlkp2OBAQ--.23244S2;
        Thu, 09 Mar 2023 08:54:01 +0100 (CET)
Message-ID: <250fe1947dd3fea27d8f4aa86fdb9980954b5425.camel@huaweicloud.com>
Subject: Re: [PATCH v7 0/6] evm: Do HMAC of multiple per LSM xattrs for new
 inodes
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 09 Mar 2023 08:53:48 +0100
In-Reply-To: <CAHC9VhTRT=o9Rv+EhZ4aab1FDCyTNa7XEYuhuOiSEkWh0Cdrnw@mail.gmail.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
         <CAHC9VhTRT=o9Rv+EhZ4aab1FDCyTNa7XEYuhuOiSEkWh0Cdrnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwB3Rl2OkAlkp2OBAQ--.23244S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4kGFy8uryfCFWDJw47Jwb_yoWkZFg_u3
        WUt3s7Gws8X3WkGa13tr1agry0g3ykZF1jvryqgr13Xw18JaykAFs7CFsavw15Jay7X3sI
        kr9rZ342y3sIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBF1jj4pbjgACsi
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-03-08 at 17:16 -0500, Paul Moore wrote:
> On Thu, Dec 1, 2022 at 5:42 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > One of the major goals of LSM stacking is to run multiple LSMs side by side
> > without interfering with each other. The ultimate decision will depend on
> > individual LSM decision.
> > 
> > Several changes need to be made to the LSM infrastructure to be able to
> > support that. This patch set tackles one of them: gives to each LSM the
> > ability to specify one or multiple xattrs to be set at inode creation
> > time and, at the same time, gives to EVM the ability to access all those
> > xattrs and calculate the HMAC on them.
> 
> Hi Roberto,
> 
> The v7 draft of this patchset had some good discussion, and based on a
> quick read of the comments it looks like everyone was eventually
> satisfied that the v7 draft was good and no further changes were
> necessary, is that correct or do you have an updated draft of this
> patchset?

Hi Paul

I addressed few more concerns from Mimi and Casey. I think v8 should be
good to send (unless you have more comments/suggestions).

Thanks

Roberto

