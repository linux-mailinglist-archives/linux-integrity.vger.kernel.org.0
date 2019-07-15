Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 349A3685F0
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 11:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfGOJFb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 05:05:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38584 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbfGOJFb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 05:05:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so14347371wmj.3
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jul 2019 02:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8SLvEjlc2V+wc5LKlamSyc/9J8fFrZb5bFr+zK982d4=;
        b=d+ZvYjGynHD9tSfzVAKbAcZULlShG6N4IRlXHCxfyVJsE4wjkuBc5ND3Eo423McfSm
         8dDaYEXQOx0TkPg/gNHXm7pQ0TFO6quYcWh0nquLLKH4aeSTax0jFwQIZSgyOI8KiGTU
         CLt2VOqpPVEBIfOIWv5XmnV1sbNH00d3TUj2x4o5EENBqzJU+fI/Rm60Xx+pMN6W09SL
         UJuh/TxSI7zowyPLEkgE2gIqyWA0TbV5wxNAb4mypuu4x9rroBT4yEzNwIqF8q6d6DzH
         RtCfYXIjSgUBkh/Z/6ExuG5YFGEp+mGe7ppl9NdSD8DxkKN3+nG+XF6DConq5KneVX8N
         KHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8SLvEjlc2V+wc5LKlamSyc/9J8fFrZb5bFr+zK982d4=;
        b=RKAlhE3Lvd3+skNd4uYqBNdp/847N0KrDR4nTgXOm7167AbADARNMFk4TXjL6LMnA3
         OVEILG0m6DdWZSAvkzfpFox24yCj9QleJzKuqYF+HSVKR8X+c7FRR2WlvR/XbNh9wGNf
         8ajpbWp4bVeS5+Rg7dXXDrI8FJDiDoYqIYD/4ZxKlVnuwv/xbB+kjmcLf4hCm6lDmKMh
         n1bmKU7VBKggpg08QufYysgyB//B+GMrgVPfUfliX3juXxo7mHa26N0X08MLRILj+08G
         zD0mNOQPeRNn6ae0eMOgdfCBP2EmmX5wH8zX3yDp9vl43PudVAjOYNoTPF/IZ2GK5pJn
         NNBQ==
X-Gm-Message-State: APjAAAWRBWFSK4KUUb9rhJ60pESnesEi+sjXq60NOAMetqc1etEVqssH
        8vVjXPIXMuxSMvOUe04PLrMQJA==
X-Google-Smtp-Source: APXvYqyooRiz3HOcEtyY+t7rwNaEQOf/QOzmw3jGwyslAKtIuZo3iNQObhOO8wgzh7ofVUfTua5ohQ==
X-Received: by 2002:a1c:4b0b:: with SMTP id y11mr24746359wma.25.1563181529488;
        Mon, 15 Jul 2019 02:05:29 -0700 (PDT)
Received: from apalos (athedsl-428434.home.otenet.gr. [79.131.225.144])
        by smtp.gmail.com with ESMTPSA id j17sm17672728wrb.35.2019.07.15.02.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 02:05:28 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:05:25 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v8 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190715090525.GA28477@apalos>
References: <20190705204746.27543-1-sashal@kernel.org>
 <20190711200858.xydm3wujikufxjcw@linux.intel.com>
 <20190711201059.GA18260@apalos>
 <20190712033758.vnwrmdxvz2kplt65@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712033758.vnwrmdxvz2kplt65@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 12, 2019 at 06:37:58AM +0300, Jarkko Sakkinen wrote:
> On Thu, Jul 11, 2019 at 11:10:59PM +0300, Ilias Apalodimas wrote:
> > Will report back any issues when we start using it on real hardware
> > rather than QEMU
> > 
> > Thanks
> > /Ilias
> 
> That would awesome. PR is far away so there is time to add more
> tested-by's. Thanks.
> 

I tested the basic fucntionality on QEMU and with the code only built as a
module. You can add my tested-by on this if you want

> /Jarkko
