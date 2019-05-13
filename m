Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B8F1B671
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2019 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfEMMyf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 May 2019 08:54:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45675 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbfEMMyf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 May 2019 08:54:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id n22so8935268lfe.12;
        Mon, 13 May 2019 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7xC8cHLyDzMeqQGy8UoBhK9uZfRCQ70OtqLrwiRwxH4=;
        b=ZRLHqJPUCy779ZIwEg4SU+jBhX8GeRUY9h7FW+0OFtBhRIEsIePzNqL3nWZj5KNUzb
         6YJ4pvay0OhNcDpFNGdgB2zs2l+ccbMydF0LN45RIhDR2Cgtfu/y3xkIZM1hlw9wrQ2t
         vigEvORCYpVrSgIlTJ+cznCLdvaaXMH8knBq6el0oGE/YX9RHbKoOSxDSw1rIjsGJy0q
         V3qwJoYbAE7gx1PtXSwCVeDstRD2ttTt2NJueEOFsRAwD4U+UJ+l4O/GVIM4FZVHL8W7
         rpwkSYDXX3bQtPE+Ml9a+q62s0eewEbsw8/PbrQm9yZV9L2K+kprZkSL92nInsYZHYqA
         BChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7xC8cHLyDzMeqQGy8UoBhK9uZfRCQ70OtqLrwiRwxH4=;
        b=MCxdCG1j2w+YMppSDz9qCV55sMzN04VjTokHfdDKDSMhxDeLsKwy4tkECyBV9kxW8A
         Ns10z6XW4ZfYkTxFDa0arpfWedC75f61fUlDuUCwPV8+kfuJBsSxtTBX1LFBGZTh2KNl
         e0CrX24p4P59L9s+E+nAHNV6SJPwX9MmJxyxyjGKu8LzV5lvcVAMABDguyhmSOAeuJ+b
         gO3UOuagTwB6uAOrhna9QnCOpLjwC8imwrk7KXnh/0VgQp9kkEzEc/dg8zusoLig11J3
         N74+3+XxSklYRybYziCUxcBPGmjG9ccugg3EcijZ9Z8KLk9RfEw/bPnB15QlA790EYnX
         2jOQ==
X-Gm-Message-State: APjAAAXY617gioZliUeznMwykkqhQNw9Mt55hLxqvoRP3S9zmBxlkWXH
        ze7PmzqEjPWVnrvFhWeaeR19Hnhr/ZA=
X-Google-Smtp-Source: APXvYqwKJcWo6k5z8t6NBmvrYXE6cVCOoGrqOCLde7xchy3MGCBB1I7YqTtoHFh5enXY9AqeGsD3tg==
X-Received: by 2002:ac2:5337:: with SMTP id f23mr12268247lfh.52.1557752072545;
        Mon, 13 May 2019 05:54:32 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-2e84ba-11.dhcp.inet.fi. [46.132.186.11])
        by smtp.gmail.com with ESMTPSA id t22sm3202924lje.58.2019.05.13.05.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 05:54:31 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com
Cc:     Janne Karhunen <janne.karhunen@gmail.com>
Subject: [PATCH 0/5] integrity: improve ima measurement accuracy
Date:   Mon, 13 May 2019 15:53:49 +0300
Message-Id: <20190513125354.23126-1-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

By default the linux integrity subsystem measures a file only
when a file is being closed. While this certainly provides
low overhead as the re-measurements are never done, it also
makes sure the system has zero means to recover from a crash
or a power outage when operating in 'appraise' mode. 

This patch series adds two new IMA api functions to retrigger
the measurements as the files change. Synchronous variant
should be invoked from less performance sensitive locations
such as sync|msync|truncate where the user is expecting some
latency, and the asynchronous variant can be called from
performance sensitive locations such as direct write or mmio.

Asynchronous variant is mostly 'out of the way' on write hot
paths, each file write is only checking that we have a cmwq
work entry pending to re-calculate the file measurement later
on. Re-measurement latencies are build time tunables and the
latencies are automatically raised for very large files.

While this does not provide absolutely perfect tolerance to
system resets, for most reasonable embedded system workloads
it can be tuned to achieve really high measurement accurancy
with the measurements being accurate 99.9%+ of the day.

Janne Karhunen (5):
  integrity: keep the integrity state of open files up to date
  integrity: update the file measurement on truncate
  integrity: update the file measurement on write
  integrity: measure the file on sync
  integrity: measure the file on msync

 fs/namei.c                            |   5 +-
 fs/open.c                             |   3 +
 fs/read_write.c                       |  11 ++-
 fs/sync.c                             |   3 +
 include/linux/ima.h                   |  12 +++
 mm/msync.c                            |   7 ++
 security/integrity/ima/Kconfig        |  20 +++++
 security/integrity/ima/ima_appraise.c |   6 +-
 security/integrity/ima/ima_main.c     | 103 +++++++++++++++++++++++++-
 security/integrity/integrity.h        |   6 ++
 10 files changed, 171 insertions(+), 5 deletions(-)

-- 
2.17.1

