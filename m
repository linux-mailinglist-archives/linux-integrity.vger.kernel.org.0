Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3675DD7F5B
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2019 20:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfJOSrd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Oct 2019 14:47:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43300 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfJOSrc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Oct 2019 14:47:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id r9so19001134edl.10
        for <linux-integrity@vger.kernel.org>; Tue, 15 Oct 2019 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pfvg+FTtrisg7B2S8oM0CWu26E9e8Sf1gXQfTf34924=;
        b=DWS32JsmOlg5VgikKYtVcPLKwn3b9Q4/V0KNahVXNAMx9O+6dQVwKcEF+Lndyz/cUP
         T8qVbCzzI3QD4vSRPTkIfkRWU0VtopbR5bmjoK4EhIeo9z9nHu8Y2+S4WUCHESEGLueY
         kZnycdUuYFT92OAHv90YZyjrMLD64mqJ+UjTBIxOfJG0g2TXBBHtiI1uNutceqDunni7
         83OPAVIphlgUTv6vOQ4XNmhn+EIzhha33eHjbIWmFxMuCd9Q36GIFYhc2Df2CVCFka+j
         tj76RJeVAtrK9OBMXa9y9PmMSeCS5tBi6bId/9RNBVnNplRBX3EyVTbe+cvZFAJ/BjE7
         ZpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pfvg+FTtrisg7B2S8oM0CWu26E9e8Sf1gXQfTf34924=;
        b=pSS28FK1D6sNKxqh38DgZ45lcwqjmt7ltDXruP9rv6E6RkcGZiLbQ/vh2l6KHWfHCT
         BWHMvNxFFGnw+s8uyu+y4DmrzfxVJwl/msLJ3ND/bGdp3ZmXXpSiX8d9zuN1e8SWeX8X
         1P4ZNnxhHTc3cdxPOX7t5uQFysjW/rI0j0ZCe7bXFxF2zkk569pjA8yhD7Sm/xxnqCiD
         fhEqxPKzj0PG75Xr2WpLYG9K5AsEF+DIzAEWEd9n3hNeWWukVfZA7Dogs3Lf06MxM8EM
         nnfr84IP7fx7Qc5vs6T/Jiufw12YOQr7wyMg3pqfJlwOzYj96BvYLmdZE3IGQiHP5gTc
         Ds8w==
X-Gm-Message-State: APjAAAW5QwIcbwrpihKDgKPpw8ryVz8qNl2VCqr7+Zn+gLKX14XmCAOZ
        SwpltzxmeDMi9YQl1SdIlHO8/XxoFgSmgKsqpcfJtg==
X-Google-Smtp-Source: APXvYqwYBNXfzf8UL1/6WH3Lzo2PnVa4eH7g/2iw18YIH4cRXry4dS5x/CxY7akvONtDlQt0LutAiqvmrk0BHlBahoo=
X-Received: by 2002:a05:6402:2022:: with SMTP id ay2mr34963109edb.219.1571165249255;
 Tue, 15 Oct 2019 11:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191011003600.22090-1-prsriva@linux.microsoft.com>
 <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com> <b35b239c-990c-0d5b-0298-8f9e35064e2b@linux.microsoft.com>
 <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
In-Reply-To: <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 15 Oct 2019 14:47:18 -0400
Message-ID: <CA+CK2bBVcE91YbJx1f_BkNqbD03wGLNtyane7PjCnEu8i_cH2Q@mail.gmail.com>
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
To:     James Morse <james.morse@arm.com>
Cc:     prsriva <prsriva@linux.microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-integrity@vger.kernel.org,
        kexec mailing list <kexec@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, jean-philippe@linaro.org,
        arnd@arndb.de, takahiro.akashi@linaro.org, sboyd@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>, zohar@linux.ibm.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>, duwe@lst.de,
        bauerman@linux.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
        allison@lohutok.net, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> I think the UEFI persistent-memory-reservations thing is a better fit for this [0][1].

Hi James,

Thank you for your thought. As I understand you propose the to use the
existing method as such:
1. Use the existing kexec ABI to pass reservation from kernel to
kernel using EFI the same as is done for GICv3 tables.
2. Allow this memory to be reservable only during first Linux boot via
EFI memory reserve
3. Allow to have this memory pre-reserved by firmware or to be
embedded into device tree.

A question I have is how to tell that a reserved region is reserved
for IMA use. With GICv3 it is done by reading the registers, finding
the interrupt tables memory, and check that the memory ranges are
indeed pre-reserved.

Is there a way to name memory with the current ABI that you think is acceptable?

Thank you,
Pasha
