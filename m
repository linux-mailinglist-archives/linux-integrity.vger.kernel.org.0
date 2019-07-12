Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B8F671F3
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfGLPG7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 11:06:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42099 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfGLPG7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 11:06:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id h18so8378897qtm.9
        for <linux-integrity@vger.kernel.org>; Fri, 12 Jul 2019 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JGGUX/cbldm/TnD9/mskWC88ti/jCeqUSGvVPxx+emw=;
        b=k+bfBfE+idKnEyplLW2SYEFU/hbDcBwKAdeuRv4/+cGpDiDtd0hfiCScmssk8k4TBy
         ztKGWKmBq6Wxlxks+7H8tXa7i+61fypAGp3ruxaQ95DzWDDgclH6X1K+b1b5a2+6uodM
         bSbYzdrh7Ig2CQqRaA6ZzNdqFP2r+tf15XkHbgcOvcDumox9tMdR7tGMX46XOo4FazPZ
         ro0HoxHYj6+NqHENO3w0QkssusurCr1N7P+5IU/CO7+Fi4Ao+AYLLdPKB0tuKn4D7+OS
         uauFq7gPrAftVX7MSo6jQnAQc9bkcwbI3gNnfQ3EkLxUWfhMsxXaJhJfmCvOeVcQgyIi
         L5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JGGUX/cbldm/TnD9/mskWC88ti/jCeqUSGvVPxx+emw=;
        b=TXfTQBn6UpHXXSpWLkj6CiDbGlXd5hO5ipSvldDiuvHaQGKNAYpbxFZjY+GJTPdxnf
         dss9ZkiGlPQBzvIkMoPS4CJycBT9/Ifh2l+9RCHQK1PMEmAunJcskQiYu9gjE8BxnJSD
         gVe8J9O7a2eMBZN6dyJxEQTNxKrSLahBfK5bvux8Vp69BiA3CSNQdp/7XRIxVxWjuoN1
         6J+nxX+aFuJTGJZ7vvR2NLb1pQfX4WSdzp19irzelcHtUIqSuvFj1KECjwLWlNUAGO4G
         atgyEoTe2x+r86+/jvJRXRRik/HWShHSXEz6vUQWGNiPDt7uc3totSx+BJADFMOnB0MN
         4CeA==
X-Gm-Message-State: APjAAAWkXETJwbLcxAqxZoTnAlQHPkrYt9CGnOHdxNiJEDnbKbZygpA9
        YiOzm/x3/DYPtmSzDDz5+nOcZA==
X-Google-Smtp-Source: APXvYqw6XqtY67sZEGbjg0qCBxuSa/8bE6zctrNcc3g8mcW8LmqtBRFkPOyC84CvtjeWB5GYrt423Q==
X-Received: by 2002:a0c:99dd:: with SMTP id y29mr7039232qve.61.1562944018347;
        Fri, 12 Jul 2019 08:06:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m5sm3668893qke.25.2019.07.12.08.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 08:06:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlx8S-00022Z-TD; Fri, 12 Jul 2019 12:06:56 -0300
Date:   Fri, 12 Jul 2019 12:06:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Subject: Re: [PATCH] tpm_crb - workaround broken ACPI tables
Message-ID: <20190712150656.GF27512@ziepe.ca>
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
 <20190711145850.GC25807@ziepe.ca>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7C56@ALPMBAPA12.e2k.ad.ge.com>
 <20190711185027.GG25807@ziepe.ca>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7CFE@ALPMBAPA12.e2k.ad.ge.com>
 <CACdnJutS4-N0GgtYPy9GGJ8dVf48VZGF5AFL2raB55bSPKUpNw@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7E2A@ALPMBAPA12.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7E2A@ALPMBAPA12.e2k.ad.ge.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 12, 2019 at 12:41:58PM +0000, Safford, David (GE Global Research, US) wrote:
> 
> > The issue is that the CRB region is mapped into a region marked as ACPI NVS.
> > drivers/acpi/nvs.c claims this region and as a result a resource conflict is
> > generated. Since Windows is clearly fine with other drivers using ACPI NVS
> > regions, the correct fix involves figuring out a way to either share these
> > resources or allow tpm_crb to reclaim the region from the NVS driver. Note
> > that the NVS driver's behaviour is to save and restore NVS regions over
> > suspend/resume, so simply forcibly allocating the resource will result in two
> > separate codepaths touching the region on resume - this seems like a bad
> > outcome. 

I wonder if the CRB in the nvs actually needs to be save/restored in
AMD's implementation?

Sounds like the answer is to have TPM CRB somehow detect NVS and
acquire the resource from it, while somehow sequencing suspend/resume
properly.

Jason
