Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5C91BF531
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2020 12:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgD3KTW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Apr 2020 06:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgD3KTU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Apr 2020 06:19:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545DDC035494;
        Thu, 30 Apr 2020 03:19:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 188so1209357wmc.2;
        Thu, 30 Apr 2020 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sbJYXBlwGOLyg45ji2Ben6BeJhkkj20b9i5FNHgQc7E=;
        b=TFJz3jN9l51rL4sTRvaVWsNqtueSOmy0YG5dmVZvHcJy4oBNjiahe+LWXBQ0omqKGM
         k7U8HX+i6gwboswmMM7LMM5IqcT/1ixfnPbCg01AUcEawoXsvhW+xg4wFcvwqXc43gCn
         YIs3qJp5bEZip/9tf6qhMdsNPfeL35Mpa1g65e2pAW+fWeuDCst9JFRU/M8BgsFUinDW
         57orgljHmHwzOmTgSVrus7Z8x+jt8+/w2xmYoJvrSoURGhlCdILwZFdpxVXbagM+kb+r
         qUJPqKJ/EMBwrKf1/klC0EuRmjlzYmMorc7Q1VCfgjiqikXPAyLFcaqhN/744J1VABTH
         Yr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sbJYXBlwGOLyg45ji2Ben6BeJhkkj20b9i5FNHgQc7E=;
        b=eVl4mfW0dlC4oxXblQ8IiUuenVskuu06Ms6bGxi1cAGPUSBe5eW1PlRDcG0tQ43x0j
         7txD2WPTuw++wIuAKrncABDfRpb9FkeWNkEnYtshLh5mL42PkWvkMhsy9rX6TLaywPby
         bPt9d6O7Y8/LzQZ3vwPJD7BzpYxhPADSUCGrZxkno6eqg0KsdMlKw8gY6el9NCwAzhON
         HRimerOkVI1XIhyp6aBHxp4FzpV/kiagfNeDL+Un2kWFnpbJcfr+C2OeG3wa5nFL+DvS
         cBKjYYQvLtLVcKqzSJSn4ph2Cb/UET0dNf168qgGtyBhinbbkdA6nc/MwNy/T2s04e41
         lBLg==
X-Gm-Message-State: AGi0PuZSBVobo2mHZwWZTphV4Tcj8r3DL9M6J3L0WdxmGzZ+UmmdFnUV
        lIHdnH233VqSvJe9Iv1uwuc=
X-Google-Smtp-Source: APiQypIFiyR1IL2f8nMpAUjauJb0orpbTeK/JIXN9qbR7trpNDpfeWSNlZ611isWlDjsKZ6MpJqPYA==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr2141356wmi.178.1588241956107;
        Thu, 30 Apr 2020 03:19:16 -0700 (PDT)
Received: from [192.168.43.138] ([37.142.166.235])
        by smtp.gmail.com with ESMTPSA id 185sm13450326wmc.32.2020.04.30.03.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 03:19:15 -0700 (PDT)
Subject: Re: [PATCH v7 2/7] tpm: tpm_tis: Add verify_data_integrity handle toy
 tpm_tis_phy_ops
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, benoit.houyere@st.com,
        eajames@linux.ibm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        oshri.alkoby@nuvoton.com, tmaimon77@gmail.com, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com,
        Christophe Ricard <christophe-h.ricard@st.com>
References: <20200427124931.115697-1-amirmizi6@gmail.com>
 <20200427124931.115697-3-amirmizi6@gmail.com>
 <20200429053456.GE8452@linux.intel.com>
From:   Amir Mizinski <amirmizi6@gmail.com>
Message-ID: <d0eec29a-20f5-1187-f0c3-c564879d7878@gmail.com>
Date:   Thu, 30 Apr 2020 10:19:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429053456.GE8452@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2020-04-29 05:34, Jarkko Sakkinen wrote:
> On Mon, Apr 27, 2020 at 03:49:26PM +0300, amirmizi6@gmail.com wrote:
>> +    bool (*verify_data_integrity)(struct tpm_tis_data *data, const u8 *buf,
>> +                      size_t len);
>
> Why can't the i2c driver verify this in the end of read_bytes()?
>

The TPM calculates the checksum of the entire command data at the end
of command transmission or the checksum of the entire response data at the
end of response transmission.
read_bytes is not necessarily called at the end of response transmission. Same for write_bytes.

> /Jarkko

