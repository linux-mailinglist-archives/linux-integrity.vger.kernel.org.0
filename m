Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD2A5B9216
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Sep 2022 03:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiIOBUd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 21:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiIOBUc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 21:20:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA8E3ED7F
        for <linux-integrity@vger.kernel.org>; Wed, 14 Sep 2022 18:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663204831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0bjgK+lBiTyGtI8DZXw0xpj/MCgq70rfPwVLT8sgAVc=;
        b=DAcfD4/LltniI7w8kT0r6OPrO7fBfZzRnQizMgS90h9eRZnsin6W9Jq4264GxUNfIbTHLg
        gmPW9KHH11L2p9ZAyi/3W9F/Blpu1SyQg6iC/0ew5o4oarj6gIlVdNSQq3Gm7LnYhmEKAb
        lWU/yRq+j327oc4Jh2jo4YcFZto85uA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-nDvdEKQIPbKHKqYFLvmIfg-1; Wed, 14 Sep 2022 21:20:27 -0400
X-MC-Unique: nDvdEKQIPbKHKqYFLvmIfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C6B83C0D85A;
        Thu, 15 Sep 2022 01:20:27 +0000 (UTC)
Received: from localhost (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 786D31121314;
        Thu, 15 Sep 2022 01:20:26 +0000 (UTC)
Date:   Thu, 15 Sep 2022 09:20:22 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, akpm@linux-foundation.org,
        nasastry@in.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec
 (ppc64)
Message-ID: <YyJ91vHulTdjri49@MiWiFi-R3L-srv>
References: <20220901214610.768645-1-stefanb@linux.ibm.com>
 <ce08b0af-fb1b-0ade-61ac-f66e95d6eb6a@linux.ibm.com>
 <CAL_JsqJ+M6TP9kWXDAUqqh7wfPHkE8YfEU7j5HWqeGMhL=c6bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ+M6TP9kWXDAUqqh7wfPHkE8YfEU7j5HWqeGMhL=c6bg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 09/14/22 at 01:01pm, Rob Herring wrote:
> On Mon, Sep 12, 2022 at 8:01 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
> >
> >
> > Hi Rob,
> >
> >    can you take this series in your tree?
> 
> IMO, it should be someone that cares about TPM, kexec, or powerpc.
> Yes, there's code in drivers/of/, but that is purely to avoid
> duplication of code across powerpc and arm64.

Looks like a PPC specific improvement, is it possible to have TPM on
other ARCHes? For generic code patch, Andrew kindly help pick them
into his tree if cooked. If it's an arch or component specific code,
we usually ask arch or component maintainer to take it.

For this patchset, it should be merged into ppc tree?

Thanks
Baoquan

