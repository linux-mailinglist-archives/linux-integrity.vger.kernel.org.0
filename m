Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A77716BB8
	for <lists+linux-integrity@lfdr.de>; Tue, 30 May 2023 19:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjE3R6A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 May 2023 13:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjE3R55 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 May 2023 13:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A17311F
        for <linux-integrity@vger.kernel.org>; Tue, 30 May 2023 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685469421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyKFKLtIu90hBDIg15YSYvy11Kb1QZe6D7iw0TE90QU=;
        b=hv2Z4F4zOeKFRxZ6U39bSgBJskMyFWAWdUWuzTTDqnMhqqHwZRGMND1EKheHgAx/Pl7blV
        zYiRyjSr2x22beM/c8V13fODiC21mJmW3Ux8CYMaJjG9SOAtTYoatTR/DYfrpe/l6Oi31/
        Q1cXsNK8oWksizZtuEHwDKrEmJo6KZ8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-kKtJy-XRM3ep7ABwXrr6aw-1; Tue, 30 May 2023 13:56:59 -0400
X-MC-Unique: kKtJy-XRM3ep7ABwXrr6aw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f6accf92e2so587171cf.0
        for <linux-integrity@vger.kernel.org>; Tue, 30 May 2023 10:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685469419; x=1688061419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyKFKLtIu90hBDIg15YSYvy11Kb1QZe6D7iw0TE90QU=;
        b=CqV58it56XgqmH6GKERQkDt3ygALrGaZb2tB2Xm0ZZlCdWF+yjMNAgcTvb+Lr5rm3B
         wkFpXLHhQx92BItda+gNGBuEQTnmZ26S+PoDAgkrVHQNl2cYvc7lnj6yr9emef8CtyKL
         QLM3PDNsfEsMOIT4EJ+K8iYqELABGfoy16fEDur3h4pxSGVpoDtOCA2FISOR9GcJZ/jy
         M44int9t0OkRNBsmL3GpaAVVg3I9aZIZ32trUkE9L5ihf1cvc1rmU6Zl7GEDwPs4Hvqp
         u0qPqp7Pai3khqX3PkM7RYj8UC9vLAu9Loghf6AldWGvPN2oLIUaB/fVyXt6Jq7emmha
         0o3g==
X-Gm-Message-State: AC+VfDxwp/NZDoIoF8b1VG7ybqYa5tyU4EoNhHhnD5jU94djjrdOjKaw
        bPteLvgE7tJszPkFVdQXRzj8ZoL6kAmwQsGDfnsdN1voPAtiZBEyh+c54S5ZCVAEtp3Uwcut6E1
        fdSMMec42dlo29NdJW1UAuHZGTpb5
X-Received: by 2002:a05:622a:1009:b0:3f6:b4bf:8ac6 with SMTP id d9-20020a05622a100900b003f6b4bf8ac6mr12054073qte.27.1685469418994;
        Tue, 30 May 2023 10:56:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4slbTuvpq5c7Z5B8w/Gq7x3c0ZpfM7wOsA7FmfXU6XF++zKQp9rZ/sglxYsXPhMx3TdqsiAg==
X-Received: by 2002:a05:622a:1009:b0:3f6:b4bf:8ac6 with SMTP id d9-20020a05622a100900b003f6b4bf8ac6mr12054049qte.27.1685469418687;
        Tue, 30 May 2023 10:56:58 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z4-20020ac84544000000b003f38f55e71asm4878069qtn.47.2023.05.30.10.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:56:58 -0700 (PDT)
Date:   Tue, 30 May 2023 10:56:56 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com, peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Message-ID: <xkp3zaclvqx6pv4qh4wv7jttqby4lp2atsrareb63ofi7sy2qp@hfugy3pyac4o>
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
 <da435e0d-5f22-fac7-bc10-96a0fd4c6d54@kunbus.com>
 <a84c447f-cdfb-d33c-62cb-bb5d9aa8510b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a84c447f-cdfb-d33c-62cb-bb5d9aa8510b@linux.intel.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 29, 2023 at 09:46:08AM +0300, Péter Ujfalusi wrote:
> Hi Lino,
> 
> On 23/05/2023 23:46, Lino Sanfilippo wrote:
> >> On the other hand any new functionality is objectively a maintanance
> >> burden of some measure (applies to any functionality). So how do we know
> >> that taking this change is less of a maintenance burden than just add
> >> new table entries, as they come up?
> >>
> > 
> > Initially this set was created as a response to this 0-day bug report which you asked me
> > to have a look at:
> > 
> > https://lore.kernel.org/linux-integrity/d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org/
> > 
> > My hope was that it could also avoid some of (existing or future) DMI entries. But even if it does not
> > (e.g. the problem Péter Ujfalusi reported with the UPX-i11 cannot be fixed by this patch set and thus
> > needs the DMI quirk) we may at least avoid more bug reports due to interrupt storms once
> > 6.4 is released. 
> 
> I'm surprised that there is a need for a storm detection in the first
> place... Do we have something else on the same IRQ line on the affected
> devices which might have a bug or no driver at all?
> It is hard to believe that a TPM (Trusted Platform Module) is integrated
> so poorly ;)
> 
> But put that aside: I think the storm detection is good given that there
> is no other way to know which machine have sloppy TPM integration.
> There are machines where this happens, so it is a know integration
> issue, right?
> 
> My only 'nitpick' is with the printk level to be used.
> The ERR level is not correct as we know the issue and we handle it, so
> all is under control.
> If we want to add these machines to the quirk list then WARN is a good
> level to gain attention but I'm not sure if a user will know how to get
> the machine in the quirk (where to file a bug).
> If we only want the quirk to be used for machines like UPX-i11 which
> simply just have broken (likely floating) IRQ line then the WARN is too
> high level, INFO or even DBG would be appropriate as you are not going
> to update the quirk, it is just handled under the hood (which is a great
> thing, but on the other hand you will have the storm never the less and
> that is not a nice thing).
> 
> It is a matter on how this is going to be handled in a long term. Add
> quirk for all the known machines with either stormy or plain broken IRQ
> line or handle the stormy ones and quirk the broken ones only.
> 
> >>> Detect an interrupt storm by counting the number of unhandled interrupts
> >>> within a 10 ms time interval. In case that more than 1000 were unhandled
> >>> deactivate interrupts, deregister the handler and fall back to polling.
> >>
> >> I know it can be sometimes hard to evaluate but can you try to explain
> >> how you came up to the 10 ms sampling period and 1000 interrupt
> >> threshold? I just don't like abritrary numbers.
> > 
> > At least the 100 ms is not plucked out of thin air but its the same time period
> > that the generic code in note_interrupt() uses - I assume for a good reason.
> > Not only this number but the whole irq storm detection logic is taken from 
> > there: 
> > 
> >>
> >>> This equals the implementation that handles interrupt storms in
> >>> note_interrupt() by means of timestamps and counters in struct irq_desc.
> >> The number of 1000 unhandled interrupts is still far below the 99900
> used in
> > note_interrupt() but IMHO enough to indicate that there is something seriously
> > wrong with interrupt processing and it is probably saver to fall back to polling.
> 
> Except that if the line got the spurious designation in core, the
> interrupt line will be disabled while the TPM driver will think that it
> is still using IRQ mode and will not switch to polling.
> 
> A storm of 1000 is better than a storm of 99900 for sure but quirking
> these would be the desired final solution. imho

If that is the case, then output could probably be sent to the console
detailing the dmi info needed to update the table.

Regards,
Jerry

> 
> There are many buts around this ;)
> 
> -- 
> Péter

