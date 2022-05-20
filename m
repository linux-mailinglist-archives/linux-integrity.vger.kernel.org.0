Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C970252EF96
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 17:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351057AbiETPpu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 11:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351040AbiETPp0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 11:45:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B4B1796FA
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 08:45:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q76so8039847pgq.10
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=gs3k/28itFHvJXmdsRExbdUsV2UQMie33SCkn2ny4ZU=;
        b=0L8NTjV/6EsGEzTVPkwaauu66xx4YsEzUoOBnKyeT8AKQ+eiucSVQznEY4zduqcyDi
         0CLs1ZMX4LtInxWYR0lOUHXiLuT12sMMkriI+yvKElKS9UMbR0JE+OaI+76C2qdfF3Hy
         jZtun6jyoo7julKaC4P4QdqO9PLV/Vg5jCN1X0S47LZt+9QFApjRdLCcdWX62xXndUY2
         nQnxou1/l4hl7wb+KaYWLjGwV7izEFK3VT+KEM82NspqCBHbsTa80DQ5q+k3u7jsgDO7
         h/fFQFJjvATlEy9anqSgbM0MJQYkuyscPwNW5Es94zhcTICI8DGnphfk4ySh06KjrZAa
         zQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=gs3k/28itFHvJXmdsRExbdUsV2UQMie33SCkn2ny4ZU=;
        b=jL63BHbqmgAzGJU+Cy6I1VoFgfNFFhlcFCgS+cQMNgDUlSmpoL2HiiEwQ4LhHihyze
         zkmfjgZ8hVrv5Fk+P3heOGs26124/lTuiBEDUG1enr6fmiqXy0GQNud8zF0xJ0FwdZK6
         dqzp08chhWrD844Zy5Y0QRjHt+vIrT+mfr1Bc08iBzh5/u5CL1DsKhPZgTt1ahJ0n7dW
         oq+Qr56AA+WZeL1ab1utNltYh6loaDqu3WxAut0Px/eomSfuOzLw7LASyvqIUYav4oWO
         HxO5qnp8NUIEj1LEBUVV1TsO4aH7m5CdGOU0Iysb0iCoUiZGSH8WRetrYlusHDhonO4t
         cwLA==
X-Gm-Message-State: AOAM533tFyEN5u99m2QrZjU/UND5VI4bF7b2ao6iPhbkMa5lpLCbJOpA
        YT4VLlUG1VLsbkAIa1alRqIsdQ==
X-Google-Smtp-Source: ABdhPJwZQuyWJmMpMf/TR7lpahjw2nquTx9J7AVvExgDhp9Su6K3b7Yem6V1CcSf9pHCcHH0pCVRBw==
X-Received: by 2002:a63:488:0:b0:3f5:e6da:4619 with SMTP id 130-20020a630488000000b003f5e6da4619mr8966800pge.6.1653061523297;
        Fri, 20 May 2022 08:45:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902ce1200b0015e8d4eb1easm5838502plg.52.2022.05.20.08.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:45:22 -0700 (PDT)
Subject: [PATCH v1 0/5] Support kexec_file on 32-bit RISC-V
Date:   Fri, 20 May 2022 08:44:26 -0700
Message-Id: <20220520154430.18593-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        robh+dt@kernel.org, frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        liaochang1@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     lizhengyu3@huawei.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

kexec_file() support was recently added for RISC-V [1], which triggered
a handful of build issues on rv32.  These all seemed pretty minor, but
it looks like this is the only 32-bit platform that has attempted to
build the kexec IMA support before so I'm not sure if there's something
more complicated going on that I'm missing (I haven't tested any of
this).

The rv64 support was just merged into kernel.org/riscv/linux/for-next as
83a7a614ce58 ("riscv: kexec: add kexec_file_load() support").  I've put
these on top of the pre-merged version at
kernel.org/palmer/linux/riscv-kexec_file-rv32 if that helps anyone.

1: https://lore.kernel.org/all/20220408100914.150110-1-lizhengyu3@huawei.com/


