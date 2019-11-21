Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF431059F2
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Nov 2019 19:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUSt4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Nov 2019 13:49:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31662 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726563AbfKUStz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Nov 2019 13:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574362194;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TzJ/SsHtd7bfy/oDgO2Y3q0F7ElX8gGJByg/j13Qj6o=;
        b=KXhefWumSo0m12Y62bBYnMPubcXLTksjcHOiYaLiYagHzqOQQlTTvFvQl44ZqksA59N/os
        oFPqJGGoVvnffL15BiOQB2nExis8GtB1tE0xnoKejOcaSMkXhSmXMrAqO01DUUvXi/DXz9
        ryZQWBKi7yAPODk6wPjs2yL0hx6Ghb4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-qYcJ6ryWMPuz6S_zx39dVg-1; Thu, 21 Nov 2019 13:49:52 -0500
Received: by mail-pg1-f199.google.com with SMTP id v10so2445291pgg.3
        for <linux-integrity@vger.kernel.org>; Thu, 21 Nov 2019 10:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=YJjTnRWdM797ItW0zSRoz6NPhQjSBtbCZP9Ez1Vbe0I=;
        b=ADtouAxztMjNkbbKIlWfknySPwWeQtp8m3pvOoM3H8A4V7I9OEpKQVy0p9BheVY2Wh
         6trowD67R8neZxpUh0TgOSTnbwRD0BEdjtvOu1NafOU008hpXjP7n4iGjnV2O6GPFewA
         KB0zMIzxpC3rpgzQtw6CyFCO3ZjaYoI0bxajmP7Fe3iEajYGQP7PhYCGXGYgh7yDqK+J
         1E0tHWt0ENbXsVXRhzFaMidtZbr4q5DPATpTJkwRUyb30NgUx2KihZPSGvGMAkXjXXHK
         QTNB/kXkolYg3u52BL7vq432S95oheMnbBNG0WIK/IOxpN0xCnBMPjhuBG/tK0IthYBf
         ZT6w==
X-Gm-Message-State: APjAAAUFIBSJ6xRmmhaZIAQPF/dDY+YI+NdCzOQUPzRUCzRHsQq+j398
        UcPwODna0+asGmjZAT4uNZcFshgQYJKVf9hzbp6CajGW7S60xVvHHSa2jGwS7k2puM/f+RUQAEi
        LUzdSrSwtLeLFGvwB2idYfIcw2DQW
X-Received: by 2002:a17:90a:cc18:: with SMTP id b24mr12761778pju.141.1574362191690;
        Thu, 21 Nov 2019 10:49:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxWAeBHfju8V5AcESOH4Gfa3Chb2r15GgQNTf03+xntRYELUlaqlYma+S+2k2og5XTP8gvB1Q==
X-Received: by 2002:a17:90a:cc18:: with SMTP id b24mr12761762pju.141.1574362191492;
        Thu, 21 Nov 2019 10:49:51 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id p123sm4422462pfg.30.2019.11.21.10.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:49:50 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:49:49 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: Move setting of TPM_CHIP_FLAG_IRQ into
 tpm_tis_probe_irq_single
Message-ID: <20191121184949.yvw2gwzlkhjzko64@cantor>
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
X-MC-Unique: qYcJ6ryWMPuz6S_zx39dVg-1
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
>
>>
>>/Jarkko
>
>

It appears they still have the problem. I'm still waiting on logistics
to send me a system to debug.

