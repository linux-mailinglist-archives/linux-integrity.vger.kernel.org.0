Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E101413A6A
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Sep 2021 20:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhIUS7n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Sep 2021 14:59:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232481AbhIUS7n (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Sep 2021 14:59:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE31160FDA;
        Tue, 21 Sep 2021 18:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632250694;
        bh=oc/f52nlc2DdkyCoKdR2ism0dRz5L3KWM4w49adqRl4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nMZEX1CVFJfjIK0ovN54aVJ35VQeQsjCgo8+HMst+nW5rf+k/PpAEzjW11AV6ck+A
         YsDarfb9FWOuDxuWYOYqpP22wLIlzmCEqJDCncdtLNGaMZbXsh5QcdJ/nhPppXG16w
         LBguKDQVRIjKytuvLNPfCCfKLO9BkWdunnh2woR7jp8z1rAB1SDQlfavb/aFcvgRR/
         NnhaEoZAL7fMI6c/Iupp2eFZosI7U9YaABrhltyiArChIOuMMBoXjwevWD9XmKK2V9
         N8TNdAKOpZ/PeYlRLxJMLAcgV+1tPOj2fXp6tcT0BXIhndvKeOQJhz8b04LlFgg1p0
         /Kzt4V6ULuFGQ==
Message-ID: <896a0773cac953ae2f35ba08af65a598aa71942d.camel@kernel.org>
Subject: Re: [PATCH] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI
 config
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Morten Linderud <morten@linderud.pw>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Date:   Tue, 21 Sep 2021 21:58:11 +0300
In-Reply-To: <20210920203447.4124005-1-morten@linderud.pw>
References: <20210920203447.4124005-1-morten@linderud.pw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-09-20 at 22:34 +0200, Morten Linderud wrote:
> Some vendors report faulty values in the acpi TPM2 table. This causes

Nit: ACPI (not acpi)

> the function to abort with EIO and essentially short circuits the
> tpm_read_log function as we never even attempt to read the EFI
> configuration table for a log.

Nit: tpm_read_log()

> This changes the condition to only look for a positive return value,
> else hands over the eventlog discovery to the EFI configuration table

"hands over" -> "fallback"

> which should hopefully work better.

Please write in imperative form, e.g. "Change...", or perhaps in this
case "Look...".=20

Hopes are somewhat irrelevant, in the context of a commit message.

> It's unclear to me if there is a better solution to this then just
> failing. However, I do not see any clear reason why we can't properly
> fallback to the EFI configuration table.

Neither hopes nor doubts help us :-)

Because the commit message did not discuss any of the code changes
that were done it is very hard to say much anything of this yet.

There's also one corner case that was not discussed in the commit
message.

The historical reason for not using TPM2 file is that old TPM2's
did not have that feature. You have to ensure that legacy hardware
does not break.

/Jarkko

