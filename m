Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C59B11C086
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 00:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfLKX0w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 18:26:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41700 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727077AbfLKX0w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 18:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576106810;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=xIBtoo8ZOmm+jwrAM70WjwrXU/X7efOhZSB/CmsOthA=;
        b=QGLnf6IYe3jdAqEtWNWEgM5ymUBRg6f4T4kK0ZR6k1al9sE1Oyv2iMD1favraK8MD/Xlqk
        RZB+iizej4UVYLn1TaMsvYbRRMF8jvqLwb6LL3dVvnmM+W0kCQe2PYPuPTTqzzQqo7+frN
        zOc0oeZC2OUh6zrwVRvYgyQhJtiAztw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-Hgg3n-K-ODWDmyH1X6yINA-1; Wed, 11 Dec 2019 18:26:49 -0500
X-MC-Unique: Hgg3n-K-ODWDmyH1X6yINA-1
Received: by mail-pf1-f198.google.com with SMTP id x26so91691pfa.20
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2019 15:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=xIBtoo8ZOmm+jwrAM70WjwrXU/X7efOhZSB/CmsOthA=;
        b=uDFaUCShfMyXF02NwJDueq/Tv16AWJuK9kAT178vhaRLoqVAqxvHh4tXFukSlYrKYP
         uEYcn+OiqdbPr9ooGztxcPNeVl4OjE4hQc3vDZpkxSMvg47NDuhAiKGS+Y8XWkKUZes6
         Ug8HQGZtUwtY4TT8cySXFHzdoLtu+At72MPoJS75YThM+vnjdnkGEPbe+qLtQ2ybq3nv
         gRsopUF4YzcUtKb5AXZ0xfgkcgoC787db8fJggjUSFRlypIMQrddLp/wyCqE06AX2D4q
         qjnsDYHJPDrFr04AXqs7MTrjfkhX3DSCKl5wnvnnj6nIM00iVHJdArzdVRBjSfEq8Fhu
         PAkw==
X-Gm-Message-State: APjAAAX9Y+c5C2YsSimFQnlsogwRfT72LdJrtpHHBuSL+ag2t6x9tO2q
        iTX2KeTcphudRsy/ebtkONaavn+TgHz1UBgUwHM5lqhqthC4D4mW95+RsV2gkuCZ0jofdtcYhUr
        8wSk+nzevTkumzmMMXXOeUlpV65Pt
X-Received: by 2002:a17:902:59da:: with SMTP id d26mr6164073plj.287.1576106808594;
        Wed, 11 Dec 2019 15:26:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqBrhVo8B0NkfhTA7qmWNMDe2NS+bkpJjXqPqOxnEvLKUmHEM6HPU81t6PZa+dDB2P6rEGHg==
X-Received: by 2002:a17:902:59da:: with SMTP id d26mr6164051plj.287.1576106808281;
        Wed, 11 Dec 2019 15:26:48 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id r62sm4469451pfc.89.2019.12.11.15.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 15:26:47 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:26:12 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Bundy <christianbundy@fraction.io>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: reserve chip for duration of tpm_tis_core_init
Message-ID: <20191211232612.miaizaxxikhlgvfj@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>, stable@vger.kernel.org,
        linux-integrity@vger.kernel.org
References: <20191211231758.22263-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191211231758.22263-1-jsnitsel@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Dec 11 19, Jerry Snitselaar wrote:
>Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
>issuing commands to the tpm during initialization, just reserve the
>chip after wait_startup, and release it when we are ready to call
>tpm_chip_register.
>
>Cc: Christian Bundy <christianbundy@fraction.io>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Peter Huewe <peterhuewe@gmx.de>
>Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>Cc: Jason Gunthorpe <jgg@ziepe.ca>
>Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
>Cc: stable@vger.kernel.org
>Cc: linux-intergrity@vger.kernel.org

Typo on the list address, do you want me to resend Jarkko?

>Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
>Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>---

I did some initial testing with both a 1.2 device and a 2.0 device here.
Christian, can you verify that this still solves your timeouts problem
you were seeing? Dan, can you try this on the internal system with
the interrupt issues? I will see if I can get the t490s owner to run
it as well.

Thanks,
Jerry

