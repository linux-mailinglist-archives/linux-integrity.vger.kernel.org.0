Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427B666448D
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jan 2023 16:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbjAJPYP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Jan 2023 10:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbjAJPXw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Jan 2023 10:23:52 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD2A16483
        for <linux-integrity@vger.kernel.org>; Tue, 10 Jan 2023 07:23:50 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NrvXR3vstz9xFr4
        for <linux-integrity@vger.kernel.org>; Tue, 10 Jan 2023 23:16:07 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBn7mTygr1j1AaFAA--.24160S2;
        Tue, 10 Jan 2023 16:23:36 +0100 (CET)
Message-ID: <b5bd3a3de9ef924cc5d50551a5fa55a412cd3e3a.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils 3/8] Compile the UML kernel and download
 it in Github Actions
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 10 Jan 2023 16:23:04 +0100
In-Reply-To: <fd70fa2719387961698089af520460beb8f549ea.camel@linux.ibm.com>
References: <20230109165552.3409716-1-roberto.sassu@huaweicloud.com>
         <20230109165552.3409716-4-roberto.sassu@huaweicloud.com>
         <fd70fa2719387961698089af520460beb8f549ea.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBn7mTygr1j1AaFAA--.24160S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFy3trWfuw1UuF45Aw48Crg_yoWxZFc_Wr
        n09ryFy3WqyrWxCwsrZrWkKws5JayDZwn0gry5trW5ZF12grZxG3Z2kFWfKwn7Jw15CFsr
        urW8ZwnIv3Wj9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj4NtegADst
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-01-10 at 10:14 -0500, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Mon, 2023-01-09 at 17:55 +0100, Roberto Sassu wrote:
> > +          pushd linux-integrity
> > +          git pull --depth 5 origin ${{ secrets.LINUX_BRANCH }}
> > +          ./scripts/kconfig/merge_config.sh -m .config ../config-uml
> > +          make ARCH=um olddefconfig
> 
> Should the above two lines be reversed?  First create a .config based
> on the default UML config, then update it with the test specific
> options - security, integrity, IMA, EVM.

Hi Mimi

yes, first .config needs to be created.

Thanks

Roberto

> > +          make ARCH=um $CROSS_COMPILE_OPT -j$(nproc)
> > +          chmod +x linux
> > +          cp linux ..
> > +          cp certs/signing_key.pem ..
> > +          popd

