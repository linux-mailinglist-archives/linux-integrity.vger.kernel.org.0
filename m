Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310F420A3FE
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 19:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406796AbgFYR2F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406790AbgFYR2F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 13:28:05 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B265AC08C5DC
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 10:28:04 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q198so6133042qka.2
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gmdzvrjKvy7zOpV1NRuITfFsyUSJo95kHGnNoBx7SWo=;
        b=TG9W9c4fV8P6kucxRYY3WhM2fQlAiAfIIHNf+B91GL+OmpVqBJMnTwRomjo8dY9iXX
         0oxVntm0rbHyQFyWnEM89Cp/zgkg5WR1n6V9kxDTSAIGh6lIjQ1jKao1bHnl65Q6/xqg
         T7wvSq8GyUeJllsfC0yvy7re3wM3HR+Ry2XJqwse0iL5SQngYN6k709OssiNChYg9LYv
         ZxERXwJiEJW+zNJB6g9HXkqQzV4X85ZMpva36rHTOcOOle3+v0ET8+tkf2xk0t7QXMIb
         egFAEImp4Wfl7FVeAui2jZuWmFBhpeOTnutWojoevEj7dyOWn2YT29KHLHvEdvZJ0gVi
         Tkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gmdzvrjKvy7zOpV1NRuITfFsyUSJo95kHGnNoBx7SWo=;
        b=l884k0bwq+XbGxMl5O0ABZU4TlKFw/IDFWJ0uHg5qNe91L7qyLkbF3+duBXGZcORDW
         0cRs8SWA7TxRyycBUVlhG+J9uNAkRFZ55Nx6cLjrOpmkWbDCVJUPVEUYAdiRi5SLw9dt
         Sxux0LoVwr4eHQm5JKWzkP87F7Ng0CtfOE/hiVYj3FuOtCnyDy4VnrEebEn0gyNR10DH
         LuH2oksg4WEh6put6HCddRkc5wlDrRb2G8OCWQmY9SZJWhp78KrfZ8+4YdortC0zMxlc
         uJz8Yon+136jGcsnou/laaZCQeT3Jz25U8hTkrdXqK+GSzrCfxxtz+dlfYLxBzrr1awQ
         Iwgw==
X-Gm-Message-State: AOAM530cH8W2tOCtbDXBnMqcYhdkgnViyjW93GgpJShFp93jJayEdvzo
        ZTiRPbrnuf2+CZK8WG66sjVOevZ/bSaOnQ==
X-Google-Smtp-Source: ABdhPJycbq62BggoDK0636NrdFXplcmFZ/swXm/+3aPR05wce0Y58DlZyNHuDGwiEpqljWYajCu0Vg==
X-Received: by 2002:a37:46ca:: with SMTP id t193mr1551563qka.293.1593106083838;
        Thu, 25 Jun 2020 10:28:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l46sm1431464qtf.7.2020.06.25.10.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 10:28:03 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1joVfO-00EGZI-KT; Thu, 25 Jun 2020 14:28:02 -0300
Date:   Thu, 25 Jun 2020 14:28:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Enabling interrupts in QEMU TPM TIS
Message-ID: <20200625172802.GS6578@ziepe.ca>
References: <1ca3a53d-2b83-7522-5ce1-83d9cc2f207d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ca3a53d-2b83-7522-5ce1-83d9cc2f207d@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 25, 2020 at 10:56:43AM -0400, Stefan Berger wrote:
> Hello!
> 
>  I want to enable IRQs now in QEMU's TPM TIS device model and I need to work
> with the following patch to Linux TIS. I am wondering whether the changes
> there look reasonable to you? Windows works with the QEMU modifications
> as-is, so maybe it's a bug in the TIS code (which I had not run into
> before).
> 
> 
> The point of the loop I need to introduce in the interrupt handler is that
> while the interrupt handler is running another interrupt may occur/be posted
> that then does NOT cause the interrupt handler to be invoked again but
> causes a stall, unless the loop is there.

That seems like a qemu bug, TPM interrupts are supposed to be level
interrupts, not edge.

Jason
