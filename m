Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70288F9A15
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 20:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfKLT62 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 14:58:28 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40041 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLT62 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 14:58:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id z16so15627027qkg.7
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 11:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=47lQ6/DLN6Xo+wWf7tnAV7rO9fUUtwUf7ZitRmJCvMI=;
        b=QD70fxh8o3e5RCQfeBx8taEyqzIsuI/UYkfnLH9sLIb3zQSrvawKbCbQs3SPEQftzJ
         b5WAwc6yxwlYJsDno/f7O2Jypo4qLauVvxQ/itV5BbxxxK+4t5sA0xovbQ5odld4cMDN
         9Uu34nG3AXxDo50k7dEKmn6IPe+teKNoVyvFcTraKEyJO5tqed1w7VGkKVQ83Cw6mIsB
         RK1Ts09el5D+oIjx1QiL+tAWSKjKge+N9aB1fJc4SD08ht5jj/vJF3ARbEArYAyiFZck
         5GOdVUcfnCaBkkiE9faXwAQFMCU3vpIlsPh362cY7SuW+Eb9tHe4q3nEnBTm/VZ4bfk3
         S2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=47lQ6/DLN6Xo+wWf7tnAV7rO9fUUtwUf7ZitRmJCvMI=;
        b=diljLmTSXeQTjwQ/L46355LrJObeEDfEfPY32bMrbDw0mVh6NXEf3/156+HCjtzP5b
         d+dWI6tg+srP0Np9HJ1iFlz1K4VGp4DoTAJTdeoOJ8TDQtR1AwpbsPrjUPOnVytVH/Ax
         LqD/7bKytlvHHTJ6mzw6i9Jy8pDlnLRtCApHpaa6PCrDjIHhEfPyG5oDEpvcfcKYKvnT
         Mj3EnQFGhN80E5jv1M4MQ4sSNsLYXPmPjhsrjB38I8WqUlFZOhOp5DU6bCH+YuFI9isS
         sVPLlUrBSJA5ChDG+BHJ75Pe631GzexyRkKNbZm67E689lvHjICZMMzQLcARCdJ3zHCF
         s4Ag==
X-Gm-Message-State: APjAAAXKnTvj99o+hcI4mkcVHKILxJEIQ4xdBY7WfjjumMrb2avJguvX
        Pb0m+psRndEmrTKIJjyAtLoa2IhcbIo=
X-Google-Smtp-Source: APXvYqw/M35I+/IgDKyf6BI2QzLCpV7eUbLwGQPMxPRgbREwkgt15L4XA3RjjTe/HYMKOJrT79ZTfw==
X-Received: by 2002:a37:4a03:: with SMTP id x3mr16412893qka.301.1573588707381;
        Tue, 12 Nov 2019 11:58:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u67sm4845726qkf.115.2019.11.12.11.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 11:58:26 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUcJ0-0000pI-97; Tue, 12 Nov 2019 15:58:26 -0400
Date:   Tue, 12 Nov 2019 15:58:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.5
Message-ID: <20191112195826.GA5584@ziepe.ca>
References: <20191112195542.GA10619@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112195542.GA10619@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 12, 2019 at 09:55:42PM +0200, Jarkko Sakkinen wrote:
> 1. Support for Cr50 fTPM.
> 2. Support for fTPM on AMD Zen+ CPUs.
> 3. TPM 2.0 trusted keys code relocated from drivers/char/tpm to
>    security/keys.

Just to be clear, this is for the next merge window right?

Jason
