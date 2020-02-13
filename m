Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4067115CAF1
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 20:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBMTLK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 14:11:10 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38455 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMTLK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 14:11:10 -0500
Received: by mail-qk1-f195.google.com with SMTP id z19so6771774qkj.5
        for <linux-integrity@vger.kernel.org>; Thu, 13 Feb 2020 11:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z7aOSWuLEXC3QWm9MD9qurhQUfeTA+/4KGcCkfiOHcE=;
        b=AA1bG+ykJH1UNb4pxYT1DRp8cQUs/hJcgAG0vxemSOa9k56a2nqHwlEcU7womP4vnj
         BWhSfUtBs7pLrN5+tbQ6R4n5gcJ+RszY/1WlT+4c54AHBK0rLB2E0qsZfPa0DNEmJnn5
         ddTz4chJRjClFHzJhRhuCtNf6qqvdpbn+AWyS0IEoucJf9SQI1wyqnPvUsVR22SOUNRE
         JwNaiIjjd3Ng7io91MJ1iv5yduR/rlagirKMiLGINMtyKeFAoS6y9FZhWKD6zYyG6yJP
         TC5rDD4hvG1w1OWwF8cds08P7WtMrDgB7TlIm/+WyyQTAXaZpvScplKts1RpXW/0HRjY
         bznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z7aOSWuLEXC3QWm9MD9qurhQUfeTA+/4KGcCkfiOHcE=;
        b=TIsyAE1GNLv4QXh9EoWgL2fqfmq/8O7/JQTk3WEnZKenGar+cPIAafK61dRTNIR0bc
         o3Stgr/gx0PLHZrl1PCcisozb+OI7Pxge9tqiv5ODEzASzt/pIam2ufr3txSwrMegIyn
         kOrxO8URKRtuf5l2zEECqby6gXb9T1J4mNi6SsPQxk6QwaMh4olB1I9JKZkSFlqNU9ry
         wm2gD/hKZRIIU3h4OVl4+T6cfJi54cEiZ7fK3Z4nmplktQQGFXq8FAMbnGbXWNMJHT8/
         MMuUXtWbkpCE/9eTYCaNNWyWHXf8Tojfmc936U7OD9DiBkxEKfqSrczMj+2I//7dUZ6Q
         y99w==
X-Gm-Message-State: APjAAAXOx5uyxfpgxyQuTTbxBFr524l+tU/1dgxP6wI8oBCIreDbUx/Z
        lqo3BPmQnZjjEc58+lNJBLiIvg==
X-Google-Smtp-Source: APXvYqwuYuovSukDYVadOXJ2XDdtto4wITPY05K566ucI4/YjzeB2b8/J+smH2s5pGfSSKdn5i447Q==
X-Received: by 2002:a37:6785:: with SMTP id b127mr15647287qkc.240.1581621069498;
        Thu, 13 Feb 2020 11:11:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m10sm1800193qki.74.2020.02.13.11.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 11:11:08 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2JtE-0002YV-Ej; Thu, 13 Feb 2020 15:11:08 -0400
Date:   Thu, 13 Feb 2020 15:11:08 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Nayna <nayna@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        gcwilson@linux.ibm.com
Subject: Re: [PATCH 3/3] tpm: ibmvtpm: Add support for TPM 2
Message-ID: <20200213191108.GO31668@ziepe.ca>
References: <20200204132706.3220416-1-stefanb@linux.vnet.ibm.com>
 <20200204132706.3220416-4-stefanb@linux.vnet.ibm.com>
 <a23872ef-aa23-e6b0-4b69-602d79671d4b@linux.vnet.ibm.com>
 <d805c04b-3680-97d5-8ea7-82409c7ef308@linux.ibm.com>
 <20200213183508.GL31668@ziepe.ca>
 <b424faea-33a7-8e5a-caac-f322fad68118@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b424faea-33a7-8e5a-caac-f322fad68118@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 13, 2020 at 02:04:12PM -0500, Stefan Berger wrote:
> On 2/13/20 1:35 PM, Jason Gunthorpe wrote:
> > On Thu, Feb 13, 2020 at 01:20:12PM -0500, Stefan Berger wrote:
> > 
> > > I don't want side effects for the TPM 1.2 case here, so I am only modifying
> > > the flag for the case where the new TPM 2 is being used.  Here's the code
> > > where it shows the effect.
> > I'm surprised this driver is using AUTO_STARTUP, it was intended for
> > embedded cases where their is no firmware to boot the TPM.
> 
> The TIS is also using it on any device.

TIS is a generic driver, and can run on TPMs without firmware
support. It doesn't know either way

> > Chips using AUTO_STARTUP are basically useless for PCRs/etc.
> > 
> > I'd expect somthing called vtpm to have been started and PCRs working
> > before Linux is started??
> 
> Yes, there's supposed to be firmware.
> 
> I only see one caller to tpm2_get_cc_attrs_tbl(chip), which is necessary to
> call. This caller happens to be in tpm2_auto_startup.

That seems to be a mistake, proper startup of the driver should never
require auto_startup.

Jason
