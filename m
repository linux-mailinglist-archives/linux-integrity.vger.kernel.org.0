Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E9B10C146
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Nov 2019 02:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfK1BIe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 20:08:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39921 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727088AbfK1BIe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 20:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574903312;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4lxh3+1e+t0p/N8JdhBbJ4iy/gsFRZKU/W7b/lbYo44=;
        b=bMLXgXPAqgOZbRnr+1nVNVju5nGXRSbFLkN5jsUnQ+0xPLG7IQoQlWBKmEChXcBGBp0p4Y
        bvx2E4fVRA4NFXXbSABWe89zY72wG4UPoQxe/5ZdfndTLsUL0iQNULcQY38WyGJ8J+YAg/
        /IMXhllHZKEmrUA1PEoDggE+WSGAtg0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-cQdk_q_eO6CMWh7KSRUvkw-1; Wed, 27 Nov 2019 20:08:30 -0500
Received: by mail-pg1-f199.google.com with SMTP id 14so13729786pgv.16
        for <linux-integrity@vger.kernel.org>; Wed, 27 Nov 2019 17:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4lxh3+1e+t0p/N8JdhBbJ4iy/gsFRZKU/W7b/lbYo44=;
        b=Juh92hlHiPGW1yQap1yzoHhrkisyNvY12xwx8CPzShxUdANDjWA9mqpI3UvCh5KaRp
         Q7Ga4mkwE6s7dwqvp+quNOZIC4wJwscj9OiOl3sAlI9c0JEzKgfVC4qzSZd7Zry24oQ5
         RLhIZ6MYE0Yyxu4+Ui4ovEYgiqZdUikFL9/8WqNdHFnxF1MPxWT08m+kSCaZxVzoEF4T
         p47QaSXYgkXvZG9jzJtsy+06b1HP2JPJJg7yx/X5rerJe29vrLToplJ7aCaCmk9CS8FD
         yUFyU42uEa39t/pTslQACm9EUYKea5ERpaqoPIU+xo/BsEjvcgIZKxJH+l3g86Cr7KTJ
         /DDQ==
X-Gm-Message-State: APjAAAXKkV9Y/0QiAmmILnjUBhg4ce6PEY6IeLJAS0juxvd91YKlqnXL
        VQgtv4Fhy6btf753lqRJ0egPNbqjbaMqxr4EKzPpjaVurfEhssFFWuqzZ9sgsOegadSkOXpSRi0
        yC9t8Sxh3plr2Rn69aABGWZDseOtY
X-Received: by 2002:a17:902:9b85:: with SMTP id y5mr7074826plp.334.1574903308939;
        Wed, 27 Nov 2019 17:08:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcvc25Epzzx5nB68vlU5JUnkFeScMae9w13LQmZvEajOi11t7slcGmn/Ggj/jfoNtwCuq/zQ==
X-Received: by 2002:a17:902:9b85:: with SMTP id y5mr7074796plp.334.1574903308548;
        Wed, 27 Nov 2019 17:08:28 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id h5sm1676517pfk.30.2019.11.27.17.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 17:08:27 -0800 (PST)
Date:   Wed, 27 Nov 2019 18:08:26 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4] tpm: Add tpm_version_major sysfs file
Message-ID: <20191128010826.w4ixlix3s3ovta3m@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
References: <20191030225843.23366-1-jsnitsel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191030225843.23366-1-jsnitsel@redhat.com>
X-MC-Unique: cQdk_q_eO6CMWh7KSRUvkw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Oct 30 19, Jerry Snitselaar wrote:
>Easily determining what TCG version a tpm device implements
>has been a pain point for userspace for a long time, so
>add a sysfs file to report the TCG major version of a tpm device.
>
>Also add an entry to Documentation/ABI/stable/sysfs-class-tpm
>describing the new file.
>
>Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>Cc: Mimi Zohar <zohar@linux.ibm.com>
>Cc: Peter Huewe <peterhuewe@gmx.de>
>Cc: Jason Gunthorpe <jgg@ziepe.ca>
>Cc: linux-integrity@vger.kernel.org
>Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>---
>v4: - Change file name to tpm_version_major
>    - Actually display just the major version.
>    - change structs to tpm1_* & tpm2_*
>      instead of tpm12_* tpm20_*.
>v3: - Change file name to version_major.
>v2: - Fix TCG usage in commit message.
>    - Add entry to sysfs-class-tpm in Documentation/ABI/stable
>
> Documentation/ABI/stable/sysfs-class-tpm | 11 ++++++++
> drivers/char/tpm/tpm-sysfs.c             | 34 +++++++++++++++++++-----
> 2 files changed, 38 insertions(+), 7 deletions(-)
>

Anyone else have feedback?

