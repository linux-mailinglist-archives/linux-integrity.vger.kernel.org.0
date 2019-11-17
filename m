Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9262EFFB4F
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Nov 2019 19:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfKQSIy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 17 Nov 2019 13:08:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44607 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726128AbfKQSIy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 Nov 2019 13:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574014132;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eSxCHgdI3j2NAMCC1olhatH3DrTY9N/2Xvc86ib3ruI=;
        b=TNBP7Y9zbDW7+ix1gsBLW/eXAjU3p7MrRHFijhA562tHtvuHsCjqTRVAh5rwTHdQxUmcRu
        vXQ1PzKGg115ok/cGORpBG9Yu9jBc1WLupfLFlbg1WIU33MTfuJyxE+JQ9v9A6ijK3yRCJ
        yW2r0qFxjg5ej1bhbS+nAQ8gvzLq03g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-e8tV7BNNPT20y44f56SIWg-1; Sun, 17 Nov 2019 13:08:51 -0500
Received: by mail-pg1-f200.google.com with SMTP id 14so2405847pgv.16
        for <linux-integrity@vger.kernel.org>; Sun, 17 Nov 2019 10:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=nhPTTch4TLiEOOJDKHZfBwdD5XFDvnafgmAjZS61rz8=;
        b=MwQ5UOZDnauxSSyBv5knS3xUXTvStMSE7iv7hYdZPjxpTIe6CUhDbFUYzyx6L/kwFb
         Ylzm7ZDdKuqy+YhmmvoVh0HjAxjYvj6dI6qDf9D3bWaa92VCZ+pQhmXCvMXpbUaPxdfy
         iLPbBgm5E2Fw5+PWMdXTsv4muZITGRyfjqBCpHhdA/qfhMQGEcT0Ejxisfj7Fgqz3QTV
         DXvX1eTDyGCcrJqMGK4FIazqgMmIXf1MaS9nnkqNo8vrihRGjAGG9DJsq8TuPbcXDufV
         jv6b30HrBSETXkrPoYmpuS9SbimpJmZdvyGuWcYW4Sc20ehWKy9A312GkST1KdPcR38m
         Uutg==
X-Gm-Message-State: APjAAAXNHr0OJ/iOoJ+GX+rlD3Bfc45Fe7ilwo0ctzpk1glcV/FUaRPC
        os2fiPal3+owfMiaV6ntD3MRYMxLEkDgkKgQEz5xOziErRfAUHEMtHLUTMYdrb+asRMDHFBKU9W
        KU+zNbU4vnLO7KmRBgu6DIFlzg573
X-Received: by 2002:a63:cc56:: with SMTP id q22mr10365499pgi.439.1574014130314;
        Sun, 17 Nov 2019 10:08:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxg590xxVEGOOIe1dNaEgjxSEw82NPd5dgH3ztF+eBVj9rHMhiez57C0XKIHEcdFsYXYYKOBA==
X-Received: by 2002:a63:cc56:: with SMTP id q22mr10365473pgi.439.1574014130039;
        Sun, 17 Nov 2019 10:08:50 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id j186sm17803718pfg.161.2019.11.17.10.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 10:08:48 -0800 (PST)
Date:   Sun, 17 Nov 2019 11:08:47 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: Move setting of TPM_CHIP_FLAG_IRQ into
 tpm_tis_probe_irq_single
Message-ID: <20191117180847.322467cqngpbpael@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20191112202725.3009814-1-stefanb@linux.vnet.ibm.com>
 <20191114164151.GB9528@linux.intel.com>
 <20191114164426.GC9528@linux.intel.com>
 <185664a9-58f2-2a4b-4e6b-8d7750a35690@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <185664a9-58f2-2a4b-4e6b-8d7750a35690@linux.ibm.com>
X-MC-Unique: e8tV7BNNPT20y44f56SIWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat Nov 16 19, Stefan Berger wrote:
>On 11/14/19 11:44 AM, Jarkko Sakkinen wrote:
>>On Thu, Nov 14, 2019 at 06:41:51PM +0200, Jarkko Sakkinen wrote:
>>>On Tue, Nov 12, 2019 at 03:27:25PM -0500, Stefan Berger wrote:
>>>>From: Stefan Berger <stefanb@linux.ibm.com>
>>>>
>>>>Move the setting of the TPM_CHIP_FLAG_IRQ for irq probing into
>>>>tpm_tis_probe_irq_single before calling tpm_tis_gen_interrupt.
>>>>This move handles error conditions better that may arise if anything
>>>>before fails in tpm_tis_probe_irq_single.
>>>>
>>>>Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>>What about just changing the condition?
>>Also cannot take this since it is not a bug (no fixes tag).
>
>I'll repost but will wait until Jerry has tested it on that machine.
>
>=A0=A0 Stefan
>

Sorry, I'm still waiting to hear back from the reporter, and logistics
for some reason has been silent on my request so far.

>
>>
>>/Jarkko
>
>

