Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6886FF55C
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 17:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbjEKPAi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 May 2023 11:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbjEKPAe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 May 2023 11:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782CE40E3
        for <linux-integrity@vger.kernel.org>; Thu, 11 May 2023 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683817166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1GHBw4+cTweg81q2LmlP9R18yygpPwcxBNpR1jxTxX0=;
        b=DOQpMKoeAWE+6w+0mJ/Q/Y5OLUppluA0Bg/+vtzRUqg6oVkppKMLtm5uwkCKeX7KqoE/bc
        thJuzIKo/i/Dwd6FbrZArmtIu5c/DZoKASDEr+2ayOVvardaLCmiLLKktGfbsOwdd3SRvP
        NIWo9DCZV4F/ESdb1k2NhEvD9vJx5sk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-nj0qra4pNIalkZkcTX4_-A-1; Thu, 11 May 2023 10:59:24 -0400
X-MC-Unique: nj0qra4pNIalkZkcTX4_-A-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ab1e956892so51752535ad.2
        for <linux-integrity@vger.kernel.org>; Thu, 11 May 2023 07:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683817163; x=1686409163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GHBw4+cTweg81q2LmlP9R18yygpPwcxBNpR1jxTxX0=;
        b=NgkrmH8qqKCjPkuRcdEpE8qMQhlEGpeEaqnkvpLvg/7RsGAECUG45capKZS+4lORiC
         +VUS0w6AIX/NKsxkS0CdVxI3c4sc3Fe+iZ8wnCWHK6Gv/JDEdscaxQ7TTrxgWZ2zf6UP
         A/UWiUvTkMsahPmF4aKrnIeGHvwwQhTZzbxz2doNUQHVKgNrZbVawzr10L5C+UAtQksJ
         JtUs4mxjAY2MRmH2LRn7vI/51NNj9D1gP/vFm78qcr1OM60sWkXFNGHEpOAaHSy0Wkwi
         sF+Jy+ISUJabhwBvy5AUL/xcwKTlU+oKxEnHFuSZfKqzI7XR6FOP0b3qsOAW6NihQpwO
         QOXA==
X-Gm-Message-State: AC+VfDyEWhBTDfdjJwcUWnp5shPj9WtfIbRjoRyDtwVbZCN5GHvMK2OQ
        eydlMVe9fzEDbXoZStDa14KrWZBb8dy2chB+i0QUA/ZBXsWp7ccff4QDyXpQYVSxlLRka2HS8tl
        5FmjfaVFNyKClCqzh5S2igkdNkj1G
X-Received: by 2002:a17:902:dac3:b0:1ad:b459:a7e4 with SMTP id q3-20020a170902dac300b001adb459a7e4mr7029549plx.7.1683817163110;
        Thu, 11 May 2023 07:59:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7YCfc8zzwbI8QtHHj7/8f5p4ttf/0yu00ibk/HvuJpRlFLqY+/A509IGdHATqJr0F4f+7exw==
X-Received: by 2002:a17:902:dac3:b0:1ad:b459:a7e4 with SMTP id q3-20020a170902dac300b001adb459a7e4mr7029525plx.7.1683817162756;
        Thu, 11 May 2023 07:59:22 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001a9a8983a15sm6006481plb.231.2023.05.11.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:59:22 -0700 (PDT)
Date:   Thu, 11 May 2023 07:59:21 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Jarkko Sakkinen <jarkko@kernel.org>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Michael =?utf-8?Q?Niew=C3=B6hner?= <linux@mniewoehner.de>,
        linux-integrity@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        peterz@infradead.org
Subject: Re: [linus:master] [tpm, tpm_tis] e644b2f498: RIP:acpi_safe_halt
Message-ID: <6nf5n6fdnkhx6taa2mecnsmyw7sdgaz6fbvkqy7jqkyd7jq2u7@ogsi6ije32in>
References: <202305041325.ae8b0c43-yujie.liu@intel.com>
 <d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org>
 <42ea93a1-3186-b8ff-c317-d51f3e13856e@kunbus.com>
 <20230511141607.GA32208@wunner.de>
 <1a8ecf90-80a4-9aac-95e1-9ce0c4e09ba5@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a8ecf90-80a4-9aac-95e1-9ce0c4e09ba5@kunbus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 11, 2023 at 04:22:02PM +0200, Lino Sanfilippo wrote:
> 
> Hi Lukas,
> 
> On 11.05.23 16:16, Lukas Wunner wrote:
> > ATTENTION: This e-mail is from an external sender. Please check attachments and links before opening e.g. with mouseover.
> > 
> > 
> > On Thu, May 11, 2023 at 01:22:19PM +0200, Lino Sanfilippo wrote:
> >> Since beside the one reported by Peter Zijlstra
> >> (https://lore.kernel.org/linux-integrity/CSJ0AD1CFYQP.T6T68M6ZVK49@suppilovahvero/T/#t)
> >> we have another interrupt storm here, it is probably the best to handle those in general
> >> and to disable interrupts in this case to fall back to polling (this is also what Jerry
> >> suggested in the thread above).
> >>
> >> I will try to provide a patch for this.
> > 
> > In tpm_tis_probe_irq_single(), after you've requested the irq,
> > you could convert it to a struct irq_desc (via irq_to_desc()
> > from <linux/irqnr.h>) and cache that pointer in priv.
> > 
> > Then in tis_int_handler(), you could access the irqs_unhandled
> > member of struct irq_desc (from <linux/irqdesc.h>) and check
> > if it exceeds, say, 5000.
> 
> This is the solution I am currently working on, but thanks for confirming that 
> I am on the right track with this :)
> 
> > 
> > If it does, schedule a work_struct which calls disable_interrupts().
> > You can't call that from the IRQ handler because devm_free_irq()
> > waits for the IRQ handler to finish, so you'd deadlock.  You *can*
> > of course clear the TPM_GLOBAL_INT_ENABLE bit from the IRQ handler,
> > though it's unclear to me if that's sufficient to quiesce the
> > interrupt line.
> > 
> 
> Will try this, thx.
> 
> > By reusing the genirq subsystem's irqs_unhandled infrastructure,
> > you avoid having to reimplement all of that.
> > 
> 
> Agreed.
> 
> Regards,
> Lino
> 

Thanks for finishing this off Lino.

IIRC trying to catch the irq storm didn't work in the L490 case for
some reason, so we might still need the dmi entry for that one.

The info that the T490s had a pin wired up wrong came from Lenovo, but
this one even looks to be a different vendor so I wonder how often
this happens or if there is something else going on. Is it possible to
get info about the tpm used in the Inspur system? The datasheet online
doesn't mention it.

Regards,
Jerry

> > Thanks,
> > 
> > Lukas

