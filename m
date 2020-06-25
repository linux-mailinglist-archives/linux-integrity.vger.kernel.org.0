Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2E32099C8
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 08:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389663AbgFYGV5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 02:21:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50519 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726493AbgFYGV4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 02:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593066114;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=RANWi8MsV3pCLZkoJfRG4MlBXvH11AYTJIWScwC3Zys=;
        b=feLNBAs+6osXNLuWdEz+WiwDz69JlcDsly0p4ac2tg/Ev4OOWqXkA8Iv0K8M41bruhsZjx
        YzBsYdFAJjh6NW7JkL3WioYG2lmsDP0qBu+4BYUxV39ZsGrINOcEYBu2Me4HZ+4mPLKT5H
        R2jy434Ki8DjI5Uvkz3jfyj/BnMhyPY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-I_ZjAJhOPJ6bW5pmry9Xcg-1; Thu, 25 Jun 2020 02:21:53 -0400
X-MC-Unique: I_ZjAJhOPJ6bW5pmry9Xcg-1
Received: by mail-qv1-f72.google.com with SMTP id da10so3386055qvb.2
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2020 23:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=RANWi8MsV3pCLZkoJfRG4MlBXvH11AYTJIWScwC3Zys=;
        b=YxCk8e9Nyj2/ssi1aeU1NnaSQY1+/P6gppVPvIptoPH9ZbhA031Rs6tuMNu7+Digef
         m8dNh8n0WKylQnNBA56C4tngvgN2ZByE/kZ6BtpDYNijlRfmXRVIY0ShbGHVAuMe5Zaw
         BpekwoNuwKZ9JWwnlhfplUxbFnB0pxxC0WU2PtItQYX2pJ9YPUzRMNDoEEobn1nuRloS
         +wf2U/zFDaacIzyq5xMV9W8cXzkGvQEfvpOlE5v4b/4LNLuBfWXWrnoumH6lnRbUrb+G
         NZFuxIs1ks3Sl6DkKXaBdulM/3AvneBeLbQSMMHuZVw4/lMrUfoTOE9t46ezsjRdIuxw
         awXw==
X-Gm-Message-State: AOAM532mKrmpgXUNCblJw9xIq+JWn6gJUbI1VvS+CLXMaET7k4zGOErj
        NDzGSi+vWxTY5aAmvpNhOXtKofU3TP0mA23PQa8uNWad5ic8W+WfEtqE+2SV67akpz9e2pZJ0CI
        LZJEpBZUoKJykUMM5JFBRSu5ZRpPJ
X-Received: by 2002:a37:aa83:: with SMTP id t125mr30115550qke.231.1593066112737;
        Wed, 24 Jun 2020 23:21:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7DZxp3j6YwaiC9QEGZtJDfKb+Eetc7xPdd+bygMwcAVIIYh69HcGEphZuTg+ZeyNGB5yjFA==
X-Received: by 2002:a37:aa83:: with SMTP id t125mr30115533qke.231.1593066112493;
        Wed, 24 Jun 2020 23:21:52 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id y16sm5202042qkb.116.2020.06.24.23.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:21:51 -0700 (PDT)
Date:   Wed, 24 Jun 2020 23:21:50 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm_tis: Remove the HID IFX0102
Message-ID: <20200625062150.idm6j3vm2neyt4sh@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Jun 25 20, Jarkko Sakkinen wrote:
>Acer C720 running Linux v5.3 reports this in klog:
>
>tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
>tpm tpm0: tpm_try_transmit: send(): error -5
>tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
>tpm_tis tpm_tis: Could not get TPM timeouts and durations
>tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
>tpm tpm0: tpm_try_transmit: send(): error -5
>tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
>tpm_tis 00:08: Could not get TPM timeouts and durations
>ima: No TPM chip found, activating TPM-bypass!
>tpm_inf_pnp 00:08: Found TPM with ID IFX0102
>
>% git --no-pager grep IFX0102 drivers/char/tpm
>drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
>drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */
>
>Obviously IFX0102 was added to the HID table for the TCG TIS driver by
>mistake.
>
>Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
>Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
>Cc: Kylene Jo Hall <kjhall@us.ibm.com>
>Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

