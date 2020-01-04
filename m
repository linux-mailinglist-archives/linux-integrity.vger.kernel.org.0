Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD851300C6
	for <lists+linux-integrity@lfdr.de>; Sat,  4 Jan 2020 05:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgADEdH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 23:33:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53302 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725877AbgADEdH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 23:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578112384;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=EH4HIVfE1g94Oc74sF5uvgjnl7asPTcL1vJBmw2UA5M=;
        b=Ki152kK+KEXN9irGtDYdaUXwTfZNDrbWtX3jvqCQ7VaRXw5+rAv0Acua70OgyUTC9Jqeg4
        uNmklJBxpOZgPgt+SIMbccL7Uq8lZqphmHuyDGrS27/ZM3kKpvblYvQ/zofL2sAsVYg2gO
        b2Du70SdG8AD9KWCkv3R8ZxFQreS0p0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-VNcs4qoFM2ezAVa0PIgSCA-1; Fri, 03 Jan 2020 23:33:03 -0500
X-MC-Unique: VNcs4qoFM2ezAVa0PIgSCA-1
Received: by mail-yb1-f199.google.com with SMTP id z66so11513258ybc.18
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jan 2020 20:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EH4HIVfE1g94Oc74sF5uvgjnl7asPTcL1vJBmw2UA5M=;
        b=FEOFU+TrQRivulHKpp6qt3Mg5CpnpklHK8BB2EjDjvSsyQvMJsHFkGbpYaJ+tcd2q5
         FXtRVcvg+xMDlBiPCVhRj9h/YdQDO5Gu+VHzh1JJmeo11HQST9ZWfZe9Qb9S76rdr5Ag
         xqgucuaAFB16gk+Kpi/57LI4ZT29fh88i5xFHXIDfKDbIM0GiMjCkbl2cO05Kcg+fYM3
         G1o93upEbNSeUL2XQwNIofJ1o0dUw2ThjM/I+kQ43rEarLWvr1c3cWfANgwODDXnrtKO
         SMBF4q0MUEaj0TvuT7g5u8jwSVNN9rTrGklOmPNPeweVQSUtyUgRXxBHhaiJkD94R5ZZ
         XzAw==
X-Gm-Message-State: APjAAAVE7dvumnrbzH0oGxAcZFGDPpqA2pIqae1lATQvVkliCiviAi4q
        nnQvEQs6LuRH/PXYMBK4kAseUjz3Pi0PbgSgjOOhpcSbPneRF/CxIzinzBTCG/KbRYeFZ5rNaB2
        yL+xrOzbqQJW/TqQfkj2YNooMd1IQ
X-Received: by 2002:a81:2f04:: with SMTP id v4mr64921590ywv.341.1578112382616;
        Fri, 03 Jan 2020 20:33:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYrucKBjExCaCtPyxX/ykitdGBb5WIYegTI6Se0XwSbgJhV2yWefwN68nViIpFEk+rJGnJmA==
X-Received: by 2002:a81:2f04:: with SMTP id v4mr64921565ywv.341.1578112382327;
        Fri, 03 Jan 2020 20:33:02 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id z12sm24661864ywl.27.2020.01.03.20.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 20:33:01 -0800 (PST)
Date:   Fri, 3 Jan 2020 21:32:59 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH for-linus-v5.5-rc6 0/3] TPM changes for v5.5-rc6
Message-ID: <20200104043259.krg7uo6q7owg4fka@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
References: <20200103232935.11314-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200103232935.11314-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat Jan 04 20, Jarkko Sakkinen wrote:
>There has been a bunch of reports (one from kernel bugzilla linked)
>reporting that when this commit is applied it causes on some machines
>boot freezes.
>
>Unfortunately hardware where this commit causes a failure is not widely
>available (only one I'm aware is Lenovo T490), which means we cannot
>predict yet how long it will take to properly fix tpm_tis interrupt
>probing.
>
>Thus, the least worst short term action is to revert the code to the
>state before this commit. In long term we need fix the tpm_tis probing
>code to work on machines that Stefan's code was supposed to fix.
>
>Link: https://bugzilla.kernel.org/show_bug.cgi?id=205935
>Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>
>Jarkko Sakkinen (1):
>  tpm: Revert "tpm_tis: reserve chip for duration of tpm_tis_core_init"
>
>Stefan Berger (2):
>  tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for
>    interrupts"
>  tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQ's"
>
> drivers/char/tpm/tpm_tis_core.c | 34 +++++++++++++++------------------
> 1 file changed, 15 insertions(+), 19 deletions(-)
>
>-- 
>2.20.1
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

