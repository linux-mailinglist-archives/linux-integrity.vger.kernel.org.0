Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC8121F8E
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 23:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfEQVYz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 May 2019 17:24:55 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:47179 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfEQVYz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 17:24:55 -0400
Received: by mail-qk1-f201.google.com with SMTP id l185so1966726qkd.14
        for <linux-integrity@vger.kernel.org>; Fri, 17 May 2019 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HB+0pzs2H+PqPuc5KLht6uXFIm1Vk/TwRK9m9FPAxYg=;
        b=lfi2YKKxO6izIXsbXWpCBlCQvzTvT0j8k2+Uqu9osKrVQn04h5TUEGjxg99LZAZmOr
         //V9xKFuCayFrShdfG/JGUQV+cgW4T77q/yMrKT7sHyfLe3caBW3eOhKDI1AOIt/jlWb
         odT3DE5AX7ggFkqSjPpCBeDvRg+mLWB84sm8F63g+/jzv1aG0lQSZPb8HsJo8Qkz05i7
         MOi5SeegJxnX9w82DS2sTieoNbepZU6FIX5fyh0lgzvykOVWgaStIVY1uU54Z+L67keE
         2rrpXPboKfmeIc2khePuQvyXFdOibht7K8bg2kZ79kgi6nVhdD5YnPT3277Ity1iKnko
         xnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HB+0pzs2H+PqPuc5KLht6uXFIm1Vk/TwRK9m9FPAxYg=;
        b=rPeALV7sHk5HPJP2zF8R4JJeEik7tdKpIXgP6jt+LObHlAC1SI4IIkAQgl2RbVZb+k
         cRt4kIN0S3zi86UNECJ7HS0/t2S8ErcPADQyZwZc5XctBL0FaNQcS+mZ4hmvj4xMYamo
         V/QNZsslENV0iL6Qqpsb+vg8CrBkWpszzGU/WyYUqoG8cxgxfqFcyMevirUA65LzC5hQ
         TdOd+jiwY4758xL82VQJB85ZnbPxMvGT5SN2mAUzMpu+ONP7LvW0FO0Ivg+KGdbqIKez
         F0O2K4p93eTUDLm4NYUHN4j7aXtcLd6ppYgveMfS/6va7pfgMjsfiaYvxjumYRqxAyEQ
         deRA==
X-Gm-Message-State: APjAAAWpCE3h5mzcZTWsgQ61MnXQ137wyEa2IhomE2oVDrRIBD9Qm5qG
        9G7xDi+wNBqQytMGs9KLQBPX6RoQ3qhKWKbklyxId+whE7zUib6wMK3aW4SpfsMOlKi+eDSAkSO
        Dq870sKI8+kmqY1M7ZNSdK4Ljsenu7uZYIzrQZuX5LW7FsDuz99L1kiZu0KWZREO1kVMP31iJ7c
        urpKF/Y9qw3QdYO7qwfCg=
X-Google-Smtp-Source: APXvYqynBa4Ia/HCGvB/s4ykvY7rpQ2Vbp0Lij6GV9CGDYwlRGF2Gt6bNHdp3bng2puR6ZhwJbsp9QPJHRD9Yabuv06Uig==
X-Received: by 2002:a0c:9283:: with SMTP id b3mr10140494qvb.229.1558128294610;
 Fri, 17 May 2019 14:24:54 -0700 (PDT)
Date:   Fri, 17 May 2019 14:24:42 -0700
Message-Id: <20190517212448.14256-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V3 0/6] IMA: Support asking the VFS for a file hash
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Updated to add a new template type and to allow templates to be
configured per-rule. This allows additional information about the source
of the hash to be provided without breaking any existing deployments.


