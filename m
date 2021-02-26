Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D19C3269BE
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Feb 2021 22:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhBZV46 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Feb 2021 16:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZV45 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Feb 2021 16:56:57 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE9DC061574;
        Fri, 26 Feb 2021 13:56:16 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b1so5241439lfb.7;
        Fri, 26 Feb 2021 13:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mancjAu+Bc0eVwVmvTP0rgqR/aW6rMYyUOZfbqNyj7M=;
        b=Ht+2KZzHbQGkOYkLK1GVZ4i0bo08WD/idgMYXk9OA/XdcCGY7IIKIzSHxDssLq+uFH
         NmEJnVvftuaQNFrMv+Y/14SKZoDgWR/9vPJrY7ZLkKWzt27+fhZORmGeI8OoF3GLo/gJ
         ddGSsEG3+FCPRVUlKw7XPi01Wq6cZw0BxrlBnl7baqj1tgwwGs5n2L2iz0VHBY5Iiub4
         EGED/i7C52Rma0HtUnjir/zOYjhfA6xR0XbY8nPGDhrOP9DWCf/G2NsxNLdYQkW1ZcwN
         6NO/EBOP+ezuFmMPYVJNvxMqA9Ff9EVZJZVwoNwCOZrd2EUFVXcUr1tl2S/w+kLt+2Rg
         oaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mancjAu+Bc0eVwVmvTP0rgqR/aW6rMYyUOZfbqNyj7M=;
        b=k2wUxDB0HMR7penqumK8rY/Xu1YL1U9EOWRXVzqfcDcxaWMNrP05hVwlLOG8pYnShl
         8KUvbKI6AB99dZvPgsuNYIYfaYFTAri4+nWLEPTY27dQC+gTw0w1E4JpxCSmnDNJl5SG
         PnL8cJyxBEPtTV83Q9MTRA3KFPXP6tJe5tkmLYlXTeGODBQIZ6qoQ6mUDs6fXFn/VcUD
         k/uobcXkLSfbPZW6S/C4PmFVcJSuZnHum4rH8m6GRig58eyTHZg/B3rtGkfrAOyxo6qC
         kXOj3gdWthmibZSDgGJw7HDjlWbixASrN+DK6Du8Aafs/Gbo5nMhhSnYvXlXBO2OE2TB
         1/ag==
X-Gm-Message-State: AOAM530SFLRA6UqKte4OWk+6Qwi2gpvh7wEeOADf/cNdkGu9Yh72Iw6O
        M/tFPsR45P9pBhfe8vBrRCY=
X-Google-Smtp-Source: ABdhPJwfuaFS/xNOCEF2BQf7IKgZBGoG4uhkxSyNAjLEIg2FhuXW1u1ip7PSh5bQ4BZ+X416hY0fJA==
X-Received: by 2002:ac2:4349:: with SMTP id o9mr3053275lfl.415.1614376575419;
        Fri, 26 Feb 2021 13:56:15 -0800 (PST)
Received: from rikard (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id z1sm1576245ljo.134.2021.02.26.13.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 13:56:14 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Fri, 26 Feb 2021 22:56:12 +0100
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/ppi: Constify static struct attribute_group
Message-ID: <YDlufJLcYN2bzNYV@rikard>
References: <20210204215427.49047-1-rikard.falkeborn@gmail.com>
 <YBynopNwhIhGBXv/@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBynopNwhIhGBXv/@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 05, 2021 at 04:04:18AM +0200, Jarkko Sakkinen wrote:
> On Thu, Feb 04, 2021 at 10:54:27PM +0100, Rikard Falkeborn wrote:
> > The only usage of ppi_attr_grp is to put its address in an array of
> > pointers to const struct attribute_group. Make it const to allow the
> > compiler to put it in read-only memory.
> > 
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> 
> Thanks.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> /Jarkko
> 

Hi Jarkko,
I saw this was merged as commit
90cba8d20f8b09d62a25f9864cb8e67722d76c3a, but in the commit, there was an
additional change where a call to dump_stack() was added in
drivers/char/tpm/tpm-chip.c, was this intentional?

/Rikard
