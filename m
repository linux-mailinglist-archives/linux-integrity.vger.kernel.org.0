Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9B31A4893
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2020 18:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDJQia (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Apr 2020 12:38:30 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45668 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgDJQia (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Apr 2020 12:38:30 -0400
Received: by mail-qv1-f67.google.com with SMTP id g4so1173297qvo.12
        for <linux-integrity@vger.kernel.org>; Fri, 10 Apr 2020 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ijj6/UB2JJjCpRv63Ec81U99KKZEYsmrD/Oy/eniVck=;
        b=My3ge2+y8MFEQaJl8W9frIs1HvUO65cvTFhfs/Nlwk9WSD4MkNOD+FOpx/9sYa8Vhr
         oCdmBl3c9uzHTfvwjHwhDpb1UWjtmFYi1Y6Jvm0HuoCA8QhONg6g3roJG1N4icdukV6x
         f/gFiRNN0N6hPXmuwEJvJTgPyjhNSJR7SCruO2jnUJkupuF5tZfWXt3QIWMYmRKIoPnf
         HB4dECmS0C/CbX2P5c/clVlt+2PxqORhs5yu7g7OknT6j8snNkdehrxx5V6iMhAcmSzm
         HOjAebauiNc5yUPchZKVNzIp+nqQ19bLpri7TfF0qOFQdG4Wx5On0o+xfImJiEOXMmd2
         BYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ijj6/UB2JJjCpRv63Ec81U99KKZEYsmrD/Oy/eniVck=;
        b=XufYC0zwMShkQ7bo2GQFrHkX704DU4wvK7VkwOHDgHKT61zjVfqS7ZNbCoomxdMnUH
         nK1Cs9sWjoq5JXT9se2ElfmU0jhnYdGTXLQz5OYY63n8yBEdYe+64X7Y0cd2lkxc4LrH
         jh6+ZDCXPd8dOEaizS5iHEiavLbMuYKGNoP+d5D3wkQi/wpQk29AGOpuc0oKQkhX0oeu
         pJgwJpPm0rlj7aM5R7pOsHPrDx7/NiyhDPhs2aQEDnI/kU2IKkLWJGFvbPfgftH4RWz5
         idm9AB3mfrcH9Oct6o60TeJFYLG1HjoWR95/ARXLH1cO5r1Y8zUsNSRjxZ1TZba6LVWd
         LDVw==
X-Gm-Message-State: AGi0Pua0/2IX+TXJ4qm5SuJeFWbvr0hSsG8z8qKYJUOBic19g4xZzhOl
        7SIN2OJNrhLW/Jz8ejWOS4hLEg==
X-Google-Smtp-Source: APiQypLJh6qI8r5lFY5cKhr66zBnzwYn8dDF1UADZQyw4v0uhsMXCwyXDNL581WqPEaje92p3qzT3g==
X-Received: by 2002:a0c:9b95:: with SMTP id o21mr5932430qve.175.1586536707734;
        Fri, 10 Apr 2020 09:38:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h9sm1941610qtj.3.2020.04.10.09.38.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Apr 2020 09:38:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jMwfi-0005ez-T9; Fri, 10 Apr 2020 13:38:26 -0300
Date:   Fri, 10 Apr 2020 13:38:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Message-ID: <20200410163826.GM11886@ziepe.ca>
References: <20200409211044.21625-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409211044.21625-1-hdegoede@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
> Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
> TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
> the TPM_CHIP_FLAG_IRQ ever.

This all used to work..

> So the whole IRQ probing code is not useful, worse we rely on the
> IRQ-test path of tpm_tis_send() to call disable_interrupts() if
> interrupts do not work, but that path never gets entered because we
> never set the TPM_CHIP_FLAG_IRQ.

The IRQ probing code should be deleted.
 
> On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
> to use and never free creates an interrupt storm followed by
> an "irq XX: nobody cared" oops.

Is this related to probing?

Jason
