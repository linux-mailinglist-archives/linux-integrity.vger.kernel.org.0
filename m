Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F754B4179
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 22:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391137AbfIPUAk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 16:00:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41223 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732982AbfIPUAk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 16:00:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id z9so1178027edq.8;
        Mon, 16 Sep 2019 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3NU9keS+SwIYzzTr5Kb8nPLd/tRCzLXZhLQOjpJIlOo=;
        b=OJYgS+nIgWZGa6CyEVpIltqa5IfUHkCob1tR2roCdO8FujUZcii3oF1PYElg5Jwwkr
         RKOCy4z2ym6a9VPGKa59i7JPMv4ihyTTpuonASObUV/g+lbSRpQRq8SAy2j+q62IsMGW
         2zulTCqlwnN9QJWX0qLTQfh9OB2kvMA1W3enfz120fe7b1UZUC6HsepgZeM6OvnbnfqY
         /YpHtw7DslD9kqEEJHJ7IdbhSGy75D9n1sUv9O79CHO1kyub4MDPEvH6kHCaNJ1LgNeZ
         +GTamxQIkVZYUmnqOK/FZbVE451CQYStus59kh6V/w67EPv3dM1SSV1RStiCUK0k7Qag
         2n6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3NU9keS+SwIYzzTr5Kb8nPLd/tRCzLXZhLQOjpJIlOo=;
        b=LYdSwdHq6B4Ruk3b3B+JMCVwDS3Km+wfdlOJ3yoiTdxVBHwzb7bk3d2t2ZId8S434w
         OXIDLhZc3omktYYQef+hpdXF2AuvyUDnQp8l7jXEg7HSThKgI1yPYkWVt6n4cCt3gZQO
         /XZv7rG9+V4VA9z3zqnujjDDru5HR6dIAs7jacHnHLIIciE8uwP6fVX0YC7fXa2B+R/s
         +rxuyHZGZKtfaEc6faHQh6BN0ziF5Z2aYj9IQW2dJXRGmVVIPytJjRmrcpPADvEwGKs4
         sE8p3Tc3ecLy1NYAZ+cFAjcTMiA3u5+7hanvCmSEF1x6jXsFOxzbx2EqD1WjObOsjqyX
         /6Pg==
X-Gm-Message-State: APjAAAUyI/cedfUHRTC76OCP4hX5v0X6w4r24R9mDTHXYDR1aIiFSVmG
        ScduEaCkBs7n2Us8SU7eG9RhbCs4
X-Google-Smtp-Source: APXvYqwpkelb6C3nybdWnYGEBMpoPa4/s0IWmUMsANxj9jB+16BzyjzX6lvq7jOAs02HwABOEL+3tQ==
X-Received: by 2002:a17:907:411d:: with SMTP id nw21mr1636272ejb.8.1568664038562;
        Mon, 16 Sep 2019 13:00:38 -0700 (PDT)
Received: from hv-1.home ([5.3.191.207])
        by smtp.gmail.com with ESMTPSA id x12sm3664544ejv.69.2019.09.16.13.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:00:37 -0700 (PDT)
Date:   Mon, 16 Sep 2019 23:00:30 +0300
From:   Vanya Lazeev <ivan.lazeev@gmail.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20190916200029.GA27567@hv-1.home>
References: <20190914171743.22786-1-ivan.lazeev@gmail.com>
 <20190916055130.GA7925@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916055130.GA7925@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 16, 2019 at 08:51:30AM +0300, Jarkko Sakkinen wrote:
> On Sat, Sep 14, 2019 at 08:17:44PM +0300, ivan.lazeev@gmail.com wrote:
> > +	struct list_head acpi_resources, crb_resources;
> 
> Please do not create crb_resources. I said this already last time.

But then, if I'm not mistaken, it will be impossible to track pointers
to multiple remaped regions. In this particular case, it
doesn't matter, because both buffers are in different ACPI regions,
and using acpi_resources only to fix buffer will be enough.
However, this creates incosistency between single- and
multiple-region cases: in the latter iobase field of struct crb_priv
doesn't make any difference. Am I understanding the situation correctly?
Will such fix be ok?
