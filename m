Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30B66F8792
	for <lists+linux-integrity@lfdr.de>; Fri,  5 May 2023 19:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjEER0M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 May 2023 13:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjEER0L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 May 2023 13:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D693E6C
        for <linux-integrity@vger.kernel.org>; Fri,  5 May 2023 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683307523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g1Bpo+/8mdg0BcQOaDhW+K6AV5WuIljiAVrbRU3WN+E=;
        b=C6sF4I4KvMqHm1dUFlr9evXORfk0jXRc/alOJjzflGwtoO3ByOfvU88w27kKA+9MIjNzsV
        2l0ANPjCOR+hFyZqV7kzQ4wTgVlQtdMx2WhWMj44WRBcAcEbmzFuUDr437nlVCOigLkyzS
        Z8SiKouqolX4Bh5sALZyF+F7BXerFEs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-fmUuOskIPk6R1fn1rB7rlA-1; Fri, 05 May 2023 13:25:22 -0400
X-MC-Unique: fmUuOskIPk6R1fn1rB7rlA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-751409fae81so213028285a.1
        for <linux-integrity@vger.kernel.org>; Fri, 05 May 2023 10:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683307521; x=1685899521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1Bpo+/8mdg0BcQOaDhW+K6AV5WuIljiAVrbRU3WN+E=;
        b=AAF5xVBqkKJ596AYzjzOZowEXqaS7hzjh/1lpX0tPcXMaJd+wSjyUdU2Nm+OnAy+ss
         LflqCzU3MUlkVJwj6ri0dbgGKJWEz6aRgegV6/XuMtw1wDjMEdCN53s1CG1xpv/6IhNY
         Z54InVTMxDUkERdsNn2VwCGPOdkA59v3fxa2eYDGJcx/OZgP5/KDK2jYzP4KKIzGJkSI
         iDnSUPqupqc8xPgFCrCIgy7KckZseh9ULUxbLROkyV1JSJu4AikbdI5egGa59SVocMBJ
         TN59P2HLpXIoENUHWwOsqE2B3UKDdPTf+2SgEWCilSl2+vOZU+W+dBJYiTniJkT2FZZt
         agug==
X-Gm-Message-State: AC+VfDxVA+wd8vs/FPR7ySmZ0U4EHwTlCFijJJagtEj58N8/VSWZ2/nB
        il+fp3XwoiU+7HTAQCvx4QAtG3U90Sjj8R0YqitHDbj8BoEiLtOkQoiU6Mfwxo/RXvh7DrZEmEy
        PzLJf8jnk2ESkFTraUvypybJ+eotb
X-Received: by 2002:a05:6214:29e4:b0:5ef:739a:1c46 with SMTP id jv4-20020a05621429e400b005ef739a1c46mr2952140qvb.1.1683307521687;
        Fri, 05 May 2023 10:25:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5imN5N9GIC7dzfFAOWtj0K2HPQRe/ppRy2gFMkO+PHvi4F2j9kg5oq4lWEhfv/CuQrL7JL2g==
X-Received: by 2002:a05:6214:29e4:b0:5ef:739a:1c46 with SMTP id jv4-20020a05621429e400b005ef739a1c46mr2952126qvb.1.1683307521434;
        Fri, 05 May 2023 10:25:21 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id j8-20020a05620a000800b0074411b03972sm721761qki.51.2023.05.05.10.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:25:20 -0700 (PDT)
Date:   Fri, 5 May 2023 10:25:19 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, hdegoede@redhat.com,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: tpm_sis IRQ storm on ThinkStation P360 Tiny
Message-ID: <qn4nu342cvqfiloh3vdgaqzpppecpqti4uw4jbhwpa7ixljper@fcbcr3tfk7md>
References: <20230505130731.GO83892@hirez.programming.kicks-ass.net>
 <toe7jsgedknsqj3dgw2fasjlqcpgpiqgloifxow4vnt3tntabw@l6emb5zpbff5>
 <20230505171915.GA1821641@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505171915.GA1821641@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 05, 2023 at 07:19:15PM +0200, Peter Zijlstra wrote:
> On Fri, May 05, 2023 at 08:05:53AM -0700, Jerry Snitselaar wrote:
> 
> > It will poll like it has for years with tpm_tis.interrupts=0 so that
> > should be working as it was prior to 6.3 when interrupts were re-enabled
> > for tpm_tis. Are you seeing this with 6.2 as well? IIRC with that Thinkpad
> > case is when it was first realized that interrupts had accidentally been
> > disabled for tpm_tis at one point by a change.
> 
> v6.2 gets me:
> 
> [    8.888394] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1D, rev-id 54)
> [    8.891123] tpm tpm0: [Firmware Bug]: TPM interrupt not working, polling instead
> 
> > I guess myself or someone else needs to revisit catching this in
> > general when the irq storm happens, and disabling interrupts for
> > tpm_tis. I think last time I was incorporating some feedback from
> > tglx, let my adhd get me distracted with some other issue and never
> > returned to it.
> > 
> > The diff below should (compile tested) work for the P360, but
> > tpm_tis.interrupts=0 is a good work-around.
> 
> Yep, I suppose it would. I'll keep the kernel parameter for now, that's
> easier than making sure I consistently apply that patch.
> 
> Thanks!

Yeah, going back and looking at the history it was the first attempt
that re-enabling interrupts that I think made it show up on the
Thinkpad.

I'll see if I can finish up that patch I was working on before since
this will probably be coming up again now that the interrupts were
re-enabled.

Thank you for the 6.2 info.

Regards,
Jerry

