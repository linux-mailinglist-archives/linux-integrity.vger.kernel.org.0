Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F3A678052
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Jan 2023 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjAWPqp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Jan 2023 10:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjAWPqo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jan 2023 10:46:44 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9554B5FFD
        for <linux-integrity@vger.kernel.org>; Mon, 23 Jan 2023 07:46:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P0vQW3rC1z9xFGW
        for <linux-integrity@vger.kernel.org>; Mon, 23 Jan 2023 23:38:43 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAX6F7Nq85j+wS9AA--.11533S2;
        Mon, 23 Jan 2023 16:46:28 +0100 (CET)
Message-ID: <9eecfa1cd628d3d7c832f2002c0663259d9a587a.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v2 6/9] Add tests for EVM portable
 signatures
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 23 Jan 2023 16:46:06 +0100
In-Reply-To: <4237c8d0c61038abfce21aa461611305bbe19adc.camel@linux.ibm.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
         <20230112122426.3759938-7-roberto.sassu@huaweicloud.com>
         <4b39d880d2ddfec667608222d7ca7a0eed5fe28b.camel@linux.ibm.com>
         <724585556e02178d0b9ce29af057a93ac72f0a87.camel@huaweicloud.com>
         <4237c8d0c61038abfce21aa461611305bbe19adc.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAX6F7Nq85j+wS9AA--.11533S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17Xr47uryUXFy3Jr1kZrb_yoW8GF1Dp3
        yxt3W3KrZIk3s3Jr9Yg3WIqwn2yFn7Kr48X34Ygr4rAr1vv3WDZF1IkF15uFW3KryUCF4S
        9FWDXw43ZrW7J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBF1jj4fyBwAAsA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-01-23 at 10:43 -0500, Mimi Zohar wrote:
> On Mon, 2023-01-23 at 16:31 +0100, Roberto Sassu wrote:
> > On Mon, 2023-01-23 at 09:40 -0500, Mimi Zohar wrote:
> > > Hi Roberto,
> > > 
> > > On Thu, 2023-01-12 at 13:24 +0100, Roberto Sassu wrote:
> > > > +
> > > > +key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
> > > > +if [ -f "$PWD/../signing_key.pem" ]; then
> > > > +       key_path=$PWD/../signing_key.pem
> > > > +fi
> > > > +
> > > 
> > > For testing locally, how about first checking the file exists, before
> > > setting key_path?  On not finding it, perhaps check whether
> > > "/lib/modules/$(uname -r)/build/certs/signing_key.pem" exists.
> > 
> > The precedence is:
> > 
> > TST_KEY_PATH -> ../signing_key.pem -> /lib/modules...
> 
> This is still /lib/modules, just not "source/", but "build/".
> 
> -key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
> +if [ -f "/lib/modules/$(uname -r)/source/certs/signing_key.pem" ]; then
> +       key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
> +elif [ -f "/lib/modules/$(uname -r)/build/certs/signing_key.pem" ]; then
> +       key_path="/lib/modules/$(uname -r)/build/certs/signing_key.pem"
> +fi
> +

Ok, will add it.

Thanks

Roberto

> Mimi
> 
> > If TST_KEY_PATH is not found, probably it is a good idea to not
> > fallback to the other alternatives, as it is user input.
> 
> 

