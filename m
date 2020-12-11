Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872322D81A3
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 23:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392481AbgLKWK6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 17:10:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33563 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394203AbgLKWKu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 17:10:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so9686548ots.0;
        Fri, 11 Dec 2020 14:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oq++uhCmsnyyXvk0n60vkspuJ0SIr1rZ3dJJxaNRN5E=;
        b=UONlHUL63OTmkZlsBHudAw5CqXuwAzVvx6F8eXcR3elMY1TYjwGWf7evseeL9FYWSY
         NyU38tBHxRCeJhbDfBoj53WxqLQEEcDirBTEz3LBskxlbg+9Qzf17xzq5rZwb9Pha0/b
         2zy/U4AXqSAzfrVaFxxDgZlPuQ2C/y57EwuceS+T//MWulZJ4u+w+F3tFtq2Iw1EhE/e
         8vBqeGMpW3OFwABKSMFky6oH2jIWaIIXfzHhQyglZIcl59wJuE4HI8YGJIXvztOifp3K
         hy8jV3NrAtgtf0UCW4EVnINJeCe3cXCN6NHSnLwoYDitMGix8v8Vke65KGvYZTH6ZW4s
         f55Q==
X-Gm-Message-State: AOAM533im8T1/Gijf8Sr9q6INeGKmm8PMQNRhTweD5QIyeE8Lsry5Vc0
        Uw3Sc7+U4HXfMpXuaOnsNg==
X-Google-Smtp-Source: ABdhPJzeBX2tVJeSiGStJt2Ek5vehPy1u8gbNMa270Il+3gKwOB7uc/SjrhkjkULY9asLmo+pxIcqQ==
X-Received: by 2002:a9d:506:: with SMTP id 6mr10864645otw.95.1607724610264;
        Fri, 11 Dec 2020 14:10:10 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id p3sm2137383otf.3.2020.12.11.14.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 14:10:09 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        takahiro.akashi@linaro.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        zohar@linux.ibm.com, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: [RFC PATCH 0/4] Kexec FDT setup consolidation
Date:   Fri, 11 Dec 2020 16:10:02 -0600
Message-Id: <20201211221006.1052453-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Lakshmi,

As I mentioned before for the arm64 IMA support[1], the common parts of
kexec FDT setup need to be pulled out before adding IMA support. This series
is what I'd like to see done before we add any more kexec features. Arm64
and powerpc do essentially the same DT setup and the differences don't
conflict.

It's RFC because it's compile tested only, could use some better commit
messages, and I'm only throwing it out to show what I want here. A branch
is here[2].

Rob

[1] https://lore.kernel.org/lkml/CAL_Jsq+3qBr6JT3dysSt28j0UJq80u9YRf5pAh0Dvv5_+pFKXw@mail.gmail.com/
[2] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt/kexec

Rob Herring (4):
  powerpc: Rename kexec elfcorehdr_addr to elf_headers_mem
  of: Add a common kexec FDT setup function
  arm64: Use common of_kexec_setup_new_fdt()
  powerpc: Use common of_kexec_setup_new_fdt()

 arch/arm64/kernel/machine_kexec_file.c | 123 +------------
 arch/powerpc/include/asm/kexec.h       |   2 +-
 arch/powerpc/kexec/file_load.c         | 127 +-------------
 arch/powerpc/kexec/file_load_64.c      |   4 +-
 drivers/of/Makefile                    |   1 +
 drivers/of/kexec.c                     | 228 +++++++++++++++++++++++++
 include/linux/of.h                     |   5 +
 7 files changed, 247 insertions(+), 243 deletions(-)
 create mode 100644 drivers/of/kexec.c

--
2.25.1
