Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993FE79EACB
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Sep 2023 16:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241130AbjIMOQ7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Sep 2023 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241185AbjIMOQ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Sep 2023 10:16:58 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF90ABB
        for <linux-integrity@vger.kernel.org>; Wed, 13 Sep 2023 07:16:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rm2JK1PB1z9v7Gj
        for <linux-integrity@vger.kernel.org>; Wed, 13 Sep 2023 22:04:33 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBHnbg8xAFlWTNDAA--.34259S2;
        Wed, 13 Sep 2023 15:16:37 +0100 (CET)
Message-ID: <ea3dc0b080d6ed56c2f90793017d2908ba15718f.camel@huaweicloud.com>
Subject: Re: Linux IMA documentation
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>
Date:   Wed, 13 Sep 2023 16:16:24 +0200
In-Reply-To: <5800e76f-bae5-b3c8-9d0d-51584c93d4ad@linux.ibm.com>
References: <a5ed5a0f-5692-426e-d058-983cf4d9cccb@linux.ibm.com>
         <CUUY4NO1I9DA.1S0KWKJVHQ8K5@seitikki>
         <6ea76738-f587-087d-60ea-ed03adedab62@linux.ibm.com>
         <CVAGSGSJ0NC2.1OQUGKH4ZR0ZB@suppilovahvero>
         <5800e76f-bae5-b3c8-9d0d-51584c93d4ad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwBHnbg8xAFlWTNDAA--.34259S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFykJr4xJrWDJw4rKryDKFg_yoWktrcEyr
        1DAFsak3srtwnFkanrAr47uF92gasFyF1aka4UJr42v34jyayvkF4vgrWSy3s5Gw409Fy5
        Cas8Z3yvv3W3WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbOkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
        Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBF1jj5PbzgAAsh
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-09-06 at 16:54 -0400, Ken Goldman wrote:
> Jonathan:  What should be my next step?
> 
> On 9/4/2023 5:52 PM, Jarkko Sakkinen wrote:
> > On Fri Sep 1, 2023 at 12:46 AM EEST, Ken Goldman wrote:
> > > Thank you.
> > > 
> > > Do you know the process for getting this accepted into the kernel
> > > documentation.
> > 
> > The bulk of the work would be to convert it ReStructured Text and
> > follow the guidelines in https://docs.kernel.org/doc-guide/index.html
> 
> I think I did that.  The source .rst is at
> https://github.com/IBM/ima-doc

I think your document is a good candidate for being put in
Documentation/admin-guide/LSM/, once my patch set is upstreamed:

https://lore.kernel.org/linux-integrity/20230904133415.1799503-1-roberto.sassu@huaweicloud.com/

Thanks

Roberto

> > 
> > You should also CC the documentation patches to:
> > 
> > * Jonathan Corbet <corbet@lwn.net> (maintainer of the documentation)
> > * linux-doc@vger.kernel.org
> 
> Thank you for this.
> 
> >   
> > Perhaps Mimi could help out formalizing this together so I suggest to
> > work with her. I'm also happy to review the documentation once the
> > patches are out.
> 
> Mimi worked with me from the beginning.

