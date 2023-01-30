Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CA768106F
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jan 2023 15:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbjA3ODg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 09:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbjA3ODZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 09:03:25 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443F23B3EC
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jan 2023 06:03:16 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P58nl2CvMz9xFQv
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jan 2023 21:55:07 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHXGMQztdj48zaAA--.44276S2;
        Mon, 30 Jan 2023 15:03:02 +0100 (CET)
Message-ID: <c5b46ac1e81b60aefebcf81dabe9e5a911a259a4.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Mon, 30 Jan 2023 15:02:48 +0100
In-Reply-To: <420799029373c9e0feae4eb21ca27b7253494591.camel@linux.ibm.com>
References: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
         <20230126163812.1870942-3-roberto.sassu@huaweicloud.com>
         <5a2b46ef-71de-03f5-3d4d-ef6834a33971@linux.ibm.com>
         <36d25da9b9b6aa004311e083a67bc44f3edcf05c.camel@huaweicloud.com>
         <420799029373c9e0feae4eb21ca27b7253494591.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCHXGMQztdj48zaAA--.44276S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr18WFW3GF1DKry5AFW5KFg_yoWfuwc_ua
        4Fkr95Gw1qyw4xJa12qrZxGry2grWjvr98Jw1xtrnIkFyrZr1kXF4kAayS9w1kCw4SkFy7
        CF4v9w1UC3W5ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbOAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
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
        KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj4RJogAAsV
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-01-30 at 08:28 -0500, Mimi Zohar wrote:
> [Trimmed Cc list, since this is an ima-evm-utils discussion.  Adding
> Petr.]
> 
> On Fri, 2023-01-27 at 08:57 +0100, Roberto Sassu wrote:
> > On Thu, 2023-01-26 at 17:25 -0500, Stefan Berger wrote:
> > > How do you tell the user that the patches need to be applied for the test to
> > > succeed and not worry about it when the patches are not applied?
> > 
> > Uhm, I agree. I should at least write a comment as for EVM portable
> > signatures, and maybe display a message in the test logs.
> 
> This is a generic problem that needs to be addressed.  FYI, LTP
> addressed it by introducing "struct test_tag" in commit ca2c76990
> ("lib: Add support for test tags").

One idea could be to list all the patches the group of tests is going
to check, and add an argument to expect_pass and expect_fail to specify
the indexes of patches required for the test. We print the required
patches in an error message.

Roberto

