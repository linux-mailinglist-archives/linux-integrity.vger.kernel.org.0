Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC83E144732
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jan 2020 23:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAUWXh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jan 2020 17:23:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43860 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgAUWXh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jan 2020 17:23:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so4459774oth.10;
        Tue, 21 Jan 2020 14:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zPYQbb1L3qIzvQ8N5DCuUQt8MKkG6UVa2pPHYKx0lMQ=;
        b=P3wjMeRvHeVhTzlMDZdaH4kj3rCF4ntTouR7+RgWYbVJThbYZsSl2EzjCKPQzfWewp
         PiPbgMXaWbBNK7UEO8/0Kmnz/TNzVVLXBLAvaXP5Nu5svxtt/gKlBLgRBLtD7wdnksyj
         kUHPpJyWKrS2X+78SHWeWyK8Nbz7HAfi68kVjCQ2Fj/rnoTQraLOaeVdz8jpfPKM1maw
         2TRis/tDyEW93uGXI1Jr7nE7iAaWt7eblzXfVV8WKNwQ4CsCAyWoWzsLRa7ze3WdJ4Az
         JX8e/W8vROuufBlPS7fiJbysJtaOaW55XzgnRJyz8jWItvrvRwtSNiFJVw/6eNyM8dL5
         86uw==
X-Gm-Message-State: APjAAAWAMR3ZCWyffT+thwlG2n6MAi0E/wnzdC4kLhmtPiQxwz6Jk4nb
        oJ/7XKkqlSi2cURi9quoWQ==
X-Google-Smtp-Source: APXvYqx/4SnFjRHl3ZzxW5AWsiHfbDdKsmN1qLjNM8Tn8RWFSe4Ynq6be51tbcx1pyQKKkiVIuXkVw==
X-Received: by 2002:a9d:518b:: with SMTP id y11mr4950524otg.349.1579645416152;
        Tue, 21 Jan 2020 14:23:36 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e10sm13997385otj.59.2020.01.21.14.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:23:35 -0800 (PST)
Received: (nullmailer pid 13684 invoked by uid 1000);
        Tue, 21 Jan 2020 22:23:34 -0000
Date:   Tue, 21 Jan 2020 16:23:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, masahisa.kojima@linaro.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH v2 1/2] dt-bindings: tpm-tis-mmio: add compatible string
 for SynQuacer TPM
Message-ID: <20200121222334.GA13624@bogus>
References: <20200114141647.109347-1-ardb@kernel.org>
 <20200114141647.109347-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114141647.109347-2-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 14 Jan 2020 15:16:46 +0100, Ard Biesheuvel wrote:
> Add a compatible string for the SynQuacer TPM to the binding for a
> TPM exposed via a memory mapped TIS frame. The MMIO window behaves
> slightly differently on this hardware, so it requires its own
> identifier.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
