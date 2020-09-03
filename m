Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA55625C449
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Sep 2020 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgICPIG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Sep 2020 11:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgICPIA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Sep 2020 11:08:00 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2272CC061244
        for <linux-integrity@vger.kernel.org>; Thu,  3 Sep 2020 08:08:00 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id m1so2795348ilj.10
        for <linux-integrity@vger.kernel.org>; Thu, 03 Sep 2020 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0NIPwB5WRfZyyF/k/B89ED0JGlfKlhV/NTtA4CDxlP4=;
        b=u+1OR+j7TIAgqwyRrcMrAAPYda5c7VClmjFAUOQ6qt06PHXzgdCtD6dPmuhuUZUc/r
         VprMz0GSpV2wezXXcqMtXfDBaoS5vgbFnnpAW22HudOnWMDV+AvRrq33NnjU0XQIk7BJ
         Lh8XvsVbAmwOqD+QNT+3qyiOKv5xpbl6HClyGgoL9+s5ubtSptvZcQOMF8qX7XY+Wvfy
         DlBxOZZqfVJFgyiOJ8//Y8dkLD1rz6ydb/EQR7F7AptpUlXl/4HVScRix/xKsrC93FqM
         VLR/wLdQZ6XRdJ0A/EcIiQ19yCJoBrey7ulyHiLSZjGYw8YVjA57yzeXNkUD9lkSABj5
         hgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0NIPwB5WRfZyyF/k/B89ED0JGlfKlhV/NTtA4CDxlP4=;
        b=hK970qnIW0kSOcy7XWa/Jzzk5/NOHj+jIidVqDyvQtcYK3sUYq97gezJ4Aj18vUq37
         fJM63llBxeVdcVsHcGfpvYIPI4kGKd60Zhi+yESzXqS+gI/ah9KzusOeIYPeZ7StGBV8
         V2ENhwRtzP2+eVqdasdW4oaOB+KG+/RSgLyTZhWsip2Vn1Xv+jN5bGNn2rnanzb47uLi
         0SNCuOhFtgFK/FeM/UAcR22CETeEXF+0dZiO2erA+0aTY7ioRSM8m0g6UyJvRMnPcKBa
         M9I+lvqn8noM2sV5Wt1rGh/A8SgXWtzAxmoWxISQwKOkfkNRz9xLSBWvTYZy1Um9Gqfu
         VjhA==
X-Gm-Message-State: AOAM530orr+yOXtIKHp6pCjGxS//o8w6u2MTw+ry2iLKssriOtYKiPR8
        W+iL3qNl16KygtEZ7FxjFMcEtuKE8rJMRwpIOBXTYKP5ua0=
X-Google-Smtp-Source: ABdhPJwD+CppqYzHqXDGarRkEze6fHaXv1rzj+Cu3dmpnCmWOM0kIsQVFFz5fn2cp0pYzvmFryUyK5DCXDvo899pgbc=
X-Received: by 2002:a92:6a07:: with SMTP id f7mr3626288ilc.163.1599145677003;
 Thu, 03 Sep 2020 08:07:57 -0700 (PDT)
MIME-Version: 1.0
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 3 Sep 2020 10:07:46 -0500
Message-ID: <CAFftDdoA=XBqseT5JfRbTK2HLVbLkZ=QRpTzmcooNijXvtAhaw@mail.gmail.com>
Subject: tpm:warn(2.0): out of memory for object contexts
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

I maintain a lot of the userspace components in the tpm2-software
opensource community. We had a bug come in where we're getting oom TPM
errors when using /dev/tpmrm0. The bug seems to go away when we use
the userspace resource manager tpm2-abrmd. Thai leads me to believe
that there is a kernel bug.

The question is, "is anyone aware of any bugs in the kernel RM that
could cause this?"

The kernel version is:
5.4.0-42-generic #46-Ubuntu

The discussion can be found here:
  - https://github.com/tpm2-software/tpm2-pkcs11/issues/567

Thanks,
Bill
