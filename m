Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6371E48F8
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2020 17:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbgE0P6M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 May 2020 11:58:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55571 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728241AbgE0P6J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 May 2020 11:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590595088;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=DWpuiUINxt4qxMPqMFxQ6KZtk1tvRy62rBt3VQ6hobk=;
        b=GolplG58JPzHrvsBsDboUUbFzux9HuGsGiwj7HyCqSX0w68lvDn3wqhk/XgV3ljJbotLLX
        UfXA59IjmbU6pn7aRKmqbtJGVrmRmUU67ShWr387UT9vQzfwByaH4VrEhfmfHxwhPuCLtq
        UadIytkIshWo4ZzsmhMGc7R8EusDXUQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-0dw0UZyLPymN3VFY1fExLQ-1; Wed, 27 May 2020 11:58:04 -0400
X-MC-Unique: 0dw0UZyLPymN3VFY1fExLQ-1
Received: by mail-qt1-f198.google.com with SMTP id e44so26230482qta.9
        for <linux-integrity@vger.kernel.org>; Wed, 27 May 2020 08:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=DWpuiUINxt4qxMPqMFxQ6KZtk1tvRy62rBt3VQ6hobk=;
        b=guJob/YILiDosVUTmfybbN9PVcNHoylA82Cxq84s2COYA1iXTM+xEaTA09qVQ9dq10
         LM3NUtOQ5waDiMfXUSRYPjV0zIY+foBRtbzZ7BAcFNz/uGUM19yfe84ZUFwpfhABRjWt
         w14lijggBO6oy0ATe1hBM/nfUcXuT7+98CGVdxJcMpoMoBc20QhWDzG8ZqU6KeJlcsF/
         Fn587xPyel1MnYPXNUza8h99w+qBSLRdhR+Tt/jN8MJxJu1vWa5cZCw6ka/ySRfpj69y
         Xpb8XBfYUDEaKdRrlXc4L9YrtZ0prLhZLXI1bYMjIYiNTL1bJoBbl0/Xl0Qe/UvrMBb3
         M+Tg==
X-Gm-Message-State: AOAM5338LvbJigNPTUsmA3bBaJELcV4xVq/1J4jshIP871oUcjZjgube
        Ms0/q4rehe6+V3EGj9HGEh5ZQ3dBIC9dYxa0qb55JQ0xJpbIQ6OEhPFto0Uw5zbA/399/6jVNGf
        dwXLl0beoWiw+ZUD3Ass2IL6bv12I
X-Received: by 2002:ac8:7c8f:: with SMTP id y15mr5122802qtv.248.1590595083146;
        Wed, 27 May 2020 08:58:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztZSOG22h4X4Lhy4ElSV+EyvsMV3GruujbEqQf7fry/MZnpdIaFtgplke7Q9Te34Zv6xnHAA==
X-Received: by 2002:ac8:7c8f:: with SMTP id y15mr5122779qtv.248.1590595082863;
        Wed, 27 May 2020 08:58:02 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id x36sm2697245qtd.97.2020.05.27.08.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 08:58:02 -0700 (PDT)
Date:   Wed, 27 May 2020 08:58:00 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Alex Guzman <alex@guzman.io>
Subject: Re: [PATCH] tpm2: fix TIS locality timeout problems
Message-ID: <20200527155800.ya43xm2ltuwduwjg@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <1590539114.3576.5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1590539114.3576.5.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 26 20, James Bottomley wrote:
>It has been reported that some TIS based TPMs are giving unexpected
>errors when using the O_NONBLOCK path.  The problem is that some TPMs
>don't like it when you get and then relinquish a locality (as the
>tpm_try_get_ops/tpm_put_ops pair does) without sending a command.
>This currently happens all the time in the O_NONBLOCK write path.  We
>can fix this by moving the tpm_try_get_ops further down the code to
>after the O_NONBLOCK determination is made.  This is safe because the
>priv->buffer_mutex still protects the priv state being modified.
>
>Fixes: d23d12484307 ("tpm: fix invalid locking in NONBLOCKING mode")
>Reported-by: Mario Limonciello <Mario.Limonciello@dell.com>
>Tested-by: Alex Guzman <alex@guzman.io>
>Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

