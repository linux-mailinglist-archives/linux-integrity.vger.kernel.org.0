Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10FEE4063
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 01:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfJXXgE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 19:36:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35554 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJXXgE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 19:36:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id w2so110599qkf.2
        for <linux-integrity@vger.kernel.org>; Thu, 24 Oct 2019 16:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XUGbPt6kej7ylnmx2SrxE7maB+HEW4YYHfA0Y874rtc=;
        b=MedCfatpSIRKbZeyZxU2eHrAFA3lTr97FgXOok/J5kc1LBO2EhTAsW+jva/TxaTF34
         jaN2LlXa0omyUoMJzxQqYW2nxkeDxCLXzSH3bBJcOyckkUip9A8JMRQ/KR27282vsy+R
         Dk7vJ0DbrrDHyeHZOzVlTKFYMMKyOtefjzMroTgVQeHQ1EqDD+waXjBa1VykPtQBETNt
         4wYqTVY//y+NlSYX05CubGhB/68s3/xlEsuHQsmAeE0Os/Np3AvMCS6NINal/V//NqBb
         xrsLnPnRg8nQi+pHnfUHgNftOvQaMdRVJ5wVmDwb/PMubGtnVstdgzpYPhITkLSmsD9Z
         5/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XUGbPt6kej7ylnmx2SrxE7maB+HEW4YYHfA0Y874rtc=;
        b=OkFUC7P1hskPHPXtjr2RreoyZaV3eo68k7LUVkFGdA3D29v3Mp7IG84Qu+9WgvQpWj
         aKjg2z+B4ZyXo92Dv/QswUX0B/dzvwVDat5n/sZMlkDdGxGKh9WGSx33w+BEnNlMj0Lx
         982pqx7M9+5J3tojs6RQZBgSCZiZXbsIc1bju095tI5l+l87TlVrb01Al2AcX+a4a+2j
         yCdhfde+7wbL11tqffEeNypIXhmvS3mQeao4I0eeJEvfSXOemvdtO9/4y3zmWI5hPBYY
         Qp/sv5KMTbGlFmb3hLK1ZFa9LGxEyZFQhy5gqgEj8hsbDfshK+BUJysfNcgcmXZ3yprn
         +pyg==
X-Gm-Message-State: APjAAAXj9ihvj/WwTJoolAOP82WzuZ2GJr/LpcCyD2m8IlY5dWM+8kCz
        MimEZAi1glYq0mMLj9Q/7ewgsw==
X-Google-Smtp-Source: APXvYqyjUFF66YAhw31e4KpsoCgqSQ6mKK3dmuAUFGIYN1V/FkbmXdi+PMR+uT70y1E5sBRr8NKwVA==
X-Received: by 2002:a05:620a:12b4:: with SMTP id x20mr441280qki.254.1571960162995;
        Thu, 24 Oct 2019 16:36:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id a19sm190640qtk.56.2019.10.24.16.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 16:36:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNmeA-0000SJ-1W; Thu, 24 Oct 2019 20:36:02 -0300
Date:   Thu, 24 Oct 2019 20:36:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Petr Vorel <pvorel@suse.cz>, Nayna <nayna@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20191024233602.GF23952@ziepe.ca>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
 <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
 <20191024182005.GZ23952@ziepe.ca>
 <20191024191402.GB12038@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024191402.GB12038@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 24, 2019 at 10:14:02PM +0300, Jarkko Sakkinen wrote:
> On Thu, Oct 24, 2019 at 03:20:05PM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 24, 2019 at 08:20:23PM +0300, Jarkko Sakkinen wrote:
> > > Also replicants for durations and timeouts files would make sense for
> > > TPM 2.0.
> > 
> > These ones don't meet the sysfs standard of one value per file, which
> > is why they didn't make it to tpm2
> 
> They would be still useful to have available in some form as there is
> no way deduce them from the user space.

Why? Userspace doesn't refer to these values since the kernel handles
all the timeouts, right?

Jason
