Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1228B1D02E5
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2020 01:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgELXJ6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 19:09:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40806 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELXJ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 19:09:58 -0400
Received: by mail-oi1-f195.google.com with SMTP id v128so2972117oia.7;
        Tue, 12 May 2020 16:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TjYd3leSKKn51ZfY7qRcr7llrPytDm0GdCIEZD2j8C0=;
        b=YOcW1N/aZdkNavfBhDLaPPKkCJpdD0SC0EMMo/CW1nENoZkg5aEIo6bYvKbmffD4X1
         CpySzjC7Hel/chlTNGwzBwd7jlrviOHs7IsRRZO05yzYV5/la3SjrgUdraxs2srAo0JN
         k+fvGe+iAMogHhPoKpduAbzlJVIYQdSLVCbNf683JQIUWbE9bexnLH4MAn2E05/CUW5Z
         WvJ/umlU21AIS6KAs4eT3QmxF8ZZgsatauhezwgjsy1wlsKSQey3AtK7KYSIs40HEJP+
         lkl0WK8ajuJ6QWWvGUjAxrsWCd2OY/kzjyTDj/YfbbsCBKdjhLxQLjeM/JPSw/QRdS8u
         v5CQ==
X-Gm-Message-State: AGi0PuZAWZFjJXhhxZ3Q5uBdtblrrex3FIgWhfSO8TgzGargqS/EtK9X
        JamKUDjbk+VJpRBS8NVx560jTW2OnA==
X-Google-Smtp-Source: APiQypIp6z6XpDyeSpU/MQIh4PPKcXp8UTWOTpvjD0Pwk05Fb3joF3Y1t4vigT4+SMH68vOz8q6/qQ==
X-Received: by 2002:aca:c68b:: with SMTP id w133mr23020989oif.27.1589324996924;
        Tue, 12 May 2020 16:09:56 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 34sm385316otq.67.2020.05.12.16.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 16:09:56 -0700 (PDT)
Received: (nullmailer pid 16218 invoked by uid 1000);
        Tue, 12 May 2020 23:09:54 -0000
Date:   Tue, 12 May 2020 18:09:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, masahiroy@kernel.org, james.morse@arm.com,
        bhsharma@redhat.com, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        gregkh@linuxfoundation.org, nramas@linux.microsoft.com,
        tusharsu@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [RFC][PATCH 1/2] Add a layer of abstraction to use the memory
 reserved by device tree for ima buffer pass.
Message-ID: <20200512230954.GB2654@bogus>
References: <20200504203829.6330-1-prsriva@linux.microsoft.com>
 <20200504203829.6330-2-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504203829.6330-2-prsriva@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 04, 2020 at 01:38:28PM -0700, Prakhar Srivastava wrote:
> Introduce a device tree layer for to read and store ima buffer
> from the reserved memory section of a device tree.

But why do I need 'a layer of abstraction'? I don't like them.

> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> ---
>  drivers/of/Kconfig  |   6 ++
>  drivers/of/Makefile |   1 +
>  drivers/of/of_ima.c | 165 ++++++++++++++++++++++++++++++++++++++++++++

Who are the users of this code and why does it need to be here? Most 
code for specific bindings are not in drivers/of/ but with the user. It 
doesn't sound like there's more than 1 user.

>  include/linux/of.h  |  34 +++++++++
>  4 files changed, 206 insertions(+)
>  create mode 100644 drivers/of/of_ima.c
