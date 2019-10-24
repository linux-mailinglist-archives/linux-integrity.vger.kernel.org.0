Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6BFE3AD4
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 20:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408011AbfJXSUH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 14:20:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39246 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404839AbfJXSUH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 14:20:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id t8so21721011qtc.6
        for <linux-integrity@vger.kernel.org>; Thu, 24 Oct 2019 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YHxw/1jGqaSBr3k4wmSS8cvXYEwgfMv2jjCpj8Ti9BU=;
        b=k5crps8DS3wPfJ9fKd27AId15T9Eo/o+EWv2YQJ20fpZZrzexH5WTG+8gTBBIOsejG
         f8VlHtHlLf9Qf2zZwNztpn4wUgJu8gsGxySwycQ9F2lwPmo0RhABh6vKSPT23R4jptNv
         2gm9eqrr0uqo22Kh/TTSmunT3DG8IwNCpRrX9M4nfM6K4Oo2PbmNYS2hRit5uXUzQ5ty
         UMzQja3JazqozHU34RXFk4r8XsIzOdJWBK3DIaZb5Mh/qgRvAzLK69I33CDI1fMFXOSa
         FUjKmGsgrQTYOfypnXMyUZizzdn1ws4675olskDtBh1U+Qy8xutQ8dSKGoHn/caUKxbp
         gp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YHxw/1jGqaSBr3k4wmSS8cvXYEwgfMv2jjCpj8Ti9BU=;
        b=V3uzg+0j1wqCD7RtjEKPpfBWL20/YPz6x8kFZe9igrSnYTGsO89U/AmEKlu9U5VLlw
         ZBlGG56L9hpC8BIkYHkuaf0grnzGu/lgVrHw8CYhxgJiX9yVy4Mk+y/ll+3eGPPUwt8I
         eJO1MNVD74el6zMtNdJtWZqxJgIs1qllabEuf/JFS+Rqdq31pwaHPzclgNLrsneVThXj
         /x71wqdf+81Laoz0jBM5Ve1Xfs659II5MWi0RNvESyZSBKjPv4IjFCyxZwV4PkD3z4q7
         DRn60t1IENf68THmtb3HF81+sYdQz+2Fp23Onqznmu70XdJB3zRclh6uVzciwzf2hwAP
         i6GQ==
X-Gm-Message-State: APjAAAUGsQ7ICvey9FEtlW7ywAxDcoQrtxYerAJgpiz5re2bgKKAo5eJ
        B/ZufaRS03TwwuX2NDiLtawQSA==
X-Google-Smtp-Source: APXvYqzYGvB9lyLOAokJnp0KMY9tslvin0Gd8Mi3CWHmu38LyonkVq0A6NJq6BEkCK91t9OLDKo11w==
X-Received: by 2002:a0c:8144:: with SMTP id 62mr16232469qvc.6.1571941206391;
        Thu, 24 Oct 2019 11:20:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c23sm18287416qte.66.2019.10.24.11.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 11:20:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNhiP-0001BP-Ei; Thu, 24 Oct 2019 15:20:05 -0300
Date:   Thu, 24 Oct 2019 15:20:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Petr Vorel <pvorel@suse.cz>, Nayna <nayna@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20191024182005.GZ23952@ziepe.ca>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
 <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024172023.GA7948@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 24, 2019 at 08:20:23PM +0300, Jarkko Sakkinen wrote:
> Also replicants for durations and timeouts files would make sense for
> TPM 2.0.

These ones don't meet the sysfs standard of one value per file, which
is why they didn't make it to tpm2

Jason
