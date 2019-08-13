Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 324728B88A
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfHMM2k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Aug 2019 08:28:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38432 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfHMM2k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Aug 2019 08:28:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id x4so8068402qts.5
        for <linux-integrity@vger.kernel.org>; Tue, 13 Aug 2019 05:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HHB8yM3vQkqgreE2AHKKcVDkONiTAy7syYKyVsmLHqM=;
        b=fA19DjLpFNicVIHAt5lmequF1vP/semPl6oLTkcbjtvOX5yj/c5C8NXy/ussXTtvOh
         x6SXuMtpH5ksXDTUikluQLP6RTDyCSIk3DjrixVuH33kC9vVl2AsyDfB4HkcBggy34kS
         NgwdQ8oxmM/rh6ai4P0ympad7jnf4kjsx1lJ1pEvIKY4SGVKAAemy5zGnB1vg/PaoSpy
         MFc7xhPuac8P5lEQmXjXMUEeJ1SGAgCh7vfXc/UyhUOVrs+wF0pwPhuQ1ynIQbnmXa63
         dE6JVIcPRcKTuir157wQP2leWSg/iFJPNZjYYKyAnylMZFT4VhgkVDFIPFiXuGhnRE2T
         znhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HHB8yM3vQkqgreE2AHKKcVDkONiTAy7syYKyVsmLHqM=;
        b=jvxb49fIze1jalAhcGG+Ti6E8aDDv2Gca02Qbsv+ZyOpxABbTpXPf0t8MHj/bkiAM0
         4YtJ6al7ZbeDMh+CLmHQQNz4LaFY/Os0uDkz36M9rLpEwLIWdvenQCvm1pf/Z1TtL7ut
         DgNRKK+8V9QaoPl8pP0DaUlBWtuAA/29b28qG1zZVxBLUsf3SWnAZ4ubtEevkbTi9hFB
         uNPaoHh0IpoBiBCeuN6T7dlzudbE+tdJz7K7xKLQfk88JPwnCdybs8bAVDuvI4o5DaWQ
         hkkWuYpaKp4gRiG/QM9shZQI/duNpGuOMdmJESBsX/zpSkiwsLkFqTGKtMrVJ5YU3Ftd
         xI0A==
X-Gm-Message-State: APjAAAUDOlN6QZVPhohByaRWsu0BUWYgk3QHv0N3gwUbMowqKUzpJ7Dc
        6WBo/k7oEzTrkI8DOFL9yHqoig1bR8c=
X-Google-Smtp-Source: APXvYqzwQz4PTh+ipg9NPoMHdxYU71GSPFuYcr6bdKfQyKGG8GjU5XmkrgMfJsRSPQp6g4LolNztVg==
X-Received: by 2002:ac8:2f61:: with SMTP id k30mr24600841qta.340.1565699319594;
        Tue, 13 Aug 2019 05:28:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g3sm47531950qke.105.2019.08.13.05.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 05:28:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hxVuo-0008KT-3m; Tue, 13 Aug 2019 09:28:38 -0300
Date:   Tue, 13 Aug 2019 09:28:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: Does probing of TIS with interrupts work
Message-ID: <20190813122838.GD29508@ziepe.ca>
References: <f721bf34-1cfc-de2b-91e4-24b17150645b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f721bf34-1cfc-de2b-91e4-24b17150645b@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 12, 2019 at 11:39:27PM -0400, Stefan Berger wrote:
> I have tried to get probing of TIS with interrupts to work on a module and I
> am wondering whether it works for anyone. I noticed it tries to probe while
> locality 0 is released and the TPM_CHIP_FLAG_IRQ is never set, so it never
> gets to certain places in the code. To get it to work I had to add a patch
> like this one here to tpm_tis_core_init:

It worked a long time ago, probably bitrotted

We should probably drop it entirely if it doesn't even work today and
nobody has complained.

Jason
