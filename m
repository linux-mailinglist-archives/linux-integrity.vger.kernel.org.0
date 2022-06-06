Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB08A53E051
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jun 2022 06:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiFFDys (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Jun 2022 23:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiFFDyr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Jun 2022 23:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2736161604
        for <linux-integrity@vger.kernel.org>; Sun,  5 Jun 2022 20:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654487685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i5iEgTqlGFXZU9nwYiUMELTTny6xbpViLZQTc0dGuT4=;
        b=BzZuxR8mdyJmle1i+qlgyTMovPqXJQwSa3pymMzUPg2SsZdA5zF/4fM+eeFpdZyccSUsMF
        NV3RI3jZeaiicOhZQx1wEZP23CVklfgRauclhPSlhLfNFGoLv1PNySrLHazJCF+fvU0qNm
        XkHaL11Q+bTba639kecBUkoM/YG1ZAo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-IQrCFuIjN8215spNptb1Rg-1; Sun, 05 Jun 2022 23:54:42 -0400
X-MC-Unique: IQrCFuIjN8215spNptb1Rg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41FCD398CA60;
        Mon,  6 Jun 2022 03:54:41 +0000 (UTC)
Received: from localhost (ovpn-12-209.pek2.redhat.com [10.72.12.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB65D403371;
        Mon,  6 Jun 2022 03:54:38 +0000 (UTC)
Date:   Mon, 6 Jun 2022 11:54:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jonathan McDowell <noodles@fb.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
Subject: Re: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Message-ID: <Yp16e5hMphomr2+H@MiWiFi-R3L-srv>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <8634d4dd0813b9522f039ed211023c2c65c6f888.camel@linux.ibm.com>
 <YpSC4AQInLM73wex@noodles-fedora.dhcp.thefacebook.com>
 <e7758ed1-5dcb-80dd-092a-a6bb21c3997d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7758ed1-5dcb-80dd-092a-a6bb21c3997d@intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 06/03/22 at 08:55am, Dave Hansen wrote:
> On 5/30/22 01:40, Jonathan McDowell wrote:
> > Borislav,
> > 
> > I don't think there are any outstanding review comments for me to deal
> > with on this, so is it safe to assume it'll get picked up at some point
> > once the merge window calms down?
> 
> Nothing here looks too crazy, but it's still been _very_ lightly
> reviewed.  It doesn't seem like anyone from the kexec world has seen it,
> for instance.
> 
> Mimi's review was a great start, but it would be really nice to make
> sure that the kexec bits look good.

The change looks good from kexec/kdump side. Not sure if Eric has
any concern.

