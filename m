Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7464E24257
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2019 22:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfETUzH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 May 2019 16:55:07 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:46761 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfETUzH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 May 2019 16:55:07 -0400
Received: by mail-qt1-f202.google.com with SMTP id z7so15363264qtq.13
        for <linux-integrity@vger.kernel.org>; Mon, 20 May 2019 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CEe51n1cJjGjM3r3jhy0lvCRaDr0xuP675ZqA1iPYL4=;
        b=KwKcFS84Od+0uDcbkZwTpIrT43f2kU8zmORrILLiHk2F8YkNKiv1DApHnhAMtYlYNA
         TTKtXmA8TJ8/ipv7ecH3TyAPVRf9bZ8GXZEFmFgwDXPD4Hjtc9OoZlG6aBmwZtYTn8Oc
         Nvt9VJVKM4ko0egxxq7cUr2yFh5bt2A6FPsfeESlkTgj+tTo5HipWQkdt0PV7yGNpC2p
         qwWO/zif0wXn7M/9LQBi1kh21TF0FRSHZu9qfX+5MMJsj7woSz3xBh9gb5WkU4/0KX4c
         dnI+ZE7GgTCEi7VKzXkA1bmYAkK0Nv9eJ0xJyAJqd/DQAikMJoy/AIkKcuCOHk84b2v+
         el5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CEe51n1cJjGjM3r3jhy0lvCRaDr0xuP675ZqA1iPYL4=;
        b=obFYqcAjrXUJWZW8R4uvgwsDgDZdjU3+BugkstnzjoXifR4HZCmeX8PV4EOzZr2Ndt
         in4VC9V7yGaPzxbTOm9qWjF3zxpRpJ1eMer3ZruY9nlxiXuS24Ny697E5qVnvMUnBTuH
         4FsdAp4JuaWW96lWGwKlWRq9nkM5kkRlc0CZq78NDgt4uRnJ93VBoFRfgIhUe33mm6In
         tWiczAvgQndTxhQJaEJPvGF9MEDIWR6LCDoQcrOWxUXJPnd9RyprUxMwgG/UHD2FeAqg
         GeXKz4Apd3bmXQ1JnyT7Qr8rUGCZmHh8/fOlw7oIda6R7WeyXm+ksLGSQHrwyJUHc+Oe
         Cs0g==
X-Gm-Message-State: APjAAAUBJAcW2sQngZb4QFZomC9XxW7YPyWVtyfu6B1cUYCWcsfxuEXJ
        56TsdErGTQ/HNqfPGBCf2Arr2X1JVL/N4qTsP18fzmHRc5m599Cy2G246lFzG4Z2OIa4brTuRi8
        ANOsCe6t7NxcJRpKJ9W8elyV3e9YM3Ud1bZX8WOSOY+5KyufcYuybP4KH/Yli8Ymh8eV3z42avM
        XASV5KsUKhFjl8LKqnYNs=
X-Google-Smtp-Source: APXvYqxcgPZwWQB2M99XR5b353YmJ/Ei17uYUIv35ZBhj13nsYbaZL7VC+EcLkbxPlvT59VqEEmZiqG52LG+K02tnRds4g==
X-Received: by 2002:a05:620a:144c:: with SMTP id i12mr32298826qkl.243.1558385706056;
 Mon, 20 May 2019 13:55:06 -0700 (PDT)
Date:   Mon, 20 May 2019 13:54:57 -0700
Message-Id: <20190520205501.177637-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V7 0/4] Add support for crypto agile logs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Identical to previous version except without the KSAN workaround - Ard
has a better solution for that.


