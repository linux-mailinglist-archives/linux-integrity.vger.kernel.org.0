Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB9E20A8BB
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 01:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407763AbgFYXTh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 19:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407754AbgFYXTg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 19:19:36 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B12BC08C5DB
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 16:19:36 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q8so7927661iow.7
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 16:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gXl5/p0573ZJRbwiRmTK/Thk5dGxKEwaqQGqi7gfkCU=;
        b=AOwchFPXuB/qlH4hAxwdiSdqbb9aYQFbZLFGcBEkoPeblxHTmtuRSHADfp3j9QvBi7
         PeKPqGL35L9BwaDBE8fBu7iWey5Hb4wToVoUsCFWnwP8OZIgI7EcRrK5gsq7XpfI13kc
         S+4ihWYlIEt5v4sFwMgGd79cXikvnytF8strBN2DGifolDdiVdGj1JKOl2pidZ3qRK9T
         aMkq7xG2w7c6OkApGQdc52mzQ2oSL+WNqyPQSdSkM/gckwfkYnNZMIgX7cZDKwnVR4VV
         yuFRFFVTamKNMnAkIaMhdEmOic8OGEMz36BFlsWSmAv79fCC2adrAzi3sKWf5jzjudyJ
         VvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gXl5/p0573ZJRbwiRmTK/Thk5dGxKEwaqQGqi7gfkCU=;
        b=Jsn7Iw6RmHdHtK/NV+WJatiE81mrMNwgw3LRRLwXRLghLpAGJ23WEFjiI6ylEaSxjQ
         S8DI/mKhUycVa5lDG7qZ4LvHhH3jAFFzOvSqnk62+uv2FNOwNxG6HhceB1LpmhpAaKdd
         eMSGCeUi5QXpZSFIuN4qJpxyRZOXT151bGq1s15Xpq4p9Fb2gYnAv1847hlC2WeR7RDo
         rGGbd+ARxQ+xTEC21FEH/rtulWNY3yQZW00+hEe19ioFUKoORFIHUmLsP7KFUD+pxdA/
         Hp7/6zAhM5CNXHppOfQFbzJ0EPg5KDzczvOKKtlnx7+mqAqSychcJjC27DjTLNlOaWJC
         3j0A==
X-Gm-Message-State: AOAM5308lCH/8qYAKAxgbelkVnfvEEclhO0ZIE8vwZkRGdnAdafYox7d
        8ETbUiFmZ49bt6HfqLXDEsmpZA==
X-Google-Smtp-Source: ABdhPJzQDaH1oCH1pHv0A4+sqnoZhHGPK3PU4SwGFAnZ7cKvuI1IKycPTSvNpZOsmJlIPWwF6qQzZw==
X-Received: by 2002:a5d:914d:: with SMTP id y13mr552819ioq.48.1593127175678;
        Thu, 25 Jun 2020 16:19:35 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c20sm14155116iot.33.2020.06.25.16.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:19:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1job9a-00ENMt-33; Thu, 25 Jun 2020 20:19:34 -0300
Date:   Thu, 25 Jun 2020 20:19:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Enabling interrupts in QEMU TPM TIS
Message-ID: <20200625231934.GU6578@ziepe.ca>
References: <1ca3a53d-2b83-7522-5ce1-83d9cc2f207d@linux.ibm.com>
 <20200625172802.GS6578@ziepe.ca>
 <0a524093-e744-e266-6087-ddc17b5c598c@linux.ibm.com>
 <5b3267b7-57d5-badf-6664-9d47bc9909e7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b3267b7-57d5-badf-6664-9d47bc9909e7@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 06:48:09PM -0400, Stefan Berger wrote:
> On 6/25/20 5:26 PM, Stefan Berger wrote:
> > On 6/25/20 1:28 PM, Jason Gunthorpe wrote:
> > > On Thu, Jun 25, 2020 at 10:56:43AM -0400, Stefan Berger wrote:
> > > > Hello!
> > > > 
> > > >   I want to enable IRQs now in QEMU's TPM TIS device model and I
> > > > need to work
> > > > with the following patch to Linux TIS. I am wondering whether
> > > > the changes
> > > > there look reasonable to you? Windows works with the QEMU modifications
> > > > as-is, so maybe it's a bug in the TIS code (which I had not run into
> > > > before).
> > > > 
> > > > 
> > > > The point of the loop I need to introduce in the interrupt
> > > > handler is that
> > > > while the interrupt handler is running another interrupt may
> > > > occur/be posted
> > > > that then does NOT cause the interrupt handler to be invoked again but
> > > > causes a stall, unless the loop is there.
> > > That seems like a qemu bug, TPM interrupts are supposed to be level
> > > interrupts, not edge.
> > 
> > 
> > Following this document here the hardware may choose to support
> > different types of interrutps:
> > 
> > https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p04_r0p37_pub-1.pdf
> > 
> > 
> > Table 23. Edge falling or rising, level low or level high.
> > 
> > So with different steps in the driver causing different types of
> > interrupts, we may get into such situations where we process some
> > interrupt 'reasons' but then another one gets posted, I guess due to
> > parallel processing.
> 
> 
> Another data point: I had the TIS driver working on IRQ 5 (festeoi) without
> the introduction of this loop. There are additional bits being set while the
> interrupt handler is running, but the handler deals with them in the next
> invocation. On IRQ 13 (edge), it does need the loop since the next interrupt
> handler invocation is not happening. 

A loop like that is never the correct way to handle edge interrupts.

I don't think the tpm driver was ever designed for edge, so most
likely the structure and order of the hard irq is not correct.

Jason
