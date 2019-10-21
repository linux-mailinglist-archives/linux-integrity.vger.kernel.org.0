Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1550DEEB7
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2019 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfJUOFF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Oct 2019 10:05:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43064 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfJUOFF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Oct 2019 10:05:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id t20so21149232qtr.10
        for <linux-integrity@vger.kernel.org>; Mon, 21 Oct 2019 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uHSUtIWR/MadKTm9DdHLsDW0HlZfKhT+oF7SQ2xDVWQ=;
        b=Gt8aygKXCXnbhdZiR9dptnISb+xlnbVbVqDUItWYq7b2FjVPPCMCf5wpjfkshgIu7m
         8z4rZMl39WtpqIQ1sjqShBckmhMfgG/jw1r9W2PQ8tKB5QSSel/5pc6eZW+mJATMeUgP
         3gm3xlQP/sD8e9gqav0nH6arB8ai4IJuut2vFTqSNHTLSv9yL7V0E6znwWDSMssUNWJM
         jPfYCIZnCjLyITHAObQV8jYMYOKiLxzPzyhvlNGeLwrzrutqjk3cm1LNdJ8kFi2iqGsR
         ekQ1laEv6O4Ayh8XKlqlVnZCSej4yZxFtuI9s4LF6Fq/xloL92XvcMltmYR1Io82Zy6U
         uY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uHSUtIWR/MadKTm9DdHLsDW0HlZfKhT+oF7SQ2xDVWQ=;
        b=tqMnAeO32Vhep96DpXrFYM1QHmuvIcCJ+CotpOrBXa+W3+fPNHHCVlE39G6yInYUNw
         7TZNiA0NGjMQCXMjU2YwdND/YyJA7fGrc6KBbQBjOUrUgvoYe4ALS3VPK8iDDHuFRgV5
         EXA4iVDdZJULnAL0C5GBIdh5iwFRyTonSDtbQ7xGCheubgLOL+q2+5hN1I1e/+R3R7Yo
         UQiXqGIJ2cAIe1/+rBWgK9n5vUGzVRdYFxxj10+MbubB1ybs7paC8WcueK28nJvYcjv7
         4aOOO2LmKe1uP+5T0nBk0MDmUsAVXoGZMGv5bLhhxQ/3lFWTOAB7shXPO2TnzJ2UDleV
         vOeg==
X-Gm-Message-State: APjAAAVIo/dTQXn3WlQmTRqXmooUZ4RtPLLNq7YFCBfYYaOmC7NF3osR
        yw62cvtQYwjhbBFsV1Fi3B4PpA==
X-Google-Smtp-Source: APXvYqwjfbA8lxSEltBPIXN2g9Cy86MiiFlGuRHqBaSZ5A+ZP9zDbZwb5f5Gq52Iu8yMl+DlBhppLA==
X-Received: by 2002:ac8:4819:: with SMTP id g25mr18624716qtq.252.1571666704169;
        Mon, 21 Oct 2019 07:05:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id o67sm8300617qkf.8.2019.10.21.07.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 07:05:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMYIw-0007wM-UL; Mon, 21 Oct 2019 11:05:02 -0300
Date:   Mon, 21 Oct 2019 11:05:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tpm: Switch to platform_get_irq_optional()
Message-ID: <20191021140502.GA25178@ziepe.ca>
References: <20191019094528.27850-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191019094528.27850-1-hdegoede@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Oct 19, 2019 at 11:45:28AM +0200, Hans de Goede wrote:
> Since commit 7723f4c5ecdb ("driver core: platform: Add an error message to
> platform_get_irq*()"), platform_get_irq() will call dev_err() on an error,
> as the IRQ usage in the tpm_tis driver is optional, this is undesirable.

This should have a fixes line for the above, or maybe the commit that
addtion the _optional version..

Jason
