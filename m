Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15796659B1
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 16:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfGKO6x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 10:58:53 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41121 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbfGKO6w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 10:58:52 -0400
Received: by mail-ua1-f66.google.com with SMTP id 34so2611797uar.8
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VSeJRnMBRlAZgiB5k4Y2qz2kWNE36CEfg4yIjJyqvhE=;
        b=L/vdLv4iVDauOStSoN5mWVpMcCMpjOoSFqQfd3mfscTbN8Y9UeXWvcvhdIAVlUfzT5
         6O/r9B+wfruIvqnFskBw7Rt2gbmG1vHwu55WabIvGYJaFpPrMB3sVKcm1Ps5/6v8OYW+
         D50r7Nn51vewo9BzcGW403mV6x2mkvRypyggRNM+v6Dbk3f+FmoQBJSm6cCo9FXKltTQ
         qp5hPiZ5mjaPv565xL+00d5OizLJDO+s1XGM3pAd7gI2soZvLR0zA6LaZjo1fEYebx45
         udHkj3wAQyeQmeu40sHVyF0L0UZ98SAMSfvHGaXoxM6fW9c3IjPoi8vDnJqDVikBfZeo
         ybOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VSeJRnMBRlAZgiB5k4Y2qz2kWNE36CEfg4yIjJyqvhE=;
        b=NUNIrRK/WTxhpQRuEYb5F0nYlU9HSGOe7hJj0q3dV205clg0p6ssaExK7+SwKfpNrJ
         +wPkIRkVE9sz43oW4s6/ubc3XS8x+szLhRqc6VQwxBxD2NDyMlh4sG4lvFNO9GV/ql4q
         d9CoTdPX3IhGegbIHrdXy9dWMegNL0yKzbDkVBCwSejdV1zVvtPw9fRCJLBWp0FWCnHX
         OBFucBf+S2G+QlwDq08eco03WiKYqcCII5BCs6cfNGDc9+iwYFVYunnyAWsH6a7QHQZE
         H8wcJMPTlK+HACXdGVNlR/Y0tlrn04mTUyfXb3up6pWQEcsdnXi4/Al4C/zkGjEepzZs
         aGwQ==
X-Gm-Message-State: APjAAAWRdejwXGALo9+vL8P14u0eIrCLSx7uS9W8M7mLj8sf1iR9gmT3
        AsP9DNHaw8uAXlKcw96sEWiCRQ==
X-Google-Smtp-Source: APXvYqx0PEFB9yVF5UO+1qNyVKVAiKZDbRnQvbrwzohYVSHo2ASJHYwU+GXVk4cfEboKR1Bjl0r6Qg==
X-Received: by 2002:a9f:248b:: with SMTP id 11mr4948191uar.9.1562857131590;
        Thu, 11 Jul 2019 07:58:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q29sm2850845vsl.3.2019.07.11.07.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 07:58:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlaX4-0006Bc-Ld; Thu, 11 Jul 2019 11:58:50 -0300
Date:   Thu, 11 Jul 2019 11:58:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Subject: Re: [PATCH] tpm_crb - workaround broken ACPI tables
Message-ID: <20190711145850.GC25807@ziepe.ca>
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 11, 2019 at 12:29:30PM +0000, Safford, David (GE Global Research, US) wrote:
> Most x86 desktops and laptops have firmware TPMs which support the
> CRB interface. Unfortunately, the linux tpm_crb driver depends on
> perfectly correct ACPI tables, and there are a *lot* of systems out
> there with broken tpm_crb entries. (Not one of my five tpm_crb
> systems works with the existing driver.) While it is good to
> encourage vendors to fix their firmware, many refuse ("It works on
> Windows"), leaving users in the lurch.
> 
> This patch adds a kernel parameter "tpm_crb.force=1" that works
> around the problem in every case I have tested so far. Basically
> it does two things:
> 	- it trusts the cmd and resp addresses in the CRB registers
> 	- it ignores all alleged IO resource conflicts
> 
> Both workarounds make sense. If there really were an address conflict,
> or if the register values really were wrong, the device would not be
> working at all. And testing with this patch has shown that in every
> case (so far), the problem has been bogus ACPI entries.
> 
> This patch is against the upstream 5.2 kernel.
> 
> Signed-off-by: David Safford <david.safford@ge.com>

I think we need to ask the ioresource and ACPI people how to fix this
properly and automatically. Maybe some ACPI quirk or maybe we try to
resorve the resoruce and fall back to forcing or something

I don't think t a module parameter is the right answer

Jaason
