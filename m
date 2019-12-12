Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2400C11C313
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 03:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfLLCQD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 21:16:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37568 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfLLCQD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 21:16:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id k14so876388otn.4
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2019 18:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfZqzYbzlI4qJvFk+tQo2f1KM1Kh7iadCkXBQ7iIRwg=;
        b=qTf8M7UmPyeZzBaccuaHtvT3a/sakASiqOp2Z+RwIME8+PMqvWqfaLxv1lkXmdjHzF
         /3sSc6VfsgRQAXU76FlNdaDFyHOJP2tj83y6ExOhTtu7UhIBJkUtVkbAjbn5BZZCkW2Y
         Rs2gYms1yw3wy8BZ2c6fYkXZSaJ/YaSnANbT3E2mZ7ZDt2jnRI2T5vmZjRoxQfE4esaT
         iJgLv1sIKyfNikcEKZ2I1Ok81K8eBACmzvUEl4ia0pYCkXNae2aP7al4CVq+Cka0P7CK
         W+VP6KmmmTdg4UyTgg12psU2q3voShpwrdh3GPI4mdkCqk73pdlMIgJSni6I2qIu1oVc
         9DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfZqzYbzlI4qJvFk+tQo2f1KM1Kh7iadCkXBQ7iIRwg=;
        b=F2aryGRObzMdoPU37yHF0UuakdNXaWZKDhuppQ1++gCgrE1rgQEzL7ssMAGvymZDDQ
         Kb/K4rH5HsRxyYxyy1b3M/y1nGWKzlBL2O5tALLTI00k84QGTBJsseqvYzRrWgHZqyeO
         eBSRVQEnZftVuFPD+ptbTiGTW1hf5uUEL/hyX+erPPji5EcOMG4I351pCpxdaP/1n/Dg
         vpCl/3exoJTxZNz6tjYGDPreqpIwSXe3VH6l0uLv8/5ThRF+mGuwvzKytJs8ts98CnTD
         3z2no7tVhVvxv34TsnIQ9CuECpPIqS6dinvEmR8lwGShnVn6ZlpAzf7wfNQu24DtVhs3
         Mr7w==
X-Gm-Message-State: APjAAAWMzJEAUrEpW6/grK+UF6GxCFcnj3wQNO1dkP6eVUrHdUGxU4AC
        xPOUiayMFt5Yblvxp8vXIuJH2AUySxocVOBdxMLpmQ==
X-Google-Smtp-Source: APXvYqzxNRvK94jxtJxmhO0k8PrlKZLR+98P8FXxh7Ge4bTNkRznw0p+mDLpxvpfpV1N1afBe0yBfT6T0tHzFxUCQMA=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr5252698otq.126.1576116962131;
 Wed, 11 Dec 2019 18:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20191211231758.22263-1-jsnitsel@redhat.com> <20191211235455.24424-1-jsnitsel@redhat.com>
In-Reply-To: <20191211235455.24424-1-jsnitsel@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Dec 2019 18:15:50 -0800
Message-ID: <CAPcyv4j_FJ9teSyfodCjXs5Wz2Pj7BjqKX6Mx53OtPnVu0mjGA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm_tis: reserve chip for duration of tpm_tis_core_init
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 11, 2019 at 3:56 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
> issuing commands to the tpm during initialization, just reserve the
> chip after wait_startup, and release it when we are ready to call
> tpm_chip_register.
>
> Cc: Christian Bundy <christianbundy@fraction.io>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")

Ugh, sorry, I guess this jinxed it. This patch does not address the
IRQ storm on the platform I reported earlier.
