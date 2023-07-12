Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96D0750F25
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jul 2023 19:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGLRA5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jul 2023 13:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjGLRA4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jul 2023 13:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B9F2111
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jul 2023 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689181209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V34PBFVRSyPmXY6TnLemmwcb7RItdmjHqC9gKS1fTBo=;
        b=fmKQuv4tvXcPIh/lauKsl5NkUchs/WK6tss+6Z8K2N33DlB3JvIL1+2RULNBvciypm/IVO
        rtEOcnqp1RTaxAdywQqkgl8woR88SEhX5d6PI4GUbFI+M7k365YMuIXzrqzPlYIZ0/tNX4
        aVq8tCPRuLSvqUoYgtrgZUl7JTE3QL4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-VHSW0Q1YOm2SlKQAtb8K4A-1; Wed, 12 Jul 2023 13:00:08 -0400
X-MC-Unique: VHSW0Q1YOm2SlKQAtb8K4A-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7673e4eee45so691482585a.0
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jul 2023 10:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181208; x=1691773208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V34PBFVRSyPmXY6TnLemmwcb7RItdmjHqC9gKS1fTBo=;
        b=CY2h2gI41Ye/gH7NIXxifgoShsgQQsbQ8iBclrhoyYf0WwVX4MW/tz5R1Aik2bK/SL
         77a24SIwKr7vMerVrC/WFyKYhAxunushLXcy2675wtY3Y3lCHQJ6fg3CQVYQo7fi+Rax
         kvwsH0QZX4W+Kp4kfqaIrg9P/SUEj6O468vyJR70BleMrtk9e/qtI1QvQT9alSc9pEUv
         R5mdfYLYoRduJQosjuQddVCfq5QmaYOZ9flIirYYPhGnlrHr+e9c6f+lU8HXycwbQHU7
         6LIgbEvFUJobZ3SuL1JtD4sGj/IGwWcwnxtuvxCRmWdeQMvGPDD5gRDao9Vab+p/egRl
         +l3w==
X-Gm-Message-State: ABy/qLYGuk2nNzzcAWDVQm2AsPpm11Z/D/JFVCAw+fFAyZoQhYKdeksZ
        sQuOarW8RkhpUd3AXOPMKOIdxGi/g6F9yaVi6TDKq4E0WJHZ6k0lsrKvebN5BF196fBigpkC9ko
        pmGuhiQEG+zvdcERctYhfiO88Tj42
X-Received: by 2002:a05:620a:318f:b0:765:4418:cac7 with SMTP id bi15-20020a05620a318f00b007654418cac7mr18968020qkb.73.1689181208070;
        Wed, 12 Jul 2023 10:00:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGfbsBm1Dqr0aQLF1S4fgHLvR9TbsCSLLXCvHTFTZHyd5eS5VdOP6vDZI4492sbHtDleRsIrg==
X-Received: by 2002:a05:620a:318f:b0:765:4418:cac7 with SMTP id bi15-20020a05620a318f00b007654418cac7mr18967998qkb.73.1689181207795;
        Wed, 12 Jul 2023 10:00:07 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id w18-20020a0cb552000000b0063004b5482csm2342328qvd.92.2023.07.12.10.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 10:00:07 -0700 (PDT)
Date:   Wed, 12 Jul 2023 10:00:05 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christian Hesse <mail@eworm.de>, linux-integrity@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>, stable@vger.kernel.org,
        roubro1991@gmail.com
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
Message-ID: <qvt4ndqc23ftspjtpljyv45yfhtxi6oomjios2nuk34bs7n5fi@2ye4znwhgn4a>
References: <20230710133836.4367-1-mail@eworm.de>
 <20230710142916.18162-1-mail@eworm.de>
 <ZKxHfTkgKHYqhBz2@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKxHfTkgKHYqhBz2@ziepe.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 10, 2023 at 03:01:33PM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 10, 2023 at 04:28:43PM +0200, Christian Hesse wrote:
> > This device suffer an irq storm, so add it in tpm_tis_dmi_table to
> > force polling.
> 
> I can't help but feel like we are doing something wrong in the Linux
> driver that we keep having IRQ problems.
> 
> Surely Windows uses the IRQ on these devices? How does it work
> reliably there?
> 
> Jason

I worry about it as well, especially as more vendors get added to the
list. On the other hand it seems like every 6-12 months I am
interacting with vendors that repeatedly forget to have reserved
memory regions added to IVRS and DMAR tables for devices that need
them. So I guess it is possible for the problem to be on their end as
well. For at least one case that someone looked at back in May, it
looked like he could see the issue looking at a schematic for the
system.

Regards,
Jerry

