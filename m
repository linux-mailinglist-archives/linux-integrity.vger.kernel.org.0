Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E66A55916C
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jun 2022 07:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiFXEty (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jun 2022 00:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiFXEs2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jun 2022 00:48:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC2E6924D
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jun 2022 21:48:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n10so1151516plp.0
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jun 2022 21:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=VOrN2Skldd6ynBdimZLEfOLlQdQeXbU4ZvduMfJHL6c=;
        b=XgTwJU2SJn7OgRjOacDrBq8AbIvZy9A81IA50d1kPRNcGZ35nasRgjV4RLK/GhrSHQ
         liBXBNjEUUlPp7BL7s5TqwGWSyxagHvQ+xTyaGyQcCkEpt11davqrfMjfjAoapuf6WZn
         v6n8vJYQWsu4abQaVlYDcuSEV6Jot7TID2g+Pt0cEwyChpdWBH/41ODLnB/El/jl5Xlc
         WGrSAghyUAohMDgNK8/g16MxKloX+ZO5e5BTBzscGGT9lseU/cNO1WuZfmcRl5onAV85
         +S2Z1J0jMLcEbiefwlIIQiebdEEaaQDPxk7iERWdaKfVeUWSz1gTQ1mXF06EWgq4DNX0
         fgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=VOrN2Skldd6ynBdimZLEfOLlQdQeXbU4ZvduMfJHL6c=;
        b=xsqGu46JHr3IIUIoxZsp5whSkps97FFQL/F+3wf5xgKDNJiRO+mO39/0fpLC1oGXVA
         IsNjD+xfiw497nf8gwjD7VIia2DiWnTo5irCB4//bxvoi3FhtKEi7eG9EOnW1PBabQRH
         B59HKBwmwJPAd0qcUHo6OjJAUOAPProOXWsqF7wN/r/WTNsR1NtiQx1/vs5cTuQ0dGIt
         KmBDvaKpjqmwT4zsAX+BkgheAVMcY0KPZg21CdblDZwU9sFmlVhxEDAf3pOzUMM8QXsU
         63kFpVCFpmDl5C3eblBzUJ27QApI2cUMcmclWXc+pEx6KXtv5OG30cVSOUbvB9AMxCLQ
         Bjsg==
X-Gm-Message-State: AJIora+CpeqPMHC2u7UogIWbWUdjjB0kFpCutxBk47jLrwm7bq/YPcK+
        w7D5MGtrZbzY53mE8er1mgXXjQ==
X-Google-Smtp-Source: AGRyM1twjNfvXdC15oBPlo3E7P9L0CcbGOzh0tICPbKtW3VyqvOblbLp0OUdm7yJez7FETjSBlaYbg==
X-Received: by 2002:a17:902:d48e:b0:16a:67e7:d979 with SMTP id c14-20020a170902d48e00b0016a67e7d979mr1887249plg.29.1656046104242;
        Thu, 23 Jun 2022 21:48:24 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id x20-20020a056a00189400b005251b9102dbsm557073pfh.144.2022.06.23.21.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 21:48:23 -0700 (PDT)
Subject: [PATCH v2 0/5] Support kexec_file on 32-bit RISC-V
Date:   Thu, 23 Jun 2022 21:48:06 -0700
Message-Id: <20220624044811.9682-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
            linux-security-module@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This rolled itself back to the top of my inbox, so I figured I'd send it
again as Rob's review landed.  IMO the security/integrity/ima/ change is
sufficiently trivial that it's fine to take it through the RISC-V tree
but I don't have an Review/Ack so I'll wait until this loops back again
to give the security/integrity/ folks a chance to chime in.

If this loops back to the top of my queue (which looks about a month
deep right now) without any comments then I'll put it in riscv/for-next.

Thanks!

Changes since v1
<https://lore.kernel.org/all/20220520154430.18593-1-palmer@rivosinc.com/>
* Collected reviews for drivers/of/kexec.c.


