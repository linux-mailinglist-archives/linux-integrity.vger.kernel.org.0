Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 993EAB6A87
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2019 20:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbfIRSes (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Sep 2019 14:34:48 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:35219 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbfIRSes (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Sep 2019 14:34:48 -0400
Received: by mail-io1-f48.google.com with SMTP id q10so1623803iop.2
        for <linux-integrity@vger.kernel.org>; Wed, 18 Sep 2019 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:date:subject:message-id
         :to;
        bh=AAWpl8T8CUzXxXA3WLT6ExuW+cisvl4IaWgPxaGLOZE=;
        b=fJzaknzWPRkMCaixo3OAbIYsqJ931MxfiAJ2HlHpwxM3bgGhUk1/NwqHpnwxVf+Qk8
         NdQaES9cB47t36XOGSHH9/7iyExH3TFCAjVu5lItRS2DMXdZknL4XLu9kyYBQvXNu+T7
         1gxhcDlB3jLR5yb36krosWike7hLGW6sO2aR9PHj2uI+viBCL2TI9DHbvdnTz4J8f2Pl
         d5tYVlAQxjJGnQvYhy2CmOI1ldISv9wKcmtr2ORyqp+e3zcok1F0leMUBwWY8A3t2zOo
         W7V2HOccVBdqdHp+0t8zqpeRzp05dQxr4nxWmMLwamUACyRqbAdFu++DBGOBk/P8ppQs
         3ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version:date
         :subject:message-id:to;
        bh=AAWpl8T8CUzXxXA3WLT6ExuW+cisvl4IaWgPxaGLOZE=;
        b=oBPAlCRVvIhghJM1oMR5/aHxuahLFgESzzhSevJirjhqkWbG90iWQSTMPQRb2e1lAP
         qOp2WD3D+NlwLnJhiH/LHxr1Vh5X/3xX8OCh38jCd7gABQ1tVA4uR9eYJeq7kjq1N+s4
         csMO6Jp2qbQQhLmp8z3juA8YYMnEW+Udi/KrU3VHoYAQLwDwB+EvjxtpBB6zeI+I3M1J
         UcQD63HqZC/YzVPKNgTv0VaQaiOdx+zxyglesdgX1iZxD+T2BLQ6ledxQS05wm65lsX0
         NGcZvLnVB3HKuwU6RexuAr9SXlIoMe31cTEOCeqUvEq+D9TfN9kz298HaI3qFGy46ZmK
         g47Q==
X-Gm-Message-State: APjAAAWeyYU5mszUdUPEJbwY8gVxp3RKcYpEgaSbar9rFKFowPwHZ23b
        AvlKV6EC5+wutM8sqNLO4Zs2CJrr
X-Google-Smtp-Source: APXvYqxyv/P/TPCtEYGrpLRSdffpNLzwW9AOx/7ZYAqfV3JJYe5ou4Cpnkv2PkN6lZzQOXPG7v+AUQ==
X-Received: by 2002:a5e:9917:: with SMTP id t23mr6783864ioj.141.1568831687745;
        Wed, 18 Sep 2019 11:34:47 -0700 (PDT)
Received: from [100.64.74.169] ([205.185.206.122])
        by smtp.gmail.com with ESMTPSA id m67sm5981339iof.21.2019.09.18.11.34.47
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 11:34:47 -0700 (PDT)
From:   Rich Persaud <persaur@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date:   Wed, 18 Sep 2019 14:34:46 -0400
Subject: Platform Security Summit 2019, Oct 1-3, Redmond, WA
Message-Id: <112E0740-D7E0-46A1-880F-EA40CB53510F@gmail.com>
To:     linux-integrity@vger.kernel.org
X-Mailer: iPad Mail (16G102)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If you attended last week's Linux Plumbers microconf [1] on system boot and s=
ecurity, you may be interested in Platform Security Summit [2], a single-tra=
ck conference with  talks on coreboot, LinuxBoot, TrenchBoot, UEFI, TPM, TEE=
, TXT/SKINIT, OpenXT and more.

Rich


[1] LPC System Boot and Security MC
Schedule: https://linuxplumbersconf.org/event/4/sessions/69/
Notes: https://etherpad.net/p/LPC2019_System_Boot_and_Security/export/html

[2] PSEC 2019 speakers
https://platformsecuritysummit.com

[3] PSEC 2018 videos on boot integrity
https://www.platformsecuritysummit.com/2018/videos/

