Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDE15B8F9C
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 22:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiINUS7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 16:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiINUS6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 16:18:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC6B80F5B;
        Wed, 14 Sep 2022 13:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 234AFB81CB4;
        Wed, 14 Sep 2022 20:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC215C4347C;
        Wed, 14 Sep 2022 20:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663186734;
        bh=Lru7PFikr9gooa+rcfmfjS8+VVhSRnx69Y2dyir0dfs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BMstrKotZRuU/6fpqWWtHEls40R0T74xGpA39Hx1Q96QHV0sIzhrkwNF7GMwR3KQX
         Cem6orYPoPcYV6nRPCt7264M+ztbTxaXFucJvvLaGdHu+QlxkrD3nI/k4OA/uP1vLK
         QTssqx3lIM9bk7d+cf3eyUmQDKsiMCMjwqhs6TSeqk61spt5bWd1sqVJ2TD+/8GuxF
         rKXQFdD196CdEdl3h/U2ti1vsDN4pXP18iAsNgwUKDSWl+DTSbLBXTIIDs7xpgO7VY
         9v+uMQxPFBrXq9h8K5qLLoyAes+2K1dPtDLtRgQ+/oPxQ5YU07ULAiEqFh05X0j4G3
         1I51Hz+xU9aLw==
Received: by mail-vk1-f169.google.com with SMTP id g185so8027659vkb.13;
        Wed, 14 Sep 2022 13:18:54 -0700 (PDT)
X-Gm-Message-State: ACgBeo0cWgzks2r6wkavJZLl23zWaCQ6mmEiUgMPOyxIoEh0tKn4i3Ns
        mxO3tTxqLr2HsPDvx1pPoXdVUzIK0l1j4YZ+Gw==
X-Google-Smtp-Source: AA6agR5iKd4zqjkDmalrBk7jisYALPKK0lS1iB8OaES1QH5gwnk2lDL6XD8fe2N0XD9jtwdNmPTFk5W9R/MFUIkxt4A=
X-Received: by 2002:a1f:9e44:0:b0:39e:e4ff:1622 with SMTP id
 h65-20020a1f9e44000000b0039ee4ff1622mr11608618vke.15.1663186733579; Wed, 14
 Sep 2022 13:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220901214610.768645-1-stefanb@linux.ibm.com>
 <ce08b0af-fb1b-0ade-61ac-f66e95d6eb6a@linux.ibm.com> <CAL_JsqJ+M6TP9kWXDAUqqh7wfPHkE8YfEU7j5HWqeGMhL=c6bg@mail.gmail.com>
 <f8c8b3dd-f77b-7917-6029-a288255fee8a@linux.ibm.com>
In-Reply-To: <f8c8b3dd-f77b-7917-6029-a288255fee8a@linux.ibm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 14 Sep 2022 15:18:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLN-7LHJuMhR+kbGb_n09K8usmcfKVzA_fV40FHmqaaDw@mail.gmail.com>
Message-ID: <CAL_JsqLN-7LHJuMhR+kbGb_n09K8usmcfKVzA_fV40FHmqaaDw@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec (ppc64)
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, nasastry@in.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 14, 2022 at 2:46 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>
>
> On 9/14/22 14:01, Rob Herring wrote:
> > On Mon, Sep 12, 2022 at 8:01 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
> >>
> >>
> >> Hi Rob,
> >>
> >>     can you take this series in your tree?
> >
> > IMO, it should be someone that cares about TPM, kexec, or powerpc.
> > Yes, there's code in drivers/of/, but that is purely to avoid
> > duplication of code across powerpc and arm64.
>
> What about 1/4? Can someone else take it into their tree?

I thought that was taken long ago now by Palmer in the riscv tree, but
it seems not.

In any case, it has my Ack, so yes, someone else can take it. It *can*
go in via 2 different trees (as git won't care), but we generally try
to avoid that.

Rob
